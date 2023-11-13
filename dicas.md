
## Altera a cor da fonte

[Texto]{style = "color: blue"}

## Altera a cor de fundo de um texto

[Texto Texto Texto]{style = "background-color: yellow"}

## Talves usar em Intro to R

- R é uma linguagem de programação de domínio específico, seu domínio são os métodos estatísticos para análise e visualização de dados.

- R tem uma comunidade online vibrante e próspera (*e.g.*, [Stack Overflow](https://stackoverflow.com/questions/tagged/r)).

- R é muito __flexível e poderosa__—adaptável a praticamente qualquer tarefa, _por exemplo_, 'econometria, análise de dados espaciais, aprendizado de máquina, raspagem de web, limpeza de dados, construção de sites...

- Além disso é __free__ and __open source__.

Fundamentos

1. Tudo é um *objeto* (incluindo funções) e todo objeto possui um *nome* 
e um *valor*

`foo <- c(2, 4, 9)`

3. Usamos __functions__ nesses objetos.

`mean(foo)`

4. Muitas funções estão em *libraries* (*packages*)

`library(dplyr)`

5. R tentará ajudá-lo *help*

`?dplyr`


# AULA 1: SLIDE PARTE 2

# Introdução à Linguagem R

   ## Summário
   ## RStudio Project
   ## R packages
   ## Usando R como uma calculadora
   ## Sintáxe da linguagem: Atribuição
   ## Programando em R: Boas Práticas


# Tipos de Dados (Atômicos)
 
   ## Principais Tipos
   ## Tipos Especiais
   ## Documentação: Definições daLinguagem R 

# Estruturas de Dados

   ## Estruturas de Dados: Visão Geral
   ## Factors: `forcats` package

 # Manipulando dados com o pacote dplyr
 
   ## Data Frames: Manipulação com o pacote `dplyr`
   ## Pacote `dplyr`: Principais Verbos
   ## Tutorial sobre o Pacote `dplyr`
   ## Pacote `dplyr`: Verbos
   ## Pacote `dplyr`: `group_by()` e `summarise()`
   ## O que não foi tratado sobre a Linguagem R?
   ## Referência Adicional
   
   
## PCA: Explicação do cos2

### Intuicao 

Vamos simplificar a ideia do cosseno quadrado na análise de componentes principais (PCA) usando uma analogia.

Imagine que você tem um feixe de luz representando a variabilidade de uma variável nos seus dados originais. Agora, a análise de componentes principais é como um prisma que divide essa luz em diferentes cores, onde cada cor representa uma componente principal.

A qualidade da representação de uma variável no contexto da PCA é como medir o quanto dessa luz original é capturada pelas cores (componentes principais) do prisma.

Agora, o cosseno quadrado age como um indicador de quão alinhada está a luz original com cada componente principal. Se a luz original estiver perfeitamente alinhada com uma componente principal, o cosseno quadrado será próximo de 1. Isso significa que a componente principal captura praticamente toda a variação da variável original.

Por outro lado, se a luz original estiver em um ângulo próximo a 90 graus em relação a uma componente principal, o cosseno quadrado será próximo de 0. Isso indica que a componente principal não está capturando bem a variação da variável original.

Em resumo, o cosseno quadrado mede o quanto a "luz" da variável original está sendo "projetada" nas componentes principais. Quanto mais próximo de 1, melhor a representação, e quanto mais próximo de 0, menos a variabilidade está sendo capturada. Isso ajuda a avaliar quão bem as componentes principais estão expressando as características importantes das variáveis originais na análise de componentes principais.


### Por que ao quadrado?

A escolha do cosseno ao quadrado (cos²) como medida da qualidade da representação de uma variável na análise de componentes principais (PCA) está relacionada à interpretação geométrica do cosseno e à necessidade de expressar a contribuição relativa de uma variável nas componentes principais de forma positiva.

A medida do cosseno em si indica a proporção do comprimento do vetor projetado (variável no espaço das componentes principais) em relação ao comprimento total do vetor original (variável nos dados originais). No entanto, o cosseno pode ser positivo ou negativo, dependendo da direção do vetor.

Ao elevar o cosseno ao quadrado (cos²), você elimina o sinal negativo e obtém uma medida de contribuição positiva, representando a proporção da variabilidade original que é explicada pela projeção no espaço das componentes principais.

Aqui estão algumas razões para usar o cosseno ao quadrado na PCA:

1. **Contribuição Positiva:**
   - O quadrado do cosseno garante que a contribuição de uma variável seja sempre positiva. Isso é importante porque queremos expressar a ideia de que quanto mais bem uma variável é representada, maior é sua contribuição positiva.

2. **Facilidade de Interpretação:**
   - O quadrado do cosseno é mais fácil de interpretar, pois está na escala de 0 a 1, onde 0 indica nenhuma contribuição e 1 indica contribuição total. Isso facilita a compreensão da importância relativa das variáveis.

3. **Consistência com Variância Explicada:**
   - A medida do cosseno ao quadrado é consistente com a interpretação da variância explicada pelas componentes principais. Na PCA, muitas vezes falamos em termos de porcentagem da variância explicada, e o cosseno ao quadrado está na mesma linha conceitual.

Portanto, o uso do cosseno ao quadrado como medida de qualidade da representação em PCA visa simplificar a interpretação e garantir que a contribuição das variáveis seja positiva e facilmente comparável.
