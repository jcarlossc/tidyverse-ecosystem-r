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

# 4. purrr (programação funcional)

# map() - aplica função sobre listas/vetores
# map_dbl(), map_chr() - retorna vetores tipados
# map_df() - retorna data frame
# pmap() - aplica função com múltiplos argumentos


# Aplica a função que muda a grandeza da altura: cm para m.
dados_resultado <- map(dados$height, function(x) x / 100)

dados_resultado

# ----------

# Retorna um vetor numérico do peso ao quadrado.
resultado_vetor <- map_dbl(dados$mass, function(x) x ** 2)

resultado_vetor

# ----------

# Retorn um vetor de caracteres.
dados_caracteres <- map_chr(dados$name, function(x) paste("Personagem:", x))

dados_caracteres

# ----------

# Retorna um data frame com peso, peso_quadrado e peso_cubo.

dados_df <- map_df(dados$mass, function(x) {
  tibble(
    peso = x,
    peso_quadrado = x ** 2,
    peso_cubo = x ** 3
  )
})

dados_df

# ----------

# Mapeia múltiplas colunas (argumentos paralelos)
dados_escolhidos <- dados %>%
  select(height, mass)

dados_soma <- pmap_dbl(dados_escolhidos, function(height, mass) height * mass)

head(dados_soma)

# ================================================================

# 5. tibble (data frames modernos)

# tibble() - cria tibble
# as_tibble() - converte para tibble
# glimpse() - visualização compacta dos dados

# Exemplo de criação de data frame:

# Criação de um tibble manualmente.

dados_tibble <- tibble(
  nome = c("Ana", "Bruno", "Carlos", "Teresa"),
  idade = c(23, 35, 48, 3),
  cidade = c("Recife", "São Paulo", "Recife", "Recife")
)

# Exibe o tibble
print(dados_tibble)

# ----------

# Criação de um data frame base
df_base <- data.frame(
  nome = c("Carlos", "Teresa"),
  idade = c(48, 3)
)

# Conversão para tibble
tb_convertido <- as_tibble(df_base)

# Exibição
print(tb_convertido)

# ----------

# A função glimpse() mostra uma visão resumida horizontal dos dados — 
# ideal para explorar rapidamente colunas e tipos.

glimpse(dados)

# ================================================================






