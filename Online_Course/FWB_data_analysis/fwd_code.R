#Download dplyr
install.packages("dplyer")

library(dplyr)
library(ggplot2)

#Importing FWB dataset
fwbdata <- read.csv("https://www.consumerfinance.gov/documents/5614/NFWBS_PUF_2016_data.csv")

#subset: less than $50 income
lowinc <- fwbdata %>% filter(PPINCIMP<=4)

table(lowinc$PPINCIMP)

lowinc2 <- lowinc %>% select(PPGENDER,PPHHSIZE,PPINCIMP, FWBscore, finalwt)

#creating a smaller_house dummy variable
lowinc2$smaller_house <- ifelse(lowinc2$PPHHSIZE <= 2, 1,0)

#Renaming the levels of the PPGENDER variable
lowinc2$PPGENDER <- recode(lowinc2$PPGENDER, "1"="Male", "2"="Female")

#Creating a new categorical variable at the intersection of PPGENDER and small_house
lowinc2$gen_small_house <- ifelse(lowinc2$PPGENDER=="Female" & lowinc2$smaller_house==1, "Female living in a smaller house",
                                  ifelse(lowinc2$PPGENDER=="Female" & lowinc2$smaller_house==0, "Female living in a larger house",
                                         ifelse(lowinc2$PPGENDER=="Male" & lowinc2$smaller_house==1, "Male living in a smaller house",
                                                "Male living in a larger house")
                                  )
                            )

#Renaming the levels of the PPINCIMP variable
lowinc2$PPINCIMP <- recode(lowinc2$PPINCIMP, "1"="Less than $20,000",
                           "2"="$20,000 to $29,999",
                           "3"="$30,000 to $39,999",
                           "4"="$40,000 to $49,999")


#Creating a summary statistics table
sum_stat_tab <- lowinc2 %>% group_by(gen_small_house, PPINCIMP) %>% 
#sum_stat_tab <- lowinc2 %>% group_by(PPGENDER, smaller_house) %>% 
                            summarise(Average_FWBscore= round(mean(FWBscore), digits=1),
                                      Average_FWBscore_weighted= round(weighted.mean(FWBscore, finalwt), digits=1),
                                      Median_FWBscore = round(median(FWBscore), digits=1),
                                      SD_FWBscore= round(sd(FWBscore), digits=1))


ggplot(sum_stat_tab, aes(x=gen_small_house, y=Average_FWBscore_weighted, fill=PPINCIMP)) +
  geom_bar(stat="identity", position = "dodge")+
  coord_flip()+
  labs(x=" ", y="Average Financial wellbeing score", fill="Household Income", fill="Household income")+
  theme_minimal()



  


