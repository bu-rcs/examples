# A simple R script
foo<-function(x){
  return(list(mean=mean(x, na.rm=TRUE), 
              sd = sd(x,na.rm=TRUE),
              median = median(x, na.rm=TRUE),
              range=range(x, na.rm=TRUE)))
}