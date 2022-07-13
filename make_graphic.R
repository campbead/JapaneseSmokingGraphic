#https://data.oecd.org/healthrisk/daily-smokers.htm
library(dplyr)
library(ggplot2)
library(camptheme)
library(RColorBrewer)

full_data <- read.csv("data/DP_LIVE_08072022232509779.csv")

countries <- c("USA", "NLD", "NZL", "NOR", "JPN", "RUS", "FIN")
countries_original <- c("USA", "NLD", "NOR", "JPN", "FIN")

long_country_names <- c("United States", "Netherlands", "Norway", "Japan", "Finland")

country_names <- data.frame(countries_original, long_country_names)



data <- full_data %>%
  filter(LOCATION %in% countries_original) %>%
  left_join(country_names, by=c("LOCATION" = "countries_original")) %>%
  filter(SUBJECT == "TOT") %>%
  select(c("long_country_names", "TIME", "Value"))

ggplot(data, aes(x=TIME, y= Value, color= long_country_names)) +
  geom_point(size = 2, alpha = 0.7) +
  scale_colour_brewer(palette = "Dark2") +
  xlab("")+
  ylab("")+
  xlim(c(1980,2019))+
  ylim(c(5,45))+

  ggtitle("Smokers as a percentage of adult population (15+)")+
  labs(caption= "data: data.oecd.org/healthrisk/daily-smokers.htm | @campbead")+
  theme_campbead() +
  theme(legend.position="top",
        legend.title=element_blank())
ggsave("output/Smokers-as-a-percentage-of-adult-pop.png",
       width = 18, height = 10, units = "cm")
