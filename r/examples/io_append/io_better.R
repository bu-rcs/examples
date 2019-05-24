#-----------------------------------#
# define a function:
#    1. Compute some results
#    2. Output these results into the file as a single line
#-----------------------------------#
fn <- function(outFile, data1, data2){
  
  #process input data and calculate some result to output
  lm.out<-  lm( data2 ~ data1, na.action="na.omit" )
  lm.out<-	summary( lm.out )$coef
  lm.out<-  as.vector(lm.out)
  
  
  #Write a single line to the opened file 
  #In this case outFile contains the connection associated with the file
  cat(lm.out, file=outFile, fill=256)   
}

#-------------------------#
# main function
#-------------------------#
main <-function(){
  
  
  #Define names for 3 files
  files<-c("file1", "file2", "file3")
  
  #Open files once.
  #In this example we open files in the current directory (project space)
  #Ideally output files with large number of write statements should be opened in /scratch space
  #This would allow for much faster writes, avoiding network traffic.
  file.conns<-list()
  file.conns[[1]] <- file("file1","w")
  file.conns[[2]] <- file("file2","w")
  file.conns[[3]] <- file("file3","w")
  
  # Main loop: normally read data from some input source
  # For this example we will just simulate some input data
  i<-0
  while(i<1000){
    
    #simulate some randomly distributed data
    data1 <- rnorm(10,0,1.)
    
    #create a loop that will execute function fn() and write results into 3 different files 
    for (j in 1:3){
      
      #simulate some data
      data2 <- data1 + rnorm(10,0,0.1)
      
      #execute the function (passing connection to the opened file)
      fn(file.conns[[j]], data1, data2)
    }
    
    
    #next iteration
    i <- i+1
  }
  
  
  #close all files
  close(file.conns[[1]])
  close(file.conns[[2]])
  close(file.conns[[3]])
}

#Start profiling
#Rprof()

#Call main function
system.time(main())

#Stop profiling
#Rprof(NULL)

#Print the profiling results
#summaryRprof()