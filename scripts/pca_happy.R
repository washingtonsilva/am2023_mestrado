


path_happy <- here::here("data_raw", "world-happiness-report-2021.csv")

HAPPY <- read.csv(path_happy, check.names = FALSE)

dplyr::glimpse(HAPPY)

happy <- HAPPY[,8:12]

rownames(happy) <- HAPPY[,1]


happy_pca <-
  FactoMineR::PCA(happy,
    scale.unit = TRUE,
    ncp = 5,
    graph = F
  )

summary(happy_pca)


factoextra::fviz_screeplot(
  happy_pca,
  choice = "variance",
  addlabels = TRUE,
  ylim = c(0, 100)
)


factoextra::fviz_pca_var(happy_pca, col.var = "red")

factoextra::fviz_pca_ind(happy_pca, col.var = "blue", col.ind="cos2", repel = TRUE)

factoextra::fviz_pca_biplot(happy_pca, 
                            label = "all", 
                            col.var = "red",
                            col.ind = "blue",
                            repel = TRUE)

