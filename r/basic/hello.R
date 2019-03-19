# This is a simple R code

print("Hello, World!")


# Print current R version
print(version$version.string)

A <- rnorm(100,0,1)
summary(A)

# Open an output file for a graphics image
#pdf(file="mypdf.pdf")
png(file="mypdf.png")
hist(A)
dev.off() # close file



