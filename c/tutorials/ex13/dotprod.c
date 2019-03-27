#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "dp.h"
#define OUTFILE "outputfile"

main () {
  REAL result=0.0;
  REAL result_read = 0.0;
  int sz;
  int ret;
  FILE *fp;
  struct rvec v1, v2;
  int i;
  printf("Please input vector size: ");
  scanf("%d", &sz);
  v1.veclen = sz;
  v1.vec = malloc(sz*sizeof(REAL));
  v2.veclen = sz;
  v2.vec = malloc(sz*sizeof(REAL));

  printf("Please input first vector: ");
  for(i=0;i<sz;i++) {
    scanf(SCANFORMAT, v1.vec+i);
  }
  printf("Please input second vector: ");
  for(i=0;i<sz;i++) {
    scanf(SCANFORMAT, v2.vec+i);
  }
  result = dp(&v1, &v2);
  if (ABS(result) < 1.0e-6) {
    printf("Warning: fabsf(result) < 10^-6\n");
  } else {
    fp = fopen(OUTFILE, "w");
    if (!fp) {
      printf("Error opening %s\n", OUTFILE);
      exit(1);
    } 
    ret = fwrite(&result, sizeof(REAL), 1, fp);
    if (ret != 1) {
      printf("Error writing to %s\n", OUTFILE);
      exit(2);
    } 
    fclose(fp);
    printf("Output written to file.\n");
    fp = fopen(OUTFILE, "r");
    if (!fp) {
      printf("Error opening %s\n", OUTFILE);
      exit(1);
    } 
    ret = fread(&result_read, sizeof(REAL), 1, fp);    
    if (ret != 1) {
      printf("Error reading from %s\n", OUTFILE);
      exit(2);
    } 
    fclose(fp);
    printf("Value read from file: %5.2f\n", result_read);
  }
}
