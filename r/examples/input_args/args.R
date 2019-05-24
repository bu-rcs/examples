# Example R script to read arguments from a command line


#Define default values for variables
nSim <- 10
meanVal <- 0
sdVal <- 1.

#Get aruments from the command line
argv <- commandArgs(TRUE)

# Check if the command line is not empty and convert values to numerical values
if (length(argv) > 0){
   nSim <- as.numeric( argv[1] )
   meanVal <- as.numeric( argv[2] ) 
   sdVal <- as.numeric( argv[3] )
}

# Print the values
paste("Number of Simulations:",nSim)
paste("Mean Value:",meanVal)
paste("Standard Deviation:",sdVal)




