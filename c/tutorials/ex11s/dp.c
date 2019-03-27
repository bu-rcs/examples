#include "dp.h"

REAL dp(int len, REAL *v1, REAL *v2) {
  int i;
  REAL result=0;
  for(i=0;i<len;i++) {
    result += *v1++ * *v2++;
  }
  return(result);
}
