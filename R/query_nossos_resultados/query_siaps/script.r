# ===================================================================
# PASSO 1: SCRIPT R SIMPLIFICADO (APENAS CARGA COMO TEXTO)
# ===================================================================

# ------------------------------------------------------------------
#INDICADORES ESF
# ------------------------------------------------------------------

  install.packages("googlesheets4")
  install.packages("bigrquery")
  install.packages ("janitor")
  install.packages ("dplyr")
  install.packages("googledrive")

library(googlesheets4)
library(bigrquery)
library(janitor)
library(dplyr)
library(googledrive)

# --- AUTENTICAÇÃO ---
gs4_auth() # Conta NIA
bq_auth() # Conta Letícia

# --- CONFIGURAÇÃO ---
url_da_planilha <- "Inserir link da planilha"
id_do_projeto_gcp <- "inserir id do projeto"
id_do_dataset_bq <- "inserir id do dataset"
aba_para_excluir <- "PANORAMA GERAL"
prefixo_tabela <- "SIAPS_" # <- Prefixo para as tabelas brutas

cat("Iniciando a carga de dados brutos...\n\n")
nomes_das_abas <- sheet_names(ss = url_da_planilha)

for (nome_da_aba in nomes_das_abas) {
  if (nome_da_aba == aba_para_excluir) {
    next
  }
  
  cat(paste("--> Carregando aba bruta: '", nome_da_aba, "'\n", sep=""))
  
  # 1. Lê os dados e limpa os nomes das colunas
  dados_brutos <- read_sheet(ss = url_da_planilha, sheet = nome_da_aba, col_types = "c") %>%
    clean_names()
  
  # 2. Cria o nome da tabela bruta
  nome_tabela_bruta <- paste0(prefixo_tabela, make_clean_names(nome_da_aba))
  
  # 3. Define o destino
  tabela_destino <- bq_table(project = id_do_projeto_gcp, dataset = id_do_dataset_bq, table = nome_tabela_bruta)
  
  # 4. Faz o upload. Forçamos tudo como texto para garantir o sucesso.
  bq_table_upload(
    x = tabela_destino,
    values = dados_brutos,
    fields = as_bq_fields(dados_brutos), # Força o esquema a ser STRING
    create_disposition = "CREATE_IF_NEEDED",
    write_disposition = "WRITE_TRUNCATE"
  )
  cat("    - Carga bruta concluída com sucesso.\n")
}
cat("\nETAPA DE CARGA FINALIZADA. Agora execute o SQL no BigQuery.\n")



#------------------------------------------------------------------
  #INDICADORES E-MULTI
#------------------------------------------------------------------

library(googlesheets4)
library(bigrquery)
library(janitor)
library(dplyr)

# --- AUTENTICAÇÃO ---
gs4_auth() #CONTA NUCLEO
bq_auth() #CONTA LETICIA

# --- CONFIGURAÇÃO ---
url_da_planilha <- "Inserir link da planilha"
id_do_projeto_gcp <- "inserir id do projeto"
id_do_dataset_bq <- "inserir id do dataset"
aba_para_excluir <- "PANORAMA GERAL"
prefixo_tabela <- "SIAPS_EMULTI_" # <- Prefixo para as tabelas brutas

cat("Iniciando a carga de dados brutos...\n\n")
nomes_das_abas <- sheet_names(ss = url_da_planilha)

for (nome_da_aba in nomes_das_abas) {
  if (nome_da_aba == aba_para_excluir) {
    next
  }
  
  cat(paste("--> Carregando aba bruta: '", nome_da_aba, "'\n", sep=""))
  
  # 1. Lê os dados e limpa os nomes das colunas
  dados_brutos <- read_sheet(ss = url_da_planilha, sheet = nome_da_aba, col_types = "c") %>%
    clean_names()
  
  # 2. Cria o nome da tabela bruta
  nome_tabela_bruta <- paste0(prefixo_tabela, make_clean_names(nome_da_aba))
  
  # 3. Define o destino
  tabela_destino <- bq_table(project = id_do_projeto_gcp, dataset = id_do_dataset_bq, table = nome_tabela_bruta)
  
  # 4. Faz o upload. Forçamos tudo como texto para garantir o sucesso.
  bq_table_upload(
    x = tabela_destino,
    values = dados_brutos,
    fields = as_bq_fields(dados_brutos), # Força o esquema a ser STRING
    create_disposition = "CREATE_IF_NEEDED",
    write_disposition = "WRITE_TRUNCATE"
  )
  cat("    - Carga bruta concluída com sucesso.\n")
}
cat("\nETAPA DE CARGA FINALIZADA. Agora execute o SQL no BigQuery.\n")


#------------------------------------------------------------------
#INDICADORES ESB
#------------------------------------------------------------------

library(googlesheets4)
library(bigrquery)
library(janitor)
library(dplyr)

# --- AUTENTICAÇÃO ---
gs4_auth() # Conta Nucleo
bq_auth() #Conta Letícia

# --- CONFIGURAÇÃO ---
url_da_planilha <- "Inserir link da planilha"
id_do_projeto_gcp <- "inserir id do projeto"
id_do_dataset_bq <- "inserir id do dataset"
aba_para_excluir <- "PANORAMA GERAL"
prefixo_tabela <- "SIAPS_ESB_" # <- Prefixo para as tabelas brutas

cat("Iniciando a carga de dados brutos...\n\n")
nomes_das_abas <- sheet_names(ss = url_da_planilha)

for (nome_da_aba in nomes_das_abas) {
  if (nome_da_aba == aba_para_excluir) {
    next
  }
  
  cat(paste("--> Carregando aba bruta: '", nome_da_aba, "'\n", sep=""))
  
  # 1. Lê os dados e limpa os nomes das colunas
  dados_brutos <- read_sheet(ss = url_da_planilha, sheet = nome_da_aba, col_types = "c") %>%
    clean_names()
  
  # 2. Cria o nome da tabela bruta
  nome_tabela_bruta <- paste0(prefixo_tabela, make_clean_names(nome_da_aba))
  
  # 3. Define o destino
  tabela_destino <- bq_table(project = id_do_projeto_gcp, dataset = id_do_dataset_bq, table = nome_tabela_bruta)
  
  # 4. Faz o upload. Forçamos tudo como texto para garantir o sucesso.
  bq_table_upload(
    x = tabela_destino,
    values = dados_brutos,
    fields = as_bq_fields(dados_brutos), # Força o esquema a ser STRING
    create_disposition = "CREATE_IF_NEEDED",
    write_disposition = "WRITE_TRUNCATE"
  )
  cat("    - Carga bruta concluída com sucesso.\n")
}
cat("\nETAPA DE CARGA FINALIZADA. Agora execute o SQL no BigQuery.\n")

