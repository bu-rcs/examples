library(dplyr)
library(data.table)
library(stringr)
library(microbenchmark)

# The data.table R package provides an enhanced version of data.frame that allows you 
# to do fast and memory efficient data manipulations. 
# It is especially useful when working with large data sets.
# It is compatible  with R functions and packages that accept data.frames only.

# General form: DT[ i, j, by]
#                   ^  ^  ^
#                   |  |  |_____ grouped by what?
#                   |  |____ whta to do
#                   |_____on which rows
#
# Take DT, subset rows using <i>, then calculate <j> grouped by <by>

# Note: In recent versions of data.table some of the functions has been parallelized. 
# You can control how much threads you want to use with setDTthreads().

# Note: Be careful when benchmarking data.table package. See notes in 
# vignette("datatable-benchmarking", package="data.table") about correct ways of benchmarking this package.


#-------------------------------------------#
#         Create a Data table
#-------------------------------------------#

# --- Define a Data Table from a list of vectors --- #

dt <- data.table ( ID = c(rep(1034,3), rep(5621,2),rep(3468,4)), 
                   admission = as.POSIXct(c("2018-03-14","2018-05-28", "2018-11-03", "2018-04-15","2018-10-11","2018-02-09","2018-03-17", "2018-08-31","2018-10-12")),
                   discharge = as.POSIXct(c("2018-03-16","2018-05-29", "2018-11-06", "2018-04-19","2018-10-18","2018-02-15","2018-03-28", "2018-09-15","2018-10-19")),
                   age = c(rep(38,3), rep(45,2), rep(69,4)), 
                   diastBP = c(80, 75, 78, 60, 65, 90, 100, 105, 90), 
                   systBP = c(120,110, 115, 90, 110, 130, 135, 140, 130),
                   weight = c(180, 182, 180, 130, 135, 210, 205, 212, 207),
                   height = c(5.9, 5.9, 5.9, 5.1, 5.1, 5.4, 5.4, 5.4, 5.4),
                   symptoms=c("cough, headache, rash","cough,sore throat","diarrhea", "chest pain, cough","headache", "chest pain", "shortness of breath, chest pain", "nausea, vomiting, chest pain","cough"))
# print to the sceen
dt
class(dt)  # dt is both data.table and data.frame

# --- Read from a file --- #


# Read data using base R read.csv() function
system.time ({ hhc <- read.csv("HHC_SOCRATA_HHCAHPS_PRVDR.csv") })
str(hhc)
class(hhc)

# Read data.using data.table's fread() function
system.time ({ hhc <- fread("HHC_SOCRATA_HHCAHPS_PRVDR.csv") })
str(hhc)
class(hhc)

# Notes: 
#   fread() does not turn character columns into factors automatically
#   data.table never sets or uses row names
#   data.table column is added after the row index
#   by default data.table does not print the whole dataset to the screen 
#       to print more or less records use print(dt, topn=N) function
#   when the data table does not fit into console window, the column names are also printed at the botton




# --- Convert a data.frame or a list to a data.table --- #
data(iris)
iris.dt <- as.data.table(iris)
iris.dt

# convert data table back to a data frame
hhc_df <- as.data.frame(hhc)


# --- Convert a data.frame or a list to a data.table by reference --- #

class(iris)

setDT(iris)  # make iris to be a data.table
class(iris)

setDF(iris)  # make iris to be back a data.frame
class(iris)



# list data.tables are in current R session?
tables()


#-------------------------------------------#
#         Selecting rows
#-------------------------------------------#

# When selecting rows in data.table, no need for a comma:
dt[5]  # select fifth row

# Selecting the last row
# A special symbol .N can be used within data.table structure. It is equal to the number of rows
dt [.N]

# specifying a condition
dt[ age < 50 ]

# between operator
dt[ systBP %between% c(100,120) ]


# ******* Benchmarking ******* #
set.seed(12345)
dt_e6 <- data.table( V1 = sample(10000, 10e6, T), 
                     V2 = sample(letters, 10e6, T),
                     V3 = sample(c(T,F), 10e6, T))

set.seed(12345)
df_e6 <- data.frame( V1 = sample(10000, 10e6, T), 
                     V2 = sample(letters, 10e6, T),
                     V3 = sample(c(T,F), 10e6, T), 
                     stringsAsFactors=F)

#first time
indices(dt_e6)
# NULL

# measure row filtering in the data.table the first time
system.time(dt_e6[V2=="a"])
#user  system elapsed 
#0.25    0.00    0.25 

# check indices
indices(dt_e6)
# [1] "V2"

# measure row filtering in the data.table for the subsequent runs
system.time(dt_e6[V2=="a"])
#user  system elapsed 
#0.04    0.00    0.03 

system.time(dt_e6[V2=="b"])
#user  system elapsed 
#0.03    0.00    0.03 

# same for the data.frame
system.time(df_e6[df_e6$V2=="a", ])
#user  system elapsed 
#0.17    0.00    0.18
system.time(df_e6[df_e6$V2=="b", ])
#user  system elapsed 
#0.14    0.01    0.15 


# ******************* #
# *** Exericise   *** #
# ******************* #

# Select  7th row in iris.dt
#iris.dt[ --- ]


# Select  5th row through 9th in iris.dt
#iris.dt[ --- ]

# compare the above output with selecting 5th through 9th row in iris data.frame
#iris[5:9, ]

# display the row before the last in data table iris.dt
#iris.dt[ --- ]


# select those rows in data.table iris.dt for which  Species is equal to "versicolor"
#iris.dt[ --- ]









#-------------------------------------------#
#  Aditional Functions for Filtering Rows
#-------------------------------------------#

#--------
# %like% - for character columns
#--------

# Subset all rows where symptoms contain word cough
dt[symptoms %like% "cough"]

# Traditional base R approach
dt[ grepl("cough", symptoms) ]

# Some useful symbols for regular expression search:
# "^Mass" - string starts with "Mass"
# "Mass" - string contains "Mass"
# "Mass$" - string ends with "Mass"


#--------
# %between% - for numeric columns
#--------
dt[diastBP %between% c(60,70) ]

# Traditional base R approach
dt[diastBP >= 60 & diastBP <= 70 ]

#--------
# %chin% - for character vectors 
#--------
iris.dt[Species %chin% c("setosa", "versicolor")]


#-------------------------------------------#
#         Selecting columns
#-------------------------------------------#

#selecting columns by index (same as with a data.frames)
iris.dt[ , 2]
iris.dt[ , c(2, 4) ]
# However, Selecting columns using column number is not a safe approach.
# It leads to bugs
# It is better to use column names.


# selecting columns by name (notice no quotes are needed!)
dt[ ,  ID ]        # output is a vector 
dt[ , "ID" ]       # output is a data.table 
dt[ ,.(ID) ]       # output is a data.table

dt[ ,.(ID, symptoms) ]   # multiple columns

# "-" or "!" can be used to exclude columns
dt[ ,!c("symptoms","age") ]  


# ******************* #
# *** Exericise   *** #
# ******************* #

# select first 3 columns in iris.dt data.table
#iris.dt[ , --- ]

# select column Species in iris.dt and return a vector
#iris.dt[ , --- ]

# select column Species in iris.dt and return a data.table
#iris.dt[ , --- ]










#-------------------------------------------#
#        Computing on columns
#-------------------------------------------#

# If a single value or a vector is computed
dt[ , mean(age) ]
dt[ , range(age) ]

# For multiple summaries or when the output should be a data.table use list notation .()
dt[ , .(ave_age = mean(age), max_age = max(age)) ]

# When one vector in the output is longer than the other, the shorter one is recycled
dt[ , .(NumRecords =.N, range_age = range(age)) ]


# Unlike data.frames the second argument could be a function that can operate on vectors:
dt[, plot(diastBP)]

# We can define a multi-line function operating on columns of a data.table
dt[, {
       map = (systBP + 2*diastBP)/3 
       boxplot(map, horizontal = T)
       NULL    # Return value
 }]





# ******************* #
# *** Exericise  *** #
# ******************* #

# Calculate how many observations in hhc data.table have PT column equal to No
#hhc[ --- ]



#-------------------------------------------#
#    Add/update/remove columns by reference
#-------------------------------------------#

# Warning: These operations do not create a new copy of the data.table
# They modify the current one!

# Create a new column
dt[, map := systBP + 2*diastBP ]
dt

# Update column (convert weight to kilos )
dt[, weight := 0.453592 * weight ]
dt

# Remove column from the data.table
dt[ , map := NULL]   
dt

# Note: There is a difference between " = " and " := " operations.
# The first one executes operation(s) on columns and creates a new data.table, 
# the second one modifies the existing one:
dt[ , .( mean_weight= mean(weight), Total=.N) ]
dt[ , map := systBP + 2*diastBP ]
dt

# To create more than one column at a time:
dt[ , `:=` (X = rnorm(.N), Y = rbinom(.N, 100, 0.5)) ]
dt

# Remove multiple columns
dt[ , c("X","Y") := NULL]   
dt

# ******************* #
# *** Exericise   *** #
# ******************* #

# Convert height to meters  1 foot = 0.3048 meters
#dt[ , --- ]
#dt

# Add a new column BMI into data.table BMI = weight/height^2
#dt[ , --- ]
#dt


# Delete BMI column
#dt[ , --- ]
#dt






#-------------------------------------------#
#    set() operations
#-------------------------------------------#


X <- data.table( a=1:5, b=rnorm(5))

# Assign new column names
X
setnames( X, 1:2, c("A", "B") )
X

# Reorder columns
setcolorder( X, c("B", "A") )
X









#-------------------------------------------#
#    Executing functions on groups
#-------------------------------------------#

# Restore original data.table
dt <- data.table ( ID = c(rep(1034,3), rep(5621,2),rep(3468,4)), 
                   admission = as.POSIXct(c("2018-03-14","2018-05-28", "2018-11-03", "2018-04-15","2018-10-11","2018-02-09","2018-03-17", "2018-08-31","2018-10-12")),
                   discharge = as.POSIXct(c("2018-03-16","2018-05-29", "2018-11-06", "2018-04-19","2018-10-18","2018-02-15","2018-03-28", "2018-09-15","2018-10-19")),
                   age = c(rep(38,3), rep(45,2), rep(69,4)), 
                   diastBP = c(80, 75, 78, 60, 65, 90, 100, 105, 90), 
                   systBP = c(120,110, 115, 90, 110, 130, 135, 140, 130),
                   weight = c(180, 182, 180, 130, 135, 210, 205, 212, 207),
                   height = c(5.9, 5.9, 5.9, 5.1, 5.1, 5.4, 5.4, 5.4, 5.4),
                   symptoms=c("cough, headache, rash","cough,sore throat","diarrhea", "chest pain, cough","headache", "chest pain", "shortness of breath, chest pain", "nausea, vomiting, chest pain","cough"))


# Calculate mean weight and height for each patient (use ID variable)
dt [, .( weight = mean(weight), height = mean(height)), by = ID]


# If the result should be ordered by the grouping variable(s), use keyby:
dt [, .( weight = mean(weight), height = mean(height)), keyby = ID]


# Grouping using multiple columns
dt [, .( .N ), by = .(admission < as.POSIXct("2018-07-01"), age > 50)]

# Same but provide a new name for the grouping column
dt [, .( .N ), by = .(FirstHalfOfYear = admission < as.POSIXct("2018-07-01"), MoreThan50 = age > 50)]

#uniqueN - number of unique values
uniqueN( c( 1,2,4,1,2,1) )

# Number of patients admitted every month
dt[ , uniqueN(ID), by = .(month(admission) )]



# ******************* #
# *** Exericise   *** #
# ******************* #

# Calculate mean value of diastBP and systBP for each patient (ID)
# ( there are missing values there! )
#dt[ , .(---), by = .(---) ] 

# Select only patients who are 50 year old or younger  and calculate mean difference of 
# staying in the hospital for each patient
#dt[ --- ,.(mean_stay = mean(difftime( ---, --- ))), by= --- ]



# Compare summary operation : base R vs. dplyr vs. data.table
microbenchmark(
  aggregate(Grade ~ State, data=hhc_df, FUN=function(x){ c(mean=mean(x,na.rm=TRUE), sum=sum(x,na.rm=TRUE)) }),
  
  hhc_df %>% group_by(State) %>% summarise( mean=mean(Grade,na.rm=TRUE), sum=sum(Grade,na.rm=TRUE) ),
  
  hhc[ , .( mean=mean(Grade,na.rm=TRUE), sum=sum(Grade,na.rm=TRUE) ), by=State]
)


#See more benchmarks 
# relatively old:
# https://github.com/Rdatatable/data.table/wiki/Benchmarks-:-Grouping
# newer:
# https://h2oai.github.io/db-benchmark/


#-------------------------------------------#
#   Merging 2 data.tables
#-------------------------------------------#
# data.table package has its own implementation of the merge() function
# - inner
# - full
# - left
# - right

visits.dt <- data.table (id = c(11425, 11425 , 10873, 14562 ,19112, 19112, 19112, 18567, 14475, 15940, 15940, 15940, 15940),
                         admission=c("20-Feb-17","25-Mar-18","7-Aug-17","17-Dec-17","14-Mar-17","3-Jul-18","23-Jan-18","9-Nov-17","18-Aug-18","5-Feb-18","11-Mar-17","21-Oct-17","3-Nov-18"),
                         discharge=c("22-Feb-17","26-Mar-18","11-Aug-17","19-Dec-17", "19-Mar-17", "8-Jul-18","27-Jan-18","11-Nov-17","19-Aug-18","7-Feb-18","13-Mar-17","24-Oct-17", "4-Nov-18"),
                         temp=c(101.5,98.3,98.6,98.8,98.2,98.4,103.3,102.7,98.8,102.5,103.4,101.2,98.6),
                         DBP=c(55, 60,100,70,56,60,60,80,75,65,70,NA,70),
                         SBP=c(95,90,150,100,80,85,90,120, 110, 115,120,110,110),
                         heartrate=c(110,80,105,70,65,70,80,75,80,77,84,80, 75))
patient.dt <- data.table(ID = c(11425,10873,14567,19112,18567,14475,15940,15786),
                         Gender = c("Male","Female","Male","Female","Female","Male","Male","Female"))
                                    
                                     
# inner join is the default type
merge( x = visits.dt, y = patient.dt, by.x = "id", by.y="ID")

# Full or "outer" join
merge( x = visits.dt, y = patient.dt, by.x = "id", by.y="ID", all = T)

# Left join (keep all observation on the left side of the merge - X)
merge( x = visits.dt, y = patient.dt, by.x = "id", by.y="ID", all.x = TRUE)

# Right join (keep all observation on the right side of the merge - Y)
merge( x = visits.dt, y = patient.dt, by.x = "id", by.y="ID", all.y = TRUE)


# Using data.table syntax for merging 2 datasets

#DT[i, on]
#   |   |
#   |   ------> join key columns
#   ----------> join to which data.table


# This is Right join
visits.dt[patient.dt, on=.(id=ID)]   # all rows in Y will be preserved


#Did you notice the difference in row ordering 
#in the result? This is because joins using 
# the data.table syntax treat the i argument 
# like a subset operation, so it returns rows 
# in the order they appear in the data.table 
# given to the i argument, while the merge() function 
# sorts rows based on the values in the key 
# column.


# For left joins - just swap the datasets names
patient.dt[visits.dt, on=.(ID=id)] 

# For inner join use nomatch argument
visits.dt[patient.dt, on=.(id=ID), nomatch=0]

# It is not possible to do Full Join with dt
# Use merge function for it.

# Anti-join
visits.dt[!patient.dt, on=.(id=ID)]


#---------------------------------------
# Setting and viewing data.table keys
#---------------------------------------

# Useful if you perform multiple joins by the same column
# Setting key sorts the data.table in memory by the key column(s)
# Setting a key makes filter and join operations faster
setkey(visits.dt, id)

# check if a key has been set
haskey(visits.dt)


# return key columns that were set
key(visits.dt)

# tables() function also returns the list of keys
tables()

