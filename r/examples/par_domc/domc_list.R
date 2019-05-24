# load libraries 
library(doMC)
library(foreach)
library(parallel)

# detect how many cores are available
# This function will return how many total cores are available
# on the machine. 
( nCores <- detectCores() )



# If you plan to use 8 cores on the cluster
# you MUST add option -pe omp 8
# to your qsub command
# On the SCC the maximum number of cores you can request for an OMP job is 16
argv <-commandArgs(TRUE)
nCores <- as.numeric(argv[1])
paste("Running code using",nCores,"cores") 

# The other way to know how many cores is requested is to search for the value of the enviroment variable NSLOTS.
# This variable is set when the jobs is submitted 
nCores <- as.numeric(Sys.getenv("NSLOTS"))

registerDoMC(nCores)

# simulate some data
D <- rnorm(1000, 165, 5)
M <- D + rnorm(1000, 0, 1)

# calculate linear model
DataModel <- lm(D ~ M)
Beta <- coef( DataModel )[2]

nSim<-10

# Execute sampling and analysis in parallel
#This loop will return you nSim lists, with each of them a list of 2 matrices.
output <- foreach(i=1:nSim) %dopar% {

  matr1<-matrix(rnorm(16,0,1), nrow = 4)
  matr2<-matrix(rnorm(8,0,1), nrow=2)
  list(matr1,matr2)
}

#This also can be done the other way around
trans <- function(x, ...){
  lapply(seq_along(x), function(i) c(x[[i]], lapply(list(...), function(y) y[[i]]) ) )
}
# This loop now will return 2 lists with nSim matrices in each
output <- foreach(i=1:nSim, .combine='trans', .init = list(list(),list())) %dopar% {
  
  matr1<-matrix(rnorm(16,0,1), nrow = 4)
  matr2<-matrix(rnorm(8,0,1), nrow=2)
  list(matr1,matr2)
}
output1 <- output[[1]]
output2 <- output[[2]]

# if we want to append all 4x4 matrices together then we can
output1.append <- do.call(rbind,output1)
output2.append <- do.call(rbind,output2)

# calculate and print p value
pValue <- sum( abs(matrix[,3]) > Beta ) /nrow(matrix)
paste("p-value :",pValue)
