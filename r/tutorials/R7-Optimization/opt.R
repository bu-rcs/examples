library(profvis)
library(microbenchmark)
library(ggplot2)


# There is a built-in function system.time() that allows to measure the time to execute one or more R statements:
system.time ({
  x <- c()
  for (i in  1:10e4) x <- c( x, i )
})


# --------------------------------------------
# ----- "Growing" arrays and matricies -------
# --------------------------------------------


# Pre-allocating memory for the vector or matrix/dataframe that needs to be created within a for-loop
# improves memory usage and significantly improves the speed for large number iterations:

x <- c()
for (i in  1: 7) {
  x <- c( x, i )
  
  print( paste("Iteration", i, " x: ", paste(x, collapse=", ")))
}

#[1] "Iteration 1  x:  1"
#[1] "Iteration 2  x:  1, 2"
#[1] "Iteration 3  x:  1, 2, 3"
#[1] "Iteration 4  x:  1, 2, 3, 4"
#[1] "Iteration 5  x:  1, 2, 3, 4, 5"
#[1] "Iteration 6  x:  1, 2, 3, 4, 5, 6"
#[1] "Iteration 7  x:  1, 2, 3, 4, 5, 6, 7"

x <- numeric(7)
for (i in  1: 7) {
  x[i] <- i
  
  print( paste("Iteration", i, " x: ", paste(x, collapse=", ")))
}

#[1] "Iteration 1  x:  1, 0, 0, 0, 0, 0, 0"
#[1] "Iteration 2  x:  1, 2, 0, 0, 0, 0, 0"
#[1] "Iteration 3  x:  1, 2, 3, 0, 0, 0, 0"
#[1] "Iteration 4  x:  1, 2, 3, 4, 0, 0, 0"
#[1] "Iteration 5  x:  1, 2, 3, 4, 5, 0, 0"
#[1] "Iteration 6  x:  1, 2, 3, 4, 5, 6, 0"
#[1] "Iteration 7  x:  1, 2, 3, 4, 5, 6, 7"



# similar with matricies
matr <-NULL
system.time( for(i in seq(1e4)) matr <-rbind(matr, 1:10) )
#user  system elapsed 
#4.447   0.012   4.454 

matr <- matrix(NA, nrow=1e4, ncol=10)
system.time( for(i in seq(1e4) ) matr[i,] <- 1:10)
#user  system elapsed 
#0.013   0.000   0.013 


# If the size of the final vector or matrix unknown - initialize with some reasonable upperbound value
# and then remove extra records at the end








# --------------------------------------------
# ---------------- Vectorize -----------------
# --------------------------------------------


# In this example we create random numbers one at a time
slow<-function(){
  
  vals<- as.numeric(10e4)
  for(i in 1:10e4) vals[i] <- rnorm(1)
}
  
# Here we generate random numbers using a single function call:  
fast<-function(){
  vals<-rnorm(10e4)
}
system.time( for(i in 1:10) slow() )
system.time( for(i in 1:10) fast() )



# ----- Use microbenchmark package for very short executions-----
microbenchmark(slow(), fast() )
res <- microbenchmark(slow(), fast(), times=10 )
print(res)
boxplot(res)


# *** Calls to functions ***
# Loop: one million calls to rnorm()
# Vectorized: a single call to rnorm()

# *** Result assignment ***
# Loop: One million calls to the assignment method
# Vectorized: a single assignment




# Another example of vectorized approach
x <- rnorm( 10e3, 100,2 )

microbenchmark({
  # Slow method:
  total <- 0
  for(i in seq_along(x)) total <- total + log(x[i])
},
{
  # Faster:
  log_sum <- sum(log(x))
})



# Another example of vectorized approach
vec <- rep(FALSE, 10e4)
x <- rnorm(10e4,0,1)

microbenchmark(
  # Slow method: using if() within a loop 
  "if:" = ( for(i in 1:length(vec)) if(x[i] < 0) vec[i] <- TRUE),

  # Faster method: use ifelse() function
  "ifelse:" = ( vec <-ifelse (x<0, TRUE, FALSE ) )
)




# seq_along(x) function is faster than 1:length(x):
x<- rnorm(1e5)
microbenchmark( 1:length(x), seq_along(x) )
#        expr min  lq mean median  uq  max neval
# 1:length(x) 200 300  414    300 300 7600   100
#seq_along(x) 100 100  170    100 200 3700   100








# --------------------------------------------
# ------------- Order matters! ---------------
# --------------------------------------------


# matrix A * matrix B * vector v
A <- matrix(rnorm(10000), nrow = 100)
B <- matrix(rnorm(10000), nrow = 100)
v <- rnorm(100)
microbenchmark(
  A %*% B %*% v, 
  A %*% (B %*% v) )

# A few other optimized functions for matricies:
# - crossprod()
# - tcrossprod()




# ----------------------------------------------------------------------
# ----- Use colMeans rowMeans colSums rowSums instead of apply() -------
# ----------------------------------------------------------------------

#Define a matrix
matr <- matrix(runif(1e4), nrow=100) 

# Compare apply(,1,FUN = mean) with rowMeans()
microbenchmark( 
  apply(matr, 1, mean),
  rowMeans(matr) )


# Compare apply(,2,FUN = mean) with colMeans()
microbenchmark( 
  apply(matr, 2, mean),
  colMeans(matr) )

# Compare apply(,1,FUN = sum) with rowSums()
microbenchmark( 
  apply(matr, 1, sum),
  matr %*% (rep(1,100) ), 
  rowSums(matr) )


#With the dataframe
data <- as.data.frame( matr )
microbenchmark( 
  apply(data, 2, mean),
  lapply(data,mean ),
  vapply(data,mean, numeric(1) ),
  colMeans(data),
  times=2 
)



# ----------------------------------------------------------------------
# ------------- Data Frames VS. Matrix ---------------------------------
# ----------------------------------------------------------------------

# If you are working with all-numeric data, matrix is a faster R object to use than a data.frame

mat <- matrix(rnorm(10e5),ncol=10)
df <- as.data.frame(mat)
microbenchmark(mat[,1], df[,1])


# When using a data.frame it is slilghtly faster to use a column name
microbenchmark(
  "[50, 3]" = df[50,3],
  "$V3[50]" = df$V3[50]
)



# Which is faster, mat[1, ] or df[1, ]? 
microbenchmark(mat[1,], df[1,])
# Also selecting a row in the dataframe returns a dataframe!









# use data.frame to store the data
d <- function() {
  data.frame(
    col1 = sample(1:10, 30, replace = TRUE)
  )
}

# use matrix to store the data
m <- function() {
  matrix(sample(1:10, 30, replace = TRUE), nrow=30)
}

# compare 2 approaches
microbenchmark(
  df = d(),
  mat = m()
)
# Unit: microseconds
# expr   min    lq    mean median     uq    max neval
#   df 148.7 151.0 181.672 152.55 154.55 2549.0   100
#  mat   7.7   9.1  32.219  10.50  12.40 2132.3   100




# ----------------------------------------------------------------------
# ---------------------------- sort() function -------------------------
# ----------------------------------------------------------------------
x <- runif(10^5)
# if the goal is to find only a few smallest elements than it's more optimal to use partial sort
microbenchmark(
  
  (first10 <- sort(x)[1:10]), 
  (first10 <- sort(x,  partial=1:10) ) 
)



# finding indecies of elements which are equal to minimum or maximum value
x <- rep(1:9, each =10000)
microbenchmark(
  (min.loc1 <- which (x == min(x) ) ),
  (min.loc2 <- which.min (x))
)

#  Unit: microseconds
#     expr   min     lq    mean median      uq    max neval
#(min.loc1 <- which(x == min(x))) 339.8 440.95 662.826 455.65 1073.50 1370.2   100
#(min.loc2 <- which.min(x)) 114.5 121.60 174.138 122.10  150.75  507.9   100





# ----------------------------------------------------------------------
# ---------------------- if():   &  vs. &&  ----------------------------
# ----------------------------------------------------------------------

# The & operator will always evaluate both its argumnet. 
# The && operator will not calculate second if first is FALSE
# Note: && works only on a single logical value while & works on a vector!

# Example data
choice1 <- T
choice2 <- F
choice3 <- T

## microbenchmark both solutions
microbenchmark(if (choice1 & choice2 & choice3)  1  else 0 , 
               if (choice1 && choice2 && choice3)  1  else 0  , times = 1e5)




# ----------------------------------------------------------------------
# ------------------------ pmax,pmin vs. max,min ------------------------
# ----------------------------------------------------------------------



# ----- Calculating max/min value for each row in a matrix -----
# Especially effective when the number of rows is large and number of columns is low ---
x <- matrix(rnorm(1e7,0,1),ncol=1e6,nrow=10)

system.time(apply(x,1,max))
system.time(do.call(pmax,data.frame(x)))

microbenchmark( 
  apply(x,1,max),
  do.call(pmax,data.frame(x)) , 
  times = 3)
  




# ----------------------------------------------------------------------
# --------- Comparing various approaches to solve a problem  -----------
# ----------------------------------------------------------------------


# Problem:
# Make all elements in vector to me no larger than xmax and no smaller than xmin
trim.ifelse <- function(x, xmin, xmax){
  
  ifelse( x<=xmin, xmin, ifelse(x>=xmax, xmax, x))
}

trim.pmaxmin <- function(x, xmin, xmax){
  
  pmax(pmin(x,xmax), xmin)
}

trim.replace <- function(x, xmin, xmax){
  
  x [x < xmin ] <- xmin
  x [x > xmax ] <- xmax
}

#load Rcpp library
library(Rcpp)
#compile C function
sourceCpp('trim.cpp')

x <- runif(100, -5, 5)
microbenchmark(
  trim.ifelse(x, -3, 3),
  trim.pmaxmin(x, -3, 3), 
  trim.replace(x, -3, 3),
  trim_cpp(x, -3, 3) )









# ----------------------------------------------------------------------
# ------------------- for() loop has [condition] -----------------------
# ----------------------------------------------------------------------
df <- data.frame(age = runif(10^3, min=0, max=100),
                 body.temp = runif(10^3, min=35.5, max = 42),
                 bmi = runif(10^3, min=18, max=32)
                 )

#We want to create another column, that for significantly overweight people performs some analysis


#very slow method
method1 <- function(){
  df$res <- rep(NA,nrow(df))
  for (i in 1:nrow(df)){
    
    if (df$bmi[i] > 28){
      
      #here we calculate something (here we just do some random calculations)
      if (df$age[i] > 18)df$res[i] = mean(rnorm(1000,mean=df$age[i])) else median(rnorm(1000,mean=df$age[i]))
      
    }else {
      df$res = -1
    }
    
  }
}

#faster approach - to include the condition in the loop:
method2 <- function(){
  
  #faster method
  df$res <- rep(NA,nrow(df))
  condition <- df$bmi > 28
  for (i in (1:nrow(df)) [condition ]) {
    
    #here we calculate something (here we just do some random calculations)
    if (df$age[i] > 18)df$res[i] = mean(rnorm(1000,mean=df$age[i])) else median(rnorm(1000,mean=df$age[i]))  
    
  }
  
}
#compare methods
microbenchmark(method1(), method2(), rep=10)








# -----------------------------------------------------
# ------- Unlist (keep the names only if needed)-------
# -----------------------------------------------------

#Create some list
my.list <- split(sample(1000, size = 100000, rep=TRUE), rep(1:10000, times=10))
microbenchmark(
  v <- unlist(my.list), 
  v <- unlist(my.list, use.names = FALSE) )







# -----------------------------------------------------
# ---------------- R code profiling -------------------
# -----------------------------------------------------

x <- matrix(rnorm(10000000), nrow=1000)
x[sample(1:10000000, 1000, replace=FALSE)] <- NA
slowFun = function(x) {
  # initialize res 
  res = NULL
  n = nrow(x)
  
  for (i in 1:n) {
    if (!any(is.na(x[i,]))) res = rbind(res, x[i,])
  }
  apply(res,1,mean)
}

# Start profiler
Rprof ()

  # run code
   x.nomiss <- slowFun(x)
   
# end profiler
Rprof(NULL)


# view results
summaryRprof()




# use profvis() from profvis package to visually see the bottleneck
profvis({  
  res = NULL
  n = nrow(x)
  
  for (i in 1:n) {
    if (!any(is.na(x[i,]))) res = rbind(res, x[i,])
  }
  apply(res,1,mean)
})




# -----------------------------------------------------
# ---------------- R code parallelization -------------
# -----------------------------------------------------


library(parallel)
ncores <- detectCores()


# The parallel package is part of R since 2011
# Cross platform: Code works under Windows, Linux, Mac
# Has parallel version of some functions


# on a server all available cores could be used (if requested by the qsub command)
# on a local computer it is safer to leave 1 or more cores free
cl <- makeCluster(ncores -1)
res <- parApply(cl, mat, 1, median)
stopCluster(cl)


#---------------------------------------
# sapply -> parSapply
# lapply -> parLapply
# Note: you need to export functions/data and do not forget to shutdown the cluster

# Export the myFun() function to the cluster
# clusterExport(cl, "myFun")

