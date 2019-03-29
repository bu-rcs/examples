#include <mpi.h>
#include <stdio.h>

double do_some_integratin(long long nsize,int myrank,int nprocs)
{

  long long i, start_int, end_int;
  int       iam, np;
  double    mypi, h, x;
  double    sum = 0.;
  
  /* Calculate the interval size */
  h = (double)1.0/(double)(nsize*nprocs);
   
  /* Calculate the interval section */
  start_int = nsize*myrank + 1;
  end_int = start_int + nsize;
  
    /* integrate over the appropriate interval over np threads */
    for(i=start_int;i<=end_int;i++)
    {
      x = h * ((double)i - 0.5);
      sum = sum + (4./(1. + x*x));
    }
  
  mypi = h * sum;
  return mypi;
}     
     
int main( argc, argv )
int argc;
char **argv;
{
  
  int        nprocs, myrank;
  long long totaln=500000000000;
  double     mypi=0, pi=0;
  
  double t1, t2, t3, t4, t5;

  MPI_Init( &argc, &argv );
  MPI_Comm_rank( MPI_COMM_WORLD, &myrank );
  MPI_Comm_size( MPI_COMM_WORLD, &nprocs );

  long long nsize=totaln/nprocs;
  
  MPI_Barrier(MPI_COMM_WORLD);
  if ( myrank == 0 ) printf("\n");
  
  /*  Compute pi = integral(4/(1+x2) on the interval (0,1) */
  mypi = do_some_integratin(nsize,myrank,nprocs);

  /*  Collect all the partial sums */
  MPI_Reduce(&mypi,&pi,1,MPI_DOUBLE,MPI_SUM,0,MPI_COMM_WORLD);

  MPI_Barrier(MPI_COMM_WORLD);
  
  if (myrank == 0) printf ("The value of pi is: %11.8f\n",pi);
  
  MPI_Finalize();
  
  printf("\n --------------- My rank is: %d/%d ---------------",myrank,nprocs);

  return 0;
}
