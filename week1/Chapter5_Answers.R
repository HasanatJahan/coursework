# import all the needed libraries and packages
install.packages(c("nycflights13", "gapminder", "Lahman"))
install.packages("tidyverse")

# put them in the library
library(tidyverse)
library(nycflights13)

##########################################
# Questions from 5.2.4
########################################
# Problem No 1
###############
# Find all flights that
# load the flights dataframe to flights object
flights <- nycflights13::flights
# Had an arrival delay of two or more hours
flights %>% 
  filter(arr_delay >= 120) %>% 
  select(arr_delay, flight)


# Flew to Houston (IAH or HOU)
flights %>% 
  filter(dest == "IAH" | dest == "HOU" ) %>% 
  select(flight, dest)

# Were operated by United, American, or Delta
flights %>% 
  filter(carrier == "UA" | carrier == "AA" | carrier == "DL" ) %>% 
  select(flight, carrier)

# Departed in summer (July, August, and September)
flights %>% 
  filter(month %in% c(7, 8, 9)) %>% 
  select(flight, month)

# Arrived more than two hours late, but didn't leave late
flights %>% 
  filter(arr_delay > 120 & dep_delay <=0) %>% 
  select(flight, arr_delay, dep_delay)

# Were delayed by at least an hour, but made up over 30 minutes in flight
flights %>% 
  filter(dep_delay >= 60 & dep_delay - arr_delay > 30) %>% 
  select(flight, arr_delay, dep_delay)

# Departed between midnight and 6am (inclusive)
flights %>% 
  filter(dep_time <= 600 | dep_time == 2400 ) %>% 
  select(flight, dep_time)

################
# Problem No 3
################
# How many flights have a missing dep_time? 
flights %>% 
  filter(is.na(dep_time)) %>% 
  summarise(count = n()) 

# What other variables are missing? 
colnames(flights)[colSums(is.na(flights)) > 0]

# What might these rows represent?
# They could represent flights where the data is missing, so flights that have been cancelled


#########################################################
# Section 5.5.2 
#########################################################
# Problem No 2 
###############
# Compare air_time with arr_time - dep_time. 
# What do you expect to see? What do you see? 
# What do you need to do to fix it?

## Need help


#####################################################
# Section 5.7.1 
################
# Problem No 3
###############
# What time of day should you fly if you want to avoid delays as much as possible?
flights %>% 
  mutate(time_by_hour = floor_date(time_hour, "hour"))%>%
  group_by(dep_delay,arr_delay, time_by_hour) %>% 
  summarise(count = n()) %>% group_by(time_by_hour) %>% 
  summarise(mean_of_time_hour = mean(count)) %>% 
  arrange(mean_of_time_hour) %>% select(time_by_hour) %>% 
  head(10)










