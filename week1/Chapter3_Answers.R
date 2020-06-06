library(tidyverse)
library(ggplot2)
library(gganimate)
#######################################
# Section 3.3.1
###############
# Problem No 1
##############
# What's gone wrong with this code? 
# Why are the points not blue?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# Answer: the color attribute should be outside of the aes function. 
# Then it would convert the points to blue
# Correct command:
ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy),  color = "blue")

#############
# Problem 2: Which variables in mpg are categorical? 
# Which variables are continuous? 
# (Hint: type ?mpg to read the documentation for the dataset). 
# How can you see this information when you run mpg?
############
# Answer:
# Categorical:
# 1. manufacturer
# 2. model 
# 3. trans
# 4. drv
# 5. fl
# 6. class

# Continuous 
# 1. year 
# 2. cyl 
# 3. cty
# 4. hwy

# According to book: Those with <chr> are categorical 
# and those with <dbl> or <int> are continuous


#############
# Problem 3: Map a continuous variable to color, size, and shape. 
#How do these aesthetics behave differently for categorical vs. continuous variables?
##############
# Examples
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = year, y = model, color = cty))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = hwy, size = year))

# A continuous variable cannot be mapped to shape
# The rest behaves with corresponding to color and size of the value


############################################################
# Section 3.5.1 
# Exercise 1 & 4
#################
# 1. What happens if you facet on a continuous variable? 
# The continuous variable is treated as discrete values, and a column
# is created for each value 

# 4. What are the advantages to using faceting instead of the colour aesthetic? 
# What are the disadvantages? How might the balance change if you had a larger dataset?

# Using faceted
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# Using color aesthetic
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) 

# For a pretty graph 
 ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) + 
  facet_wrap(~ class, nrow=2) 

# Using only a color aesthetic means that all the plots are
 # on the same graph, with overlapping values and a general jitter 
 # that makes it hard to make out individual patterns
 # The disadvantage might be that color coding might add extended
 # differences between values that are easy to spot and pick out
 
################################################################
# Section 3.6.1 
# Exercises 5 & 6
##################

# Example: A good example of how we can combine the plots together 
 ggplot(data = mpg) + 
  geom_point(mapping = aes(x =displ, y=hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv)) 
 
# 5. Will these two graphs look different? Why/why not? 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy), color = "green") + 
  geom_point() + 
  geom_smooth()
 
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
 
# Answer: They would look the same. They use the same values. 

# 6. Replicate graphs 
# Graph (0,0)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  +     geom_point() + 
  +     geom_smooth(se = FALSE)

# Graph (0,1)
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_smooth(mapping = aes(group = drv), se = FALSE) + 
  geom_point()

# Graph (1,0)
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_smooth(mapping = aes(group = drv, color = drv), se = FALSE) + 
  geom_point(mapping = aes(color = drv))

# Graph (1,1)
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_smooth( se = FALSE) + 
  geom_point(mapping = aes(color = drv))

# Graph (2,0)
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_smooth(mapping = aes(linetype = drv) ,se = FALSE) + 
  geom_point(mapping = aes(color = drv))
 
# Graph (2,1)
# Similar 
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = drv, fill = drv), color = "white", pch = 21 ,size = 5)

# Or

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(shape = 1, size = 6, color = "white") +
  geom_point(mapping = aes(color = drv), size = 5)



###############################################
# Section 3.8.1 
# Exercise No 1 & 2
#########################

# 1. What is the default geom associated with stat_summary()? 
# How could you rewrite the previous plot to use that geom function instead of the stat function?
# Answer: The deafult geom associated is geom_pointrange()
# The ggplot to do the same transformation
ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary",
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

# 2. What does geom_col() do? 
# How is it different to geom_bar()?
# Answer: They are two of the ways of plotting bars. 
# In geom_bar() the height of the bar does not represnt 
# the count of observations but a sum over a variable. 
# It uses stat  = "bin . The data is modified to
# produce a sum
# geom_col() uses stat = "identity". The data is left as is 
# and the data is plotted directly on the abr graph as bars. 
 
 
 
 
 
 
 
 
 
 
 
 
 
