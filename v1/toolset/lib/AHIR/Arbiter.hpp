#ifndef __INTERLINKFUNCTION_HPP__
#define __INTERLINKFUNCTION_HPP__

#include "Symbol.hpp"

#include <string>
#include <map>

namespace ahir {

  class Module;

  struct Client {
    std::string id;
    std::string module;
    unsigned callsite;
    
    Client(const std::string& _id
		, const std::string& _module
		, unsigned _callsite)
       : id(_id), module(_module), callsite(_callsite)
    {};
  };

  typedef std::map<std::string, Client*> ClientList;
  
  struct Arbiter {
    std::string id;

    ClientList clients;
    void register_client(Client *client);
    Client* find_client(const std::string &id);
    
    Arbiter(const std::string& _id)
      : id(_id)
    {};
  };

};

#endif
