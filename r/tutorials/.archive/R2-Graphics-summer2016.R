# ---------------------------------------#
#                                        #
#  R script for RCS tutorial             #
#  Graphics in R
#  Katia Oleinik                         #
# ---------------------------------------#

#To install a package:
install.packages("ggplot2")

#To load R package
library(ggplot2)


#
# Read data files
babynames <- read.csv("http://scv.bu.edu/examples/r/tutorials/babynames.csv")
#

# ----- Data exploration ----- :

#structure of the dataset
str(babynames)

#summary for each column
summary(babynames)

# How many unique names do we have in the dataset
length(unique(babynames$name))

# When a string variable is not a categorical variable it should not be converted to a factor
# This could be achieved by either converting it back to a character variable
babynames$name <- as.character( babynames$name )

#or we can disable conversion to factor when we read the data:
babynames <- read.csv("http://scv.bu.edu/examples/r/tutorials/babynames.csv",
                      stringsAsFactors=FALSE)



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


#erase all plots that have been made so far
dev.off()

#Check opened devices
dev.list()

    #Plot something
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

dev.list()

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

# ----- Regular Plot command ---
#
# #plot time series
# y <- rnorm (10, 5, 1)
# plot(y)
# plot(y, type="c", col="steelblue4", lty=1)
# points(y,  pch=19, col="steelblue4", cex=1.5)


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
barplot(c(1:10), col=c(1:10))

      #list colors in the current palette:
      palette()

      pie(rep(1,length(palette())),
          col=palette())

      #some available palettes: 
      #   rainbow(), heat.colors(), terrain.colors(), topo.colors(), cm.colors(), gray.colors()
num.col=15
barplot(c(1:num.col), col=rainbow(num.col))
barplot(c(1:num.col), col=heat.colors(num.col))
barplot(c(1:num.col), col=terrain.colors(num.col))
barplot(c(1:num.col), col=topo.colors(num.col))
barplot(c(1:num.col), col=cm.colors(num.col))
barplot(c(1:num.col), col=gray.colors(num.col))


#A popular palettes could be found in package RColorBrewer
#install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()
barplot(c(1:8), col=brewer.pal(8,"Dark2") )
barplot(c(1:9), col=brewer.pal(9,"Set1") )



# 2. Specify colors by name
colors() # list all colornames
barplot(c(1:20), col=colors()[581:600])
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

legend("topright", 
       legend=c("boys","girls"), 
       pch=15,
       col = c("forestgreen", "gold"))

# ------- Plot -------
salaries <- read.csv("http://scv.bu.edu/examples/r/tutorials/Salaries_full.csv")

plot(salaries$salary~salaries$yrs.service)
# or 
plot(salaries$yrs.service, salaries$salary)

#Function plot could be used to plot points or lines

#Explore various symbols 
?points

#Draw a table with all symbols
plot(c(-1, 26), 0:1, type = "n", axes = FALSE, xlab="", ylab="")
text(0:25, 0.6, 0:25, cex=0.75)
points(0:25, rep(0.5, 26), pch = 0:25, bg = "grey")


plot(x = salaries$yrs.service,
     y = salaries$salary, 
     pch = 19)

# Some often used graphics parameters:
# - pch: plotting symbol (default - open circle)
# - lty: line type (default - solid line)
# - lwd: line width 
# - las: orientation of the axis labels on the plot
# - bg: background color
# - fg: foreground color
# - mar: margin size
# - oma: outer margin size

levels(salaries$rank)
col3 <- c("steelblue4","firebrick","forestgreen")
cols <- col3 [ as.numeric(salaries$rank) ]
plot(x = salaries$yrs.service,
     y = salaries$salary, 
     pch = 19, 
     main = "Analysis of dependency of 2 variables",
     xlab = "Years of Service",
     ylab = "Salary", 
     col = cols,
     cex=1.5)

lm.fit <- lm(salary ~ yrs.service, data = salaries)
abline(lm.fit, lty = 2, lwd = 2)
legend("topleft",levels(salaries$rank),fill=col3 )


eq <- substitute(italic(salary) == a + b %.% italic(yrs.service)*","~~italic(r)^2~"="~r2, 
                 list(a = format(coef(lm.fit)[1], digits = 2), 
                      b = format(coef(lm.fit)[2], digits = 2), 
                      r2 = format(summary(lm.fit)$r.squared, digits = 3)))
#R-squared: what proportion of the variation in the outcome can be explained by the covariates/predictors
# if R-squared is low, than the outcome is poorly predicted by the covariates/


text(20,220000,labels=as.expression(eq) )



# -------- Another example of Plot --------

assist.prof <- salaries[salaries$rank == "AsstProf" &  salaries$discipline == "A", ]
plot( sort (assist.prof$salary ) )

#types:
  #p - points
  #l - lines
  #o - overplotted points and lines
  #b,c - points (empty if "c") joined by lines
  #s, S stair steps
  #h - histogram-like vertical lines
  #n - does not produce any points or lines

#Simple line plot
plot(sort(assist.prof$salary), type= "l")


plot(sort(assist.prof$salary), 
     type= "b", 
     lwd=2, 
     cex=1.5, 
     col="steelblue4", 
     pch = 19, 
     main = "Salaries for an Assistant Professorin Discipline A",
     xlab="", 
     #at=1:25, 
     ylab="Salary, dollars")


# -------- Histogram --------


#plot simple histogram
hist(salaries$salary)


hist(salaries$salary, 
     main="Histogram of Salaries of professors in Disciplines A and B",
     col="steelblue3",
     xlab="Salary, dollars")


hist(salaries$salary, 
     main="Histogram of Salaries of professors in Disciplines A and B",
     col="steelblue3",
     xlab="Salary, dollars", 
     prob=TRUE)


#Add rugplot
rug(salaries$salary)

lines(density(salaries$salary), col="darkblue", lwd=2)


# ----- Pairs -----


# Delays per airport
pairs(salaries[ c(4,5,7) ] ) 

#An alternative way using formula
pairs( ~ yrs.since.phd + yrs.service + salary, 
       data = salaries) 



panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}

pairs( ~ yrs.since.phd + yrs.service + salary, 
       data = salaries,
       lower.panel = panel.smooth, 
       upper.panel = panel.cor) 




# ----- Multiple plots in one graph -----
par.save <- par()  # save current graphics parameters
print( par() )     # print current graphics parameters

par( mfrow = c(2,2) )  # 2 rows and 3 columns

    # first graph
    pie(table(salaries$rank),
    labels = c("Associate Professor", "Assistant Professor", "Professor"),
    col = c("steelblue4","firebrick","forestgreen"),
    main = "Percentage of various Professor Ranks")

    # second graph
    b<-barplot(table(salaries$rank),
           col=c("steelblue4","firebrick","forestgreen"),
           main = "Professor Ranks",
           names.arg = c("Associate Professor", "Assistant Professor", "Professor"),
           ylim = c(0, max(table(salaries$rank)) * 1.25), 
           axes=FALSE)
    text(b,table(salaries$rank),table(salaries$rank), pos=3)
    mtext("Disciplines A and B")

    #third graph
    hist(salaries$salary, 
     main="Histogram of salaries",
     col="steelblue3",
     xlab="Proportion values", prob = TRUE)


     #fourth graph
col3 <- c("steelblue4","firebrick","forestgreen")
cols <- col3 [ as.numeric(salaries$rank) ]
plot(x = salaries$yrs.service,
     y = salaries$salary, 
     pch = 19, 
     main = "Analysis of dependency of 2 variables",
     xlab = "Years of Service",
     ylab = "Salary", 
     col = cols,
     cex=1.5)

par ( mfrow = c(1,1) )





# A few useful links with Many examples:
# http://shinyapps.org/apps/RGraphCompendium/index.php
# http://manuals.bioinformatics.ucr.edu/home/R_BioCondManual   #TOC-Some-Great-R-Functions
# http://www.cookbook-r.com/Graphs/
