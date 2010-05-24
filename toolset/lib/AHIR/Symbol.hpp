#ifndef __SYMBOL_HPP__
#define __SYMBOL_HPP__

/*! \file Symbol.hpp
  Header file that declares types for Symbol and SymbolList.
  */

#include <vector>

//! A Symbol used in AHIR handshakes
typedef unsigned Symbol;
//! A list of Symbols
typedef std::vector<Symbol> SymbolList;

#endif
