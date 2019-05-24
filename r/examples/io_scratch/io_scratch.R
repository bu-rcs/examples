
# Get path to the temporary directory on /scratch
tmpdir<- Sys.getenv("TMPDIR")   
# Enviroment variable TMPDIR is created when the job starts,
# In case this program is run interactively on the login node, or if the user would like
# to create a subdirectory in the /scratch with his username, the following command could be used instead :
tmpdir=paste("/scratch/",Sys.getenv("USER"), sep="")
system(paste("mkdir", tmpdir))

#Create some data to write to a file
t <- rnorm(100000,50,10)
p <- rnorm(100000,998,50)
prec <-rbinom(100000,1,0.2)
dt <- data.frame(temperature=t,pressure=p,precipitation=prec)

# --------------------------------------------------------------------------------------#

# Measure the time writing the whole dataset to the NFS (project space) over the network 
# and local scratch directory
system.time(write.csv(dt, file="_data.csv"))
system.time(write.csv(dt, file=paste(tmpdir,"/_data.csv",sep="")))

# --------------------------------------------------------------------------------------#

# In some cases the data has to be written one record at a time
out.dt <- function(infile, line){
  write.table(line, file=infile,append=TRUE, col.names =FALSE, row.names=FALSE, sep=",")
}

# The most inefficient way: write one record at a time appending it to the end of the file
infile <- "_data.csv"
system.time(for(i in 1:10000) out.dt(infile,dt[i,]))

# Writing to the local scratch directory will be faster
# though still inefficient since writing this way involves
# 1. openning the file
# 2. moving to the end of the file
# 3. writing a line
# 4. closing the file
infile <- paste(tmpdir,"/_data.csv",sep="")
system.time(for(i in 1:10000) out.dt(infile,dt[i,]))

# The best way to output the data to the file one record at a time is 
# to open a file (preferably in the local scratch directory)
# and then use the connection to this file to write the records. 
# At the end the connection to the file needs to be closed
infile <- paste(tmpdir,"/_data.csv",sep="")
file.conn <- file(infile, open="w")
system.time(for(i in 1:10000) out.dt(file.conn,dt[i,]))
close(file.conn)

# --------------------------------------------------------------------
#Clean-up
unlink("_data.csv")
unlink(paste(tmpdir,"/_data.csv",sep=""))

