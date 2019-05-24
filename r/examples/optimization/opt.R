library(ggplot2)


mv <- as.numeric(-5000:5000)  # vector of means
sds <- rep(0.1, 10001)      # vector of sd
vals<-vector(mode="numeric",length(10001))
for(i in 1:10001){
  vals[i] <- rnorm(1, mv[i],sds[i])
}   

system.time(
{
  mv <- as.numeric(-5000:5000)  # vector of means
  sds <- rep(0.1, 10001)      # vector of sd
  vals<-vector(mode="numeric",length(10001))
  for(i in 1:10001){
    vals[i] <- rnorm(1, mv[i],sds[i])
  }   
  
})



# ----- Vectorize -----------------

slow<-function(){
  mv <- as.numeric(-5000:5000)  # vector of means
  sds <- rep(0.1, 10001)      # vector of sd
  vals<-vector(mode="numeric",length(10001))
  for(i in 1:10001){
    vals[i] <- rnorm(1, mv[i],sds[i])
  }   
}
fast<-function(){
  mv <- as.numeric(-5000:5000)  # vector of means
  sds <- rep(0.1, 10001)      # vector of sd
  vals<-rnorm(10001, mv, sds)
}
system.time( for(i in 1:10)slow() )
system.time( for(i in 1:10)fast() )



# ----- Use microbenchmark package -----
library(microbenchmark)
microbenchmark(slow(), fast() )
res <- microbenchmark(slow(), fast(), times=10 )
print(res)
boxplot(res)



# ----- Order matters! -------

# matrix A * matrix B * vector v
A <- matrix(rnorm(10000), nrow = 100)
B <- matrix(rnorm(10000), nrow = 100)
v <- rnorm(100)
microbenchmark(
  A %*% B %*% v, 
  A %*% (B %*% v) )

# ----- A few other optimizied functions for matricies-----
A <- matrix(rnorm(10000), nrow = 100)
B <- matrix(rnorm(10000), nrow = 100)
v <- rnorm(100)
w <- rnorm(100)

microbenchmark(
  t(A) %*% A, 
  crossprod(A) )


microbenchmark(
  t(A) %*% v, 
  crossprod(A,v) )


microbenchmark(
  v %*% t(w), 
  tcrossprod(v,w) )


# ----- Use colMeans rowMeans colSums rowSums instead of apply() -------

#Define a matrix
matr <- matrix(runif(10000),nrow=100) 

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


# Compare apply(,2,FUN = mean) with colMeans()
matr <- matrix(runif(10000000),nrow=100) 
microbenchmark( 
  apply(matr, 2, mean),
  colMeans(matr),
  times=2 
)

#With the dataframe
data <- as.data.frame( matr )
microbenchmark( 
  apply(data, 2, mean),
  lapply(data,mean ),
  vapply(data,mean, numeric(1) ),
  colMeans(data),
  times=2 
)

library(profvis)
profvis({ 
  apply(data, 2, mean)
  lapply(data,mean )
  vapply(data,mean, numeric(1) )
  colMeans(data)
  })

profvis({ 
  apply(data, 2, sum)
  lapply(data,sum )
  vapply(data,sum, numeric(1) )
  colSums(data)
})



# --------- sort() function --------
x <- runif(10^6)
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


# --------- Use ifelse () instead of if() working with arrays --------

vec <- rep(FALSE, 100000)
x <- rnorm(100000,0,1)
system.time( for(i in 1:length(vec)) if(x[i] < 0)vec[i] <- TRUE)
system.time( vec <-ifelse (x<0, TRUE, FALSE) )


# ----- Calculating max/min value for each row in a matrix -----
# Especially effective when the number of rows is large and number of columns is low ---
x <- matrix(rnorm(1e7,0,1),ncol=1e6,nrow=10)

system.time(apply(x,1,max))
system.time(do.call(pmax,data.frame(x)))

microbenchmark( 
  apply(x,1,max),
  do.call(pmax,data.frame(x)) , 
  times = 3)
  

# ----- ifelse, pmax, pmin and simple assignment -----

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



x <- c()
system.time( for(i in seq(1e5) ) x <- c( x, i ) )  #most inefficient way to calculate an array

#user  system elapsed 
#13.075   0.104  13.167 


x <- numeric(1e5)
system.time( for(i in seq(1e5) ) x[i] <- i )   # much more efficient

#user  system elapsed 
#0.089   0.003   0.092 


system.time( vec <-  1:100000  )   # most efficient way for this example 




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


# -----------------------------------------------------
# ------- Unlist (keep the names only if needed)-------
# -----------------------------------------------------

#Create some list
my.list <- split(sample(1000, size = 100000, rep=TRUE), rep(1:10000, times=10))
microbenchmark(
  v <- unlist(my.list), 
  v <- unlist(my.list, use.names = FALSE) )


# # ----------- Reading Large files -----------------
# #Create some large dataframe
# MakeRandomString <- function(n, len = 10){
#   v <- vector(mode="character", len = n)
#   for (i in 1:n){
#     v[i] <- paste(sample(letters, size = len, replace = TRUE), collapse="")
#   }
#   return(v)
# }
# 
# N <- 1000000
# dt <- data.frame(V1 = MakeRandomString(N, len=25),
#                  V2 = MakeRandomString(N, len=15),
#                  V3 = rnorm(N),
#                  V4 = rnorm(N))
# 
# #Output into the file
# write.csv(dt, file="SampleFile.csv", quote = FALSE, row.names = FALSE)

system.time(dt1<- read.csv("SampleFile.csv"))
library(data.table)
system.time(dt2 <- fread("SampleFile.csv", data.table = FALSE))


# ------- Extracting a value from the dataframe -------
microbenchmark(
  "[50, 3]" = dt1[50,3],
  "$V3[50]" = dt1$V3[50],
  "subset2" = .subset2(dt1,3)[50] )

microbenchmark(
  "[, 3]" = dt1[,3],
  "$V3" = dt1$V3,
  "subset2" = .subset2(dt1,3) )


# ------- R code profiling -------

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

Rprof ()
x.nomiss <- slowFun(x)
Rprof(NULL)
summaryRprof()


Rprof (tmp <- tempfile())
x.nomiss <- slowFun(x)
Rprof(NULL)
summaryRprof(tmp)

library(proftools)
plotProfileCallGraph(
  readProfileData(tmp), score = "total") 


fasterFun = function(x) {
  # initialize res 
  res = NULL
  n = nrow(x)
  res = x # initialize res with the size of x
  k = 0
  for (i in 1:n) {
    if (!any(is.na(x[i,]))) {
      res[k, ] = x[i,]
      k = k + 1
    }
  }
  rowMeans(res[1:k,])
}


Rprof (tmp <- tempfile())
x.nomiss <- fasterFun(x)
Rprof(NULL)
summaryRprof(tmp)

library(proftools)
plotProfileCallGraph(
  readProfileData(tmp), score = "total") 



# TO add:
# x[x>0]  vs x[which(x>0)] for large vectors
