library(Rmpi)
library(snow)

# Initialize SNOW using MPI communication. The first line will get the
# number of MPI processes the scheduler assigned to us. Everything else 
# is standard SNOW

np <- mpi.universe.size()
cluster <- makeMPIcluster(np)

# Print the hostname for each cluster member
sayhello <- function()
{
	info <- Sys.info()[c("nodename", "machine")]
	paste("Hello from", info[1], "with CPU type", info[2])
}

names <- clusterCall(cluster, sayhello)
print(unlist(names))

# Compute row sums in parallel using all processes,
# then a grand sum at the end on the master process
parallelSum <- function(m, n)
{
	set.seed(21)
	A <- matrix(rnorm(m*n), nrow = m, ncol = n)


	print(system.time(row.sums <- parApply(cluster, A, 1, sum)))
	print(paste("Parallel: ",sum(row.sums)))
}

parallelSum(5000, 5000)

stopCluster(cluster)
mpi.exit()
