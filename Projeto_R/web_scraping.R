library(rvest)
library(stringr)
library(dplyr)
library(lubridate)
library(readr)
library(ggplot2)
library(tidyr)

# Extrair os registros
year = rep(c(2011:2021),each = 12)
year <- year[8:125]
month = rep(01:12,11)
month <- sprintf("%02d", month)
month <- month[8:125]

# URL que serao extaidos
radios_url <- paste0("https://www.radios.com.br/relatorios/stat_", year,"-", month,"_amfmestado_33-26")

# Funcao de extracao rvest
read_html(iconv(page_source[[1]], to = "UTF-8"), encoding = "utf8")
get_table <- function(url){
  url %>% 
    read_html(encoding="iso-8859-1") %>% 
    html_nodes(xpath = '//*[@id="relatorio"]') %>% 
    html_table(header = T)
}

# Aplicando a funcao criada com as URLs
results <- sapply(radios_url, get_table)

# Juntando o resultado obtido em um dataframe
data <- do.call(rbind, results)
data <- as.data.frame(data)

# adicionando uma coluna Data
Data <- str_sub(rownames(data), start = 43, end = 49)
data <- cbind(data, Data = Data)

# Retirando os nomes das linhas
rownames(data) <- NULL

# Salvando em csv
write.table(data, "Radios.csv", sep = ",")

data

##3
webpage <- radios_url[112] %>% 
  read_html() %>% 
  html_node(xpath = '//*[@id="relatorio"]') %>% 
  html_table(header = T)
