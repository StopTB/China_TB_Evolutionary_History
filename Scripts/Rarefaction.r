library("iNEXT")

library("ape")

library("ggplot2")

library(grid)

h1 <- list(china=c(128,31,15,8,6,1,1,1,1), 
           india=c(87,37,18,17,17,6,5,3,3,2,1,1,1,1,1),
           vietnam=c(96,43,14,10,7,6,5,4,3,3,2,2,2,1,1,1))

h2 <- as.list(h1)
h2[1:3] <- lapply(h2[1:3], as.numeric)

out <- iNEXT(h2, q=0, datatype="abundance", endpoint=500)

g <- ggiNEXT(out, type=1)

gb3 <- ggplot_build(g)

gb3$data[[1]]$size <- 3

gb3$data[[2]]$size <- 1

gt3 <- ggplot_gtable(gb3)

grid.draw(gt3)
  
g4 <- g + theme_bw() + theme(legend.position = "right") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
gb4 <- ggplot_build(g4)
gb4$data[[1]]$size <- 3
gb4$data[[2]]$size <- 1
gt4 <- ggplot_gtable(gb4)
grid.draw(gt4)

#  scale_shape_manual(values=c(19,19,19))+
  scale_linetype_manual(values = c(1,2,2))
  theme_bw()+
  theme(line = 1, panel.grid.major = element_blank(), panel.grid.minor = element_blank())


geom_line(out, size=0.3)


data1 <- as.list(data)
data1[1:2] <- lapply(data1[1:2], as.numeric)
h2[1:2] <- lapply(h2[1:2], as.numeric)

iNEXT(test1, q=0, datatype="abundance")
iNEXT(spider, q=0, datatype="abundance")
iNEXT(h2, q=0, datatype="abundance")


test1[1:2] <- lapply(test1[1:2], as.numeric)

out <- iNEXT(h2, q=c(0,1,2), datatype="abundance", endpoint=500)
out <- iNEXT(h2, q=0, datatype="abundance", endpoint=500)
ggiNEXT(out, type=1, facet.var="site")

ggiNEXT(out, type=1, facet.var="order")
ggiNEXT(out, type=1)

ggiNEXT(out, type=1, facet.var="order", grey=TRUE)