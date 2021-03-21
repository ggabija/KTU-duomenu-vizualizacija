library(tidyr)
library(tidyverse)
library(dplyr)
library(quantreg)
library(ggplot2)
getwd()
#Failo nuskaitymas
data <- read.csv("../data/lab_sodra.csv", encoding = "UTF-8", stringsAsFactors = FALSE)
summary(data)

#1 uzduotis
data %>% filter(ecoActCode == "471100") %>% 
  ggplot(aes(x = avgWage)) + 
  geom_histogram(binwidth = 5, bins = 300, fill="darkblue") + 
  ggtitle("Vidutinio atlyginimo histograma")

#2 uzduotis
data %>% filter(ecoActCode == "471100") %>%
  arrange(desc(avgWage)) %>% head(6) %>%
  ggplot() + geom_line(aes(x = month, y = avgWage, color = name)) +
  ggtitle("Darbo uzmokestis")

#3 uzduotis
data %>% filter(ecoActCode == "471100") %>%
  arrange(desc(avgWage)) %>% head(6) %>%
  arrange(desc(numInsured)) %>%
  ggplot() + geom_col(aes(x = name, y = numInsured, color = name)) + 
  xlab("Imones") + ylab("Apdraustu darbuotoju skaicius") + ggtitle("Apdraustu darbuotoju skaicius")


  