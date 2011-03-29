#include <Value.hpp>
using namespace std;
using namespace _base_value_;

int main()
{
  Unsigned b(4,"_b1111");
  Unsigned a(4,"_b0000");

  cout << "Word-size is " << __WORD_SIZE__ << endl;
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
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " << " width " << a._width <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " << " width " << a._width <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " << " width " << a._width <<  endl;

  Unsigned one_val(68);
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

  Signed sa (a._width);
  sa.Assign(a);

  sa.Shift_Right();
  cout << sa.To_String() << " sa = SHRA(a)" << endl;


  Float c(8,23,"2.5");
  Float d(8,23,"5.0");

  c.Add(d);
  cout << c.To_String() << endl;
  c.Subtract(d);
  cout << c.To_String() << endl;
  c.Multiply(d);
  cout << c.To_String() << endl;
  c.Divide(d);
  cout << c.To_String() << endl;

  Float e(11,52,"247.5");
  c.Assign(e);
  cout << c.To_String() << endl;

  return(1);
}
