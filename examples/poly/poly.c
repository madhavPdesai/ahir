
float power(float x, unsigned p)
{
  float y = 1;

  while (p > 0) {
    y *= x;
    p--;
  }

  return y;
}

float divide(float N, float D)
{
  float sign = 1;
  float X;
    
  if (N < 0) {
    N = -N;
    sign = -sign;
  }

  if (D < 0) {
    D = -D;
    sign = -sign;
  }


  if (D > 0) {
    while (D < (float)0.5) {
      D = 2 * D;
      N = 2 * N;
    }

    while (D > 1) {
      D = 0.5 * D;
      N = 0.5 * N;
    }
  }

  X = (float)2.9142 - 2*D;

  X = X*(2 - D*X);
  X = X*(2 - D*X);
  X = X*(2 - D*X);
  X = X*(2 - D*X);

  return sign * X * N;
}

float start(float x)
{
  float n, d;

  n = (float)3.14159 * power(x, 3);
  n = n - (float)10.0 * x;

  d = (float)5.42 * power(x, 4);
  d = d + (float)107.234;

  return divide(n, d);
}

