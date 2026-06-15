setwd("C:/sourcecode/R_Programming/R_Survey_Code/Online_Course/SHED_data_analysis")

install.packages("fixest")

#Importing SHED Dataset

shed2020 <- read.csv("public2020.csv")
shed2021 <- read.csv("public2021.csv")
shed2022 <- read.csv("public2022.csv")
shed2023 <- read.csv("public2023.csv")
shed2024 <- read.csv("public2024.csv")
shed2025 <- read.csv("public2025.csv")

library(dplyr)

#create a Year variable
shed2020$year <- 2020
shed2021$year <- 2021
shed2022$year <- 2022
shed2023$year <- 2023
shed2024$year <- 2024
shed2025$year <- 2025

#Create a common weight variable (see the codebook)
shed2020$weight <- shed2020$weight_pop
shed2021$weight <- shed2021$weight_pop
shed2022$weight <- shed2022$weight_pop
#shed2023
#shed2024
#shed2025

common_col_names <- Reduce(intersect, list(
                                  names(shed2020),
                                  names(shed2021),
                                  names(shed2022),
                                  names(shed2023),
                                  names(shed2024),
                                  names(shed2025)))

#Merging all by the common columns
data <- rbind(shed2020 %>% select(all_of(common_col_names)),
              shed2021 %>% select(all_of(common_col_names)),
              shed2022 %>% select(all_of(common_col_names)),
              shed2023 %>% select(all_of(common_col_names)),
              shed2024 %>% select(all_of(common_col_names)),
              shed2025 %>% select(all_of(common_col_names)))

# create a line chart

table(data$B7_b)

#selecting respondents who provided an answer

data_line_chart <- data %>% filter(B7_b=="Poor"|B7_b=="Good"|B7_b=="Only fair"|B7_b=="Excellent")

#create a binary poor economic

data_line_chart$econ_poor <- ifelse(data_line_chart$B7_b=="Poor", 100.0, 0)

table(data_line_chart$econ_poor)

#Create a line chart

library(ggplot2)

data_line_chart %>% group_by(year, ppethm) %>% 
    summarise(Poor=weighted.mean(econ_poor, weight)) %>%
    ggplot(aes(y=Poor,x=factor(year), group=ppethm, color=ppethm)) + 
    geom_point(size=5) +
    geom_line(size=2) + labs(title = "% of Americans Saying Current Economic Conditions Are Poor", y="Percent",x="", color="Race and ethnicity")
    theme_bw()

#saving a chart
ggsave("econ_poor.png", width=10, height=4)

#saving a table
table <- data_line_chart %>% group_by(year) %>% summarise(Poor=weighted.mean(econ_poor, weight))

write.csv(table,"econ_poor_table.csv")

library(fixest) 

model1 <- feols(econ_poor ~ ppgender,
                data = data_line_chart,
                weight = data_line_chart$weight)

etable(model1)

model2 <- feols(econ_poor ~ ppgender+ppagecat,
                data = data_line_chart,
                weight = data_line_chart$weight)

etable(model2)

model3 <- feols(econ_poor ~ ppgender+ppagecat+ppgender:ppagecat,
                data = data_line_chart,
                weight = data_line_chart$weight,
                se="hetero")

etable(model3)

reg_tab <- etable(model1, model2, model3, keep="x", digits=2)




