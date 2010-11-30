#include <AaEnums.h>
#include <AaUtil.h>

int main (int argc, char* argv)
{

  cout << "#include <stdlib.h>" << endl;
  cout << "#include <stdint.h>" << endl;

  cout << endl;
  // write the int types
  for(unsigned int i=1; i <= 64; i++)
    {
      string stdint_type;
      string stduint_type;
      if(i <= 8)
	{
	  stduint_type = "uint8_t";
	  stdint_type = "int8_t";
	}
      else if(i <= 16)
	{
	  stduint_type = "uint16_t";
	  stdint_type = "int16_t";
	}
      else if(i <= 32)
	{
	  stduint_type = "uint32_t";
	  stdint_type = "int32_t";
	}
      else
	{
	  stduint_type = "uint64_t";
	  stdint_type = "int64_t";
	}

      cout << "typedef struct _uint_" << IntToStr(i) << " { " << endl;
      cout << "\t" << stduint_type << " __val : " << IntToStr(i) << ";" << endl;
      cout << "} uint_" << IntToStr(i) << ";" << endl;

 
      cout << endl;

      cout << "typedef struct _int_" << IntToStr(i) << " { " << endl;
      cout << "\t" << stdint_type << " __val : " << IntToStr(i) << ";" << endl;
      cout << "} int_" << IntToStr(i) << ";" << endl;

      cout << endl;
    } 

  cout << "typedef struct _pointer_ { " << endl;
  cout << "\t void* " << " __val ;" << endl;
  cout << "} pointer;" << endl;

  cout << endl;
  // write the float types
  cout << "typedef struct _float_8_23 { float __val; }  float_8_23;" << endl;
  cout << "typedef struct _float_11_52 { double __val; } float_11_52;" << endl;


  // Now write the operations
  cout << endl;
  cout << "#define " << C_Name(__OR)           << "(x,y)  ((x) | (y))"      << endl;
  cout << "#define " << C_Name(__AND)          << "(x,y)  ((x) & (y))"      << endl;
  cout << "#define " << C_Name(__NOR)          << "(x,y)  (~((x) | (y)))"   << endl;
  cout << "#define " << C_Name(__NAND)         << "(x,y)  (~((x) & (y)))"   << endl;
  cout << "#define " << C_Name(__XOR)          << "(x,y)  ((x) ^ (y))"      << endl;
  cout << "#define " << C_Name(__XNOR)         << "(x,y)  (~((x) ^ (y)))"   << endl;
  cout << "#define " << C_Name(__SHL)          << "(x,y)  ((x) << (y))"     << endl;
  cout << "#define " << C_Name(__SHR)          << "(x,y)  ((x) >> (y))"     << endl;
  cout << "#define " << C_Name(__PLUS)         << "(x,y)  ((x) + (y))"      << endl;
  cout << "#define " << C_Name(__MINUS)        << "(x,y)  ((x) - (y))"      << endl;
  cout << "#define " << C_Name(__DIV)          << "(x,y)  ((x) / (y))"      << endl;
  cout << "#define " << C_Name(__MUL)          << "(x,y)  ((x) * (y))"      << endl;
  cout << "#define " << C_Name(__EQUAL)        << "(x,y)  ((x) == (y))"     << endl;
  cout << "#define " << C_Name(__NOTEQUAL)     << "(x,y)  ((x) != (y))"     << endl;
  cout << "#define " << C_Name(__LESS)         << "(x,y)  ((x) < (y))"      << endl;
  cout << "#define " << C_Name(__LESSEQUAL)    << "(x,y)  ((x) <= (y))"     << endl;
  cout << "#define " << C_Name(__GREATER)      << "(x,y)  ((x) > (y))"      << endl;
  cout << "#define " << C_Name(__GREATEREQUAL) << "(x,y)  ((x) >= (y))"     << endl;
  cout << "#define " << C_Name(__NOT)          << "(x)    (~(x))"           << endl;
  
  // added bit-select and concatenate
  cout << "#define " << C_Name(__BITSEL)       << "(x,y)  ((x & (1 << y)) >> y)"      << endl;
  cout << "#define " << C_Name(__CONCAT)       << "(z,x,lx,y,ly)  (((uint ##z)(x << ly))|y)" << endl;

  // some return codes
  cout << "#define AASUCCESS 0" << endl;
  cout << "#define AAFAILURE 1" << endl;
}

