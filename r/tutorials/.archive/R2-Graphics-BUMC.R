#To install a package:
#install.packages("ggplot2")
library(ggplot2)


# Load the data from csv file
library(data.table)
babynames <- fread(input="babynames.csv", data.table = FALSE)
flights <- fread(input="flights.csv", data.table = FALSE)

# ----- Data exploration ----- :

#structure of the dataset
str(babynames)

#summary for each column
summary(babynames)

# How many unique names do we have in the dataset
length(unique(babynames$name))

#How many female and how many male names in the table
table(babynames$sex)

#sort datatable by the number of time the name occurs it the table
b.ordered <- babynames[order(babynames$n,decreasing = TRUE),]

#print the first 3 most popular female names
print ( unique(b.ordered[b.ordered$sex=="F",3]) [1:3])

#print the first 3 most popular male names
print ( unique(b.ordered[b.ordered$sex=="M",3]) [1:3])



# There are 3 main environments in R to create graphics:
# - R base utilities
# - lattice package
# - ggplot2 package
# There is also powerful "grid" package and a couple in-development interactive packages


# ------ Base R Graphics -------

# Generic(high level) plot functions:
# -plot: generic x-y plots, scatterplots
# -matplot
# -barplot
# -boxplot
# -hist: histogram
# -pie: pie charts
# -dotchart: cleveland dot plots
# -image, heatmap, contour, persp: image-like plots
# -qqnorm, qqline, qqplot: distribution analysis plots
# -pairs, coplot: display of multivariant data
# -dotchart
# -mosaicplot
# -stripchart
# -contour
# -hclust: hierarchial clustering

# Low level - functions that add to the existing plot created with a high-level plot functions:
# -points
# -lines
# -abline
# -segments
# -text
# -mtext
# -title
# -axis
# -grid
# -legend
# -rug
# -polygon
# -box


# -------- Pie Chart ---------

gender.tbl <- table(babynames$sex)

pie(gender.tbl)

#How to improve the graph - read help for the function and see the examples!
?pie

pie(gender.tbl,
    labels = c("Girl names", "Boy names"),
    col = c("pink","skyblue"),
    main = "Percentage of male and female names in the table")


# Note: Pie charts are a very bad way of displaying information. 
#       The eye is good at judging linear measures and bad at judging relative areas. 
#       A bar chart or dot chart is a preferable way of displaying this type of data.
# Let's add some numeric information to the graph... 
names.percent = round(100 * gender.tbl / sum(gender.tbl), 1)
names.percent.labels <- paste(c("Girl names ", "Boy names "),
                              names.percent,
                              "%",
                              sep="")
pie( gender.tbl,
    labels = names.percent.labels,
    col = c("pink","skyblue"),
    init.angle = 90,
    main = "Percentage of male and female names in the table")

#Add some text to the graph
text(x=0.25,y=-1.0, 
     labels = "Source: Social security administration", 
     pos = 4, 
     cex=0.75)


# ----- Saving graphic -----

# Two ways to output graph into the file:
# - copy the existing graph to the file
# - plot to the file (the graph will not appear on the screen)


#Check opened devices
dev.list()

#Check current device
dev.cur()

# Copy the existing graph to the file
dev.copy(png,"piechart.png")

#The png file is not the current device:
dev.list()
dev.cur()

#Close the png file
dev.off() 

#Close rstudio device
dev.off()

# Plot the graph to the file (it will not appear on the screen )
png("piechart.png")

    pie(gender.tbl,
    labels = names.percent.labels,
    col = c("pink","skyblue"),
    init.angle = 90,
    main = "Percentage of male and female names in the table")

     text(x=0.25,y=-1.0, 
     labels = "Source: Social security administration", 
     pos = 4, 
     cex=0.75)

dev.off() # close file

# There are a number of graphic devices in R
# bitmap files: bmp(), jpeg(), png(), tiff()
# pdf graphics device: pdf()
# postscript graphics: postscript()


# -------- Bar plot --------

barplot(gender.tbl)


b<-barplot(gender.tbl,
           col=c("pink","skyblue"),
           main = "Percentage of male and female names in the table",
           sub = "Source: Social security administration",
           names.arg = c("Female","Male"),
           ylim = c(0, max(gender.tbl) * 1.25), 
           axes=FALSE)

text(b,gender.tbl,
     labels = gender.tbl, 
     pos = 3)

# There are many ways to specify a color in R:
# - specify an index within a colorscheme
# - by name
# - using rgb, hsv, hex values

# 1. Using index within colorscheme (palettes)
barplot(c(7,11), col=c(1,2))

      #list colors in the current palette:
      palette()
      pie(rep(1,length(palette())),
          col=palette())

      #some available palettes: 
      #   rainbow(), heat.colors(), terrain.colors(), topo.colors(), cm.colors(), gray.colors()
      pie(rep(1,length( palette( heat.colors(10) ) )),
      col=palette( heat.colors(10) ))

      #return to the default palette
      palette("default")

      #A popular palettes could be found in package RColorBrewer
      #install.packages("RColorBrewer")
      library(RColorBrewer)
      display.brewer.all()

# 2. Specify colors by name
colors() # list all colornames
barplot(c(14,8,5,4,3,2,1), col=c("steelblue4",
                                "dodgerblue",
                                "firebrick",
                                "forestgreen",
                                "gold",
                                "darkorange",
                                "darkgrey"))


# 3. Specify rgb values
col1 <- rgb(0.1, 0.5, 0.1)
col2 <- rgb(0.9, 0.7, 0.0)
barplot(c(7,11), col=c(col1, col2))


#Conversion one color format to another
# col2rgb(), rgb2hsv()

# Additional help related to colors
help(package=colorspace)



# -------- Histogram --------

#Extract short distance flights
short <- flights[flights$distance < 500, ]

#Are there any missing data
any(is.na(short))

#Let's remove observations with missing data
short <- na.omit(short)
  

hist(short$air_time)


hist(short$air_time, 
     main="NY flights in 2013",
     col="steelblue3",
     xlab="Proportion values")

hist(short$air_time, 
     main="NY flights in 2013",
     col="steelblue3",
     xlab="Proportion values", prob = TRUE)


#Add rugplot
rug(short$air_time)

lines(density(short$air_time), col="darkblue")

# -------- Boxplot--------
#Let's look at most frequent names in 2013
some <- babynames[babynames$year == 2013 & babynames$n > 15000,]

boxplot(some$n)

#let's display 2 boxplots: one for male and one for female names
boxplot( formula = n ~ sex,
         data = some,
         names = c("girls","boys"),
         col = c("gold","forestgreen"),
         horizontal = TRUE )


# ------- Plot -------

plot(some$prop~some$n)

long <- flights[flights$air_time > 200, ]
plot(long$arr_delay~long$dep_delay)

#Function plot could be used to plot points or lines

#Explore various symbols 
?points

#Draw a table with all symbols
plot(c(-1, 26), 0:1, type = "n", axes = FALSE, xlab="", ylab="")
text(0:25, 0.6, 0:25, cex=0.75)
points(0:25, rep(0.5, 26), pch = 0:25, bg = "grey")


plot(x = some$n,
     y = some$prop, 
     pch = 16)

# Some often used graphics parameters:
# - pch: plotting symbol (default - open circle)
# - lty: line type (default - solid line)
# - lwd: line width 
# - las: orientation of the axis labels on the plot
# - bg: background color
# - fg: foreground color
# - mar: margin size
# - oma: outer margin size

cols <- ifelse(some$sex == "M", "steelblue4","firebrick")
plot(x = some$n,
     y = some$prop, 
     pch = 16, 
     main = "Analysis of dependency of 2 variables",
     xlab = "n",
     ylab = "prop", 
     col = cols)

lm.fit <- lm(prop ~ n, data = some)
abline(lm.fit, lty = 2, lwd = 2)


#Use function expression() to plot math symbols (see more info ?plotmath )
text(20000,0.01,labels=expression(bar(prop) %prop% bar(n)))


# Plot function to draw lines:
x <- seq(-pi, pi, len = 65)
plot(x, sin(x), 
     type="l", col = "darkblue", 
     xlab = expression(phi), 
     ylab = expression(f(phi)),
     lwd = 2)

lines(x, cos(x), col = "firebrick", lty = 2, lwd = 2)
abline(h=-1:1, v=pi/2*(-6:6), col="gray90")
ex2 <- expression(plain(sin) * phi, paste("cos", phi))
legend(-3, .9, ex2, lty=1:2, col=c("darkblue", "firebrick"), adj = c(0, .6))


# ----- Dot Chart -----

# Delays per airport
long.flights <- na.omit(flights[flights$distance > 2000, ])
delays <- aggregate(long.flights$dep_delay, list(Airport=long.flights$dest), mean)
row.names(delays)<- delays[,1]

dotchart(t(delays$x), 
         labels = row.names(delays),
         groups = delays$x,
         main="Mens for the delay time for each destination", 
         xlab= "Mean Values (min)", 
         cex = 0.75)



# ----- Pairs -----

small <- na.omit( flights[1:200,] )

# Delays per airport
pairs(small[ c(5,7,13,14) ] ) 

#An alternative way using formula
pairs( ~ dep_delay + arr_delay + air_time + distance, 
       data = small) 


# ----- Multiple plots in one graph -----
par.save <- par()  # save current graphics parameters
print( par() )     # print current graphics parameters

par( mfrow = c(2,2) )  # 2 rows and 3 columns

    # first graph
    pie(gender.tbl,
    labels = c("Girl names", "Boy names"),
    col = c("pink","skyblue"),
    main = "Percentage of male and female names in the table")

    # second graph
    barplot(gender.tbl,
           col=c("pink","skyblue"),
           main = "Numer of male and female names in the table",
           sub = "Source: Social security administration",
           names.arg = c("Female","Male"),
           ylim = c(0, max(gender.tbl) * 1.25), 
           axes=FALSE)

    #third graph
    hist(some$n, 
     main="Histogram of baby names",
     col="steelblue3",
     xlab="Proportion values", prob = TRUE)


     #fourth graph
     plot(x = some$n,
     y = some$prop, 
     pch = 16, 
     main = "Analysis of dependency of 2 variables",
     xlab = "n",
     ylab = "prop", 
     col = cols)

par ( mfrow = c(1,1) )



# Use manipulate library to dynamically change graphics parameters
library(manipulate)

manipulate(plot(some$prop[1:x],
                type = type, 
                col = col,
                pch = pch), 
           x = slider(1,10),
           type = picker("Points" = "p", "Lines" = "l", "Step" = "s"),
           col = picker("red"="red", "green"="green",
                         "yellow"="yellow"), 
           pch=picker("1"=1,"2"=2,"3"=3, "4"=4, "5"=5)
           )

# A few useful links with Many examples:
# http://manuals.bioinformatics.ucr.edu/home/R_BioCondManual#TOC-Some-Great-R-Functions
# http://www.cookbook-r.com/Graphs/Plotting_means_and_error_bars_(ggplot2)/
