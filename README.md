# 📌 Guia Prático do Tidyverse no R

Este repositório apresenta uma visão geral dos principais pacotes e funções do Tidyverse, o ecossistema mais poderoso e intuitivo para 
manipulação e visualização de dados em R.

---

## 📌 O que é o Tidyverse?

O tidyverse é um ecossistema de pacotes no R criado para facilitar o trabalho com dados. A ideia central é seguir a filosofia do tidy data, onde:

cada variável é uma coluna,<br>
cada observação é uma linha,<br>
cada valor é uma célula.<br>

Essa padronização torna os dados mais fáceis de manipular, analisar e visualizar.

- Site oficial: [https://www.tidyverse.org/](https://www.tidyverse.org/)

---

## 📌 O tidyverse cobre todo o fluxo de ciência de dados:

- Importar dados
- Organizar dados
- Transformar dados
- Visualizar resultadoss
- Modelar dados
- Comunicar resultados

---

## 📌 Principais pacotes

- readr - importação/exportação de dados
- dplyr - manipulação de dados
- ggplot2 - visualização de dados
- tidyr - organização de dados
- purrr - programação funcional
- tibble - data frames modernos
- stringr - manipulação de strings
- forcats - manipulação de fatores

---

## 📌 Principais funções

### 📌 1. readr (importação/exportação)

- read_csv() - ler CSV
- read_tsv() - ler TSV
- read_delim() - ler delimitados
- write_csv() - salvar CSV
- read_rds() e write_rds() - salvar/ler binário

### 📌 2. dplyr (manipulação de dados)

- select() - selecionar colunas
- filter() - filtrar linhas
- arrange() - ordenar
- mutate() - criar/transformar colunas
- summarise() - resumir valores
- group_by() - agrupar para cálculos
- distinct() - valores únicos
- rename() - renomear colunas
- join functions (left_join, inner_join, right_join, full_join)

### 📌 3. tidyr (organização dos dados)

- pivot_longer() - transformar colunas em linhas
- pivot_wider() - transformar linhas em colunas
- separate() - separar colunas
- unite() - unir colunas
- drop_na() - remover NAs
- replace_na() - substituir NAs

### 📌 4. purrr (programação funcional)

- map() - aplica função sobre listas/vetores
- map_dbl(), map_chr() - retorna vetores tipados
- map_df() - retorna data frame
- pmap() - aplica função com múltiplos argumentos

### 📌 5. tibble (data frames modernos)

- tibble() - cria tibble
- as_tibble() - converte para tibble
- glimpse() - visualização compacta dos dados

### 📌 6. stringr (manipulação de strings)

- str_detect() - detectar padrão
- str_replace() - substituir padrão
- str_to_upper(), str_to_lower(), str_to_title() - maiúsculas/minúsculas
- str_length() - tamanho da string
- str_c() - concatenar

### 📌 7. forcats (fatores/categorias)

- fct_relevel() - reordenar níveis manualmente
- fct_infreq() - ordenar por frequência
- fct_recode() - renomear níveis
- fct_lump() - agrupar categorias raras em "outros"
- 8. ggplot2 (visualização)

### 📌 8. ggplot() - inicializa gráfico

- geom_point() - gráfico de dispersão
- geom_line() - linha
- geom_col() / geom_bar() - barras
- geom_histogram() - histograma
- geom_boxplot() - boxplot
- facet_wrap() / facet_grid() - dividir gráfico em painéis
- labs() - títulos e eixos
- theme_minimal(), theme_classic() - temas

---

## 📌 Pré-requisitos
Antes de rodar o projeto, você precisa ter:

* [Linguagem R](https://cran.r-project.org/) instalada (versão recomendada: ≥ 4.5.1)
* [RStudio](https://posit.co/download/rstudio-desktop/) instalado
* Instalação da [Linguagem R:](https://informaticus77-r.blogspot.com/2025/09/blog-post.html)
* Microtutorial [RStudio:](https://informaticus77-r.blogspot.com/2025/09/blog-post_8.html)

---

## 📌 Pacotes Utilizados

```
install.packages("tidyverse")
```

---

## 📌 Clonar este repositório
Abra o terminal e execute:
```bash
git clone https://github.com/jcarlossc/tidyverse-ecosystem-r.git
cd tidyverse-ecosystem-r
```

---

## 📌 Ativar ambiente virtual com renv
Este projeto utiliza o pacote renv para gerenciar dependências de forma reprodutível.
1. Abra o projeto no RStudio.
2. Ative o ambiente e restaure as dependências:
```
# Estes comandos devem ser executados no console do RStudio.

renv::activate()   # Ativa o ambiente virtual
renv::restore()    # Instala as dependências
```
3. Verifique se tudo está funcionando:
```
# Este comando deve ser executado no console do RStudio.
renv::status()
```

---

## 📌 Sobre
Este material foi criado para servir como introdução ao R, com exemplos simples e organizados para facilitar o aprendizado inicial.

---

## 📌 Contribuições
Se quiser contribuir:
1. Faça um fork deste repositório
2. Crie uma branch para sua feature ou correção (git checkout -b minha-feature)
3. Faça commits descritos claramente
4. Submeta um Pull Request

---

## 📌 Licença
Este projeto está licenciado sob a MIT License.

---

## 📌 Contatos
📌Autor: Carlos da Costa<br>
📌Recife, PE - Brasil<br>
📌Telefone: +55 81 99712 9140<br>
📌Telegram: @jcarlossc<br>
📌Blogger linguagem R: [https://informaticus77-r.blogspot.com/](https://informaticus77-r.blogspot.com/)<br>
📌Blogger linguagem Python: [https://informaticus77-python.blogspot.com/](https://informaticus77-python.blogspot.com/)<br>
📌Email: jcarlossc1977@gmail.com<br>
📌Portfólio em construção: https://portfolio-carlos-costa.netlify.app/<br>
📌LinkedIn: https://www.linkedin.com/in/carlos-da-costa-669252149/<br>
📌GitHub: https://github.com/jcarlossc<br>
📌Kaggle: https://www.kaggle.com/jcarlossc/  
📌Twitter/X: https://x.com/jcarlossc1977

---
