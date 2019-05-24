# ---------------------------------------#
#                                        #
#  R script for RCS tutorial             #
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
A <- 7  # R is case sensitive - variables a and A are different variables

# Avoid using names F and T as those are built-in constants for FALSE and TRUE 
# There is an R function c(). To avoid confusion it is a good practice to avoid naming
# your own variables and functions "c".

# The variable name can contain letters, digits, underscores and dots and 
# start with the letter or dot
# The variable name cannot contain dollar sign
name <- "Nikola Tesla"   # character variable
age <- 87                # numeric variable
male <- TRUE             # boolean variable
today <- Sys.time()      # date and time variable

# Check object class:
class(age)






# There are 4 main data types: vectors matrices, dataframes, lists

#------------------ #
#   R vectors       #
#------------------ #

# Vector is an array of R objects of the same type:
names <- c ("Alex", "Nick", "Mike")
print(names)  # print result
names         # printing the name of the variable at the prompt shows the content of the variable


# Vectors can be defined in a number of ways:
c (2, -7, 5, 3, -1 )              # concatenation
25:75                             # range of values
seq( from=0, to=3, by=0.5 )       # sequence definition
rep( 1, times=7)                  # repeat value
rnorm( 50 )                       # returns normally distributed values


# systolic blood pressure values
SBP <- c(96, 110, 100, 125, 90 )

# diastolic blood pressure
DBP <- c(55, 70, 68, 100, 50)

# calculate MAP (mean arterial pressure)
MAP <- SBP/3 + 2*DBP/3
MAP

# R arithmetic operators
#              +, -, *, /  - addition, subtraction, multiplication, division
#              ^ or **     - exponentiation
#              %%          - modulus
#              %/%         - integer division

# R logial (boolean) operators
#              %in%        - membership
#              <, <=, ==, >=, >, !=     - boolean comparative
#              






#-------------------------------------- #
#   R vector slicing (subsetting)       #
#-------------------------------------- #
 
temp <- c(36.6, 38.2, 36.4, 37.9, 41.0, 39.9, 36.8, 37.5)    # define a numeric vector
temp[2]         # returns second element 
temp[2:4]       # returns second through 4th elements inclusive
temp[c(1,3,5)]  # returns 1st, 3rd and 5th elements
temp[-2]        # returns all but 2nd element
temp[c(TRUE, FALSE, TRUE, FALSE, FALSE,FALSE, TRUE, FALSE)]   # returns 1st, 3rd, and 7th elements

#compare each element of the vector with a value
temp < 37.0

#return only those elements of the vector that satisfy a specific condition
temp[ temp < 37.0 ]    






#-------------------------------------- #
#             Vector operations         #
#-------------------------------------- #

which.max(temp)  # find the (first)maximum element and return its index
which.min(temp)
which(temp >= 37.0) # find the location of all the elements that satisfy a specific condition


# vector functions:
#               max(x),   min(x),  sum(x),     prod(),
#               mean(x),  sd(),    median(x),  range(x)
#               sort(x),  rank(x),    order(x)
#               cumsum(), cumprod(x), cummin(x), cummax(x)
#               var(x)                            - simple variance
#               cor(x,y)                          - correlation between x and y
#               duplicated(x), unique(x)
#               summary()








#------------------ #
#   R help          #
#------------------ #

# Access help file for the R function
?sd
help(sd)

# Search for help
??"standard deviation"
help.search("standard deviation")
help.search("analysis of variance")






#-------------------------------------------------------- #
#                  Missing Values                         #
#-------------------------------------------------------- #

x <- c(734, 145, NA, 456, NA)    # define a numeric vector
is.na( x )              # check if the element in the vector is missing
which( is.na(x) )       # which elements are missing
anyNA( x )              # are there any missing data
sum( is.na(x) )         # how many missing data are there
x[ !is.na(x)  ]         # list values excluding missing

#x == NA   # this does not work ! - missing value cannot be compared to anything



# Applying functions to vectors containing missing values:
mean(x)
# By default mamy statistical functions will not compute if the data contain missing values

# Read help topic for the function
?mean

#Perform computation removing the missing data
mean(x, na.rm=TRUE)





#-----------------------------------------------------------------------#
#                       Read-in data from a file                        #
#-----------------------------------------------------------------------#
df <- read.csv( "http://scv.bu.edu/examples/r/tutorials/Datasets/Salaries.csv")


#See more examples of reading the data from the various formats in IO.R script





#----------------------------------------------------------------------#
#                      Dataframe exploration                           #
#----------------------------------------------------------------------#

#Look at the first few records
head(df)
tail(df)

#Get the list of the columns
names(df)

#Number of rows:
nrow(df)

#Number of columns:
ncol(df)

#Get the structure of the data:
str(df)

#Get the summary of the data:
summary(df)





#numeric data exploratory analysis
min(df$salary)
max(df$salary)
range(df$yrs.service)
summary(df$salary)

#view the data
hist(df$salary)

#another way to look at the data
boxplot( df$salary )

#view qq-plot to see if the data normaly distributed
qqnorm(df$salary); qqline(df$salary)

#Shapiro-Wilks test of normality
shapiro.test(df$salary)
#Null-hypothesis - the sample comes from a normal distribution
#Alternative hypothesis - the sample does not come from a normal distribution
#p-value < 0.05 - reject the Null-hypothesis - data are not normally distributed


#categorical data analysis
summary(df$rank)
summary(df$sex)






#------------------------------------------------------------- #
#                       dataframes slicing                     #
#------------------------------------------------------------- #



# dataframe slicing (accessing elements)
df[3,5]    # element, from the 3rd row, 5th column
df[3,]     # all elements from the 3rd row
df[ ,5]    # all elements in the 5th column 

df$sex  # accessing elemnts using variable name
df[df$sex == "Male", ]  # list all the rows in the dataset for which variable ed is equal to specific value

#Create a new dataframe as a subset of the original one
disc.B <- df[df$discipline == "B", ] 

#Alternatively we can use function subset()
disc.B <- subset( df, discipline == "B")

# Save a new data frame into a file
write.csv(disc.B, file="B_discipline.csv", row.names=FALSE, quote=FALSE)







#------------------------------------------------------------------ #
#     Data Analysis (numeric vs. categorical)                       #
#------------------------------------------------------------------ #

#We would like to complare to groups of the dataframe
# Let's compare the salaries of 
# - Assistant Professor, 
# - Associate Professor,
# - Professor

boxplot(salary ~ rank, data=df)

#get mean value for each subgroup
mean( df$salary[ df$rank == "AsstProf" ] )
mean( df$salary[ df$rank == "AssocProf" ] )
mean( df$salary[ df$rank == "Prof" ] )

#There is an easier way to perform the above calculation for each value of a categorical variable:
tapply( df$salary,  df$rank, mean)



-
#Let's explore if women get a similar salaries as men do (within this sample)
boxplot(salary ~ sex, data=df)

#calculate mean for each subgroup using tapply
tapply( df$salary,  df$sex,  mean)



# is this difference is actually significant to state that women's salary is lower than men's
# We will perform the analysis of variance (anova test)
aov.res <- aov( salary ~ sex, data=df )
summary(aov.res)
# Since p-value is < 0.05 we reject the Null hypothesis of equal means
# F - is the ration of two mean square values. If the Null hypothesis is true, 
# we expect F to be close to 1.  large F ratio means that variation among group means
# is larger than we expect to see by chance


# The difference in salary for various disciplines in this dataset is even more pronounced
boxplot( salary ~ sex + discipline, data=df  )
aov.res <- aov( salary ~ sex + discipline, data=df )
summary(aov.res)


#Multiple Comparisions
boxplot( salary ~ rank, data=df  )
aov.res <- aov( salary ~ rank, data=df )
summary(aov.res)
# Here we definetly reject the Null hypothesis, but we cannot state that all groups have different means

#To compare means between each subgroup - perform Tukey honestly significant difference test
TukeyHSD(aov.res)
# There is a significant difference between Professor and the other 2 groups, but
# we cannot reject a Null hypothesis comparing the mean salaries of Assistant Professor and Associate Professor






#----------------------------------------------------------------#
#              Analysis of 2 numeric variables
#----------------------------------------------------------------#
plot(df$yrs.service, df$salary)

# Linear regression: fit linear model
lm.fit <- lm (salary ~ yrs.service, data = df) 
summary(lm.fit)   


# plot original data together with a fitted line
plot(df$yrs.service, df$salary)
abline (lm.fit)

#predict
predict (lm.fit, data.frame(yrs.service=10:20) )











#--------------------------------------------------------------#
#
#   Optional material for the tutorial
#   Example of exploring a data set with missing values
#-------------------------------------------------------------#


# 1. Read the data from a file
# 2. Clean the dataset if necessary, check for missing values
# 3. Get summary of the data
# 4. Use R graphics to explore each variable in the dataset
# 5. Perform statistical analysis

# NCCTG Lung Cancer Data
# Survival in patients with advanced lung cancer from the North Central Cancer Treatment Group. 
# Performance scores rate how well the patient can perform usual daily activities. 
cancer <- read.csv("http://scv.bu.edu/examples/r/tutorials/Datasets/cancer.csv")   # read the dataframe
# inst:  Institution code
# time:	Survival time in days
# status:	censoring status 1=censored, 2=dead
# age:	Age in years
# sex:	Male=1 Female=2
# ph.ecog:	ECOG performance score (0=good 5=dead)
# ph.karno:	Karnofsky performance score (bad=0-good=100) rated by physician
# pat.karno:	Karnofsky performance score as rated by patient
# meal.cal:	Calories consumed at meals
# wt.loss:	Weight loss in last six months



# look at the first and last fiew records
head(cancer)
tail(cancer)

names(cancer)        # get the names of the variables
dim(cancer)          # get the number of the observations and the number of the variables
nrow(cancer)         # number of rows
ncol(cancer)         # number of columns

summary(cancer)      # get general summary
str(cancer)          # display the structure of the dataset

# convert numeric variable to a factor (categorical variable)
cancer$sex <- factor(cancer$sex, levels=c("1","2"), labels=c("Male", "Female") )

# An example of R graphics
hist(cancer$age)
boxplot(cancer$time)


#--------------------------------------- #
#  check for missing values              #
#--------------------------------------- #

# check if the value is missing
is.na(cancer$wt.loss)

# how many values are missing in the variable
sum(is.na(cancer$wt.loss))

# which observations have missing values in the variable cigar
which(is.na(cancer$wt.loss))

#if we want to exclude all observations with missing data 
cancer <- na.omit(cancer)


#--------------------------------------- #
#   summaries for continues variables    #
#--------------------------------------- #
summary(cancer)

summary( cancer$time )
mean( cancer$time )    

mean(cancer$inst, na.rm=TRUE)     

median(cancer$inst, na.rm=TRUE) 
quantile(cancer$inst, na.rm=TRUE)    
sd(cancer$inst, na.rm=TRUE)         # standard deviation
fivenum(cancer$inst, na.rm=TRUE)    # Tukey min, lower-hinge, median, upper-hindge, max
max(cancer$inst, na.rm=TRUE) 
min(cancer$inst, na.rm=TRUE) 

unique(cancer$status)


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
( lm.fit <- with(cancer, lm(ph.karno ~ pat.karno) ) )  # same command using with function
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


#---------------------------- #
#  Clean current R session    #
#---------------------------- #

# check variables in the current session
objects()
ls()

rm(list=ls()) # remove everything from your working environment

#get information about R version and the versions of the packages used
sessionInfo()