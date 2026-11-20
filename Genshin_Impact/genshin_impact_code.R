# importing Genshin Impact Dataset

install.packages("dplyr")

library(dplyr)

genshindata <- read.csv("http://tetrasolution.com/research/genshin_impact_jan2026.csv")

playgame <- genshindata %>% filter(Q0.1==1)

