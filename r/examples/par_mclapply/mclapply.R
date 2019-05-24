# If you plan to use 8 cores on the cluster
# you MUST add option -pe omp 8
# to your qsub command
# On the SCC the maximum number of cores you can request for an OMP job is 16
# Linga users can request up to 64 cores 
# (Note: requesting 64 cores might cause your job to wait much longer in the queue)


# load libraries 
library(parallel)

# use only 1 core if no arguments are given on command line
nCores <- 1
argv <-commandArgs(TRUE)
if (length(argv) > 0) nCores <- as.numeric(argv[1])
paste("Running code using",nCores,"cores") 

nSim<-10000

# simulate some data
D <- rnorm(1000, 165, 5)
M <- D + rnorm(1000, 0, 1)


# define a function to be used on a vector
perm <- function(x){
    perm <- sample(D, replace=FALSE)
    model <- lm(perm ~ M)
    coef(model)
}


# calculate linear model
DataModel <- lm(D ~ M)
Beta <- coef( DataModel )[2]

# Execute sampling and analysis in parallel
output <- mclapply(as.list(1:nSim), perm, mc.cores=nCores)

#convert output to matrix 
matrix <- do.call(rbind, output)

# calculate and print p value
pValue <- sum( abs(matrix[,2]) > Beta ) /nrow(matrix) 
paste("p-value: ",pValue)
 

