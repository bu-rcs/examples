#include <R.h>
#include <Rdefines.h>
#include <stdio.h>


SEXP cfunction( SEXP a, SEXP b) {

   /* declare the output value */
   SEXP result;
   double *p_result;

   /* declare local variables */
   double aval, bval;

   /* convert input arguments to local variables */
   aval = NUMERIC_VALUE(a);
   bval = NUMERIC_VALUE(b);

   /* allocating storage space for output variable */
   PROTECT(result = NEW_NUMERIC(3));
   p_result = NUMERIC_POINTER(result);

   /* print from C */
   printf("Hello from C function\n");

   /* fill in array */
   p_result[0] = aval;
   p_result[1]= bval;
   p_result[2] = aval + bval;

   /* free memory */
   UNPROTECT(1);

  return( result );
}
