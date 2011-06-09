
int x;

int rw()
{
  return x;
}

int start(void)
{
  x = 42;

  return rw();
}
