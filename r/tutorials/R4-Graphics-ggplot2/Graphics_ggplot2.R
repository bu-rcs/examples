# ---------------------------------------#
#                                        #
#  R script for RCS tutorial             #
#  Graphics in R
#  Katia Oleinik                         #
# ---------------------------------------#

#To install a package:
install.packages("ggplot2")
install.packages("RColorBrewer")

#To load R package
library(ggplot2)
library(RColorBrewer)


#Read Salary dataset
salaries <- read.csv( "http://scv.bu.edu/examples/r/tutorials/Salaries.csv")

#Explore the dataset
head(salaries)
str(salaries)
summary(salaries)




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

ranks <- table(salaries$rank)

pie(ranks)

#How to improve the graph - read help for the function and see the examples!
?pie

mycol <- c("darkorange","forestgreen","steelblue4")
  
pie(ranks,
    labels = names(ranks),
    col = mycol,
    main = "Teaching Faculty")



# Note: Pie charts should not be used for data exploration
#       The eye is good at judging linear measures and bad at judging relative areas. 
#       A bar chart or dot chart is a preferable way of exploring this type of data.

# Let's add some numeric information to the graph... 
percent = round(100 * ranks / sum(ranks), 1)
rank.names <- c("Associate Professor", "Assistant Professor", "Professor")
labels <- paste( rank.names, " ",percent, "%",     sep="")
pie( ranks,
     labels = labels,
     col = mycol ,
     init.angle = 90,
     main = "Teaching Faculty")

#Add some text to the graph
text(x=0.25,y=-1.0, 
     labels = "Source: University Administration", 
     pos = 4, 
     cex=0.75)


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
pie( ranks, labels = labels, col = mycol , init.angle = 90, main = "Teaching Faculty")

          #Check opened devices
          dev.list()

          #Check current device
          dev.cur()


# Copy the existing graph to the file
dev.copy(png,"piechart.png")

#Close the png file
dev.off() 
#--------------------------------------------------------------------

#Close rstudio device
dev.off()

dev.list()

#--------------------------------------------------------------------
# Plot the graph to the file (it will not appear on the screen )
png("piechart.png")

   pie( ranks, labels = labels, col = mycol , init.angle = 90, main = "Teaching Faculty")

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
pie( ranks, labels = labels, col = mycol , init.angle = 90, main = "Teaching Faculty")

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



# -------- Bar plot --------

barplot(ranks)


b<-barplot(ranks,
           col = mycol,
           main = "Teaching Faculty",
           sub = "Source: University Administration",
           names.arg = rank.names, 
           ylim = c(0, max(ranks) * 1.1),
           axes = FALSE)

text(b,ranks,
     labels = ranks, 
     pos = 3)


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


# -------- Boxplot--------

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


# ----- Pairs -----


# Delays per airport
pairs( salaries[ ,c("yrs.since.phd", "yrs.service","salary") ] ) 

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
#par.save <- par()  # save current graphics parameters
#print( par() )     # print current graphics parameters

par( mfrow = c(1,2) )  # 1 row and 2 columns

    # first graph
    pie( ranks, labels = labels, col = mycol , init.angle = 90, main = "Teaching Faculty")

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


#----------------------------------------------------
#
#  ggplot2 tutorial with many useful examples
# http://r-statistics.co/ggplot2-Tutorial-With-R.html
#
#----------------------------------------------------

# Very basic ggplot2 introduction:
library(ggplot2)


# basic pie-chart
ggplot(salaries, aes(x=factor(1), fill=rank)) + 
  geom_bar(width=1)

ggplot(salaries, aes(x=factor(1), fill=rank)) + 
  geom_bar(width=1) + 
  coord_polar("y") + 
  ggtitle("Teaching Faculty")

ggplot(salaries, aes(x=factor(1), fill=rank)) + 
  geom_bar(width=1) + 
  coord_polar("y") +
  ggtitle("Teaching Faculty") + 
  theme_minimal() + 
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    panel.grid = element_blank(),
    panel.border = element_blank(),
    plot.title=element_text(size=14,face="bold")
  )



#basic plot with points
ggplot(salaries, aes( yrs.service, salary)) + geom_point() 

ggplot(salaries, aes( yrs.service, salary)) + 
  geom_point() +    # type of geom objects
  theme_bw() +      # theme
  ggtitle(" Salary analysis")   # plot title

# color the points according to the faculty type
ggplot(salaries, aes( yrs.service, salary)) + 
  geom_point( aes(color = factor(rank)  ), size=5) +    # type of geom objects
  ggtitle(" Salary analysis") +  # plot title
  theme_bw( ) +      # theme
  theme ( plot.title=element_text(size=14,face="bold" ) )


#Add a regression line to the plot
ggplot(salaries, aes( yrs.service, salary)) + 
  geom_point( aes(color = factor(rank)  ), size=5) +    # type of geom objects
  ggtitle(" Salary analysis") +  # plot title
  geom_smooth() + 
  theme_bw( ) +      # theme
  theme ( plot.title=element_text(size=14,face="bold" ) )

# Change the line to a simple lm line
ggplot(salaries, aes( yrs.service, salary)) + 
  geom_point( aes(color = factor(rank)  ), size=5) +    # type of geom objects
  ggtitle(" Salary analysis") +  # plot title
  geom_smooth( method='lm' , col = "black") + 
  theme_bw( ) +      # theme
  theme ( plot.title=element_text(size=14,face="bold" ) )


#boxplot
ggplot(salaries, aes( x=discipline, y=salary ) ) + geom_boxplot() 

#adding addional features to the boxplot
ggplot(salaries, aes( x=discipline, y=salary ) ) + 
  geom_boxplot() +
  geom_jitter(width = 0.2)

ggplot(salaries, aes( x=rank, y=salary) ) + 
  geom_boxplot( varwidth = TRUE ) + #width is proportional to the square roots of the number of observations
  geom_jitter(width = 0.2) + 
  ggtitle(" Salary analysis") + 
  coord_flip() + 
  theme ( plot.title=element_text(size=14,face="bold" ) )

#histogram
ggplot(salaries, aes(x=salary)) + geom_histogram()
ggplot(salaries, aes(x=salary)) + geom_histogram(binwidth=10000)

#improving histogram
ggplot(salaries, aes(x=salary)) + 
  geom_histogram(binwidth=10000, 
                 color="black", fill="white")

ggplot(salaries, aes(x=salary)) + 
  geom_histogram(binwidth=10000, 
                 color="black", fill="white", aes(y=..density..)) + 
  geom_density(alpha=.2, fill="darkorange")


