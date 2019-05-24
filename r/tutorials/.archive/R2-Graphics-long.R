## ------------------------------ ##
##  Graphics in R
##  Data Analysis and Visualization
##
## Scientific Computing and Visualization
## ------------------------------ ##

## install libraries
if (!  require(colorspace) ){
  install.packages("colorspace")
  if (! require(colorspace)) stop("Could not install package colorspace")
}

if (!  require(beanplot) ){
  install.packages("beanplot")
  if (! require(beanplot)) stop("Could not install package beanplot")
}
if (!  require(RColorBrewer) ){
  install.packages("RColorBrewer")
  if (! require(RColorBrewer)) stop("Could not install package RColorBrewer")
}


library(lattice)
library(car)

#======================================##

## List all available packages
library()

## Load MASS package
library(MASS)

## List datasets
data()

## Load trees dataset into workspace
data(trees)

## View first few lines of the dataset
head(trees)

## Get data dimensions
dim(trees)

## Get column (variables) names
names(trees)

##Get help/description for the dataset
?trees

## Display the structure of the dataset
str(trees)

## Get the length of a variable (vector)
length(trees$Height)

## Get type of the variable
mode(trees$Height)

## Are there any missing data
length(trees$Height[is.na(trees$Height)])
which(is.na(trees$Height))
which(c(TRUE, F, F, T, F))

## Explore some statistics
summary(trees$Height)


## Display a histogram
hist(trees$Height)

##  List all available output devices 
dev.list()

## Check which device is current. If no device is active, returns 1 - a "null device"
dev.cur()

## To switch between devices use dev.set(n) command

## open a new device
x11()   # for Windows you can use Windows() and for Mac xquartz() should work if you have it installed

## Saving graphics into a file
## R supports a number of formats including JPG, PNG, WMF, PDF, Postscript...

hist(trees$Height)                 #plot
dev.copy(png, "myHistogram.png")   # copy to device
dev.off()                          # release the device

png("myHistogram.png")  # specify the output device and format
hist(trees$Height)      # plot to device
dev.off()               # release the device

## Read in a dataset

pop <- read.csv("population.csv")
head(pop)
str(pop)

pop$Race <- factor(pop$Race, labels=c("Other", "Hispanic","White","African","Asian"))
str(pop)
table(pop$Race)

## Pie charts
pie(table(pop$Race))

## Get Help on piechart
?pie

## Get an example of pie chart
##example(pie)

## Enhance pie chart
pct <- round(table(pop$Race)/sum(table(pop$Race))*100)  # calculate percentage of each category
lbls <- levels(pop$Race)                                # make labels
lbls <- paste(lbls,pct)                                 # add percentage value to the label
lbls <- paste(lbls, "%", sep="      ")                       # add percent sign at the end
pie(table(pop$Race), labels = lbls, col = rainbow(length(lbls)), main="Race")
pie(table(pop$Race), labels = lbls, col = c("steelblue2", 
                                            "red2", 
                                            "olivedrab",
                                            "orange2",
                                            "peachpuff"), main="Race")


# various palettes in R
# rainbow
# heat.colors
# terrain.colors
# topo.colors
# cm.colors

# get help :
help(package=colorspace)

# Graphical User Interface for Choosing HCL Color Palettes
my.palette <- choose_palette()    ## library(colorspace)


# link to colors in R:
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf


# Barplots
barplot(table(pop$Race), main="Race")

b <- barplot(table(pop$Race), main="Race", ylim = c(0,200), col=c("red", rep("green",2)))
text(x=b, y=table(pop$Race), labels = table(pop$Race), pos=3, col="black", cex=1.25)

# use patterns instead of colors
b <- barplot(table(pop$Race), main="Race", ylim = c(0,200), angle = 15 + 30*1:5, density = 20)
text(x=b, y=table(pop$Race), labels = table(pop$Race), pos=3, col="black", cex=1.25)

#use shades of grey
b <- barplot(table(pop$Race), main="Race", ylim = c(0,200), col=gray.colors(5))
text(x=b, y=table(pop$Race), labels = table(pop$Race), pos=3, col="black", cex=1.25)

# Side-by-side plot
m1 <- tapply(pop$Wage, pop$Union, mean)
m2 <- tapply(pop$Wage, pop$Union, median)
r <- rbind(m1,m2)
b<- barplot(r, col = c("forestgreen", "orange"), 
            ylim=c(0,12),beside=T,
            ylab="Wage (dollars per hour)", 
            names.arg=c("non-union","union"))

# Add a legend
legend("topleft", c("mean","median"),
       col = c("forestgreen","orange"),
       pch = 15)  # use square symbol for the legend

# Add text
text(b, y = r, labels=format(r,digits=4),
     pos = 3,     # above of the specified coordinates
     cex = .75)  # character size

# Boxplot
boxplot(pop$Wage, main="Wage, sollars per hour", horizontal = TRUE)

# compare wages of two groups
boxplot(pop$Wage ~ pop$Sex, main="Wages among male and female workers")

# add colors
boxplot(pop$Wage ~ pop$Sex, 
        main="Wages among male and female workers",
        col=c("forestgreen","orange"))

# A Histogram
hist(pop$Wage)

hist(pop$Wage,
     col = "grey",
     border = "black",
     main = "Wage distribution",   
     xlab = "Wage, (dollars per hour)",
     breaks = seq(0,50,by=2) )
rug(pop$Wage)    # Add rugplot to the graphics


# Display probability density
hist(pop$Wage,
     col = "grey",
     border = "black",
     main = "Wage distribution",   
     xlab = "Wage, (dollars per hour)",
     breaks = seq(0,50,by=2),
     freq = F)
rug(pop$Wage)    # Add rugplot to the graphics

# Add lines displaying a kernel density and a legend:
hist(pop$Wage,
     col = "grey",
     border = "black",
     main = "Wage distribution",   
     xlab = "Wage, (dollars per hour)",
     breaks = seq(0,50,by=2),
     freq = F)
rug(pop$Wage)    # Add rugplot to the graphics
lines(density(pop$Wage),lwd=1.5)
lines(density(pop$Wage, adj=2),
      lwd=1.5, # line width
      col = "brown") 
lines(density(pop$Wage, adj=0.5),
      lwd=1.5, 
      col = "forestgreen")


legend("topright",
       c("Default","Double","Half"),
       col=c("black", "brown", "forestgreen"),
       pch = 16, 
       title="Kernel Density Bandwidth")

# If only lines are desired
plot(density(pop$Wage),
     col="darkblue", 
     main="Kernel .", 
     xlab="Wage .",
     lwd=1.5,
     ylim=c(0,0.12) )
lines(density(pop$Wage),lwd=1.5)
lines(density(pop$Wage, adj=2),
      lwd=1.5, # line width
      col = "brown") 
lines(density(pop$Wage, adj=0.5),
      lwd=1.5, 
      col = "forestgreen")


legend("topright",
       c("Default","Double","Half"),
       col=c("black", "brown", "forestgreen"),
       pch = 16, 
       title="Kernel Density Bandwidth")

# Plot Empirical cumulative distribution
plot(ecdf(pop$Wage),
     pch=1, 
     col="darkblue",
     xlab="Wage, dollars per hour",
     main="Empirical CDF")
grid()  # add grid

# Lets look at the dogs dataframe
dogs <- read.csv("dogs.csv")

# Plot a scatterplot
plot(dogs$height~dogs$weight,
     main="Weight-Height relationship")

# Enhanced scatterplot
plot(dogs$height[dogs$sex=="F"]~
       dogs$weight[dogs$sex=="F"],
     col="darkred",
     pch=1,
     main="Weight-Height Diagram",
     xlim=c(80,240),
     ylim=c(55,75),
     xlab="weight, lb", 
     ylab="height, inch")
points(dogs$height[dogs$sex=="M"]~ dogs$weight[dogs$sex=="M"],
       col="darkblue",
       pch=2)
legend("topleft",                       # add legend
       c("Female", "Male"),
       col=c("darkred","darkblue"),
       pch=c(1,2),
       title="Sex")
# add best-fit line
abline(lm(dogs$height~dogs$weight),
       col="forestgreen",
       lty=2)
# add text
text(80, 56, "Best-fit line: y = 0.088x + 52.32",
     col="forestgreen",
     pos=4)
# plot mean point for the cluster of female dogs
points(mean(dogs$weight[dogs$sex=="F"]),
       mean(dogs$height[dogs$sex=="F"]),
       col="black",
       bg="red",
       pch=23)
# plot mean point for the cluster of male dogs
points(mean(dogs$weight[dogs$sex=="M"]),
       mean(dogs$height[dogs$sex=="M"]),
       col="black",
       bg="lightblue",
       pch=23)
# add grid 
grid()
# add horizontal line
abline( h = 63 )
# add vertical line
abline( v = 131 )


#pick points
pts<- identify(dogs$weight,dogs$height)


# several graphs 
# specify number of rows and columns in the table
par( mfrow = c(1,2) ) 
hist(dogs$age, main="Age" )
barplot(table( dogs$dog_type), main="Dog types" )
# return to normal display
par( mfrow = c(1,1) ) 

# Matrix of scatterplots
pairs( ~height+weight+age,  
       data = dogs, 
       main="Age, Height and weight scatterplots" )

# **** Segmented Bar Charts ***
dt <- read.csv("USA_states.csv", stringsAsFactors=FALSE)   # read the dataframe
str(dt)          # display the structure of the dataset

#We can edit the names of this dataset if we want to
names(dt) <- c("state", "location", "pop", "area", "house","ap", "traffic","ed","cancer","cigar","date")
names(dt)

# convert Location & education variables to be a factor variables
dt$location <- factor(dt$location)
dt$ed <- factor(dt$ed)


barplot(table(dt$ed, dt$location), main ="Drivers Education \n in Each Region")
legend("topright", c("no education required", "education is required"), pch=16, inset=0.05)


# Dot Charts
a<- aggregate(dt[,3], list(Location=dt$location), mean)
row.names(a) <- a[,1]
dotchart(t(a[,-1]), main="Plots of Means for the Population for each region", xlab="Mean Values")


#Histogram
hist(dt$ap, main="AP scores")
# add mean and median to the plot
abline(v=mean(dt$ap), col="green", lwd=3)
abline(v=median(dt$ap), col="orange", lwd=3)
legend("topright", c("Mean", "Median"), pch = 16, col=c("green", "orange"))


#Check the data for the normality
hist(dt$cigar, prob=T, breaks=12, ylim=c(0,0.1))
lines(density(dt$cigar, na.rm=TRUE), col="orange")
mu<-mean(dt$cigar, na.rm=TRUE)
sigma<-sd(dt$cigar, na.rm=TRUE)
x<-seq(10, 40, length=100)
y<-dnorm(x,mu, sigma)
lines(x,y,lwd=2, col="green")

# Box and Whisker Plot
# --- subset the data
library(lattice)
bwplot(dt$traffic~dt$ed, 
       xlab=c("no education","training required"), 
       ylab="Number of traffic acc." , 
       main="Compare traffic laws effect on the number of accidents")


#Beanplot
# This is an alternative to the boxplot
library(beanplot)
par(mfrow=c(1,2))
boxplot(dt$cigar, main="Number of cigaretts sold")
beanplot(dt$cigar, main="Number of cigaretts sold")
par(mfrow=c(1,1))


#Scatterplots
# Look at the distributions and correlations in between the data
library(car)
scatterplotMatrix(dt[,3:6])

## Quantile-Quantile plots for comparing two Distributions
beanplot(dt$traffic~dt$ed, border=NA, overallline="median",side="both", 
         col=list(grey(0.5), c(grey(0.8), "white")))
legend("bottomleft", fill=c(grey(0.5), grey(0.8)), legend=c("No education req.", "Education req."))

## ================================================= ##
##         Explore color palettes
## ================================================= ##

# get all the color names
colors()

# convert color name to rgb value
col2rgb("red")
col2rgb(cc <- colors())

## Function to explore palletes
pal <- function(col, border = "light gray", ...)
{
  n <- length(col)
  plot(0, 0, type="n", xlim = c(0, 1), ylim = c(0, 1),
       axes = FALSE, xlab = "", ylab = "", ...)
  rect(0:(n-1)/n, 0, 1:n/n, 1, col = col, border = border)
}
 
## explore Qualitative palettes
pal(rainbow_hcl(4, start = 30, end = 300), main = "dynamic")
pal(rainbow_hcl(4, start = 60, end = 240), main = "harmonic")
pal(rainbow_hcl(4, start = 270, end = 150), main = "cold")
pal(rainbow_hcl(4, start = 90, end = -30), main = "warm")

## explore Sequential palettes
pal(sequential_hcl(12, c = 0, power = 2.2))
pal(sequential_hcl(12, power = 2.2))
pal(heat_hcl(12, c = c(80, 30), l = c(30, 90), power = c(1/5, 2)))
pal(terrain_hcl(12, c = c(65, 0), l = c(45, 90), power = c(1/2, 1.5)))
pal(rev(heat_hcl(12, h = c(0, -100), c = c(40, 80), l = c(75, 40), power = 1)))

## explore Diverging palettes
pal(diverge_hcl(7))
pal(diverge_hcl(7, c = 100, l = c(50, 90), power = 1))
pal(diverge_hcl(7, h = c(130, 43), c = 100, l = c(70, 90)))
pal(diverge_hcl(7, h = c(180, 330), c = 59, l = c(75, 95)))

# example
stu <- structure(c(443, 554, 72, 351, 222),.Names = c("MET", "CAS", "GRS", "ENG", "CFA"))
clrs <- rainbow_hcl(6, c = 60, l = 75)[c(5, 2, 6, 3, 1)]
names(clrs) <- names(stu)
pie(stu, clockwise = TRUE, col = clrs, radius = 1)


## ColorBrewer Palette
#library("RColorBrewer")
## create a sequential palette for usage and show colors
mypalette<-brewer.pal(7,"Greens")
image(1:7,1,as.matrix(1:7),col=mypalette,xlab="Greens (sequential)",
      ylab="",xaxt="n",yaxt="n",bty="n")
Sys.sleep(2)
## display a divergent palette
display.brewer.pal(7,"BrBG")
Sys.sleep(2)
## display a qualitative palette
display.brewer.pal(7,"Accent")
Sys.sleep(2)
## display a palettes simultanoeusly
display.brewer.all(n=10, exact.n=FALSE)
Sys.sleep(2)


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




