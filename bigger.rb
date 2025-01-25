#include <stdio.h>
#include <math.h>
double bigger(double a,double b) {
    double big;
    big=a;
    if a <= b;
    big=b;
    return big;
}

int main(void) {
  double a, b, big;
  printf("a> "); scanf("%lf", &a);
  printf("b> "); scanf("%lf", &b);
  big = bigger(a, b);
  printf("bigger = %g\n", big);
  return 0;
}