
float a;
float b;
float c;

float foo(float *x, float *y, float *z)
{
  *x = *y;
  *y = *z;
}

float start (void)
{
  a = 6.789;
  b = 9.432;
  c = 8.0;

  return foo(&a, &b, &c);
}
