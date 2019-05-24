# load libraries 
library(doMC)
library(foreach)
library(parallel)
library(doRNG)

#Check how many cores were requested
nCores <- as.numeric(Sys.getenv("NSLOTS"))
if (is.na(nCores))nCores=1

paste("Running code using",nCores,"cores") 
registerDoMC(nCores)



#set seed for parallel computation
registerDoRNG()
set.seed(12345)

# Execute sampling and analysis in parallel
nSim <- 10
matrix <- foreach(i=1:nSim, .combine=rbind) %dopar% {

  a <- sample (1:100, size=5, replace=FALSE)

  return( a )
  
}

