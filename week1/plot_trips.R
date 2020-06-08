########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)

# new package 
library(lubridate)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################
# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
# histogram
trips %>% filter(tripduration / 60 < 1000) %>% 
  ggplot() + 
  geom_histogram(aes(x = tripduration/60 )) + 
  scale_x_log10() +
  scale_y_continuous()
# density 
trips %>% 
  filter(tripduration / 60 < 1000) %>% 
  ggplot() + 
  geom_density(aes(x = tripduration/60 ), fill = "blue", alpha = 0.25) + 
  scale_x_log10() +
  scale_y_continuous()

# plot the distribution of trip times by rider type 
# indicated using color and fill 
# (compare a histogram vs. a density plot)
trips %>% 
  mutate(day_of_week = floor_date(starttime, unit = "day")) %>% 
  group_by(usertype, day_of_week) %>% 
  ggplot(aes(x=day_of_week, color= usertype, fill = usertype)) + 
  geom_histogram() + 
  facet_wrap(~ usertype)

# plot the total number of trips on each day in the dataset
trips %>% mutate(day_of_week = floor_date(starttime, unit = "day")) %>% 
  group_by(day_of_week) %>% 
  ggplot(aes(x= day_of_week)) + 
  geom_histogram()

# plot the total number of trips (on the y axis) by age (on the x axis) and 
# gender(indicated with color)
trips %>% 
  mutate(age = 2020 - birth_year) %>% 
  filter(age <= 100) %>% group_by(age) %>% 
  ggplot(aes(x=age, color = gender, fill = gender)) + 
  geom_freqpoly() + 
  scale_y_sqrt()

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the spread() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered spread() yet)
trips %>% 
  mutate(age = 2020 - birth_year) %>% 
  filter(age <= 100) %>% 
  group_by(age, gender) %>% 
  summarize(count = n()) %>%
  pivot_wider(names_from = gender, values_from = count) %>% 
  mutate(male_to_female_ratio = Male/Female) %>% 
  ggplot(aes(x=age, y=male_to_female_ratio)) + 
  geom_smooth()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>% 
  group_by(date) %>% 
  ggplot(aes(x=date, y= tmin)) + 
  geom_point(aes(alpha = tmin), color = "blue")

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the gather() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered gather() yet)
weather %>% 
  group_by(date) %>% 
  select(date, tmin, tmax) %>% 
  pivot_longer(names_to = "temps", values_to = "temperature", 2:3) %>% 
  group_by(temps) %>% 
  ggplot(aes(x=date, y = temperature)) + 
  geom_point(aes(color=temps))

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, 
# where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

# plot points 
trips %>%
  group_by(ymd) %>% 
  summarize(num_trips_by_date = n()) %>% 
  left_join(weather, by = "ymd") %>% 
  ggplot(mapping = aes(x= tmin, y = num_trips_by_date)) + 
  geom_point(aes(color = tmin))


# smooth
trips %>% 
  group_by(ymd) %>% 
  summarize(num_trips_by_date = n()) %>% 
  left_join(weather, by = "ymd") %>% 
  ggplot(mapping = aes(x= tmin, y = num_trips_by_date)) + 
  geom_smooth(se = FALSE)


# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips %>%
  group_by(ymd) %>% 
  summarize(num_trips_by_date = n()) %>% 
  left_join(weather, by = "ymd") %>% 
  mutate(substantial_prcp = ifelse(prcp > 0.5, "1", "0")) %>% 
  ggplot(mapping = aes(x= tmin, y = num_trips_by_date)) + 
  geom_point(aes(color = substantial_prcp), size = 3) 

# add a smoothed fit on top of the previous plot, using geom_smooth
trips %>%
  group_by(ymd) %>% 
  summarize(num_trips_by_date = n()) %>% 
  left_join(weather, by = "ymd") %>% 
  mutate(substantial_prcp = ifelse(prcp > 0.5, "1", "0")) %>% 
  ggplot(mapping = aes(x= tmin, y = num_trips_by_date)) + 
  geom_point(aes(color = substantial_prcp), size = 3) + 
  geom_smooth()

# compute the average number of trips and 
# standard deviation 
# in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

trips %>% 
  mutate(hour_of_day = hour(starttime), day = floor_date(starttime, unit = "day")) %>% 
  group_by(hour_of_day, day) %>% 
  select(hour_of_day, day) %>% 
  summarise(hour_and_day_count = n()) %>% 
  group_by(hour_of_day) %>% 
  mutate(hour_mean = mean(hour_and_day_count), sd_hour = sd(hour_and_day_count)) %>% 
  pivot_wider(names_from = day, values_from = hour_and_day_count) %>% 
  select(hour_of_day, hour_mean, sd_hour)


# plot the above
trips %>% 
  mutate(hour_of_day = hour(starttime), day = floor_date(starttime, unit = "day")) %>% 
  group_by(hour_of_day, day) %>% 
  select(hour_of_day, day) %>% 
  summarise(hour_and_day_count = n()) %>% group_by(hour_of_day) %>% 
  mutate(hour_mean = mean(hour_and_day_count), sd_hour = sd(hour_and_day_count)) %>% 
  pivot_wider(names_from = day, values_from = hour_and_day_count) %>% 
  select(hour_of_day, hour_mean, sd_hour) %>% 
  ggplot(aes(x = hour_of_day)) + 
  geom_point(aes(y= hour_mean, color = 'hour_mean')) + 
  geom_point(aes(y = sd_hour, color = 'sd_hour')) + 
  scale_color_manual(name= "", values = c("hour_mean" = "red", "sd_hour" = "blue"))

# repeat this, but now split the results by day of the week
# (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips %>% 
  mutate(day = floor_date(starttime, unit = "day"), day_of_week = wday(starttime))  %>%
  group_by(day_of_week, day) %>% 
  select(day, day_of_week) %>% 
  arrange(day_of_week) %>% group_by(day_of_week, day) %>%
  summarise(day_count = n()) %>% 
  group_by(day_of_week) %>% 
  mutate(day_mean = mean(day_count), sd_day = sd(day_count)) %>% 
  pivot_wider(names_from = day, values_from = day_count) %>% 
  select(day_of_week, day_mean, sd_day)

# now to plot this 
trips %>% 
  mutate(day = floor_date(starttime, unit = "day"), day_of_week = wday(starttime))  %>%
  group_by(day_of_week, day) %>% 
  select(day, day_of_week) %>% 
  arrange(day_of_week) %>% group_by(day_of_week, day) %>%
  summarise(day_count = n()) %>% 
  group_by(day_of_week) %>% 
  mutate(day_mean = mean(day_count), sd_day = sd(day_count)) %>% 
  pivot_wider(names_from = day, values_from = day_count) %>% 
  select(day_of_week, day_mean, sd_day) %>%  
  mutate(is_weekend = ifelse(day_of_week > 5, "1", "0")) %>% 
  ggplot(aes(x = day_of_week, color = is_weekend)) + 
  geom_pointrange(aes(y = day_mean, ymin = day_mean - sd_day, ymax = day_mean + sd_day ))



