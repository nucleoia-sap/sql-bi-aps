
# ================================
# Importar PMM, PMPB, PROF_EQUIP, PROF_UNID
# ================================
pmm <- rio::import(file.path("PMM.xlsx"))
pmpb <- rio::import(file.path("PMPB.xlsx"))

# upload da base de pmm no datalake
library(bigrquery)

project_id <- "rj-sms-sandbox"
dataset_id <- "sub_pav_us"        # << ajuste aqui; antes estava "pmm"
table_name <- "pmm"

# 1) Função de limpeza (cole se ainda não tiver no ambiente)
library(dplyr); library(janitor)
clean_for_bq <- function(df, drop_all_na = TRUE){
  if (drop_all_na) df <- df %>% select(where(~ !all(is.na(.))))
  nm <- names(df) |>
    janitor::make_clean_names() |>
    gsub("[^A-Za-z0-9_]", "_", x = _) |>
    substr(1, 300)
  nm <- ifelse(grepl("^[A-Za-z_]", nm), nm, paste0("col_", nm))
  names(df) <- make.unique(nm, sep = "_")
  df
}

# 2) Limpar a base
pmm_clean <- clean_for_bq(pmm)

ds  <- bq_dataset(project_id, dataset_id)
if (!bq_dataset_exists(ds)) bq_dataset_create(ds, location = "US")
tbl <- bq_table(ds, table_name)

bq_table_upload(
  x = tbl,
  values = pmm_clean,
  create_disposition = "CREATE_IF_NEEDED",
  write_disposition  = "WRITE_TRUNCATE"
)

# salvando o pmpb
# se ainda não tiver no ambiente:
library(dplyr); library(janitor)
clean_for_bq <- function(df, drop_all_na = TRUE){
  if (drop_all_na) df <- df %>% select(where(~ !all(is.na(.))))
  nm <- names(df) |>
    janitor::make_clean_names() |>
    gsub("[^A-Za-z0-9_]", "_", x = _) |>
    substr(1, 300)
  nm <- ifelse(grepl("^[A-Za-z_]", nm), nm, paste0("col_", nm))
  names(df) <- make.unique(nm, sep = "_")
  df
}

# limpar e enviar a PMPB
pmpb_clean <- clean_for_bq(pmpb)

bq_table_upload(
  x = bq_table(project_id, dataset_id, "pmpb"),
  values = pmpb_clean,
  create_disposition = "CREATE_IF_NEEDED",
  write_disposition  = "WRITE_TRUNCATE"
)
