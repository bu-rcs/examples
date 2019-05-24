
## ================================================= ##
##          ggplot2 examples
##     GGplot (implementation of the Grammar of Graphics)
## ================================================= ##
library(ggplot2)

# qplot command to create most common graphs (similar to plot() from base graphics)
# It takes two primary arguments: 
# data (dataframe) 
# aes (aesthetic mapping to pass on to the plot elements)

# example
summary(mpg) # examine mpg dataset that comes with base R

# scatterplot
ggplot(mpg,aes(mpg$displ, mpg$hwy)) + geom_point() 

# color the points according to the number of cylinders in the engine
ggplot(mpg,aes(mpg$displ, mpg$hwy)) + geom_point(aes(color = factor(cyl)))

#lineplot
ggplot(mpg,aes(mpg$displ, mpg$hwy)) + geom_point() + geom_line()

# color the lines according to the number of cylinders in the engine
ggplot(mpg,aes(mpg$displ, mpg$hwy)) + geom_point() + geom_line(aes(color = factor(cyl)))

# color both - points and lines
ggplot(mpg,aes(mpg$displ, mpg$hwy, color = factor(cyl))) + geom_point() + geom_line()

# barplot
pop <- read.csv("population.csv")
pop$Race <- factor(pop$Race, labels=c("Other", "Hispanic","White","African","Asian"))
ggplot(pop, aes(Race)) +  geom_bar(aes(fill =Race))

# Grouping + statistics
summary(mpg) # examine mpg dataset that comes with base R

# add loess (local regression) line with the standard error ribbon
ggplot(mpg, aes(displ, hwy))+geom_point() + stat_smooth()

# use lm menthod to fit linear model into each group
ggplot(mpg, aes(displ, hwy, color = factor(cyl)))+
       geom_point()+
       stat_smooth(method = "lm")

# grouping using both - colors and symbols
ggplot(mpg, aes(displ, hwy, color = factor(cyl), 
                shape = factor(year), 
                linetype = factor(year)))+
      geom_point()+
      stat_smooth(method = "lm")



