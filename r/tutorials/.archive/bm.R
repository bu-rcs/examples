# slow version of BM function
bmslow <- function (x, steps){
  
  BM <- matrix(x, nrow=length(x))
  for (i in 1:steps){
    
    # sample from normal distribution
    z <- rnorm(2)
      
    # attach a new column to the output matrix
    BM <- cbind (BM,z)
  }
  return(BM)
}

# a faster version of BM function
bm <- function (x, steps){
  
  # allocate enough space to hold the output matrix
  BM <- matrix(nrow = length(x), ncol=steps+1)
  
  # add initial point to the matrix
  BM[,1] = x
  
  # sample from normal distribution (delX, delY)
  z <- matrix(rnorm(steps*length(x)),nrow=length(x))
  
  for (i in 1:steps) BM[,i+1] <- BM[,i] + z[,i]
  
  return(BM)
}
