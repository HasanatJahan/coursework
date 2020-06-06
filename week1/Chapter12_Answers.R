library(tidyverse)
library(lubridate)
library(tidyr)


############################################
# Section 12.2.1
# Exercise 2
#################
# table2
table2 %>%
  group_by(country, year) %>% 
  pivot_wider(names_from = type, values_from = count) %>% 
  mutate(cases_by_population = cases/population*10000)

# table 4a and 4b
table4a %>% 
  left_join(table4b) %>% 
  mutate(difference = `2000`-`1999`) %>% 
  mutate(rate = difference / `1999` )


##############################################
# Section 12.3.3
# Exercise 1 & 3 
#################

# 1. Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
# Answer: The functions pivot_longer() and pivot_wider() are not perfectly symmetrical 
# because column type information is lost. When we use pivot_wider() on a data frame, 
# it discards the original column types. It has to coerce all the variables into a single 
# vector with a single type.

# 3. What would happen if you widen this table? Why? 
# How could you add a new column to uniquely identify each value?
# Answer: you could add a new column for the names for age and 
# height of the names. And the values could be the values for 
# the age and height. 

##############################################
























