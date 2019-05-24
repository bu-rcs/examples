/* A simple Hello World SAS program */

/* Print Hello World */
data _null_;
   put "Hello, World!";
run;

/* Output current version of SAS */
proc product_status;
run;

/* Get license information */
proc setinit noalias;
run;

/* Output total memory size default value */
proc options option=MEMSIZE value;
run;

/* Output total sort size default value */
proc options option=SORTSIZE value;
run;

/* Output number of threads default value */
proc options option=CPUCOUNT value;
run;
