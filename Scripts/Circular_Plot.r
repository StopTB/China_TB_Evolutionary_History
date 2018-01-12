library(circlize)

df <- read.csv("cirlular.csv", header = T)
# two groups
cate <- as.character(unique(df[[1]]))
species <- as.character(unique(df[[2]]))

# color
library(RColorBrewer)
#col1 = brewer.pal(5, "Set1")
col1= c("#0096FF", "#0365C0", "#A899C4", "#EEE92A", "#D13894")
names(col1) = species
col2 = brewer.pal(length(cate), "Set3")
names(col2) = cate


df[[1]] = as.character(df[[1]])
df[[2]] = as.character(df[[2]])

sector = NULL
sector_xlim =  NULL
for(t in unique(df[[1]])) {
  sector = c(sector, t)
  sector_xlim = rbind(sector_xlim, c(0, sum(df[df[[1]] == t, 3])))
}
for(t in unique(df[[2]])) {
  sector = c(sector, t)
  sector_xlim = rbind(sector_xlim, c(0, sum(df[df[[2]] == t, 4])))
}

# start to plot
circos.par(cell.padding = c(0, 0, 0, 0), start.degree = 270, gap.degree = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 10))
circos.initialize(factors = factor(sector, levels = sector), xlim = sector_xlim,
                  sector.width = c(sector_xlim[1:11,2]/sum(sector_xlim[1:11,2]), 1*sector_xlim[12:16,2]/sum(sector_xlim[12:16,2])))

#plot the row and column names, cex = font size
circos.trackPlotRegion(ylim = c(0, 1), panel.fun = function(x, y) {
  sector.index = get.cell.meta.data("sector.index")
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  circos.text(mean(xlim), mean(ylim), sector.index, cex = 0.5,facing = "bending.inside", niceFacing = TRUE)
}, track.height = 0.2, bg.border = NA)

#plot the first track colors
circos.trackPlotRegion(ylim = c(0, 1), panel.fun = function(x, y) {
  circos.axis(h = "top", labels.cex = 0.3, major.tick.percentage = 0.1)
}, track.height = 0.02, bg.col = c(col2, col1), track.margin = c(0, 0.01))

#plot the second track blanks
circos.trackPlotRegion(ylim = c(0, 1), panel.fun = function(x, y) {
}, track.height = 0.02, track.margin = c(0, 0.01))

#plot ribbons
accum_species = sapply(species, function(x) get.cell.meta.data("xrange", sector.index = x)); names(accum_species) = species
accum_cate = sapply(cate, function(x) get.cell.meta.data("xrange", sector.index = x)); names(accum_cate) = cate
for(i in seq_len(nrow(df))) {
  circos.link(df[i,1], c(accum_cate[df[i,1]], accum_cate[df[i,1]] - df[i, 3]),
              df[i,2], c(accum_species[df[i,2]], accum_species[df[i,2]] - df[i, 4]),
              col = paste0(col1[df[i,2]], "80"), border = NA)
  
  circos.rect(accum_cate[df[i,1]], 0, accum_cate[df[i,1]] - df[i, 3], 1, sector.index = df[i,1], col = col1[df[i,2]])
  circos.rect(accum_species[df[i,2]], 0, accum_species[df[i,2]] - df[i, 4], 1, sector.index = df[i,2], col = col2[df[i,1]])
  
  accum_cate[df[i,1]] = accum_cate[df[i,1]] - df[i, 3]
  accum_species[df[i,2]] = accum_species[df[i,2]] - df[i, 4]
}
circos.clear()