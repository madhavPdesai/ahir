#include <Value.hpp>
using namespace std;
using namespace _base_value_;

int main()
{
  IntValue a(16,"_b0000000000000000");
  IntValue b(16,"_b1111111111111111");

  cout << a.To_String() << " a" << endl << b.To_String() << " b" << endl;

  a.Add(b);
  cout << a.To_String() << " a = a + b " <<  endl;
  a.Subtract(b);
  cout << a.To_String() <<  " a = a - b " << endl;
  a.Multiply(b);
  cout << a.To_String() << " a = a*b " << endl;
  a.Divide(b);
  cout << a.To_String() << " a = a/b " << endl;
  a.Concatenate(b);
  cout << a.To_String() << " a = Concatenate(a,b) " << endl;
  a.Concatenate(b);
  cout << a.To_String() << " a = Concatenate(a,b) " << endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;

  IntValue one_val(80);
  one_val.Increment();
  a.Add(one_val);
  cout << a.To_String() << " a = a + 1" << endl;
  a.Decrement();
  cout << a.To_String() << " a = a - 1 " << endl;

  a.Rotate_Left();
  cout << a.To_String() << " a = ROL(a) " << endl;

  a.Rotate_Right();
  cout << a.To_String() << " a = ROR(a)" << endl;

  a.Rotate_Right();
  cout << a.To_String() << " a = ROR(a)" << endl;

  a.Shift_Right_Signed();
  cout << a.To_String() << " a = SHRA(a)" << endl;


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

  FloatValue e(11,52,"247.5");
  c.Assign(e);
  cout << c.To_String() << endl;

  return(1);
}
