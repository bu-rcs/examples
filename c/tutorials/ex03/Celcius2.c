#include <stdio.h>

main () {
  float celcius;
  float fahrenheit;
  printf("Please input temperature in celcius: ");
  scanf("%f", &celcius);
  fahrenheit = 9.0/5.0*celcius + 32.0;
  printf("%f celcius = %f fahrenheit\n", celcius, fahrenheit);
}
