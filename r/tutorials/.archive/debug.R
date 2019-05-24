my.f <- function(x){
  y <- x-x
  z <- 1/y
  w <- -x
  v <- log(w)
  
  return(c (y,z,w,v))
}

result <- my.f(5)