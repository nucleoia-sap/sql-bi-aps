---------------------
---- turnover
---------------------
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.profissionais_aps_turnover` AS
  WITH
  prof AS (
    SELECT 
      id_cnes,
      estabelecimento_nome_fantasia,
      id_estabelecimento_ap,
      data_registro,
      profissional_codigo_sus,
      cns,
      cbo,
      data_entrada_profissional,
      data_desligamento_profissional
    FROM `rj-sms.saude_cnes.profissional_sus_rio_historico` 
    WHERE data_entrada_profissional IS NOT NULL
    AND data_registro = (
      SELECT max(data_registro) FROM `rj-sms.saude_cnes.profissional_sus_rio_historico`
    ) 
  ),
  estab AS (
    SELECT distinct(id_cnes), TRIM(tipo_sms_simplificado) AS tipo_sms_simplificado
    FROM `rj-sms.saude_cnes.estabelecimento_sus_rio_historico`
    WHERE UPPER(TRIM(tipo_sms_simplificado)) IN ('CF', 'CSE', 'CMS')
    AND LOWER(TRIM(ativa)) = 'sim'
  )
  SELECT 
    A.id_cnes,
    B.tipo_sms_simplificado,
    id_estabelecimento_ap,
    A.estabelecimento_nome_fantasia,
    A.data_registro,
    A.profissional_codigo_sus,
    A.cns,
    A.cbo,
    CASE 
      WHEN UPPER(cbo) LIKE '%MEDICO%' OR UPPER(cbo) LIKE '%MÉDICO%' THEN 'Medico'
      WHEN UPPER(cbo) LIKE '%ENFERMEIRO%' THEN 'Enfermeiro'
      WHEN UPPER(cbo) LIKE '%AGENTE COMUNITARIO%' OR UPPER(cbo) LIKE '%AGENTE COMUNITÁRIO%' THEN 'ACS'
      WHEN UPPER(cbo) LIKE '%ENFERM%' THEN 'Tec/Aux Enfermagem'
      ELSE 'Outros'
    END AS tipo_profissional,
    A.data_entrada_profissional,
    FORMAT_DATE('%Y-%m', A.data_entrada_profissional) AS mes_entrada_profissional,
    A.data_desligamento_profissional,
    FORMAT_DATE('%Y-%m', A.data_desligamento_profissional) AS mes_desligamento_profissional
  FROM prof AS A 
  JOIN estab AS B
  ON A.id_cnes = B.id_cnes;

select * from `rj-sms-sandbox.sub_pav_us.profissionais_aps_turnover` limit 10;

-- próximos passos: agrupar por mês de saída, mês de entrada, AP, por profissão e criar uma coluna de count (ver query abaixo). Obs: no caso geral, caso um profissional seja parte de mais de uma AP, ele será contado duas vezes. Não tem problema, apenas precisa ter isso em mente. Ponto de melhoria futuro: verificar se a volumetria de pessoas sem data de entrada é muito alta. Se sim, tentar criar um código que atribua uma data de entrada baseada em quando a pessoa entrou no sistema. 

CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.profissionais_aps_turnover_agrupado` AS
  SELECT
    id_estabelecimento_ap,
    estabelecimento_nome_fantasia,
    tipo_profissional,
    mes_entrada_profissional,
    mes_desligamento_profissional,
    count(*) AS quantidade
  FROM `rj-sms-sandbox.sub_pav_us.profissionais_aps_turnover`
  GROUP BY 1, 2, 3, 4,5
