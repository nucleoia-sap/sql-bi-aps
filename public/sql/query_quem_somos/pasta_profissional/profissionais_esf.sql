 ---------------------------------------------------------------------
-- DW (MESMO NOME PARA NÃO QUEBRAR O BI)
-- Base mãe = estabelecimento_sus_rio_historico
-- FILTRO ANTES DO JOIN: tipo_sms_simplificado IN ('CF','CMS','CSE')
-- Sem “mais recente”. Mantém unidades mesmo sem equipe.
---------------------------------------------------------------------

CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.dw_equipes_unidades_profissionais` AS
WITH
est AS (
  SELECT
    * EXCEPT (
      nome_razao_social,
      nome_complemento,
      id_natureza_juridica,
      natureza_juridica_descr,
      diretor_clinico_cpf,
      diretor_clinico_conselho,
      tipo_disponibilidade,
      prontuario_estoque_tem_dado,
      prontuario_estoque_motivo_sem_dado,
      prontuario_episodio_tem_dado,
      estabelecimento_sms_indicador,
      vinculo_sus_indicador,
      atendimento_internacao_sus_indicador,
      atendimento_ambulatorial_sus_indicador,
      atendimento_sadt_sus_indicador,
      atendimento_urgencia_sus_indicador,
      atendimento_outros_sus_indicador,
      atendimento_vigilancia_sus_indicador,
      atendimento_regulacao_sus_indicador,
      usuario_atualizador_registro,
      data_snapshot
    )
  FROM `rj-sms.saude_cnes.estabelecimento_sus_rio_historico`
  WHERE tipo_sms_simplificado IN ('CF', 'CMS', 'CSE')   -- <<< filtro antes do join
),
eq AS (
  SELECT *
  FROM `rj-sms.saude_dados_mestres.equipe_profissional_saude`
),
prof_norm AS (
  SELECT
    UPPER(TRIM(p.id_profissional_sus)) AS prof_id,
    UPPER(COALESCE(c.cbo, c.cbo_agrupador, c.cbo_familia, '')) AS cbo_text
  FROM `rj-sms.saude_dados_mestres.profissional_saude` p
  LEFT JOIN UNNEST(p.cbo) c
),
sb_exp AS (
  SELECT
    e.id_ine,
    UPPER(TRIM(p)) AS prof_id
  FROM eq e, UNNEST(COALESCE(e.auxiliares_tecnico_saude_bucal, [])) p
),
sb_class AS (
  SELECT
    s.id_ine,
    s.prof_id,
    MAX(REGEXP_CONTAINS(n.cbo_text, r'T[ÉE]CNIC[OA].*SA[UÚ]DE BUCAL|(^|[^A-Z])TSB([^A-Z]|$)')) AS has_tsb,
    MAX(REGEXP_CONTAINS(n.cbo_text, r'AUXILIAR.*SA[UÚ]DE BUCAL|(^|[^A-Z])ASB([^A-Z]|$)'))       AS has_asb
  FROM sb_exp s
  LEFT JOIN prof_norm n
    ON n.prof_id = s.prof_id
  GROUP BY s.id_ine, s.prof_id
),
sb_agg AS (
  SELECT
    id_ine,
    COUNTIF(has_tsb) AS numero_de_tsb,
    COUNTIF(NOT has_tsb AND has_asb) AS numero_de_asb
  FROM sb_class
  GROUP BY id_ine
)
SELECT
  -- novas (competência / AP)
  est.ano_competencia,
  est.mes_competencia,
  FORMAT('%04d-%02d', est.ano_competencia, est.mes_competencia) AS ano_mes_competencia,
  est.id_ap,
  est.ap,

  -- id_ine sem nulos (para evitar erro no lado "1" do relacionamento no BI)
  COALESCE(eq.id_ine, CONCAT('SEM_EQUIPE_', est.id_cnes)) AS id_ine,

  eq.nome_referencia AS nome_equipe,

  est.id_cnes,
  est.id_unidade,
  est.nome_limpo     AS nome_unidade,
  est.ap             AS area_programatica,

  est.ativa,
  est.tipo_sms_agrupado,
  est.tipo_sms,
  est.tipo_sms_simplificado,
  est.tipo           AS tipo_unidade,
  est.responsavel_sms,
  est.administracao,

  eq.id_equipe_tipo,
  eq.equipe_tipo_descricao,

  eq.telefone        AS whatsapp_equipe,
  est.telefone       AS telefones_unidade,
  est.email          AS email_unidade,
  est.facebook,
  est.instagram,
  est.twitter,

  est.endereco_bairro,
  est.endereco_logradouro,
  est.endereco_numero,
  est.endereco_complemento,
  est.endereco_cep,
  est.endereco_latitude,
  est.endereco_longitude,
  ARRAY_TO_STRING(
    ARRAY(
      SELECT x
      FROM UNNEST([est.endereco_logradouro, est.endereco_numero, est.endereco_bairro, est.endereco_cep]) x
      WHERE x IS NOT NULL AND x != ''
    ),
    ', '
  ) AS endereco_completo,

  est.data_particao AS data_cadastro,

  IF(eq.id_ine IS NULL, 0, 1) AS num_equipes,

  ARRAY_LENGTH(COALESCE(eq.medicos, []))                        AS numero_de_medicos,
  ARRAY_LENGTH(COALESCE(eq.enfermeiros, []))                    AS numero_de_enfermeiros,
  ARRAY_LENGTH(COALESCE(eq.agentes_comunitarios, []))           AS numero_de_acs,
  ARRAY_LENGTH(COALESCE(eq.auxiliares_tecnicos_enfermagem, [])) AS numero_de_tecnicos,
  ARRAY_LENGTH(COALESCE(eq.dentista, []))                       AS numero_de_dentistas,

  COALESCE(sb.numero_de_asb, 0) AS numero_de_asb,
  COALESCE(sb.numero_de_tsb, 0) AS numero_de_tsb,

  eq.ultima_atualizacao_infos_equipe

FROM est
LEFT JOIN eq
  ON est.id_cnes = eq.id_cnes
LEFT JOIN sb_agg sb
  ON eq.id_ine = sb.id_ine
;

-- Corrige latitude/longitude do CNES 9071385 na tabela usada no BI
-- (vai atualizar TODAS as linhas desse CNES: todos os meses/competências e equipes)

UPDATE `rj-sms-sandbox.sub_pav_us.dw_equipes_unidades_profissionais`
SET
  endereco_latitude  = -22.936866883422773,
  endereco_longitude = -43.38986352061604
WHERE id_cnes = '9071385';

-- Atualiza area_programatica para receber o id_ap (para todas as linhas)
UPDATE `rj-sms-sandbox.sub_pav_us.dw_equipes_unidades_profissionais`
SET area_programatica = id_ap
WHERE TRUE;
