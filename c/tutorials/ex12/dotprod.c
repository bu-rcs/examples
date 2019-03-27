#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "dp.h"
#define INFILE "inputfile"

main () {
  REAL result=0.0;
  int sz;
  struct rvec v1, v2;
  int i;
  int ret;
  FILE *fp;
  fp = fopen(INFILE, "r");
  if (!fp) {
    fprintf(stderr, "Error opening %s\n", INFILE);
    exit(1);
  }
  ret = fscanf(fp,"%d", &sz);
  if (ret != 1) {
    fprintf(stderr, "Error reading %s\n", INFILE);
    exit(2);
  }
  v1.veclen = sz;
  v1.vec = malloc(sz*sizeof(REAL));
  v2.veclen = sz;
  v2.vec = malloc(sz*sizeof(REAL));
  for(i=0;i<sz;i++) {
    ret = fscanf(fp,SCANFORMAT, v1.vec+i);
    if (ret != 1) {
      fprintf(stderr, "Error reading %s\n", INFILE);
      exit(2);
    }
  }
  for(i=0;i<sz;i++) {
    ret = fscanf(fp,SCANFORMAT, v2.vec+i);
    if (ret != 1) {
      fprintf(stderr, "Error reading %s\n", INFILE);
      exit(2);
    }
  }
  fclose(fp);
  result = dp(&v1, &v2);
  if (ABS(result) < 1.0e-6) {
    printf("Warning: fabsf(result) < 10^-6\n");
  } else {
    printf("result = %f\n", result);
  }
}
