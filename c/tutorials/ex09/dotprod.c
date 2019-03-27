#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "dp.h"

main () {
  float *vec1, *vec2, result=0.0;
  int sz;
  int i;
  printf("Please input vector size: ");
  scanf("%d", &sz);
  vec1 = malloc(sz*sizeof(float));
  vec2 = malloc(sz*sizeof(float));
  printf("Please input first vector: ");
  for(i=0;i<sz;i++) {
    scanf("%f", vec1+i);
  }
  printf("Please input second vector: ");
  for(i=0;i<sz;i++) {
    scanf("%f", vec2+i);
  }
  result = dp(sz, vec1, vec2);
  if (fabsf(result) < 1.0e-6) {
    printf("Warning: fabsf(result) < 10^-6\n");
  } else {
    printf("result = %f\n", result);
  }
}
