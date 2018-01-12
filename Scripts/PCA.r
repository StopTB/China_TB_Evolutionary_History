library("factoextra")


data <- read.csv("PCA_test_2.csv", header = T)
data1 <- as.data.frame(data)

res.pca <- prcomp(data1[, c(-1,-2)],  scale = TRUE)

fviz_pca_ind(res.pca)

#Color individuals by groups
fviz_pca_ind(res.pca, label="none", habillage=data1$SUB)

#Add ellipses
p <- fviz_pca_ind(res.pca, label="none", habillage=data1$SUB,
                  addEllipses=TRUE, ellipse.level=0.95)
print(p)

# change x, y 

p + xlim(-50, 40) + ylim (-50, 40)+
  theme_minimal()

# Change group colors using RColorBrewer color palettes
p + scale_color_brewer(palette="Dark2") +
  theme_minimal()

p + scale_color_brewer(palette="Paired") +
  theme_minimal()

p + scale_color_brewer(palette="Set1") +
  xlim(-50, 40) + ylim (-50, 40)+
  theme_minimal()

# Change color manually
p + scale_color_manual(values=c("#0096FF", "#EEE92A", "#D13894", "#E53E27","#0D9B9B"))
#

fviz_pca_ind(res.pca, col.ind = "blue")+
  xlim(-40, 40) + ylim (-30, 40)+
  theme_minimal()