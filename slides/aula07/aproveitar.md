## PIES: Simulação

```{r, echo = FALSE, results ="hide", message = FALSE, warning = FALSE }
# specifica o modelo
piesDataModel <- "General =~ 0.9*i1 + 0.7*i2 + 0.5*i3
                  Feature =~ 0.3*i3 + 0.7*i4 + 0.9*i5 + 0.5*i6  + 0.9*i7
                  Image   =~ 0.2*i3 + 0.8*i8 + 0.9*i9 + 0.8*i10 + 0.7*i11 
                  PIES =~ 0.7*General + 0.8*Feature + 0.8*Image"

# dados simulados
library(lavaan)
set.seed(10001)    
piesSimData.norm <- simulateData(piesDataModel, sample.nobs = 3600)
print(head(piesSimData.norm), digits = 2)

# converter os números reais em itens do tipo Likert na escala de 1 a 7
piesSimData <- data.frame(lapply(piesSimData.norm, 
                          function(x) {cut(x, breaks = 7, labels = FALSE)}))

# ajusta o modelo estrutural aos dados simulados
# definir o modelo estrutural hierárquico 
piesModel0 <- "General =~ 0.9*i1 + 0.7*i2 + 0.5*i3
               Feature =~ 0.3*i3 + 0.7*i4 + 0.9*i5 + 0.5*i6  + 0.9*i7
               Image   =~ 0.2*i3 + 0.8*i8 + 0.9*i9 + 0.8*i10 + 0.7*i11"

pies.fit <- cfa(piesModel0, data = piesSimData, warn = FALSE)

# figura do modelo
library(semPlot)
semPaths(pies.fit, what = "path", fade = FALSE, residuals = FALSE,
         edge.label.cex = 0.75, fixedStyle = 1, edge.color = "darkblue")
```



## Agora...dados!

11 itens para dados simulados sobre Product Interest and Engagement Data 
(PIES), classificados em Escala tipo Likert de 7 pontos. 

**Itens**: 

*Paraphrased item*        | &nbsp;
------------------------  | -------------------------
not important *[reversed]*| never think *[reversed]* 
very interested           | look for specific features
investigate in depth      | some are clearly better
learn about options       | others see, form opinion
expresses person          | tells about person
match one's image         | &nbsp; 



## Etapa 1: Importar e Preparar os dados

Importando os dados 
```{r}
pies.data <- read.csv("http://goo.gl/yT0XwJ")
```

Nomeando:

```{r, echo=FALSE}
names(pies.data) <- c(
  "NotImportant", "NeverThink", "VeryInterested", "LookFeatures",
  "InvestigateDepth", "SomeAreBetter", "LearnAboutOptions",
  "OthersOpinion", "ExpressesPerson", "TellsAbout", "MatchImage"
)

psych::describe(pies.data)
```



## Modelo CFA alvo para PIES

Definiremos um **modelo de 3 fatores** com fatores potencialmente 
correlacionados.

```{r, echo=FALSE, results="hide", message=FALSE, warning=FALSE }
names(pies.data) <- paste0("i", 1:11)
piesModel3 <- "General =~ i1 + i2 + i3
               Feature =~ i4 + i5 + i6  + i7
               Image   =~ i8 + i9 + i10 + i11 "

pies.fit3 <- cfa(piesModel3, data = pies.data, warn = FALSE)

# visualizacao
semPlot::semPaths(pies.fit3,
  what = "path", fade = FALSE, residuals = FALSE,
  edge.label.cex = 0.75, fixedStyle = 1, edge.color = "darkblue"
)

```



## Cmodelo comparativo para PIES

Compare um **modelo de 1 fator** em que todas as variáveis são carregadas 
em um fator de *interesse*.

O modelo de 3 fatores deve se ajustar melhor que isso para ser relevante!

```{r, echo=FALSE, results="hide", message=FALSE, warning=FALSE }
piesModel1 <- " Interest =~ i1 + i2 + i3 + i4 + i5 + i6  + i7 +
                            i8 + i9 + i10 + i11 "

pies.fit1 <- cfa(piesModel1, data = pies.data, warn = FALSE)

# plot it
library(semPlot)
semPaths(pies.fit1, what="path", fade=FALSE, residuals=FALSE,
         edge.label.cex=0.75, fixedStyle = 1, edge.color="darkblue")

```



## Ajuste de Modelos: Medidas de Qualidade do Ajuste

**Global fit indices**

Exemplo: Comparative Fit Index (CFI). Tentativas de avaliar o ajuste "absoluto" versus os dados. Medidas não muito boas, mas estabeleça uma barra mínima: quero ajuste > 0,90.$

**Approximation error and residuals** 

Exemplo: Standardized Root Mean Square Residual (SRMR). Diferença entre o
matriz de covariância dos dados e a matriz do modelo ajustado. 

- Desejamos $SRMR <0,08$. Para Erro quadrático médio de aproximação, desejamos 
CI inferior $(RMSEA) <0,05$.

**Information Criteria**  

Exemplo: Critério de Informação de Akaike (AIC). Avalia o ajuste do modelo 
versus os dados observados. Nenhuma interpretação absoluta, mas quanto menor, melhor. Diferença de 10 ou mais é grande.



## Código R para ajustar um modelo 3-fatores

É muito simples definir e ajustar um CFA em R:

```{r, eval=FALSE}
library(lavaan)

piesModel3 <- " General =~ i1 + i2 + i3
                Feature =~ i4 + i5 + i6  + i7
                Image   =~ i8 + i9 + i10 + i11 "

pies.fit3 <- cfa(piesModel3, data=pies.data)

summary(pies.fit3, fit.measures=TRUE)
```



## Ajuste de Modelos: Modelo 1-Fator

```{r, eval=FALSE}
piesModel1 <- " Interest =~ i1 + i2 + i3 + i4 + i5 + i6  + i7 +
                             i8 + i9 + i10 + i11 "
pies.fit1 <- cfa(piesModel1, data=pies.data)
summary(pies.fit1, fit.measures=TRUE)

  Comparative Fit Index (CFI)        0.672   # Bad

  Akaike (AIC)                  108812.709   # Much higher
  Bayesian (BIC)                108948.860

  RMSEA                              0.143   # Bad
  90 Percent Confidence Interval  0.139  0.147
  P-value RMSEA <= 0.05              0.000   # Bad
  SRMR                               0.102   # Bad
```



## Ajuste de Modelos: Modelo 3-Fatores

```{r, eval=FALSE}
> piesModel3 <- " General =~ i1 + i2 + i3
+                 Feature =~ i4 + i5 + i6  + i7
+                 Image   =~ i8 + i9 + i10 + i11 "
> pies.fit3 <- cfa(piesModel3, data=pies.data)
> summary(pies.fit3, fit.measures=TRUE)

  Comparative Fit Index (CFI)        0.975   # Excellent

  Akaike (AIC)                  105821.776   # Much lower
  Bayesian (BIC)                105976.494

  RMSEA                              0.041   # Excellent
  90 Percent Confidence Interval  0.036  0.045 
  P-value RMSEA <= 0.05              1.000   # Good
  SRMR                               0.030   # Excellent
```

O modelo de 3 fatores se ajusta muito melhor a esses dados.



## Model Paths

```{r, eval=FALSE}
Latent Variables    Estimate  Std.Err  Z-value  P(>|z|)
  General =~                                          
    i1                1.000                           
    i2                0.948    0.042   22.415    0.000
    i3                1.305    0.052   25.268    0.000
  Feature =~                                          
    i4                1.000                           
    i5                1.168    0.037   31.168    0.000
    i6                0.822    0.033   25.211    0.000
    i7                1.119    0.036   31.022    0.000
  Image =~                                            
    i8                1.000                           
    i9                0.963    0.028   34.657    0.000
    i10               0.908    0.027   33.146    0.000
    i11               0.850    0.027   31.786    0.000
```



## Visualize

```{r, echo=FALSE}
library(semPlot)
semPaths(pies.fit3, what="est", fade=FALSE, residuals=FALSE,
         edge.label.cex=0.75, edge.color="darkblue")
```



## Alguns outros pontos sobre CFA {.scrollable}

**Consertando caminhos**

Para tornar um modelo identificável, um caminho deve ser fixado entre um fator e
uma variável. Isso torna os caminhos interpretáveis em relação a essa
variável. Padronizar os preditores é importante para que sejam comparáveis!

**Modelagem das Correlações entre Fatores**

Você pode especificar algumas correlações de fatores como baixas 
(por exemplo, 0,10) ou altas (por exemplo, 0,50). 
Isso é fácil de fazer em R; difere em outros pacotes.

**Modelos Hierárquicos**

Você pode modelar fatores de ordem superior, como "interesse no produto" geral.

A CFA permite variáveis latentes associadas a outras variáveis latentes.



## Cargas fatoriais versus coeficientes de caminho {.scrollable}

Por padrão, EFA e CFA relatam factor::coeficientes 
variáveis em escalas diferentes. 

- Cargas Fatoriais na EFA

As cargas fatoriais da EFA estão na escala *r* de Pearson, ou seja, 
são coeficientes de correlação entre o fator e a variável.

- Coeficientes de caminho CFA

Os caminhos do CFA estão na(s) própria(s) escala(s) das variáveis, fixadas em
1,0 para uma variável por fator. 

Se você padronizar ($Z = \frac{X-\bar{X}}{sd(X)}$) as variáveis e fixa a 
variância dos fatores em 1.0, eles estarão na escala *r*. 

**Observação**: Ter caminhos na escala original é muitas vezes
útil na análise de pesquisas, porque é fácil de comparar com a escala
em si.



## Pontos Principais {.scrollable}

1. Se você usa escalas com vários itens, verifique-as com EFA e CFA! Não apenas
presuma que sua escala está correta ou que os itens são carregados onde 
você espera.

2. Se você tiver scores de vários itens - como itens que somam uma
pontuação de "satisfação" - considere usar pontuações fatoriais.

3. Se você propor um modelo complexo, prove com o CFA que ele é melhor que as alternativas.

4. Esta área tem muito jargão, mas não é intrinsecamente difícil... e é
muito melhor do que ignorá-lo e esperar pelo melhor! SPSS, R, SAS e Stata
todos possuem ferramentas para análise fatorial.



## Workflow para desenvolvimento em escala

1. Identifique os fatores de possível interesse

2. Escreva muitos itens para esses fatores e implemente a uma pesquisa

3. Use a EFA para identificar se os fatores se sustentam e quais itens 
são correlacionados com estes fatores.

4. Repita 1-3 até acreditar que possui fatores confiáveis e bons itens.

5. Use o CFA para demonstrar que os fatores e itens se mantêm em uma 
   nova amostra

Examplo: [PIES scale development paper, Chapman et al, 2009](http://www.userphilosophy.com/wp-content/uploads/2009/02/wip337-chapman.pdf)



## Aprendendo mais: Livros

1. Brown (2015), *Confirmatory Factor Analysis for Applied Research*. Um
texto bom e prático sobre CFA para as ciências sociais.

2. Kline (2015), *Principles and Practice of Structural Equation Modeling*. O
guia definitivo para o uso de CFA e SEM em ciências sociais.

3. DeVellis (2011), *Scale Development*. Um guia muito prático e legível
para construir boas escalas de pesquisa.



## Notas sobre software: pacotes R

1. **`corrplot`** é útil para explorar matrizes de correlação com vistas 
a uma análise fatorial.

2. **`psych`** tem muitas opções para análise fatorial exploratória e outras
aplicações psicométricas (pesquisa/teste).

3. **`lavaan`** é um pacote SEM/CFA fácil de usar. Altamente recomendado.

4. **`semPlot`** cria diagramas de caminho SEM/CFA básicos conforme mostrado 
nestes slides.

5. **`DiagrammeR`** cria diagramas de caminho de qualidade de publicação. Isso requer especificação manual --- tediosa, mas não difícil --- para diagramas EFA/CFA/SEM.

6. **`OpenMX`** fornece opções avançadas para SEM, como modelos de efeitos 
mistos.



## Referências

::: {#refs}
:::
