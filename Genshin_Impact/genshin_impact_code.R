# importing Genshin Impact Dataset

install.packages("dplyr")
install.packages("psych")

library(dplyr)
library(psych)
?describe


genshindata <- read.csv("https://tetrasolution.com/research/genshin_impact_jan2026.csv")

print("Number of records")
print(nrow(genshindata))

playgame <- genshindata %>% filter(Q0.1==1)
print("Number of players")
print(nrow(playgame))

consent <- playgame %>% filter(Q0.2==1)
print("Number of respondents who give consent")
print(nrow(consent))

summary(consent)

describe(consent)

consent$waifu_num <- consent$Q2.1.1 + consent$Q2.1.2 + consent$Q2.1.3

table(consent$waifu_num)




