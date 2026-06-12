library(tidyverse)

#data()
#View(mpg)
#glimpse(mpg)

mpg_efficient <- filter(mpg, cty >= 20)
View(mpg_efficient)

mpg_ford <- filter(mpg, manufacturer == "ford")
View(mpg_ford)

#mpg_metric <- mutate(mpg, cty_metric = 0.425144 * cty)

mpg_metric <- mpg %>%
  mutate(cty_metric = 0.425144 * cty)

mpg %>%
  group_by(class) %>%
  summarise(mean(cty),
    median(cty))

ggplot(mpg, aes(x = cty)) + geom_histogram() + labs(x = "City mileage")
ggplot(mpg, aes(x = cty)) + geom_freqpoly() + labs(x = "City mileage")

ggplot(mpg, aes(x = cty, y = hwy)) + geom_point() + geom_smooth(method = "lm")
ggplot(mpg, aes(x = cty, y = hwy, color=class)) + 
  geom_point() + 
  scale_color_brewer(palette = "Dark2")
