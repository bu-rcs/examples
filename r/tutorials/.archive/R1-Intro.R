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


#------------------ #
#     variables     #
#------------------ #

a <- 3
b = -5  # both assignment operators are equivalent, the first one is more traditional
A <- 7  # R is case sensitive

# Avoid using names c, t, cat, F, T, D as those are built-in functions/constants

# The variable name can contain letters, digits, underscores and dots and 
# start with the letter or dot
# The variable name cannot contain dollar sign
str.var  <- "character variable"   # character variable
num.var  <- 21.17                  # numerical variable
bool.var <- TRUE                   # boolean variable
comp.var <- 1-3i                   # complex variable


# There are 5 main data types: vectors matrices, dataframes, lists, factors
#------------------ #
#   R vectors       #
#------------------ #

# Vector is an array of R objects of the same type:
names <- c ("Alex", "Nick", "Mike")
print(names)  # print result

# Execute the statement and print the result
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


# R operators
#              +, -, *, /  - addition, subtraction, multiplication, division
#              ^ or **     - exponentiation
#              %%          - modulus
#              %/%         - integer division
#              %in%        - membership
#              :           - sequence genration
#              <, <=, ==, >=, >, !=     - boolean comparative
#              |, ||       - OR  vectorized/not vectorized
#              &, &&       - AND
#              


# vector slicing (subsetting)
x <- c(734, 145, 958, 456, 924)    # define a numeric vector
x[2]         # returns second element 
x[2:4]       # returns second through 4th elements inclusive
x[c(1,3,5)]  # returns 1st, 3rd and 5th elements
x[-2]        # returns all but 2nd element
x[c(TRUE, TRUE, FALSE, FALSE, TRUE)]   # returns 1st, 2nd, and 5th elements
x[x<500]     # returns only those elements that less than 500


which.max(x)
which(x > 500)


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

smatr * smatr    # products of matrices elements
smatr %*% smatr  # matrix product
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
cancer <- read.csv("cancer.csv")   # read the dataframe

#------------------------ #
#   explore dataframes    #
#------------------------ #
# look at the first and last fiew records
head(cancer)
tail(cancer)

names(cancer)        # get the names of the variables
dim(cancer)          # get the number of the observations and the number of the variables
nrow(cancer)         # number of rows
ncol(cancer)         # number of columns

summary(cancer)      # get general summary
str(cancer)          # display the structure of the dataset

#Excersize: Read in colon.csv data and explore it
# Find:
#     - number of observations
#     - names of the columns
#     - types of variables
colon <- read.csv("colon.csv")   # read the dataframe

# from the previous command we see that strings were interpreted as factors
# in general this should be avoided for non-categorical variables

# factor variables
table(colon$rx)

# convert variable to a factor
cancer$sex <- factor(cancer$sex, levels=c("1","2"), labels=c("Male", "Female") )

# An example of R graphics
hist(cancer$age)
boxplot(cancer$time)

#------------------------ #
#   dataframes slicing    #
#------------------------ #
# dataframe slicing (accessing elements)
cancer[3,5]    # element, from the 3rd row, 5th column
cancer[3,]     # all elements from the 3rd row
cancer[ ,5]    # all elements in the 5th column 
cancer[[5]]    # same: accessing 5th variable (column) in the dataframe

cancer$age  # accessing elemnts using variable name
cancer[cancer$sex == 1, ]  # list all the rows in the dataset for which variable ed is equal to 1

male <- cancer[cancer$sex == "Male", ] 
#Save this new dataset
write.csv(male, "male.csv") # the default options might not give the desired result
write.csv(male, "male.csv", row.names=FALSE, quote = FALSE) # the default options might not give the desired result


#--------------------------------------- #
#  check for missing values              #
#--------------------------------------- #

# check if the value is missing
is.na(cancer$wt.loss)

# how many values are missing in the variable
sum(is.na(cancer$wt.loss))

# which observations have missing values in the variable cigar
which(is.na(cancer$wt.loss))

#if we want to exclude all observations with missing data (generally not a good idea)
cancer.no.miss <- na.omit(cancer)


#--------------------------------------- #
#   summaries for continues variables    #
#--------------------------------------- #
summary(cancer)

summary( cancer$time )
mean( cancer$time )    

mean( cancer$inst )  # does not work... because of missing variables
mean(cancer$inst, na.rm=TRUE)     

median(cancer$inst, na.rm=TRUE) 
quantile(cancer$inst, na.rm=TRUE)    
sd(cancer$inst, na.rm=TRUE)         # standard deviation
fivenum(cancer$inst, na.rm=TRUE)    # Tukey min, lower-hinge, median, upper-hindge, max
max(cancer$inst, na.rm=TRUE) 
min(cancer$inst, na.rm=TRUE) 

unique(cancer$age)
table(cancer$inst)


#--------------------------------------- #
#        Data Mining                     #
#--------------------------------------- #

#subset
sub.cancer <- subset(cancer, age > 65, select=c(time, age, sex, inst))

# Summary information by groups
tapply(cancer$time, cancer$sex, mean)

# Using Aggregate function
aggregate(cancer$time, by=list(sex=cancer$sex), FUN=mean)

# Correlation between 2 variables
cor(cancer$time, cancer$age, use = "complete.obs")

cor(cancer$ph.karno, cancer$pat.karno, use = "complete.obs")

# Linear Model (fit a line)
plot( cancer$ph.karno, cancer$pat.karno )
( lm.fit <- lm( cancer$ph.karno ~ cancer$pat.karno ) )
( lm.fit <- lm(ph.karno ~ pat.karno, data=cancer) )  # same command using data option
( lm.fit <- with(cancer, lm(ph.karno ~ pat.karno) ) )  # same command using data option
summary(lm.fit)   
coef(lm.fit)   # access coefficients
resid(lm.fit)  # access residual errors
fitted(lm.fit) # predicted values for dt$ap
abline (lm.fit)

#predict
predict (lm.fit )



# Tests for normality
# if the variable is normally distributed, the graph should be close to the straight line
qqnorm(cancer$time)  
qqline(cancer$time, lty=2)
shapiro.test(cancer$time) 
# p-value is small so we  reject the hypothesis that the data
# is normally distributed


# Create some normally distributed data
norm <- rnorm (100, mean=38, sd=1.5)
qqnorm(norm)  
qqline(norm, lty=2)
shapiro.test(norm) 
# This time the variable is normally distributed


# Fisher F test: compare  if 2 sample variances are significantly different
var.test (cancer$age[cancer$sex == 'Male'], cancer$age[cancer$sex=='Female'] ) 
# p-value (large) and 95-confidence interval (includes 1) suggests
# that we cannot reject the hypothesis that variances are the same for 2 samples

# Comparing 2 means: Student's t test
t.test ( cancer$age[cancer$sex == 'Male'] , cancer$age[cancer$sex=='Female'] ) 
# we cannot reject null-hypothesis based on the confidence interval and p value

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
