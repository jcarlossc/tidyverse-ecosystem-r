# Explorando o ecossistema tidyverse no R.

# O que é o tidyverse?
# O tidyverse é um ecossistema de pacotes no R criado para facilitar 
# o trabalho com dados. A ideia central é seguir a filosofia do tidy 
# data, onde:

# Cada variável é uma coluna,
# Cada observação é uma linha,
# Cada valor é uma célula.

# Essa padronização torna os dados mais fáceis de manipular, analisar 
# e visualizar.

# O tidyverse cobre todo o fluxo de ciência de dados:
# Importar dados.
# Organizar dados.
# Transformar dados.
# Visualizar resultados.
# Modelar dados.
# Comunicar resultados.

# Caso ainda não o tenha instalado:
# install.packages("tidyverse").

# Após instalado, a próxima linha carrega toda a coleção:

library(tidyverse)

# são carregados:
# ggplot2 → visualização de dados.
# dplyr → manipulação de dados.
# tidyr → organização de dados.
# readr → importação/exportação de dados.
# purrr → programação funcional.
# tibble → data frames modernos.
# stringr → manipulação de strings.
# forcats → manipulação de fatores.

# ================================================================

# 1. readr (importação/exportação).

# Funções principais:
# read_csv() - ler CSV.
# read_tsv() - ler TSV.
# read_delim() - ler delimitados.
# write_csv() - salvar CSV.
# read_rds() e write_rds() - salvar/ler binário.

# Exemplo de leitura de arquivo csv:

# Exemplo de leitura de arquivo csv:

# Endereço do arquivo csv a ser explorado.
arquivo <- "exemplo.csv"

# Variável que conterá o data frame.
dados <- read_csv(file=arquivo)

# ================================================================

