#include "dp.h"

REAL dp(struct rvec *v1, struct rvec *v2) {
  int i;
  REAL result=0;
  for(i=0;i<v1->veclen;i++) {
    result += *(v1->vec+i) * *(v2->vec+i);
  }
  return(result);
}
