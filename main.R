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

# Variável do arquivo csv a ser explorado.
arquivo <- "exemplo.csv"

# Variável que conterá o data frame.
dados <- read_csv(file = arquivo)

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

# 3. tidyr (organização dos dados)

# pivot_longer() - transformar colunas em linhas.
# pivot_wider() - transformar linhas em colunas.
# separate() - separar colunas.
# unite() - unir colunas.
# drop_na() - remover NAs.
# replace_na() - substituir NAs.

# Exemplo de organização de dados:

# Serve para “derreter” colunas e deixá-las empilhadas.
# Transforma colunas em linhas.
# Transformar as colunas height, mass e birth_year em duas colunas:
# atributo e valor.

dados_longos <- dados %>%
  select(name, height, mass, birth_year) %>%  # seleciona colunas relevantes
  pivot_longer(
    cols = c(height, mass, birth_year),       # colunas que serão transformadas
    names_to = "atributo",                    # nome da nova coluna com os nomes originais
    values_to = "valor"                       # nome da nova coluna com os valores
  )

head(dados_longos)

# ----------

# Fazer o caminho inverso, transformando as linhas (atributos) 
# de volta em colunas.
dados_grandes <- dados_longos %>%
  pivot_wider(
    names_from = atributo,   
    values_from = valor      
  )

head(dados_grandes)

# ----------

# Separa uma coluna em duas.
dados_separados <- dados %>%
  separate(name, into = c("primeiro_nome", "segundo_nome"), sep = " ")

dados_separados

# ----------

# Unir duas colunas.
dados_unidos <- separados %>%
  unite(col = "name", primeiro_nome, segundo_nome, sep = " ")

dados_unidos

# ----------

# Remover linhas com valores ausentes.
dados_apagar_na <- dados %>%
  drop_na()

dados_apagar_na

# ----------

# Substitui valores ausentes de colunas específicas.
dados_substituidos <- dados %>%
  replace_na(list(hair_color = "Desconhecido"))

dados_substituidos

# ================================================================








