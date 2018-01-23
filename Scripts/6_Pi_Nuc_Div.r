library(ape)
library(pegas)
library(ggplot2)

#run multiple "fa" files, and output into "out.txt"

temp = list.files(pattern="*.fa")
sink("out.txt") 
for (i in 1:length(temp)) {
  fa <- read.dna(temp[i], format="fasta")
  out<- nuc.div(fa)
  print(out)
}
sink() 

# read in data
data <- read.table("all_country_pi.txt", header=T)

# boxplot
ggplot(data, aes(x=factor(Country), y=Pi, fill=Country))+ 
  geom_boxplot(lwd=0.3, alpha=0.3)+
  scale_x_discrete(limits=c("China","Vietnam","India","Russia","Germany",
                            "UK","Malawi","Mali","SA","SL","Ethiopia",
                            "Greenland","Inuit"))+
  scale_y_continuous(limits = c(0,5E-04))+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme(axis.text.x = element_text(size = 7, face = "bold",vjust=0.6, angle = 45))