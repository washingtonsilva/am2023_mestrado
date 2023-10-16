
# NOME: aula01_script.R
#
# DESCRICAO: - script para aula 1 em 16/10/2023 da disciplina optativa 
#              Analise Multivariada do Mestrado Prof. em Administracao.
#             - Topicos tratados:
#            1.  Introducao a linguagem R
#            1.1 packages, importacao de dados, sintaxe da linguagem, tipos e 
#                estrutras de dados, manipulcacao de estrutras de dados,
#                manipuando dados com dplyr.
#
# AUTOR: Washington S. da Silva                                                       #
# ULTIMA ALTERACAO: 15/10/2023                                          


# pacotes utilizados ------------------------------------------------------

# verifique sempre se os pacotes estão instalados!

# lembre-se que pode instalá-los retirand o comentario 
# do comando abaixo e executando-o
# install.packages("here", "readxl",,"dplyr", "skimr", "gapminder")

# Ativa os pacotes para a sessao:
library(here) 
library(readxl)
library(dplyr)
library(skimr)
library(gapminder)

# importando arquivos de dados --------------------------------------------

# hair6e_data.xls: arquivo xls disponibilizado por HAIR et. al. (2009)
path_xls <- here("data_raw", "hair6e_data.xls")

hatco <- readxl::read_xls(
  path_xls,
  sheet = "HATCO",
)

# visao geral
dplyr::glimpse(hatco)

# visao mais detalhada
str(hatco)

# estatisticas descritivas
skimr::skim(hatco)


# Obtendo ajuda -----------------------------------------------------------

# acessa a ajuda sobre a funcao log()
?dplyr::glimpse

# realiza uma busca ampla em toda a documentacao sobre um termo:
??multivariate


# Usando R como uma calculadora -------------------------------------------

# adicao
2 + 18  

# subtracao
2 - 18

# divisao
50821/6 

# multiplicacao
21*4  

# exponencial
exp(10) 

# log natural de 10
log(10)  

# combinacao de n elementos k a k 
choose(10, 8) 

# fatorial
factorial(100)

# funcoes trigonometricas
cos(pi)
sin(pi) 

# arredontamento
round(pi, digits=2) 


## Precedencia de operacoes -----------------------------------------------

# divisao tem precedencia
1/200*30

# definimos a precedencia com parenteses
1/(200*30)
(59 + 73 + 2)/3

## Variaveis e atribuicao de valores --------------------------------------

# é melhor usar <- para atribuir valores
# atalho: Alt + (-)
x <- 3*4 
x

# = funcina mas nao é uma boa pratica
x = 5*9 
x

## Sintáxe da Linguagem: R é case-sensitive -------------------------------
(r_rocks <- 2^3)

r_rock
R_rocks
r_rocks


## Operadores lógicos -----------------------------------------------------

a <- 5; b <- 7

a < b           
a <= b    
a > b    
a >= b
a == b    # exatamente igual          
a != b    # não igual a


# variaveis logicas
x <- TRUE
x

y <- FALSE
y

# complemento logico ou negacao de x
!x        

x & y     # x e y               
x | y     # x ou y 

z <- 12
z > 5 & z < 15


## Tipos Atômicos ---------------------------------------------------------

a <- 1.23
typeof(a)     # fornece o tipo atomico do objeto

# L é usada para definir numeros inteiros
b <- 2L
b
typeof(b)

d <- "João" 
d
typeof(d)

e <- TRUE
e
typeof(e)

# Fazendo a coerção de `logical` para `numeric`
v <- as.numeric(e)
v

c <- 1 + 3i
c
typeof(c)

## Tipos Especiais --------------------------------------------------------

# NA = Not Available 
g <- c(0, NA, 4, 7, NA)
g

# NaN = Not a Number 
h <- c(0/0, 2, 100)
h

# Inf = infinity 
i <- c(1, 100/0, -10/0)
i


## Estruturas de Dados ----------------------------------------------------

# vetores podem conter elementos de somente um tipo de dados atomico!

# vetor: numeric
vec1 <- c(0.5, 0.6, 0.1, 0.8, 2, 1.5) 
print(vec1)
class(vec1)

# vetor: logical 
vec2 <- c(TRUE, FALSE)            
vec2
class(vec2)

# vetor: character
vec3 <- c("a", "b", "c")             
vec3
class(vec3)

# vetor: integer
vec4 <- 9:29                        
vec4
class(vec4)

# vetor: complex
vec5 <- c(1+0i, 2+4i)           
vec5
class(vec5)

# vetorização
# A vetorização signfica que podemos realizar operações diretamente 
# em vetores 

x <- c(1, 2, 3, 4, 5)
y <- c(2, 3, 4, 5, 6)
resultado <- mean((x - y)^2)
resultado


## Data Frame -------------------------------------------------------------

# É a estrutura de dados mais utilizada em analises de dados
# as linhas representam observações e as colunas variáveis, ou 
# caracteríticas das observações
# As colunar podem ter tipos de dados  atomicos diferentes, ou seja,
#  Diferentes colunas podem conter tipos de dados diferentes.

# Criando a data frame df1
df1 <- data.frame(x1 = c(7.1, 2.5, 8.4, 3.2, 3.8, 7.3),        
                  x2 = c("H", "M", "M", "H", "M", "H"),
                  x3 = c(0, 0, 1, 1, 0, 1)
                  )
df1
str(df1)


# criando a data frame dataf
custo = c(120, 180, 348, 125, 290)
preco = c(152, 239, 487, 145, 345)
produto = c("A","B","C","D","E")
dataf = data.frame(produto, custo, preco)
str(dataf)
dplyr::glimpse(dataf)


## Matrix -----------------------------------------------------------------

# Criando uma Matriz 
m <- matrix(c(0, 2, 1, 0), nrow = 2, ncol = 2, byrow = TRUE)
m

# dimensoes da matriz
dim(m)   

# adicao
m + m 

# subtracao
m - m 

# multiplicacao por escalar
2*m 

# multiplicacao de matrizes
m %*% m  

# multiplicacao elemento x elemento
m*m    

# matriz transposta
t(m)     

# inversa de m1 (se existir)
solve(m) 

# validando a inversa
solve(m) %*% m == diag(nrow = nrow(m), ncol = ncol(m))

# autovalores e autovetores
eigen(m)


## List -------------------------------------------------------------------

# as listas são as estruturas de dados mais complexas da linguagem R
# cada elemento de uma lista pode ser uma estrutura de dados diferente.

lista_1 <- list(vec1, df1, m)
lista_1

# Manipulacao de Dados ----------------------------------------------------

# Vetores 

# lista os objetos ativos na secao
ls() 

# Extracao de elementos de Vetores
print(vec1)

# seleciona o primeiro elemento
vec1[1]

# seleciona o sexto elemento
vec1[6]		     

# seleciona todos, exceto o primeiro elemento
vec1[-1]      

# seleciona todos menos o primeiro e o segundo elementos
vec1[c(-1,-2)]  

# seleciona o segundo e quarto elementos
vec1[c(2,4)]

# seleciona o segundo até o quarto elementos
vec1[c(2:4)]

# substituindo um elemento de um vetor
# O terceiro elemento passa a ser 500

vec1[3] <- 500 
vec1

## Funções Matemáticas e Estatísticas para vetores -------------------------

# calcula o tamanho/numero de elementos do vetor
length(vec1)   

# exibe os elementos únicos no vetor
unique(vec1)  

# ordena os elementos em ordem ascendente
sort(vec1)     

# ordena os elementos em ordem decrescente
sort(vec1, decreasing = TRUE)

# calcula a soma dos elementos
sum(vec1) 

# calcula o produto dos elementos do vetor
prod(vec1)     

# calcula o mínimo dos elementos do vetor
min(vec1)

# calcula o máximo dos elementos do vetor
max(vec1) 

# calcula a média dos elementos
sum(vec1)/length(vec1)
mean(vec1)     

# mediana dos elementos
median(vec1)   

# calcula os valores mínimo e máximo
range(vec1) 

# Calcula a variância dos dados

sum((vec1 - mean(vec1))^2)/(length(vec1) - 1)
var(vec1) 

# calcula o desvio-padrão
sqrt(var(vec1))
sd(vec1)  

# covariância (cov(x,y))
cov(vec1,vec1) 

# correlação (cor(x,y))
cor(vec1,vec1) 

# sumário de estatíticas descritivas
summary(vec1)  

# Lidando com valores faltantes em estatísticas descritivas

# criando um vetor com dados faltantes (missing data)
vetor_na <- c(1, 2, 0, 2, NA, 5, 10, NA)

# tente calcular a média
mean(vetor_na)

# precisamos instruir R sobre os dados faltantes
mean(vetor_na, na.rm = TRUE)

# há dados faltantes no vetor?
is.na(vetor_na)

# quantos dados completos há no vetor?
sum(is.na(vetor_na)) 


# Análise Exploratória de Dados -------------------------------------------

# Dados utilizados

data("gapminder")

# visao geral dos dados

# exibe as primeiras linhas do objeto
head(gapminder) 

# exibe as ultimas linhas do objeto
tail(gapminder)

# visao geral da data.frame
dplyr::glimpse(gapminder)

# tabela de estatisticas descritivas
skimr::skim(gapminder)

# seleção por inclusão
dados <- select(gapminder, year, country, gdpPercap)

# seleção por exclusão
smaller_gapminder_data <- select(gapminder, -continent)

# boa pratica com dplyr
dados <- gapminder %>% select(year, country, gdpPercap)

# analisando resultados apenas para paises da europa
dados <- gapminder %>%
  filter(continent == "Europe") %>%
  select(year, country, gdpPercap)

# analisando resultados apenas para paises da europa em 2007
dados_lifexp2007 <- gapminder %>%
  filter(continent == "Europe", year == 2007) %>%
  select(country, lifeExp)

# estimaando a renda média per capita por continente em todos os anos?
rmp_continente <- gapminder %>%
  group_by(continent) %>%
  summarize(gdpPercap_media = mean(gdpPercap))
rmp_continente




