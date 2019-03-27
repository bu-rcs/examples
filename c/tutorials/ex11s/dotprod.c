#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "dp.h"

main () {
  REAL result=0.0;
  int sz;
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
  result = dp(v1.veclen, v1.vec, v2.vec);
  if (ABS(result) < 1.0e-6) {
    printf("Warning: fabsf(result) < 10^-6\n");
  } else {
    printf("result = %f\n", result);
  }
}
