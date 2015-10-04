#ifndef rtl_Enums_h___
#define rtl_Enums_h___

using namespace std;

#include <cstddef>
#include <algorithm>
#include <stdlib.h>
#include <ctype.h>
#include <malloc.h>
#include <unistd.h>
#include <fstream>
#include <iostream>
#include <getopt.h>
#include <string>
#include <set>
#include <list>
#include <vector>
#include <deque>
#include <map>
#include <deque>
#include <iomanip>
#include <sstream>
#include <math.h>
#include <istream>
#include <ostream>
#include <assert.h>
#include <stdint.h>

enum rtlOperation {
	__NOP,
	__NOT,
	__OR,
	__AND,
	__XOR,
	__NOR,
	__NAND,
	__XNOR,
	__SHL,
	__SHR,
	__ROR,
	__ROL,
	__EQUAL,
	__NOTEQUAL,
	__LESS,
	__LESSEQUAL,
	__GREATER,
	__GREATEREQUAL,
	__PLUS,
	__MINUS,
	__MUL,
	__DIV,
	__CONCAT
};

enum rtlPipeSignalAccessType {
	_NOT_ACCESSED, 
	_READ_FROM,
	_WRITTEN_TO,
	_READ_FROM_AND_WRITTEN_TO
};

string rtlOp_To_String(rtlOperation op);
string rtlOp_To_Vhdl_String(rtlOperation op);

#endif
