float dp(int leng, float *v1, float *v2) {
  int i;
  float result=0;
  for(i=0;i<leng;i++) {
    result += *v1++ * *v2++;
  }
  return(result);
}
