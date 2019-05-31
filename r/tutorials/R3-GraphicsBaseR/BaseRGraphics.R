# ---------------------------------------#
#                                        #
#  R script for RCS tutorial             #
#  Graphics in R
#  Katia Oleinik                         #
# ---------------------------------------#


# There are 3 main environments in R to create graphics:
# - R base utilities
# - lattice package
# - ggplot2 package
# There is also powerful "grid" package and a few in-development interactive packages


# Graphics is an important part of R language. It allows for:
# - exploratory graphics (helps to understand the data)
# - exlanatory graphics (allows to communicate our findings  with others)


# ------ Base R Graphics -------

# Generic(high level) plot functions include:
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


#-------------------------------------
# Analysis of relationship of two or more
#       numeric variables
#-------------------------------------

library(MASS)

#cats dataset: Anatomical Data from Domestic Cats
#Sex sex: Factor with evels "F" and "M".
#Bwt body weight in kg.
#Hwt heart weight in g.
plot( Bwt ~ Hwt, data = cats)


# In some cases data points could overlay each other
# In this case we can use
# Sunflower plot:
plot( Petal.Width ~ Petal.Length, data=iris )
sunflowerplot(Petal.Width ~ Petal.Length, data=iris)


# Another useful plot to see a relationship 
# between a few numeric variables is correlation plot

# There are a couple of choices - first is a function pairs()
pairs( iris[, 1:4] )

# A different method of showing the same data comes in corrplot() function
# from corrplot package
library(corrplot)

# Extract the numerical variables for analysis
numvals <- iris[, 1:4]

# Compute the correlation matrix 
corrm <- cor(numvals)

# Generate the correlation ellipse plot
corrplot(corrm, method="ellipse")


#------------------------------------
# Modifying graphs to improve quality 
# and to communicate the information 
#    to others
#-------------------------------------

# Let's go back to our first plot
plot( Bwt ~ Hwt, data = cats)

# We would like to 
# - add a title
# - modify the axis labels
# - possible change size and the color of the points
# - add a linear regression line

# Calculate a linear regression
ln.res <- lm(Bwt ~ Hwt, data = cats)

colors <- c("brown", "steelblue")
plot( Bwt ~ Hwt, data = cats, 
      main = " Relationship between body weight and heart weight in cats",
      xlab = "Heart weight (g)",
      ylab = "Body weight (kg)",
      cex = 1.1,
      pch = 16,
      col=colors[ cats$Sex ] )

legend("topleft",col=colors[ unique(cats$Sex) ], pch=16, legend=levels(cats$Sex))

abline(ln.res, lwd=2, lty=2)





# ----- Saving graphic -----

#Rstudio way to save the graph is to use "Export" menu and select appropriate format


# Two ways in R to output graph into the file:
# - copy the existing graph to the file
# - plot to the file (the graph will not appear on the screen)


#erase all plots that have been made so far
dev.off()

#Check opened devices
dev.list()


#--------------------------------------------------------------------
#Plot something
colors <- c("brown", "steelblue")
plot( Bwt ~ Hwt, data = cats, 
      main = " Relationship between body weight and heart weight in cats",
      xlab = "Heart weight (g)",
      ylab = "Body weight (kg)",
      cex = 1.1,
      pch = 16,
      col=colors[ cats$Sex ] )

legend("topleft",col=colors[ unique(cats$Sex) ], pch=16, legend=levels(cats$Sex))

abline(ln.res, lwd=2, lty=2)

#Check opened devices
dev.list()

#Check current device
dev.cur()


# Copy the existing graph to the file
dev.copy(png,"cats.png")

#Close the png file
dev.off() 
#--------------------------------------------------------------------

#Close rstudio device
dev.off()

dev.list()

#--------------------------------------------------------------------
# Plot the graph to the file (it will not appear on the screen )
png("cats.png")

colors <- c("brown", "steelblue")
plot( Bwt ~ Hwt, data = cats, 
      main = " Relationship between body weight and heart weight in cats",
      xlab = "Heart weight (g)",
      ylab = "Body weight (kg)",
      cex = 1.1,
      pch = 16,
      col=colors[ cats$Sex ] )

legend("topleft",col=colors[ unique(cats$Sex) ], pch=16, legend=c("Female","Male"))

abline(ln.res, lwd=2, lty=2)

dev.off() # close file
#--------------------------------------------------------------------


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



# -------- Graphics Parameters in R --------

# Function par() returns all the parameters that can be set withint R graphics functions
par()

# If you plan to change some global parameters it's always a good idea to save the default (current) ones
par.save <- par( no.readonly=TRUE)

# If we want to change any of the parameters globally using par() function, it's better to save the original values in a variable 
# and use it later to restore them if necessary
par( bg = "lightgray", no.readonly=TRUE)

pie( table(cats$Sex), 
     labels = c("Female","Male"), 
     col = c("brown", "steelblue") , 
     init.angle = 90, 
     main = "Cats")

#restore background to original value 
par(par.save)  

# ------ Example of using graphics parameters to change the original plot into informative one:

# create points for sqrt(x) and log(x) functions
x <- 1:10
y1 <- log(x)
y2 <- sqrt(x)

# First attempt to draw the points:
plot(x,y1)
lines(x,y2)

# Using R graphics parameters we can convert this plot into high quality one:
plot(x, y1,                                          # specify the coordinates
     type = "b",                                     # type of the plot
     ylim = c(min(c(y1,y2)), max(c(y1,y2))),         # set the axis limits
     main = "Logarithm and Square root functions",   # title
     ylab = "y",     #                               # y label
     col = "darkgreen",                              # line color
     lwd = 2,                                        # line tickness
     pch=15,                                         # symbol to display the point
     cex.lab=1.5,                                    # size of the font used for labels
     font.lab = 3,                                   # font type
     cex.main = 2)                                   # size of the font used for the title

#Additional line
lines(x,y2,                        # coordinates
      col = "steelblue",           # color
      lwd =2,                      # line width
      type="b",                    # line type (b - both, lines and points) 
      pch=19,                      # symbol used to display points
      cex.lab=1.5)                 # font size for labels

#Add grid to the plot
abline(h = seq(0,3,by=0.5), v = c(0:10), col='lightgray',lty="dotted")

#Add legend
legend("topleft",                             # position
       col=c("darkgreen","steelblue"),        # colors
       lty=1,                                 # draw line
       pch=c(15,19),                          # draw points
       cex=1.5,                               # text size
       legend=c("logarithm","square root"))   # text

# Add text to the graph
text(x = 6, y = sqrt(6), pos = 2, labels=expression(paste("y = ",sqrt(x))), cex=2, offset=0.75)
text(x = 6, y = log(6),  pos = 2, labels=expression(paste("y = ",ln(x))),   cex=2, offset=0.75)


#-----------------------------
#       Bar plot 
#-----------------------------

cats.sex <- table(cats$Sex)
barplot(cats.sex)

colors <- c("brown", "steelblue")
b<-barplot(cats.sex,
           col = colors,
           main = "Cats",
           sub = "R. A. Fisher (1947)",
           names.arg = c("Female","Male"), 
           ylim = c(0, max(cats.sex) * 1.1),
           axes = FALSE)

text(b,cats.sex,
     labels = cats.sex, 
     pos = 3)
title("Anatomical Data from Domestic Cats", line=0, cex.main=.8)

# Text justification
# adj parameter (0 - left justification, 1 - right justification)
# srt - angle of orientation with respect in horisonatl exis
# cex - font size
# font - 1 (default) - normal; 2 - bold; 3 - italics; 4 - both
# pos - position: 1 -  - below, 2 - to the left, 3 - top, 4 - to the right


#--------------------------------------------------
#       Stacked barplots and Side-by-side barplots 
#--------------------------------------------------

data <- matrix( c(45,78,90, 30, 50, 60), nrow=2, byrow=TRUE)
data

# By default barplot will show stacked bars
barplot(data)

colors <- c("brown", "steelblue")
b <- barplot(data, 
             main="Hours worked by 2 teams during 2015-2017 ", 
             col=colors, 
             ylim = c(0, max(colSums(data)) * 1.2))
text(b, c(45,78,90, 45+30, 78+50, 90+60), c(45,78,90, 30, 50, 60), pos=1)

# Side by side plot
colors <- c("brown", "steelblue")
b <- barplot(data, 
             main="Hours worked by 2 teams during 2015-2017 ", 
             col=colors, 
             ylim = c(0, max(data) * 1.2),
             beside=T)
b
text(b, data, data, pos=3)

legend("topleft",col=colors, pch=15, legend=c("team1", "team2"))


# -------- Colors in R ---------
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
barplot(c(21,19,16,14,12,10,8,5,4,3,2,1), col=c("steelblue4",
                                                "darkred",
                                                "dodgerblue",
                                                "forestgreen",
                                                "gold",
                                                "steelblue",
                                                "firebrick",
                                                "darkorange",
                                                "darkgrey",
                                                "tomato",
                                                "olivedrab",
                                                "dimgray"))


# A lits of some of my favorite colors:
#steelblue, steelblue4
#firebrick
#tomato
#skyblue
#olivedrab
#forestgreen
#gold
#dodgerblue
#dimgray
#darkred
#darkorange
#darkgray


#springgreen
#violetred
#slateblue
#sienna
#seagreen
#sandybrown
#salmon
#saddlebrown
#maroon
#limegreen

barplot(c(21,19,17,14,12,8,5,4,3,2,1), col=c("springgreen",
                                             "skyblue",
                                             "violetred",
                                             "slateblue",
                                             "sienna",
                                             "seagreen",
                                             "sandybrown",
                                             "salmon",
                                             "saddlebrown",
                                             "maroon",
                                             "limegreen"))


# 3. Specify rgb values
col1 <- rgb(0.1, 0.5, 0.1)
col2 <- rgb(0.9, 0.7, 0.0)
barplot(c(7,11), col=c(col1, col2))


#Conversion one color format to another
# col2rgb(), rgb2hsv()

# Additional help related to colors
help(package=colorspace)



#-------------------------------------
# Numeric and categorical variable
#-------------------------------------

# -------- Boxplot--------
salaries <- read.csv( "http://scv.bu.edu/examples/r/tutorials/Datasets/Salaries.csv")
boxplot(salaries$salary)

#let's display 2 boxplots: one for male and one for female names
boxplot( formula = salary ~ discipline,
         data = salaries,
         names = c("A","B"),
         col = c("gold","forestgreen"),
         horizontal = TRUE,
         main = "Salary range for Disciplines A and B")

# ------- Plot -------
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
abline(lm.fit, lty = 4, lwd = 2, col="darkgray")
legend("topleft",levels(salaries$rank),fill=col3 )


# explore functions like 
# substitute()
# expression()
# quote()
# bquote()
# enquote()  
# todisplay formulas and font changes
eq <- substitute(italic(salary) == a + b %.% italic(yrs.service)*","~~italic(r)^2~"="~r2, 
                 list(a = format(coef(lm.fit)[1], digits = 2), 
                      b = format(coef(lm.fit)[2], digits = 2), 
                      r2 = format(summary(lm.fit)$r.squared, digits = 3)))
#R-squared: what proportion of the variation in the outcome can be explained by the covariates/predictors
# if R-squared is low, than the outcome is poorly predicted by the covariates/


text(15,170000,labels=as.expression(eq), pos=4, cex=.8 )


# -------- Histogram --------


#plot simple histogram
hist(salaries$salary)


hist(salaries$salary, 
     main="Histogram of Salaries of professors in Disciplines A and B",
     col="steelblue3",
     xlab="Salary, dollars")

# Same plot with probability along the y axes
hist(salaries$salary, 
     main="Histogram of Salaries of professors in Disciplines A and B",
     col="steelblue3",
     xlab="Salary, dollars", 
     prob=TRUE)


#Add rugplot
rug(salaries$salary)

#Add density line
lines(density(salaries$salary), col="darkblue", lwd=2)


# --------- Using functions in plots ------------


pairs( iris[, 1:4] )
# or using a formula
pairs( ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data=iris)

pairs( ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, 
       data = iris,
       lower.panel = panel.smooth, 
       upper.panel = NULL) 



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

pairs( ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, 
       data = iris,
       lower.panel = panel.smooth, 
       upper.panel = panel.cor) 


# Put histogram on the diagonal 

panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}
pairs(~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, 
      data = iris,
      panel = panel.smooth,
      cex = 1.5, pch = 16, bg = "light blue",
      diag.panel = panel.hist, cex.labels = 2, font.labels = 2)



# ----- Multiple plots in one graph -----
#par.save <- par()  # save current graphics parameters
#print( par() )     # print current graphics parameters

par( mfrow = c(1,2) )  # 1 row and 2 columns

# first graph
ranks <- table(salaries$rank)
labels <-c ("Associate Professor", "Assistant Professor", "Professor")
pie( ranks, labels = labels, col = 2:4 , init.angle = 90, main = "Teaching Faculty")

# second graph
b<-barplot(table(salaries$rank),
           col=c("steelblue4","firebrick","forestgreen"),
           main = "Professor Ranks",
           names.arg = c("Associate Professor", "Assistant Professor", "Professor"),
           ylim = c(0, max(table(salaries$rank)) * 1.25), 
           axes=FALSE)
text(b,table(salaries$rank),table(salaries$rank), pos=3)


par ( mfrow = c(1,1) )
par(par.save)



# A few useful links with Many examples:
# http://shinyapps.org/apps/RGraphCompendium/index.php
# http://manuals.bioinformatics.ucr.edu/home/R_BioCondManual   #TOC-Some-Great-R-Functions
# http://www.cookbook-r.com/Graphs/

