#ifndef _Aa_Util__
#define _Aa_Util__
#include <AaIncludes.h>


// Tab string
string Tab_(unsigned int n);

// IntToStr
string IntToStr(unsigned int x);

// string compare
struct StringCompare:public binary_function
  <string, string, bool >
{
  bool operator() (string, string) const;
};


bool Is_Compare_Operation(string op);

bool Is_Shift_Operation(string op);

#endif
