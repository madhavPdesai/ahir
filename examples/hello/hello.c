int i1;
short s1, s2, s3;
float f1, f2, f3;

void start (void) 
{
  short t;
  
  if (i1 > 0)
    t = s2 + s1;
  else {
    t = s2 + 5;
    f3 = f2 + f1;
  }

  s3 = t;
}
