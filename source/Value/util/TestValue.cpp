#include <Value.hpp>
using namespace std;
using namespace _base_value_;

int main()
{
  IntValue a(4,"binary","0000");
  IntValue b(4,"binary","1111");

  cout << a.To_String() << " " << b.To_String() << endl;

  a.Add(b);
  cout << a.To_String() << endl;
  a.Subtract(b);
  cout << a.To_String() << endl;
  a.Multiply(b);
  cout << a.To_String() << endl;
  a.Divide(b);
  cout << a.To_String() << endl;
  a.Concatenate(b);
  cout << a.To_String() << endl;
  a.Concatenate(b);
  cout << a.To_String() << endl;
  a.Concatenate(b);
  cout << a.To_String() << endl;
  a.Concatenate(b);
  cout << a.To_String() << endl;



  
  FloatValue c(8,23,"2.5");
  FloatValue d(8,23,"5.0");
  c.Add(d);
  cout << c.To_String() << endl;
  c.Subtract(d);
  cout << c.To_String() << endl;
  c.Multiply(d);
  cout << c.To_String() << endl;
  c.Divide(d);
  cout << c.To_String() << endl;

  return(1);
}
