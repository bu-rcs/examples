## Example of Parallel computation using snowfall package
library(snowfall)

#
#Specifying parameters insode the code
#sfInit(parallel = TRUE, cpus = 4, type = "SOCK")
#
#Another way - passing parameters from the command line
# R --no-save --no-restore --args --parallel --cpus=4 --type=SOCK
sfInit()

#If random numbers are generated during the parallel loop, we need to set it up:
sfClusterSetupRNG()

#If some packages will be used during the parallel execution, they need to be exported
sfLibrary(BRugs)

#If some global data will be used inside the parallel function
globalVar <- 3.14
sfExport( "globalVar")


#Define a function that will be executed in parallel
wrapper <- function (i, N, num){
  
  cat(" Index: ", i, "\n")
  row <- sample(1:N, num, replace = TRUE)
  mean.value <- mean(row)
  ifelse(mean.value <= globalVar, 1, 0)  #gloablVar is a global variable defined ouside the function
  
}


#Execute the function in parallel
result <- sfLapply(1:1000000, wrapper, 5, 70000)
print(paste("result=",mean(unlist(result, use.names = FALSE))))


#Stop snowfall
sfStop()