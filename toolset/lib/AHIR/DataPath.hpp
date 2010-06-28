#ifndef __DATAPATH_HPP__
#define __DATAPATH_HPP__

#include "Symbol.hpp"
#include "typedefs.hpp"
#include <Base/NodeType.hpp>
#include <Base/Utils.hpp>

#include <set>

namespace hls {

  class Addressable;
  class Type;

}

namespace ahir {

  class Module;
  class DataPath;
  class Wire;
  class DPElement;
  class Wrapper;

  typedef std::map<unsigned, Wire*> WireList;
  typedef std::map<unsigned, Wrapper*> WrapperList;
  typedef std::set<unsigned> MemberList;
  
  struct Port
  {
    std::string id;
    const hls::Type *type;

    hls::IOType io_type;

    Wire *wire;
    void connect_wire(Wire *w);

    DPElement *parent;
    
    Port(const std::string& _id
	 , hls::IOType _dir
         , const hls::Type *_type)
      : id(_id), type(_type), io_type(_dir), wire(NULL), parent(NULL)
    {}
  };

  inline bool is_output(Port *port) { return port->io_type == hls::OUT; }
  inline bool is_input(Port *port) { return port->io_type == hls::IN; }  

  struct Wire
  {
    unsigned id;

    Port *driver;
    std::set<Port*> users;
    void add_user(Port *u);
    
    Wire(unsigned _id)
      : id(_id), driver(NULL)
    {}
  };

  struct DPElement {
    unsigned id;
    hls::NodeType ntype;
    std::string description;
    DataPath *parent;

    PortList ports;
    void register_port(Port *port);
    Port* find_port(const std::string &id);
    
    typedef std::map<std::string, Symbol> SymbolMap;
    SymbolMap reqs, acks;
    void register_req(const std::string &id, Symbol sym);
    void register_ack(const std::string &id, Symbol sym);

    // big fat fingers in the eye of OOP
    std::string callee;
    std::string value;		   // used by Constant
    hls::Addressable *addressable; // used by Address
    DPElement *counterpart;	   // LC <-> LR mapping
    std::string portname;

    DPElement(unsigned _id, hls::NodeType t, const std::string &_d)
      : id(_id), ntype(t), description(_d), parent(NULL)
    {
      addressable = NULL;
      counterpart = NULL;
    };
  };

  struct Wrapper 
  {
    unsigned id;
    std::string description;
    MemberList members;

    void register_member(unsigned m);
    
    Wrapper(unsigned _id, const std::string &d)
      : id(_id), description(d)
    {}
  };

  struct DataPath
  {
    std::string id;
    Module *parent;

    // The list "elements" always contains a list of all the elements
    // in the datapath. The other lists are purely for convenience.
    DPEList elements;
    DPEList lrs, lcs;
    DPEList stores;
    DPEList calls;
    DPElement *retval;
    DPElement *acceptor;

    typedef std::map<std::string, std::vector<DPElement*> > IOPortList;
    IOPortList io_ports;
    
    void register_dpe(DPElement *dpe);
    DPElement* find_dpe(unsigned id);

    WrapperList wrappers;
    void register_wrapper(Wrapper *w);

    WireList wires;
    void register_wire(Wire *wire);
    Wire* find_wire(unsigned id);

    typedef std::map<Symbol, DPElement*> SymbolMap;
    SymbolMap reqs, acks;
    void register_req(DPElement *dpe, const std::string &name, Symbol req);
    void register_ack(DPElement *dpe, const std::string &name, Symbol ack);
    DPElement* req_to_dpe(Symbol req);
    DPElement* ack_to_dpe(Symbol ack);

    DataPath(const std::string& _id)
      : id(_id), parent(NULL), retval(NULL), acceptor(NULL)
    {}
  };
};

#endif
