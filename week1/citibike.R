library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('201402-citibike-tripdata.csv')

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

# convert dates strings to dates
# trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))


########################################
# YOUR SOLUTIONS BELOW
########################################
#

# count the number of trips (= rows in the data frame)
number_of_trips <- nrow(trips)

# find the earliest and latest birth years (see help for max and min to deal with NAs)
# latest birth year
trips %>% 
  summarize(max(birth_year))

#earliest birth year
trips %>% 
  filter(birth_year != "\\N") %>% 
  summarize(min(birth_year)) 

# use filter and grepl to find all trips that either start or end on broadway
trips %>% 
  filter(grepl('Broadway',start_station_name) | grepl('Broadway',end_station_name)) %>% 
  select(start_station_name | end_station_name)

# do the same, but find all trips that both start and end on broadway
trips %>% 
  filter(
    grepl('Broadway',start_station_name) & grepl('Broadway',end_station_name)) %>% 
  select(start_station_name)

# find all unique station names
trips %>% 
  select(start_station_name) %>% 
  unique()

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
trips %>% 
  group_by(gender) %>% 
  summarise(
    mean_by_gender=mean(tripduration)/60, 
    sd_duration = sd(tripduration)/60)

# find the 10 most frequent station-to-station trips
trips %>% 
  group_by(start_station_name, end_station_name) %>% 
  unique() %>% 
  select(start_station_name, end_station_name) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count)) %>%
  head(10)

# find the top 3 end stations for trips starting from each start station
trips %>% 
  group_by(start_station_name, end_station_name) %>%
  unique() %>%
  summarize(count = n()) %>%
  group_by(start_station_name) %>%
  unique() %>%
  arrange(start_station_name, desc(count)) %>%
  top_n(n=3, wt=count)

# find the top 3 most common station-to-station trips by gender
trips %>% 
  group_by(gender, start_station_name, end_station_name) %>% 
  unique() %>%
  summarize(count=n()) %>%
  group_by(gender) %>%
  unique() %>%
  arrange(gender, desc(count)) %>%
  top_n(n=3, wt=count) 

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>% 
  mutate( day_of_year = floor_date(starttime, unit="day")) %>% 
  unique() %>%
  group_by(day_of_year) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count)) %>%
  head(1)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
trips %>% 
  mutate(day = floor_date(starttime, "day"), hour = floor_date(starttime, "hour")) %>% 
  group_by(day, hour) %>% 
  summarise(count = n()) %>% 
  group_by(hour) %>% 
  summarise(mean_of_hour = mean(count)) %>% 
  arrange(desc(mean_of_hour)) %>% 
  head(1)

