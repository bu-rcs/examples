#define FLOAT 0
#define DOUBLE 1
#define REALTYPE DOUBLE

#if REALTYPE == DOUBLE
#define REAL double
#define ABS fabs
#define SCANFORMAT "%lf"
#else
#define REAL float
#define ABS fabsf
#define SCANFORMAT "%f"
#endif

struct rvec {
  int veclen;
  REAL *vec;
};

REAL dp(int len, REAL *vec1, REAL *vec2);