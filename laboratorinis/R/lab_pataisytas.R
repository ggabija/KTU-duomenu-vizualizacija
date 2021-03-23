library(tidyr)
library(tidyverse)
library(dplyr)
library(quantreg)
library(ggplot2)
getwd()
#Failo nuskaitymas
data <- read.csv("../data/lab_sodra.csv", encoding = "UTF-8", stringsAsFactors = FALSE)
summary(data)
data <- data %>% mutate(month_=as.integer(substr(month, 5 ,7)))
#1 uzduotis
data %>% filter(ecoActCode == "471100") %>% 
  ggplot(aes(x = avgWage)) + 
  geom_histogram(binwidth = 5, bins = 300, fill="darkblue") + 
  ggtitle("Vidutinio atlyginimo histograma")

#2 uzduotis
topnames <- data %>% filter(ecoActCode == "471100") %>% group_by(name) %>% slice_max(avgWage, n=1) %>% ungroup() %>%
          top_n(avgWage, n=5) %>% select(name)
top5 <- data %>% filter(name %in% topnames$name)
ggplot(top5, aes(x = month_, y = avgWage , color = name)) +
  geom_line() + scale_x_continuous(breaks = 1:12, limits = c(1, 12))

#3 uzduotis
top5 %>%
  group_by(name) %>%
  top_n(numInsured, n=1) %>% distinct(name, numInsured) %>%
  ggplot() + geom_col(aes(x = (reorder(name, -numInsured)), y = numInsured, color = name)) + 
  xlab("Imones") + ylab("Apdraustu darbuotoju skaicius") + ggtitle("Apdraustu darbuotoju skaicius")


  