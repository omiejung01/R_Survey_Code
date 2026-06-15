setwd("C:/sourcecode/R_Programming/R_Survey_Code/Online_Course/ATUS_data_analysis")

library(dplyr)
library(ggplot2)

act <- read.csv("atusact_2022.DAT")
resp <- read.csv("atusresp_2022.DAT")

options(scipen = 999)

data <- merge(resp, act, by="TUCASEID")

walking <- data %>% filter(TEWHERE==14)

fivenum(walking$TUACTDUR)

#Histogram
ggplot(walking, aes(x=TUACTDUR)) +
  geom_histogram(binwidth = 1) + theme_classic() + labs(x="Duration per trip (in minutes)")+
  xlim(0, 100)


#Boxplot
ggplot(walking, aes(x=TUACTDUR, fill=factor(TUDIARYDAY))) +
  geom_boxplot() + theme_classic() + labs(x="Duration per trip (in minutes)", fill="Diary Day")+
  xlim(0, 100)+theme(axis.text.y=element_blank(),
                     axis.ticks.y = element_blank())
