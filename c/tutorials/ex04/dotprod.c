#include <stdio.h>

main () {
  float vec1[3], vec2[3], result=0.0;
  int i;
  printf("Please input first vector: ");
  for(i=0;i<3;i++) {
    scanf("%f", &vec1[i]);
  }
  printf("Please input second vector: ");
  for(i=0;i<3;i++) {
    scanf("%f", &vec2[i]);
  }
  for(i=0;i<3;i++) {
    result += vec1[i]*vec2[i];
  }
  printf("result = %f\n", result);
}
