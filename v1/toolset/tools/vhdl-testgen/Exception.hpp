#ifndef EXCEPTION_HPP
#define EXCEPTION_HPP

#include <exception>

struct TGE : public std::exception 
{
  std::string msg;
  
  TGE(const std::string &x)
    : exception(), msg(x)
  {} 

  ~TGE() throw() {} 

  const char* what() const throw()
  {
    return msg.c_str();
  }
};


#endif
