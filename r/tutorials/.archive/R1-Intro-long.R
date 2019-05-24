# ---------------------------------------#
#                                        #
#  R script for SCV tutorial             #
#  Katia Oleinik                         #
# ---------------------------------------#

# R as a scientific calculator
2+3    # addition
2^3    # power
log(2) # built-in functions
pi     # built-in constants

# By default R outputs 7 significant digits (single precision display).
# But all calculations are always done using double precision
options(digits=15)   # change to double precision display
exp(3)

# options(digits=7) # return back to the single precision output

#------------------ #
#     variables     #
#------------------ #

a <- 3
b = -5  # both assignment operators are equivalent, the first one is more traditional

7-> x   # this works too!

A <- 7  # R is case sensitive

# Avoid using names c, t, cat, F, T, D as those are built-in functions/constants

# The variable name can contain letters, digits, underscores and dots and 
# start with the letter or dot
# The variable name cannot contain dollar sign
str.var  <- "character variable"   # character variable
num.var  <- 21.17                  # numerical variable
bool.var <- TRUE                   # boolean variable
comp.var <- 1-3i                   # complex variable

# check the mode of the variable (its type):
mode(bool.var)
mode(num.var)


# There are 5 main data types: vectors matrices, dataframes, lists, factors
#------------------ #
#   R vectors       #
#------------------ #

# Vector is an array of R objects of the same type:
( names <- c ("Alex", "Nick", "Mike") )

# Vectors can be defined in a number of ways:
( vals <- c (2, -7, 5, 3, -1 ) )    # concatenation
( vals <- 1:100 )                   # range of values
( vals <- seq(0, 3, by=0.5) )       # sequence definition
( vals <- rep("o", 7) )             # repeat value
( vals <- numeric(9))                # initialize numeric vector
( vals <- rnorm(5, 2, 1.5 ) )        # returns normally distributed values
  
# Vector elements can have labels:
heights <- c(Alex=180, Bob=175, Clara=165, Don=185)
heights


# Vector arithmetic:
a <- 1:5
b <- seq(2,10, by=2)
a+b
b/a   # do not use loops to perform operations on vectors

# vector slicing (subsetting)
x <- c(734, 145, 958, 456, 924)    # define a numeric vector
x[2]         # returns second element 
x[2:4]       # returns second through 4th elements inclusive
x[c(1,3,5)]  # returns 1st, 3rd and 5th elements
x[-2]        # returns all but 2nd element
x[c(TRUE, TRUE, FALSE, FALSE, TRUE)]   # returns 1st, 2nd, and 5th elements
x[x<500]     # returns only those elements that less than 500

# vector functions:
#               max(x),   min(x),     sum(x)
#               mean(x),  median(x),  range(x)
#               var(x)                            - simple variance
#               cor(x,y)                          - correlation between x and y
#               sort(x), rank(x), order(x)
#               cumsum(), cumprod(x), cummin(x), cumprod(x)
#               duplicated(x), unique(x)
#               summary()

#------------------ #
#   Missing Values  #
#------------------ #
x <- c(734, 145, NA, 456, NA)    # define a numeric vector
is.na(x)              # check if the element in the vector is missing
which(is.na(x))       # which elements are missing

x == NA   # this does not work ! - missing value cannot be compared to anything


#------------------ #
#   Factors         #
#------------------ #
#Factor is a special type of a vector that stores "categorical" variables.
#To convert a vector into the factor use factor() function
x <- c(0, 1, 1, 1, 0, 0, 1, 0)    
x <- factor(x)
table(x)

#Each level in the factor variable can be named
x <- factor( c(0, 0, 1, 1, 0, 0, 1, 0), labels=c("Fail","Success"))   
table(x)

#Factors are treated differently by the summary() function:
summary(x)


#------------------ #
#   R Matrices      #
#------------------ #
( matr <- matrix( c(1,2,3,4,5,6) , ncol=2))  # 3x2 matrix
( matr <- matrix( c(1,2,3,4,5,6) , nrow=2))  # 2x3 matrix

matr <- c(1,2,3,4,5,6)   # first define the vector
dim(matr) <- c(2,3)      # change dimensions
matr

#You can fill matrix by-row
matr <- matrix( c(1,2,3,4,5,6) , ncol=2, byrow=TRUE)
matr


t(matr)       # transpose matrix

( smatr = matrix( c(1,-3, 2, 5, -4, 7, 8, 0, 6) , ncol=3) )
solve(smatr)   # find inverse

smatr*smatr    # products of matrices elements
smatr%*%smatr  # matrix product
smatr^(-1)     # inverse of each element

# Some functions:
colMeans(smatr)  # column means
rowMeans(smatr)  # row means
colSums(smatr)  # column totals
rowSums(smatr)  # row totals

#------------------ #
#   R help          #
#------------------ #

# Access help file for the R function
?matrix
help(matrix)

# Search for help
help.search("matrix")

# get arguments of a function
args(matrix)

# examples of function usage
example(matrix)

#---------------------------- #
#  Clean current R session    #
#---------------------------- #

# check variables in the current session
objects()

rm(list=ls()) # remove everything from your working environment

#------------------ #
#   R dataframes    #
#------------------ #

#A data frame is more general than a matrix, 
# in that different columns can have different modes (numeric, character, factor, etc.). 
# It is similar to SAS and SPSS datasets.
names <- c("Alex", "Bob", "Cat")
ages <- c(12,5,7)
sex <- c("M","M","F")
kids <- data.frame(Names=names,Ages=ages,Sex=sex)
kids

# Summary function will recognize each variable type:
summary(kids)



# 1. Read the data from a file
# 2. Clean the dataset if necessary, check for missing values
# 3. Get summary of the data
# 4. Use R graphics to explore each variable in the dataset
# 5. Perform statistical analysis

# See IO.R for more examples on reading a dataset
dt <- read.csv("USA_states.csv")   # read the dataframe

#------------------------ #
#   explore dataframes    #
#------------------------ #
# look at the first and last fiew records
head(dt)
tail(dt)

names(dt)        # get the names of the variables
dim(dt)          # get the number of the observations and the number of the variables
nrow(dt)         # number of rows
ncol(dt)         # number of columns

summary(dt)      # get general summary
str(dt)          # display the structure of the dataset

#library Hmisc provides an addition tool to explore the dataset:
library(Hmisc)
describe(dt)

# from the previous command we see that strings were interpreted as factors
# in general this should be avoided for non-categorical variables

# factor variables
table(dt$Location)

# An example of R graphics
hist(dt$Traffic.fatalities)

# we can convert the variable back from factor to the string
dt$State <- as.character(dt$State)

# or we can read the dataset using option
dt <- read.csv("USA_states.csv", stringsAsFactors=FALSE)   # read the dataframe
str(dt)          # display the structure of the dataset

#We can edit the names of this dataset if we want to
names(dt) <- c("state", "location", "pop", "area", "house","ap", "traffic","ed","cancer","cigar","date")
names(dt)

# convert Location & education variables to be a factor variables
dt$location <- factor(dt$location)
dt$ed <- factor(dt$ed)
str(dt)          # display the structure of the dataset

#------------------------ #
#   dataframes slicing    #
#------------------------ #
# dataframe slicing (accessing elements)
dt[3,5]    # element, from the 3rd row, 5th column
dt[3,]     # all elements from the 3rd row
dt[ ,5]    # all elements in the 5th column 
dt[[5]]    # same: accessing 5th variable in the dataframe

dt$area   # accessing elemnts using variable name
dt[dt$ed ==0, ]  # list all the rows in the dataset for which variable ed is equal to 0


#--------------------------------------- #
#  check for missing values              #
#--------------------------------------- #

# how many values are missing in the variable
sum(is.na(dt$cigar))

# which observations have missing values in the variable cigar
which(is.na(dt$cigar))

#if we want to exclude all observations with missing data (generally not a good idea)
##dt <- na.omit(dt)

#--------------------------------------- #
#   summaries for continues variables    #
#--------------------------------------- #
summary(dt$cigar)
quantile(dt$cigar)   # does not work... because of missing variables
quantile(dt$cigar, na.rm=TRUE)    
mean(dt$cigar, na.rm=TRUE)    
median(dt$cigar, na.rm=TRUE) 
sd(dt$cigar, na.rm=TRUE)         # standard deviation
fivenum(dt$cigar, na.rm=TRUE)    # Tukey min, lower-hinge, median, upper-hindge, max
max(dt$cigar, na.rm=TRUE) 
min(dt$cigar, na.rm=TRUE) 
hist(dt$cigar)                  # very simple histogram
boxplot(dt$cigar, horizontal=TRUE)               # boxplot

# barplot for categorical variable
barplot(table(dt$location))

#--------------------------------------- #
#        Statistical Analysis            #
#--------------------------------------- #

# Summary information by groups
tapply(dt$ap, dt$location, mean)
tapply(dt$traffic, dt$ed, mean)


# correlation between 2  continuous variables:
plot(dt$house ~ dt$pop)     # strong correlation
cor(dt$house, dt$pop)     
plot(dt$house ~ dt$area)    # weak correlation
cor(dt$house, dt$area)    

plot(dt$ap ~ dt$pop)    
cor(dt$ap, dt$pop) 

# search for all correlated data in the table at once
pairs(dt[,c(3,4,5,6,9,10)])

# Linear Model (fit a line)
( lm.fit <- lm(dt$ap ~dt$pop) )
( lm.fit <- lm(ap ~ pop, data=dt) )  # same command using data option
( lm.fit <- with(dt, lm(ap ~ pop) ) )  # same command using data option
summary(lm.fit)   
coef(lm.fit)   # access coefficients
resid(lm.fit)  # access residual errors
fitted(lm.fit) # predicted values for dt$ap
plot(dt$ap~dt$pop)
abline (lm.fit)

# Using with() and by() functions
#With command can be used to shorted the typing:
with(dt, lm(ap ~ pop))

# The by() function can be used to execute commands on subsets of the datasets
by(dt[, c("ap","pop")], dt$location, summary)


#------------------------------------------------------ #
#                   Classical Tests                     #
#------------------------------------------------------ #



#--------------------------------------------------------------------------------------------------------------
#                      |     Observations Independent or Correlated    |                                      |
#                      |-----------------------------------------------|   Alternative tests                  |
#   Outcome variable   |                      |                        | ( non-normal distribution,           |
#                      |  independent         | correlated             |   small sample size, etc.   )        |
#                      |                      |                        |                                      |
#------------------------------------------------------------------------------------------------------------
#                      | Ttest, ANOVA         | Paired ttest           | Wilcoxon rank-sum test(alt. ttest)   |
#  Continuous          | linear correlation   | Repeated-measures ANOVA| Wilcoxon sign-rank test (alt. paired)|
#                      | linear regression    | Mixed models/GEE       | Kruskal-Wallis test  (alt. ANOVA)    |
#                      |                      |                        | Spearman rank (alt. Pearson' corr.)  |
#------------------------------------------------------------------------------------------------------------
#                      | Risk differ. (2x2)   | McNemar's test (2x2)   | Fisher's exact test                  |
#  Binary    or        | Chi-square test (RxC)| Conditional logistic   | McNemar's exact test                 |
#  Categorical         | Logistic regression  |     regression (mult.) |                                      |
#                      |   (multivariate regr)| GEE modelling (mult.)  |                                      |
#-------------------------------------------------------------------------------------------------------------
#                      | Rate Ratio           | Frailty model          | Time-varying effects                 |
# Time to event        | Kaplan-Meier stat.   |                        |                                      |
# (time to get disease)| Cox regression       |                        |                                      |
#--------------------------------------------------------------------------------------------------------------


# Tests for normality
# if the variable is normally distributed, the graph should be close to the straight line
qqnorm(dt$cigar)  
qqline(dt$cigar, lty=2)
shapiro.test(dt$cigar)  
# p-value is large so we cannot reject the hypothesis that the data
# is normally distributed

qqnorm(dt$area)  
qqline(dt$area, lty=2)
shapiro.test(dt$area) 
# This time the variable is not normally distributed

# Fisher F test: compare  if 2 sample variances are significantly different
var.test (dt$traffic[dt$ed ==0], dt$traffic[dt$ed==1] ) 
# p-value (large) and 95-confidence interval (includes 1) suggests
# that we cannot reject the hypothesis that variances are the same for 2 samples

# Comparing 2 means: Student's t test
t.test (dt$traffic[dt$ed ==0], dt$traffic[dt$ed==1] ) 
# we reject null-hypothesis based on the confidence interval and p value

# Paired t test
# Let's simulate another variable "number of traffic fatalities after after some law was implemented"
dt$traffic.after <- dt$traffic - rnorm(length(dt$traffic), mean=0.2, sd=.2)
( t.result<- t.test (dt$traffic, dt$traffic.after, paired=TRUE ) )
# as we expected the difference in means is not equal to 0 based on 95 percent conf. interval and p value
str(t.result)
# the output of this function is a list, we can access each individual element of the list by name
t.result$p.value
t.result$conf.int
# we can also access list elements by the index:
t.result[[3]]

# Binomial test - compare 2 proportions
# let's split the dataset into 2 groups and check if the proportion of "ed"=1 is the same among 2 groups
dt.group1 <- subset( dt, location =="N" | location =="NE" | location =="NW", select=c(state, traffic, ed))
dt.group2 <- subset( dt, location =="S" | location =="C" | location =="E"  | location =="S" | location =="SE" | location =="SW", select=c(state, traffic, ed))
prop.test(c(sum(dt.group1$ed==1),sum(dt.group2$ed==1)),c(length(dt.group1$ed),length(dt.group2$ed)))


#--------------------------------- #
#     Statistical Models           #
#--------------------------------- #
#
#  y ~ x    - regression
#  y ~ x-1  - regression through the origin
#  y ~ x + z - multiple regression
#  y ~ x * z - multiple regression with interaction
#  y ~ xc   - one way ANOVA (xc is a categorical variable)
#  y ~ xc1 + xc2  - two way ANOVA (xc1, xc2)
#  ...
#
lm.fit <- lm(dt$ap ~ dt$pop)
summary(lm.fit )
anova(lm.fit )
qf(0.95,1,48) 
par(mfrow=c(2,2))  # display 4 graphs at once
plot(lm.fit )
par(mfrow=c(1,1))  # return to the default mode - 1 graph at  a time
# first plot should not show any structure or pattern
# second (upper right) -should be close to the straight line
# third (bottom left) - we should not see a triangular shape
# last one - highlight the points that have the largest effect on the parameter estimates
# It displays Cook's distance contour lines , which is another measure of the importance of each observation in the regression. 
# Distances larger than 1 suggest the presence of a possible outlier or a poor model


# Multiple regression
# Suppose Y = dt$ap - number of AP tests in the state
# Predictors are X1 = dt$pop - population
#                X2 = dt$area - land area
#                X3 = dt$cigar - cigarettes sold
#         Y = FUN(X1, X2) + err
lm.fit <- lm(dt$ap ~ dt$pop + dt$area + dt$cigar)
summary(lm.fit)
