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

df <- consent

#consent$waifu_num <- consent$Q2.1.1 + consent$Q2.1.2 + consent$Q2.1.3
#table(consent$waifu_num)

df$waifu_num <- rowSums(df[, grep("^Q2\\.2[.-]", names(df))], na.rm = TRUE)
df$meta_num  <- rowSums(df[, grep("^Q2\\.1[.-]", names(df))], na.rm = TRUE)

table(df$meta_num)
table(df$waifu_num)

df2 <- df %>% select(ID,TIMESTAMP,Q0.1, Q0.2, Q1.1, Q1.2, Q1.3,meta_num, waifu_num, Q2.3, Q3.1, Q3.2, Q3.3, Q3.4, Q3.5, Q4.1, Q4.2, Q5.1,Q5.2,Q5.3,Q5.4,Q5.5,Q5.6,Q5.7)

