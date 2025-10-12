# Explorando o ecossistema tidyverse da linguagem R.

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
# install.packages("tidyverse")

# Após instalado, a próxima linha carrega toda a coleção:

library(tidyverse)

# São carregados:
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

# Exemplo com dataset interno.
dados = starwars

# Leitura das primeiras linhas.
head(dados)

# Visualização dos dados em janela separada.
View(dados)

# ----------

# filtra apenas as linhas do tipo olhos azuis. 
# Seleciona nome, cor dos olhos, peso e altura.
# Ordenação descendente dos nomes.
# Cria uma coluna altura_peso para o imc.
# Renomeia a coluna altura_peso para imc.
dados %>% 
  filter(eye_color == "blue") %>%   
  select(name, eye_color, mass, height) %>%
  arrange(desc(name)) %>%
  mutate(altura_peso = mass / ((height / 100) ** 2 )) %>%
  rename(imc = altura_peso)

# ----------

# Busca o valor mais frequente.
dados %>%
  summarise(moda = names(which.max(table(sex))))

# ----------

# Valores distintos.
dados %>%
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

# Seleciona colunas relevantes.
# Colunas que serão transformadas.
# Nome da nova coluna com os nomes originais.
# Nome da nova coluna com os valores.
dados_longos <- dados %>%
  select(name, height, mass, birth_year) %>%  
  pivot_longer(
    cols = c(height, mass, birth_year),       
    names_to = "atributo",                    
    values_to = "valor"                       
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
dados_unidos <- dados_separados %>%
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

# 6. stringr (manipulação de strings)

# str_detect() - detectar padrão
# str_replace() - substituir padrão
# str_to_upper(), str_to_lower(), str_to_title() - maiúsculas/minúsculas
# str_length() - tamanho da string
# str_c() - concatenar

# Exemplo de manipulação de string:

# Verificar se o nome contém "Skywalker", caso positivo, retorna mensagem.
string_detect <- dados %>%
  mutate(
    contem_Skywalker = str_detect(name, "Skywalker"),
    mensagem = if_else(contem_Skywalker, "Tem Skywalker!", "Não tem Skywalker")
  )

glimpse(string_detect)

# ----------

# Substituir "Luke" por "Luque".
string_replace <- dados %>%
  mutate(nome_corrigido = str_replace(name, "Luke", "Luque"))

glimpse(string_replace)

# ----------

# Alterar maiúsculas, minúsculas e primeira letra dos nomes.
string_upper_lower_title <- dados %>%
  mutate(
    nome_maiusculo = str_to_upper(name),
    nome_minusculo = str_to_lower(name),
    nome_titulo    = str_to_title(name)
  )

glimpse(string_upper_lower_title)

# ----------

# Retorma o tamanho da string.
string_tamanho <- dados %>%
  mutate(tamanho_nome = str_length(name))

glimpse(string_tamanho)

# ----------

# Concatenar strings.
string_concatenar <- dados %>%
  mutate(nome_especie = str_c(name, " - ", species))

glimpse(string_concatenar)

# ================================================================

# 7. forcats (fatores/categorias)

# fct_relevel() - reordenar níveis manualmente
# fct_infreq() - ordenar por frequência
# fct_recode() - renomear níveis
# fct_lump() - agrupar categorias raras em "outros"

# Exemplo de criação de data frame:

# Reordenar níveis manualmente.

library(forcats)
library(dplyr)

# Reordena manualmente os níveis de um fator, colocando os níveis 
# em uma posição específica (geralmente no início).

# fct_relevel() é útil quando você quer controlar a ordem dos níveis 
# para gráficos (ggplot2) ou tabelas, por exemplo, colocando uma 
# categoria como “padrão” ou “referência”.

# Criando um vetor categórico (fator).
cores <- factor(c("Azul", "Vermelho", "Verde", "Azul", "Verde", "Amarelo"))

# Visualizando a ordem original dos níveis.
levels(cores)

# Reordenando os níveis manualmente.
cores_reordenadas <- fct_relevel(cores, "Vermelho")

levels(cores_reordenadas)

# ----------

# Criando um fator com diferentes frequências.
frutas <- factor(c(
  "Maçã", "Banana", "Maçã", "Uva", "Maçã", "Banana", "Uva", "Uva", "Uva")
  )

# Contando as frequências antes.
table(frutas)

frutas_ordem_freq <- fct_infreq(frutas)

# Agora os níveis estão ordenados pela frequência, garantindo que as 
# categorias mais comuns apareçam primeiro.

levels(frutas_ordem_freq)

# ----------

# Renomeia os níveis de um fator — ou seja, altera os rótulos 
# de categorias específicas.

# Criando fator com nomes confusos.
status <- factor(c("Aprov", "Reprov", "Aprov", "Em_Analise", "Reprov"))

# Renomeando para nomes mais legíveis.
status_limpo <- fct_recode(status,
                           "Aprovado" = "Aprov",
                           "Reprovado" = "Reprov",
                           "Em Análise" = "Em_Analise")

# fct_recode() é excelente para padronizar categorias vindas de 
# bancos de dados onde há abreviações, erros de digitação 
# ou nomes pouco legíveis.

levels(status_limpo)

# ----------

# Agrupa as categorias menos frequentes em uma 
#categoria “outros” (por padrão, "Other").
# Ideal para simplificar gráficos ou análises quando há muitas categorias raras.

# Criando um fator com várias categorias.
animais <- factor(c("Cachorro", "Gato", "Gato", "Peixe", "Pássaro", 
                    "Cavalo", "Gato", "Cachorro", "Tartaruga", "Pássaro"))

# Contando frequências antes.
table(animais)

animais_lumped <- fct_lump(animais, n = 2)

# As categorias menos frequentes foram agrupadas em "Other".
# Isso é especialmente útil para gráficos de pizza ou barras, 
# evitando que apareçam dezenas de rótulos pequenos e irrelevantes.

table(animais_lumped)

# ================================================================

# 8. ggplot2 (visualização)

# ggplot() - inicializa gráfico
# geom_point() - gráfico de dispersão
# geom_line() - linha
# geom_col() / geom_bar() - barras
# geom_histogram() - histograma
# geom_boxplot() - boxplot
# facet_wrap() / facet_grid() - dividir gráfico em painéis
# labs() - títulos e eixos
# theme_minimal(), theme_classic() - temas

# Exemplo de visualizações.

library(ggplot2)

# geom_point() — gráfico de dispersão.
# Base: altura cm vs peso kg.
# geom_point() adiciona os pontos (scatter plot).
# color define a cor dos pontos.
# size define o tamanho.
ggplot(dados, aes(x = height, y = mass)) +
  geom_point(color = "steelblue", size = 3)

# ----------

# geom_line() — gráfico de linha
# geom_line() liga os pontos por uma linha.
# Requer uma variável contínua no eixo x.
# Ideal para séries temporais ou tendências.
ggplot(dados, aes(x = mass, y = sex)) +
  geom_line(color = "darkorange", linewidth = 1)

# ----------

# geom_col() / geom_bar() — gráfico de barras.
# geom_col() → usa valores já fornecidos em y.
ggplot(dados, aes(x = as.factor(mass), y = height)) +
  geom_col(fill = "seagreen")

# ----------

# geom_col() / geom_bar() — gráfico de barras.
# geom_bar() → conta automaticamente as ocorrências (não precisa de height).
ggplot(dados, aes(x = as.factor(mass))) +
  geom_bar(fill = "purple")

# ----------

# geom_histogram() — histograma.
# Agrupa valores numéricos em intervalos (bins).
# binwidth → tamanho das classes.
# Mostra distribuição de frequência.
ggplot(dados, aes(x = height)) +
  geom_histogram(binwidth = 3, fill = "skyblue", color = "black")

# ----------

# geom_boxplot() — boxplot
# Mostra mediana, quartis e outliers.
# Ideal para comparar distribuições entre grupos.
ggplot(dados, aes(x = as.factor(gender), y = height)) +
  geom_boxplot(fill = "gold")

# ----------

# facet_wrap() / facet_grid().
# facet_wrap: divide por uma variável.
ggplot(dados, aes(x = mass, y = gender)) +
  geom_point(color = "tomato") +
  facet_wrap(~mass)

# ----------

# labs() — títulos, legendas e eixos.
ggplot(dados, aes(x = mass, y = height)) +
  geom_point() +
  labs(
    title = "Relação entre peso e altura",
    subtitle = "Base de dados starswars",
    x = "peso (kg)",
    y = "Altura (cm)",
    caption = "Fonte: dataset starswars"
  )

# ----------

# theme_minimal() — aparência.
# theme_gray() (padrão)
# theme_light()
# theme_dark()
# theme_bw()
ggplot(dados, aes(x = mass, y = height)) +
  geom_point(color = "darkgreen") +
  theme_minimal()

# ----------

# theme_classic() — aparência.
# theme_gray() (padrão)
# theme_light()
# theme_dark()
# theme_bw()
ggplot(dados, aes(x = height, y = mass)) +
  geom_point(color = "darkred") +
  theme_classic()



