#Download dplyr
install.packages("dplyer")

library(dplyr)

#Importing FWB dataset

fwbdata <- read.csv("https://www.consumerfinance.gov/documents/5614/NFWBS_PUF_2016_data.csv")

#subset: less than $50 income
lowinc <- fwbdata %>% filter(PPINCIMP<=4)

table(lowinc$PPINCIMP)

lowinc2 <- lowinc %>% select(PPGENDER,PPHHSIZE,PPINCIMP)


