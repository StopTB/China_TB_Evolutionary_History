library(ggplot2)

MTBC <- read.table("data.txt", header = T, fill = T )
options(max.print=1000000)

ggplot(data=MTBC) + 
  geom_line(aes(x=y5, y=l5),color="Magenta", linetype="dotted", alpha=0.5) + 
  geom_line(aes(x=y5, y=u5),color="Magenta", linetype="dotted", alpha=0.5) + 
  geom_line(aes(x=y5, y=m5), size=0.5, color="Magenta") + 
  geom_line(aes(x=y4, y=l4),color="orange", linetype="dotted", alpha=0.5) +
  geom_line(aes(x=y4, y=u4),color="orange", linetype="dotted", alpha=0.5) + 
  geom_line(aes(x=y4, y=m4), size=0.5, color="orange") + 
  geom_line(aes(x=y3, y=l3),color="BlueViolet", linetype="dotted", alpha=0.5) +
  geom_line(aes(x=y3, y=u3),color="BlueViolet", linetype="dotted", alpha=0.5) + 
  geom_line(aes(x=y3, y=m3), size=0.5, color="BlueViolet") + 
  geom_line(aes(x=y1, y=l1),color="DodgerBlue", linetype="dotted", alpha=0.5) +
  geom_line(aes(x=y1, y=u1),color="DodgerBlue", linetype="dotted", alpha=0.5) + 
  geom_line(aes(x=y1, y=m1), size=0.5, color="DodgerBlue") + 
  geom_line(aes(x=y2, y=l2),color="Navy", linetype="dotted", alpha=0.5) +
  geom_line(aes(x=y2, y=u2),color="Navy", linetype="dotted", alpha=0.5) + 
  geom_line(aes(x=y2, y=m2), size=0.5, color="Navy") + 
  scale_x_continuous(name="Year",limits=c(800, 2010), breaks=c(seq(800,2010, by=200))) + 
  scale_y_log10(name="Effective Population Size", limits=c(100, 1000000), breaks=c(1E+02, 1E+03, 1E+04, 1e+05, 1E+06, 1E+07) )+   
  theme_bw() + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())