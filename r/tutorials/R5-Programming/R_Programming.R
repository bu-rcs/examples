## -------------------------------------------- ##
##
##   Programming in R
##   v1.3
##   Sept. 24, 2019 
##
##   Research Computing Services
##   Dennis Milechin
##
##   Need Help? help@scc.bu.edu
##
##   Tutorial Evaluation Form: http://scv.bu.edu/survey/tutorial_evaluation.html
##
## --------------------------------------------- ##


####__________________________________________________####
############# SECTION 1: FOR LOOPS ###############

# Allows you to loop through a list, arrays, or matrix 
# and visit each value


#======== 1.1 LOOP THROUGH VECTOR =======

x <- c(1,2,3,4)

print(x)

for(val in x){
  print(paste("Val is: ", val))
}










#========  1.2 LOOP THROUGH NAMED VECTOR =======


rm(list=ls())  # Removes are variables, so we start with a fresh environment

y <- c("Name"="Dennis", "Age"=20)

for(val in y){
  print(paste("Val is: ", val))
}

names(y)

for(name in names(y)){
  print(paste("Name is: ", name))
}











#========  1.3 Add 1 to each value in vector =======


rm(list=ls())

x <- c(8,10,12,14)



for(index in 1:length(x)){
  x[index] <- x[index] + 1
}

print(x)

# Note this not the best use of the loop
# A better way to accomplish the same thing is by vector addition

rm(list=ls())

x <- c(8,10,12,14)
x <- x + 1

print(x)


















#========  1.4 Loop through column in a dataframe =======

rm(list=ls())

# Let's setup an example.  We are a bank that needs to approve applications for loans.
# We have two fields, `has_job` and `credit_score`.
#         `has_job` --> TRUE/FALSE - Indicates if a person is currently employed
#         `credit_score` --> numeric - The credit score of the applicant.
#

# Create DataFrame
applicants <- data.frame(has_job=c(TRUE, FALSE, FALSE, TRUE, TRUE), credit_score=c(300, 250, 750, 600, 150))

# See what columns are available
colnames(applicants)


# Loop through a column
for(val in applicants$credit_score){
  print(paste("Credit Score is: ", val))
}


# We would like to loop through the datatable by row
applicants

# We can use column name and row index to extract values of interest
applicants$has_job[1]
applicants$credit_score[1]

# Can take advantage of row index for looping by row

# Get number of rows
nrow(applicants)

# Make a list of row indexes
1:nrow(applicants)

# Loop through by row
for(row in 1:nrow(applicants)){
  
  # Extract data for row
  score <- applicants$credit_score[row]
  has_job <- applicants$has_job[row]
  
  # Print values
  print(paste("Row Number: ", row))
  print(paste("Credit Score is: ", score))
  print(paste("Applicant has job? ", has_job))
  cat("\n") # Add return character just to make it look nicer
}



#========  1.5 Get Average Credit Score =======

rm(list=ls())

# Define dataframe
applicants <- data.frame(has_job=c(TRUE, FALSE, FALSE, TRUE, TRUE), credit_score=c(300, 250, 750, 600, 150))

# Define variables for tracking values
credit_score_sum <- 0
has_job_sum <- 0
applicant_count <- nrow(applicants)

# Loop through by row
for(row in 1:applicant_count){
  
  # Extract data for row
  score <- applicants$credit_score[row]
  has_job <- applicants$has_job[row]
  
  # add score to credit_score_sum
  credit_score_sum <- credit_score_sum + score
  
  # add has_job to has_job_sum 
  #  Note - boolean have numerical equivalent values: 
  #                     FALSE = 0 and TRUE = 1
  has_job_sum <- has_job_sum + has_job
}

# Divide the sum by number of applicants to get the mean
credit_score_mean <- credit_score_sum/applicant_count

# Divide has_job_sum by applicant count and multiply by 100 to get percent.
has_job_perc <- has_job_sum/applicant_count*100

# Print results.
cat(
    "Mean credit score is :", credit_score_mean, "\n",
    "% of applicants have a job :", has_job_perc, "%"
  )











# Vectorized Solution 1:

rm(list=ls())


# Define dataframe
applicants <- data.frame(has_job=c(TRUE, FALSE, FALSE, TRUE, TRUE), credit_score=c(300, 250, 750, 600, 150))

# Get the mean of credit_score column
credit_score_mean <- mean(applicants$credit_score)

# Get percent of applicants have job
perc_has_job <- mean(applicants$has_job)*100

# Print results.
cat(
  "Mean credit score is :", credit_score_mean, "\n",
  "% of applicants have job :", perc_has_job, "%"
  )











# Vectorized Solution 2: Using apply function

#   apply(X, MARGIN, FUN, .)
#
#    Arguments:
#      X: an array, including a matrix.
#      MARGIN: a vector giving the subscripts which the function will be applied over. 
#             E.g., for a matrix 1 indicates rows, 2 indicates columns, c(1, 2) indicates 
#             rows and columns. Where X has named dimnames, it can be a character vector 
#             selecting dimension names.
#      FUN: the function to be applied


# Get the mean value by column
apply(applicants, 2, mean)

# Can easily update to get max
apply(applicants, 2, max)



# For information at:
#     https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/apply
#     https://www.r-bloggers.com/r-tutorial-on-the-apply-family-of-functions/














#========  1.6 Nested Loops =======


rm(list=ls())

x <- c(1,2,3,4)
y <- c(5,6)


for(val1 in x){
  
  for(val2 in y){
    
    z <- val1 * val2
    print(paste(val1, " X ", val2, "=", z))
    
  }
  
}

print(z)











#========  1.7 Loops to Explore =======

# Other things to explore that we won't cover in this tutorial

# WHILE LOOPS:  https://www.datamentor.io/r-programming/while-loop/
# REPEAT LOOPS: https://www.datamentor.io/r-programming/repeat-loop/
# BREAK AND NEXT STATEMENTS: https://www.datamentor.io/r-programming/break-next/










####__________________________________________________####
#############  SECTION 2: IF-ELSE ########################




#========  2.1 Relational Operators =======


##  `<`	  Less than
##  `>`	  Greater than
##  `<=`	Less than or equal to
##  `>=`	Greater than or equal to
##  `==`	Equal to
##  `!=`	Not equal to
##
##  Result is a boolean value (TRUE or FALSE)

rm(list=ls())

# Numeric example
x <- 5

x < 5  # Note this is a relational operation not an assignment!
x > 5  
x <= 5
x >= 5
x == 5
x != 5

# String example
y <- 'hello'

y == 'hello'
y != 'hello'







#========  2.2 Basic IF Statement =======


rm(list=ls())

x <- TRUE

if(x == TRUE){
  print("The value of X is TRUE.")
}




# With Relational Operator
y <- 2

y < 5     # Note this is a relational operation not an assignment!

if(y < 5){
  print("y is less than 5")
}




# With Function returning a boolean.
x <- 7

is.character(x)

# Checking data type example
if(is.character(x) != TRUE){
  print("X is not a character type.")
}
















#========  2.3 Basic IF-ELSE and IF-ELSE-IF Statement  =======



rm(list=ls())
x <- FALSE


# IF-ELSE
if(x == TRUE){
  
  print("The value of X is TRUE!")
  
}else {   
  
  print("The value of X is not TRUE!")
  
}



x <- FALSE

# IF-ELSE-IF

if(x == TRUE){
  
  print("The value of X is TRUE!")
  
}else if(x == FALSE){
  
  print("The value of X is FALSE")
  
}else{
  
  print("X is not a boolean!")
  
}






















#========  2.4 Nested IF-ELSE STATEMENT  =======

rm(list=ls())

x <- TRUE
y <- TRUE

result <- NULL

if(x == TRUE){
  
  if(y == TRUE){
    result <- "The value of x and y is TRUE."
  }
  else{
    result <- "The value of x is TRUE, but the value of y is FALSE."
  }

}else{
  
  result <- "The value of x is not TRUE. The value of y is unknown."
  
}


print(result)














#========  2.5 PRACTICE: Nested IF-ELSE Statement  =======


# Let's practice. We have two data inputs for an applicant applying for a car loan:
#   `has_job` --> boolean if person has a job or not
#   `credit_score` --> The credit score of the applicant.
#

rm(list=ls())

# Applicants data
has_job <- TRUE
score <- 700

# Variables we need to populate
approved <- NULL


# TODO: Create if-else statement that will set the variable `approved` to TRUE if `has_job` == TRUE
#       and `credit_score` >= 600. 






















## ## START: SOLUTION for 2.5 ## ##

approved <- NULL

# Lets check if this person has a job
if(has_job == TRUE){
  
  # If this person has a job lets check their credit score
  
  if( score >= 600 ){
      # Approve if this person has a job and credit score higher than 600
      approved <- TRUE
  }
  else {
    # Deny if the person has a score below 600.
    approved <- FALSE
  }
  
}else {
  # Deny if the person does not have a job.
  approved <- FALSE

}

print(paste("Application approved? ", approved))


## ## END: SOLUTION for 2.5 ## ##






















#========  2.6 IF-ELSE Statement and For Loop  =======


rm(list=ls())

# Notice how the IF statement cannot take a vector or list of values.

x <- c(1,2,3,4,5,6,7,8,9,10)

if(x > 5){
  print("Value is greater than 5.")
}





# For loops can help

for(val in x){
  
  if(val > 5){
    print(paste(val, "is greater than 5."))
  }
} 




# Vectorized approach

result <- x[x > 5]















#========  2.7 IF-Else with DataFrame  =======


# Let's practice.  Below is a dataframe defined with multiple entries for applicants.  
# We want to determine if they are approved or not. For this excercise, we will create
# a for loop (See Section 1.4) to go through the dataframe row by row, and apply the
# if-else statements from Section 2.5

rm(list=ls())

# Dataframe is created and saved to applicants
applicants <- data.frame(has_job=c(TRUE, FALSE, FALSE, TRUE, TRUE), credit_score=c(300, 250, 750, 600, 150))


# Added two new columns `approved` (similiar setup as Section 2.5)
applicants$approved <- NA

# Checking what the new table looks like
head(applicants)

# TODO: 1.) Create for loop for the data frame
#       2.) Apply if-else statements from section 2.5 and update the `approved` columns


for(row in 1:nrow(applicants)){
  
  score <- applicants$credit_score[row]
  has_job <- applicants$has_job[row]
  
  
  
  ###   --> 
  #   YOUR CODE
  
  
  
  
  
  ##   <--
  
  applicants$approved[row] <- approved
  
}

























## ## START: SOLUTION: 2.7 ## ##

for(row in 1:nrow(applicants)){
  
  score <- applicants$credit_score[row]
  has_job <- applicants$has_job[row]
  
  # Lets check if this person has a job
  if(has_job == TRUE){
    
    # If this person has a job lets check their credit score
    if( score >= 600 ){
      # Approve if this person has a job and credit score higher than 600
      approved <- TRUE
    }
    else {
      # Deny if the person has a score below 600.
      approved <- FALSE
    }
    
  }else {
    # Deny if the person does not have a job.
    approved <- FALSE
  }
  
  
  applicants$approved[row] <- approved
  
  
}

head(applicants)

## ## END: SOLUTION: 2.7 ## ##






## ## START: VECTORIZED SOLUTION: 2.8 ## ##


rm(list=ls())

applicants <- data.frame(has_job=c(TRUE, FALSE, FALSE, TRUE, TRUE), credit_score=c(300, 250, 750, 600, 150))


applicants$approved <- ifelse(applicants$has_job == TRUE & applicants$credit_score >= 600, TRUE, FALSE)


head(applicants)


## ## END: ALTERNATIVE SOLUTION: 2.8 ## ##



# R Logical Operators

#   `!`	  Logical NOT
#   `&`	  Element-wise logical AND
#   `&&`  Logical AND (only tests the first element)
#   `|`	  Element-wise logical OR
#   `||`	Logical OR (only tests the first element)

# Learn more at: https://www.datamentor.io/r-programming/operator/#logical_operators













#========  2.8 Mean Credit Score group by "Has Job"  =======

rm(list=ls())


applicants <- data.frame(has_job=c(TRUE, FALSE, FALSE, TRUE, TRUE), credit_score=c(300, 250, 750, 600, 150))

credit_score_sum <- 0
has_job_sum <- 0
applicant_count <- nrow(applicants)

credit_sum_has_job <- 0
credit_sum_no_job <- 0

has_job_count <- 0
has_no_job_count <- 0


# Loop through by row
for(row in 1:applicant_count){
  
  # Extract data from dataframe
  score <- applicants$credit_score[row]
  has_job <- applicants$has_job[row]
  
  # Check if has_job is TRUE
  if(has_job == TRUE){
    
      # Accumulate the count and sum
      has_job_count <- has_job_count + 1
      credit_sum_has_job <-  credit_sum_has_job + score
    
  } else {
    
      # Accumulate the count and sum
      has_no_job_count <- has_no_job_count + 1
      credit_sum_no_job <- credit_sum_no_job + score
    
  }
  

}


# Make sure the count of has_job_count is greater than 0
# because for mean, we cannot divide by 0.
if(has_job_count > 0){
  
  # Calculate the mean credit score for applicants with jobs
  mean_credit_has_job <- credit_sum_has_job/has_job_count
  
} else{
  
  # If 0, then set the mean to NULL.
  mean_credit_has_job <- "Cannot compute, has_job_count is 0."
  
}

# Make sure the count of has_no_job_count is greater than 0
# because for mean, we cannot divide by 0.
if(has_no_job_count > 0){
  
  # Calculate the mean credit score for applicants with jobs
  mean_credit_has_no_job <- credit_sum_no_job/has_no_job_count
  
} else {
  
  mean_credit_has_no_job <- "Cannot compute, has_no_job_count is 0."
  
}

# Print results.

cat("Mean credit score for:\n", 
        
        "\t", "Has_Job is FALSE: ", mean_credit_has_no_job, "\n",
        "\t", "Has_Job is TRUE: ", mean_credit_has_job
    )












# Using tapply:

# tapply(<vector>, <factor list>, <function>)

tapply(applicants$credit_score, applicants$has_job, mean)
  



# For information at:
#     https://www.rdocumentation.org/packages/base/versions/3.6.1/topics/tapply
#     https://www.r-bloggers.com/r-tutorial-on-the-apply-family-of-functions/










####__________________________________________________####
############# SECTION 3:  FUNCTIONS ######################




#======== 3.1 Basic function syntax with no parameters  =======

rm(list=ls())

my_func <- function(){
  
  print("Hello World!")
  
}

my_func()














#========  3.2 Passing 1 parameter  =======

rm(list=ls())

my_func <- function(name){
  
  print(paste("Hello ", name, "!"))
  
}

my_name <- "Dennis"

my_func(my_name)


# Functions are useful to isolate a small task that is repeated
# throughout the code.
names <- c("Dennis", "Mike", "Jessica", "April")

for(name in names){
  my_func(name)
}














#========  3.3 Passing more than 1 parameter  =======

rm(list=ls())

app_check <- function(job, score){
  
  print(paste("Applicant have a job? ", job))
  print(paste("Credit Score: ", score))
  
}

# Applicants data
has_job <- TRUE
credit_score <- 700

# Order of parameters must match if you don't define names  
app_check(has_job, credit_score)

# Order doesn't matter if you define the names of parameters
app_check(score=credit_score, job=has_job)

















#========  3.4 Define default parameters =======

rm(list=ls())

app_check <- function(job=FALSE, score=0){
  
  print(paste("Applicant have a job? ", job))
  print(paste("Credit Score: ", score))
  
}


app_check()















#========  3.5 Return a value =======

rm(list=ls())

app_check <- function(job=FALSE, score=0){
  
  approved <- FALSE
  
  return(approved)
  
}



# Applicants data
has_job <- TRUE
credit_score <- 700

# Execute function and save it to `result`
result <- app_check(has_job,credit_score)

print(result)












#========  3.6 Practice =======


# Let's add the if-else statements from section 2.5 to the
# app_check function and return only the approved variable.

rm(list=ls())

# TODO: add if-else statements from section 2.5

app_check <- function(job, score){
  
  
  
  

  return(approved)
}

# Applicants data
has_job <- TRUE
credit_score <- 700

# TODO: Call the function and pass `has_job` and `credit_score` variables.
#       Print the returned value.














## ## ## START: SOLUTION 3.6 ## ## ##




app_check <- function(job, score){

  if(job == TRUE){
    
    if( score >= 600 ){
      approved <- TRUE
    }
    else {
      approved <- FALSE
    }
  }else {
    approved <- FALSE
  }

  return(approved)
}

has_job <- TRUE
credit_score <- 700

result <- app_check(has_job, credit_score)

print(paste("Application approved?" , result))


## ## ## END: SOLUTION 3.6 ## ## ##





rm(list=ls())

applicants <- data.frame(has_job=c(TRUE, FALSE, FALSE, TRUE, TRUE), credit_score=c(300, 250, 750, 600, 150))

head(applicants)



















#========  3.7 Using mapply =======

rm(list=ls())

applicants <- data.frame(has_job=c(TRUE, FALSE, FALSE, TRUE, TRUE), credit_score=c(300, 250, 750, 600, 150))

#  mapply
mapply(sum, applicants$has_job, applicants$credit_score)



app_check <- function(job, score){
  
  # Lets check if this person has a job
  if(job == TRUE){
    
    # If this person has a job lets check their credit score
    if( score >= 600 ){
      # Approve if this person has a job and credit score higher than 600
      approved <- TRUE
    }
    else {
      # Deny if the person has a score below 600.
      approved <- FALSE
    }
    
  }else {
    # Deny if the person does not have a job.
    approved <- FALSE
  }
  
  return(approved)
}

applicants$approved <- mapply(app_check, applicants$has_job, applicants$credit_score)

head(applicants)



















#========  3.8 Global versus Local =======

rm(list=ls())

# Knowing which variables are global and local is important. 


check <- function(param1){

  print(paste("IN FUNCTION `param1` = ",param1))
  
  #print(paste("IN FUNCTION `num2` = ", num2))
  
  #print(paste("IN FUNCTION `num3` = ", num3))
  
  #num3 <- 3 + 1
  
  #print(paste("IN FUNCTION `num3` = ", num3))
  
  #param1 <- 4
  
  
  
}


num1 <- 1
num2 <- 2
num3 <- 3

# Execute function
check(num1)

















####__________________________________________________####
######### SECTION 4: SOURCING ##############

# We can save our function in an R Script and then import it into another function.
# This can be helpful when working with a team of developers.



# Copy the function we created into a new R Script File, app_check.R:

app_check_v2 <- function(job, score){
  
  if(job == TRUE){
    
    if( score >= 600 ){
      approved <- TRUE
    }
    else {
      approved <- FALSE
    }
    
  }else {
    approved <- FALSE
  }
  
  return(approved)
}

# save the file as "app_check.R" in your current working directory

# Clear your environment
rm(list=ls())


# source the app_check R file
source("app_check.R")

# Now we should be able to use the function

has_job <- TRUE
credit_score <- 700

result <- app_check_v2(has_job, credit_score)

print(result)





####__________________________________________________####
######### PLEASE FILL OUT EVALUATION FORM ##############
## PLEASE FILL OUT EVALUATION FORM ##
# http://scv.bu.edu/survey/tutorial_evaluation.html


