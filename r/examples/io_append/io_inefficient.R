#-----------------------------------#
# define a function:
#    1. Compute some results
#    2. Output these results into the file as a single line
#-----------------------------------#
fn <- function(outFile, data1, data2){
  
  #process input data and calculate some result to output
  lm.out<-	lm( data2 ~ data1, na.action="na.omit" )
  lm.out<-	summary( lm.out )$coef
  lm.out<-  as.vector(lm.out)
  
  #convert output to the dataframe so it could be written as a single line using write.table
  i.outline<-  as.data.frame(t(as.matrix(lm.out)), as.is=T, stringsAsFactors=F)
  
  #WARNING: This should be avoided!
  #         output a single line to the file appending it to the end of the existing file
  #         This call will actually perform 4 operations:
  #         1. Open file
  #         2. Move the pointer to the end of the file
  #         3. Write the output line
  #         4. Close the file
  #         This operation is especially inefficient if the file is in project space
  write.table( i.outline, file=outFile, sep= " ", quote=F, row.names=F, col.names=F, append=T )
  
}

#-------------------------#
# main function
#-------------------------#
main <-function(){
  
  
  #Define names for 3 files
  files<-c("file1", "file2", "file3")
  
  #Main loop. Normally read data from some input file
  # For this example we will just simulate some input data
  i<-0
  while(i<1000){
    
    
    #create some randomly distributed data
    data1 <- rnorm(10,0,1.)
    
    #create a loop that will execute function and write results into 3 different files
    for (j in 1:3){
      
      #simulate some data
      data2 <- data1 + rnorm(10,0,0.1)
      
      #execute the function
      fn(files[j], data1, data2)
    }
    
    
    #next iteration
    i <- i+1
  }
  
}

#Start profiling
#Rprof()

#Call main function
system.time(main())

#Stop profiling
#Rprof(NULL)

#Print the results
#summaryRprof()
