#!/bin/bash
<<<<<<< HEAD
# Name: Hasanat Jahan

# add your solution after each of the 10 comments below
#

# count the number of unique bikes
# the bike id's are in col 15
echo -e "The number of unique  bikes: "
cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq | wc -l

# count the number of unique stations
# the station ids are in col 8
echo -e "The number of unique stations: "
cut -d, -f8 201402-citibike-tripdata.csv | sort | uniq | wc -l


# count the number of trips per day
echo -e "The number of trips per day: "
cut -d, -f2  201402-citibike-tripdata.csv | sort | uniq | cut -d ' ' -f1 | uniq -c | head -n -1

# find the day with the most rides
echo -e "The day with the most rides is: "
cut -d, -f2  201402-citibike-tripdata.csv | sort | uniq | cut -d ' ' -f1 | uniq -c | sort | tail -1

# find the day with the fewest rides
echo -e "The day with the fewest rides: "
cut -d, -f2  201402-citibike-tripdata.csv | sort | uniq | cut -d ' ' -f1 | uniq -c | sort | head -2 | sed "1 d"

# find the id of the bike with the most rides
echo -e "The id of the bike with most rides: "
cut -d, -f12  201402-citibike-tripdata.csv | sort | uniq -c | sort -nr | head -1


# count the number of rides by gender and birth year
echo -e "The number of rides by gender and birth year: "
#cut -d, -f15,14  201402-citibike-tripdata.csv | sort | uniq -c | sort -nr | grep -v '\N'
cut -d, -f15,14  201402-citibike-tripdata.csv | sort | uniq -c | head -n -2 | sort -nr


# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
echo -e "The number of trips that start on cross streets that both contain numbers: "
cut -d, -f5 201402-citibike-tripdata.csv | grep -E '[0-9](.*)&(.*)[0-9]' | wc -l

# compute the average trip duration
echo -e "The average trip duration: "
#cut -d, -f1 201402-citibike-tripdata.csv | grep -o '[0-9].*[0-9]' | awk '{sum+=$1;count+=1} END {print sum/count;}'

# the same command using sed instead of tr
# resource used: https://linuxconfig.org/how-to-extract-a-number-from-a-string-using-bash-example

cut -d, -f1 201402-citibike-tripdata.csv | sed 's/[^0-9]*//g' | awk '{sum+=$1;count+=1} END {print sum/count;}'

=======
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations

# count the number of unique bikes

# count the number of trips per day

# find the day with the most rides

# find the day with the fewest rides

# find the id of the bike with the most rides

# count the number of rides by gender and birth year

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)


# compute the average trip duration
>>>>>>> 62e4631ea1875e38ff851fa3648be510f542bc9b
