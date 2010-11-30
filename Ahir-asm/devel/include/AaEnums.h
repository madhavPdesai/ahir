#ifndef __Aa_Enums__
#define __Aa_Enums__
#include <AaIncludes.h>

enum AaOperation
  {
    __OR,
    __AND,
    __NOR,
    __NAND,
    __XOR,
    __XNOR,
    __SHL,
    __SHR,
    __PLUS,
    __MINUS,
    __DIV,
    __MUL,
    __EQUAL,
    __NOTEQUAL,
    __LESS,
    __LESSEQUAL,
    __GREATER,
    __GREATEREQUAL,
    __NOT,
    __CONCAT,
    __BITSEL
  };


enum AaAhirOperation
  {
    ___OR,
    ___AND,
    ___NOR,
    ___NAND,
    ___XOR,
    ___XNOR,
    ___SHL,
    ___SHR,
    ___PLUS,
    ___MINUS,
    ___DIV,
    ___MUL,
    ___EQUAL,
    ___NOTEQUAL,
    ___LESS,
    ___LESSEQUAL,
    ___GREATER,
    ___GREATEREQUAL,
    ___NOT,
    ___LOAD,
    ___STORE,
    ___PHI,
    ___SELECT,
    ___BRANCH,
    ___CONSTANT,
    ___CONCAT,
    ___BITSEL
  };


enum AaAhirTransitionType
  {
    __IN,
    __OUT
  };

#endif
