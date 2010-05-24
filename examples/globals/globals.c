int a[3] = { 2, 3, 4 };
int b = 10;
int select = 1;

int main (void)
{
  if (select == 0)
    return (a[0] + a[1] + a[2]);
  else
    return (a[0] + a[1] - a[2]);
}
