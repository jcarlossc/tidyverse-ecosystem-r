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

# 2. dplyr (manipulação de dados).

# select() - selecionar colunas.
# filter() - filtrar linhas.
# arrange() - ordenar.
# mutate() - criar/transformar colunas.
# summarise() - resumir valores.
# group_by() - agrupar para cálculos.
# distinct() - valores únicos.
# rename() - renomear colunas.
# join functions (left_join, inner_join, right_join, full_join).

# Exemplo de manipulação de dados:

# Exemplo com dataset interno
dados = starwars

# Leitura das primeiras linhas.
head(dados)

# Visualização dos dados em janela separada.
View(dados)

# ----------

dados %>% 
  # filtra apenas as linhas do tipo olhos azuis. 
  filter(eye_color == "blue") %>%   
  # Seleciona nome, cor dos olhos, peso e altura.
  select(name, eye_color, mass, height) %>%
  # Ordenação descendente dos nomes.
  arrange(desc(name)) %>%
  # Cria uma coluna altura_peso para o imc.
  mutate(altura_peso = mass / ((height / 100) ** 2 )) %>%
  # Renomeia a coluna altura_peso para imc.
  rename(imc = altura_peso)
  # Valores únicos.

# ----------

dados %>%
  # Busca o valor mais frequente.
  summarise(moda = names(which.max(table(sex))))

# ----------

dados %>%
  # Valores distintos.
  distinct(sex)

# ----------

# Em R, join functions (left_join, inner_join, right_join, full_join)
# ------------------------------------------------------------------------  
# Função	     | Tipo de junção	  | Mantém linhas de...
# -------------|------------------|---------------------------------------
# inner_join() | Interseção	      | Apenas registros que estão em ambos os data frames.
# left_join()	 | Junção à esquerda|	Todos os registros do data frame da esquerda.
# right_join() | Junção à direita	| Todos os registros do data frame da direita.
# full_join()	 | Junção completa	| Todos os registros de ambos os data frames.
# ------------------------------------------------------------------------

# Data frames criados para exemplificar as joins functions.

# Data frame 1: alunos e suas notas
alunos <- tibble(
  id = c(1, 2, 3, 4),
  nome = c("Ana", "Bruno", "Carlos", "Diana"),
  nota = c(8.5, 7.2, 9.1, 6.8)
)

# Data frame 2: alunos e suas turmas
turmas <- tibble(
  id = c(2, 3, 4, 5),
  turma = c("A", "B", "A", "C")
)

inner_join(alunos, turmas, by = "id")
left_join(alunos, turmas, by = "id")
right_join(alunos, turmas, by = "id")
full_join(alunos, turmas, by = "id")

# ================================================================


