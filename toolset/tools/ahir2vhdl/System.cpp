#include "Module.hpp"
#include "EntityBuilder.hpp"
#include "DataPathBuilder.hpp"
#include "EntityPrinter.hpp"
#include "ControlPath.hpp"
#include "DataPath.hpp"
#include "Arbiter.hpp"
#include "LinkLayer.hpp"
#include "Utils.hpp"
#include "SimpleEntity.hpp"

#include <Base/ostream.hpp>
#include <Base/Program.hpp>

#include <fstream>
#include <sstream>

using namespace vhdl;
using namespace hls;

namespace vhdl {

  void generate_system(Program *program);
  
}

namespace {

  struct Memory : public Entity
  {
    std::string component_name() { return id; }
    std::string instance_name() { return id + "_inst"; }

    Memory(const std::string &id, const std::string &d = "")
      : Entity(id, MEMORY, d)
    {}
  };

  struct System : public Entity 
  {
    std::string component_name() { return id; }
    std::string instance_name() { return id + "_inst"; }

    Memory memory;

    typedef std::map<std::string, std::set<DataPath*> > PortUserMap;
    PortUserMap port_users;
    void register_port_user(const std::string &io, DataPath *dp)
    {
      if (port_users.find(io) != port_users.end())
        assert(port_users[io].count(dp) == 0
               && "Expecting only one element per port in the DP.");
      port_users[io].insert(dp);
    }
    
    System(const std::string &id, const std::string &d = "")
      : Entity(id, SYSTEM, d), memory("memory_subsystem", "system memory")
    {} 
  };

  void create_env_port(DataPath *dp, const std::string &port_id, System &system)
  {
    Port *port = dp->find_port(port_id);
    assert(port);

    Port *env_port = create_port(system.ports, "env_" + port_id
                                 , port->io_type, port->type);
    port->mapping.clear();
    port->mapping(SLICE, env_port->id);
  }
  
  void system_create_start_ports(System &system, Program *program)
  {
    vhdl::Module *start = get_vhdl_module(program, program->start->id);
    assert(start);
    DataPath *dp = start->dp;
    assert(dp);

    create_env_port(dp, "call_ack", system);
    create_env_port(dp, "call_req", system);
    create_env_port(dp, "call_data", system);
    create_env_port(dp, "call_tag", system);
    create_env_port(dp, "return_ack", system);
    create_env_port(dp, "return_req", system);
    create_env_port(dp, "return_data", system);
    create_env_port(dp, "return_tag", system);
  }

  void system_create_standard_ports(System &system, Program *program)
  {
    system_create_start_ports(system, program);
    entity_create_clk_ports(&system);
    
    create_port(system.ports, "env_lr_req", IN
                , "std_logic", true /* is_control */);
    create_port(system.ports, "env_lr_ack", OUT
                , "std_logic", true /* is_control */);
    create_port(system.ports, "env_lr_addr", IN
                , "std_logic_vector", Range(DOWNTO, memory::address_width));
    create_port(system.ports, "env_lr_tag", IN
                , "std_logic_vector", Range(DOWNTO, memory::tag_width));

    system.register_statement("sc_req <= (others => '1');");

    system.register_statement("lr_req(0) <= env_lr_req;");
    system.register_statement("env_lr_ack <= lr_ack(0);");
    system.register_statement(str(boost::format("lr_addr(%s downto 0) <= env_lr_addr;")
                                  % (memory::address_width - 1)));
    system.register_statement(str(boost::format("lr_tag(%s downto 0) <= env_lr_tag;")
                                  % (memory::tag_width - 1)));
    system.register_statement("");
    
    create_port(system.ports, "env_lc_req", IN
                , "std_logic", true /* is_control */);
    create_port(system.ports, "env_lc_ack", OUT
                , "std_logic", true /* is_control */);
    create_port(system.ports, "env_lc_data", OUT
                , "std_logic_vector", Range(DOWNTO, memory::data_width));
    create_port(system.ports, "env_lc_tag", OUT
                , "std_logic_vector", Range(DOWNTO, memory::tag_width));
    
    system.register_statement("lc_req(0) <= env_lc_req;");
    system.register_statement("env_lc_ack <= lc_ack(0);");
    system.register_statement(str(boost::format("env_lc_data <= lc_data(%s downto 0);")
                                  % (memory::data_width - 1)));
    system.register_statement(str(boost::format("env_lc_tag <= lc_tag(%s downto 0);")
                                  % (memory::tag_width - 1)));
    system.register_statement("");

    create_port(system.ports, "env_sr_req", IN
                , "std_logic", true /* is_control */);
    create_port(system.ports, "env_sr_ack", OUT
                , "std_logic", true /* is_control */);
    create_port(system.ports, "env_sr_addr", IN
                , "std_logic_vector", Range(DOWNTO, memory::address_width));
    create_port(system.ports, "env_sr_data", IN
                , "std_logic_vector", Range(DOWNTO, memory::data_width));
    create_port(system.ports, "env_sr_tag", IN
                , "std_logic_vector", Range(DOWNTO, memory::tag_width));
    
    system.register_statement("sr_req(0) <= env_sr_req;");
    system.register_statement("env_sr_ack <= sr_ack(0);");
    system.register_statement(str(boost::format("sr_addr(%s downto 0) <= env_sr_addr;")
                                  % (memory::address_width - 1)));
    system.register_statement(str(boost::format("sr_data(%s downto 0) <= env_sr_data;")
                                  % (memory::data_width - 1)));
    system.register_statement(str(boost::format("sr_tag(%s downto 0) <= env_sr_tag;")
                                  % (memory::tag_width - 1)));

    system.register_statement("");
  }

  void memory_create_ports(Memory &memory
                           , unsigned &load_lines
                           , unsigned &store_lines)
  {
    // FIXME: The memory_subsystem uses a non-standard name for the
    // clk port.
    entity_create_port_with_map_name(&memory, "clock", IN
                                     , vhdl::Type("std_logic"), SLICE, "clk");
    entity_create_port_with_map_name(&memory, "reset", IN
                                     , vhdl::Type("std_logic"), SLICE, "reset");

    // FIXME: Notice how we take advantage of case-insensitive VHDL to
    // generate the port name. This should actually be fixed in the
    // VHDL library by removing the direction from the port names.
#define MEM_PORT(name, dir, width)                                      \
    entity_create_port_with_map_name(&memory, name"_"#dir, dir          \
                                     , vhdl::Type("std_logic_vector"    \
                                                  , Range(DOWNTO, (width))) \
                                     , WIRE, name)

    MEM_PORT("lr_req", IN, load_lines);
    MEM_PORT("lr_ack", OUT, load_lines);
    MEM_PORT("lr_addr", IN, load_lines * memory::address_width);
    MEM_PORT("lr_tag", IN, load_lines * memory::tag_width);
    
    MEM_PORT("lc_req", IN, load_lines);
    MEM_PORT("lc_ack", OUT, load_lines);
    MEM_PORT("lc_data", OUT, load_lines * memory::data_width);
    MEM_PORT("lc_tag", OUT, load_lines * memory::tag_width);
    
    MEM_PORT("sr_req", IN, store_lines);
    MEM_PORT("sr_ack", OUT, store_lines);
    MEM_PORT("sr_addr", IN, store_lines * memory::address_width);
    MEM_PORT("sr_data", IN, store_lines * memory::data_width);
    MEM_PORT("sr_tag", IN, store_lines * memory::tag_width);
    
    MEM_PORT("sc_req", IN, store_lines);
#undef MEM_PORT
  }
  
  void memory_register_generics(Memory &memory
                                , unsigned load_lines
                                , unsigned store_lines)
  {
    memory.register_generic(new Generic("num_loads", "natural"
                                        , str(boost::format("%s") % load_lines)));
    memory.register_generic(new Generic("num_stores", "natural"
                                        , str(boost::format("%s") % store_lines)));
    memory.register_generic(new Generic("addr_width", "natural"
                                        , str(boost::format("%s") % memory::address_width)));
    memory.register_generic(new Generic("data_width", "natural"
                                        , str(boost::format("%s") % memory::data_width)));
    memory.register_generic(new Generic("tag_width", "natural"
                                        , str(boost::format("%s") % memory::tag_width)));
    memory.register_generic(new Generic("number_of_banks", "natural"
                                        , str(boost::format("%s") % 1)));
    memory.register_generic(new Generic("mux_degree", "natural"
                                        , str(boost::format("%s") % 2)));
    memory.register_generic(new Generic("demux_degree", "natural"
                                        , str(boost::format("%s") % 2)));
    memory.register_generic(new Generic("base_bank_addr_width"
                                        , "natural", str(boost::format("%s") % 8)));
    memory.register_generic(new Generic("base_bank_data_width", "natural"
                                        , str(boost::format("%s") % 8)));
  }

  // Note that this function updates ``load_lines'' and
  // ``store_lines'' (they are passed by reference)
  void dp_map_memory_ports(DataPath *dp
                           , unsigned &load_lines
                           , unsigned &store_lines)
  {
#define DP_MEM_PORT_MAP(name, width)                                    \
    port_map(dp, (name), SLICE, (name), DOWNTO, (high) * (width) - 1, (low) * (width))
  
    if (dp->load_lines > 0) {
      unsigned low = load_lines;
      unsigned high = load_lines + dp->load_lines;
      
      DP_MEM_PORT_MAP("lr_req", 1);
      DP_MEM_PORT_MAP("lr_ack", 1);
      DP_MEM_PORT_MAP("lr_addr", memory::address_width);
      DP_MEM_PORT_MAP("lr_tag", memory::tag_width);
      
      DP_MEM_PORT_MAP("lc_req", 1);
      DP_MEM_PORT_MAP("lc_ack", 1);
      DP_MEM_PORT_MAP("lc_data", memory::data_width);
      DP_MEM_PORT_MAP("lc_tag", memory::tag_width);
      
      load_lines = high;
    }

    if (dp->store_lines > 0) {
      unsigned low = store_lines;
      unsigned high = store_lines + dp->store_lines;
      
      DP_MEM_PORT_MAP("sr_req", 1);
      DP_MEM_PORT_MAP("sr_ack", 1);
      DP_MEM_PORT_MAP("sr_addr", memory::address_width);
      DP_MEM_PORT_MAP("sr_data", memory::data_width);
      DP_MEM_PORT_MAP("sr_tag", memory::tag_width);
      
      store_lines = high;
    }
#undef DP_MEM_PORT_MAP
  }

  void system_connect_memory(Program *program, System &system)
  {
    unsigned load_lines = 1;
    unsigned store_lines = 1;
    
    for (Program::ModuleList::iterator mi = program->modules.begin()
           , me = program->modules.end(); mi != me; ++mi) {
      vhdl::Module *module = get_vhdl_module(program, (*mi).first);

      dp_map_memory_ports(module->dp, load_lines, store_lines);
    }
  }

  void arbiter_connect_client_port(Arbiter *arbiter, DataPath *dp
                                   , const std::string &dpe_id
                                   , const std::string &prefix, const std::string &suffix
                                   , unsigned count
                                   , hls::ostream &out)
  {
    Port *dp_port = dp->find_port(prefix + "_" + dpe_id + + "_" + suffix);
    assert(dp_port);
    Port *arb_port = arbiter->find_port(prefix + "_" + suffix + "s");
    assert(arb_port);

    if (is_input(arb_port))
      out << indent << arb_port->mapping.name << "(" << count << ") <= "
          << dp_port->mapping.name << ";";
    else
      out << indent << dp_port->mapping.name << " <= "
          << arb_port->mapping.name << "(" << count << ");";
  }

  void arbiter_connect_server_port(Arbiter *arbiter, DataPath *dp
                                   , const std::string &prefix
                                   , const std::string &suffix
                                   , hls::ostream &out)
  {
    Port *dp_port = dp->find_port(prefix + "_" + suffix);
    assert(dp_port);
    Port *arb_port = arbiter->find_port(prefix + "_m" + suffix);
    assert(arb_port);

    if (is_input(arb_port))
      out << indent << arb_port->mapping.name << " <= "
          << dp_port->mapping.name << ";";
    else
      out << indent << dp_port->mapping.name << " <= "
          << arb_port->mapping.name << ";";
  }

  void system_connect_arbiter(Program *program, vhdl::Module *module, hls::ostream& out)
  {
    Arbiter *arbiter = module->arbiter;
    DataPath *server = module->dp;

    std::vector<std::string> data_wires;
    Port *arbiter_call_port = arbiter->find_port("call_data");
    Port *arbiter_return_port = arbiter->find_port("return_data");
    
    for (ahir::ClientList::iterator ci = arbiter->clients.begin()
           , ce = arbiter->clients.end(); ci != ce; ++ci) {
      ahir::Client *client = (*ci).second;

      vhdl::Module *cm = get_vhdl_module(program, client->module);
      DataPath *dp = cm->dp;
      DPElement *dpe = dp->find_dpe_from_ahir_id(client->callsite);

      arbiter_connect_client_port(arbiter, dp, dpe->id, "call", "req", data_wires.size(), out);
      arbiter_connect_client_port(arbiter, dp, dpe->id, "call", "ack", data_wires.size(), out);
      arbiter_connect_client_port(arbiter, dp, dpe->id, "return", "req", data_wires.size(), out);
      arbiter_connect_client_port(arbiter, dp, dpe->id, "return", "ack", data_wires.size(), out);

      Port *return_port = dp->find_port("return_" + dpe->id + "_data");
      assert(return_port);
      out << indent << return_port->mapping.name << " <= extract("
          << arbiter_return_port->mapping.name <<  ", " << data_wires.size() << ");"
          << "\n";
      
      Port *call_port = dp->find_port("call_" + dpe->id + "_data");
      assert(call_port);
      data_wires.push_back(call_port->mapping.name);
    }

    out << indent << "unflatten(" << arbiter_call_port->mapping.name << ",";
    out << indent_in;
    unsigned count = data_wires.size() - 1;
    for (; count > 0; count--)
      out << indent << data_wires[count] << " &";
    out << indent << data_wires[count];
    out << ");" << indent_out;
  }

  SimpleEntity* system_create_io_entity(System &system
                                        , const std::string &pname
                                        , DPElement *dpe)
  {
    SimpleEntity *entity = new SimpleEntity("io_" + pname, str(dpe->ntype) + "Port");
    entity_create_clk_ports(entity);
    system.register_instance(entity);
    
    Port *data = dpe->find_port("odata");
    assert(data);
    entity_create_forwarded_io_port(&system, entity, pname, "data"
                                    , data->io_type, data->type);
    entity_create_forwarded_io_port(&system, entity, pname, "req"
                                    , OUT, vhdl::Type("std_logic"));
    entity_create_forwarded_io_port(&system, entity, pname, "ack"
                                    , IN, vhdl::Type("std_logic"));

    entity_create_port_with_map_name(entity, "data", (data->io_type == IN ? OUT : IN)
                                               , vhdl::Type("StdLogicArray2D"
                                                            , data->type.ranges)
                                               , WIRE, entity->id + "_data_sig");
    entity_create_port_with_map_name(entity, "req", IN
                                     , vhdl::Type("BooleanArray")
                                     , WIRE, entity->id + "_req_bool");
    entity_create_port_with_map_name(entity, "ack", OUT
                                     , vhdl::Type("BooleanArray")
                                     , WIRE, entity->id + "_ack_bool");
    return entity;
  }

  void system_create_io_ports(System &system, Program *program)
  {
    for (Program::ModuleList::iterator mi = program->modules.begin()
           , me = program->modules.end(); mi != me; ++mi) {
      vhdl::Module *module = get_vhdl_module(program, (*mi).first);

      DataPath *dp = module->dp;
      for (DPEList::iterator di = dp->io_elements.begin(), de = dp->io_elements.end();
           di != de; ++di) {
        const std::string pname = (*di).first;
        DPElement *dpe = (*di).second;
        assert(is_io(dpe->ntype));
        
        if (!system.find_instance("io_" + pname))
          system_create_io_entity(system, pname, dpe);
        system.register_port_user(pname, dp);
      }
    }

    for (System::PortUserMap::iterator pi = system.port_users.begin()
           , pe = system.port_users.end(); pi != pe; ++pi) {
      const std::string &pname = (*pi).first;
      std::set<DataPath*> &dpset = (*pi).second;

      Entity *io = system.find_instance("io_" + pname);
      assert(io);

      unsigned count = (*pi).second.size();
      io->find_port("data")->type.ranges.push_front(Range(DOWNTO, count));
      io->find_port("req")->type.ranges.push_front(Range(DOWNTO, count));
      io->find_port("ack")->type.ranges.push_front(Range(DOWNTO, count));
      io->register_generic(new Generic("colouring", "NaturalArray"
                                       , natural_array_all_same(0, count)));

      for (std::set<DataPath*>::iterator di = dpset.begin(), de = dpset.end();
           di != de; ++di) {
        DataPath *dp = *di;

        Port *data = dp->find_port(io->id + "_data");
        data->mapping(WIRE, dp->id + "_" + data->id);
        
        Port *req = dp->find_port(io->id + "_req");
        req->mapping(WIRE, dp->id + "_" + req->id + "_std");
        
        Port *ack = dp->find_port(io->id + "_ack");
        ack->mapping(WIRE, dp->id + "_" + ack->id + "_std");
      }
    }
  }
  
  void system_print_io_connections(System &system, hls::ostream &out) 
  {
    for (System::PortUserMap::iterator pi = system.port_users.begin()
           , pe = system.port_users.end(); pi != pe; ++pi) {
      Entity *io = system.find_instance("io_" + (*pi).first);
      assert(io);
      const std::string &pname = io->id;
      std::set<DataPath*> &dpset = (*pi).second;

      std::vector<std::string> wires;
      
      unsigned count = 0;
      for (std::set<DataPath*>::iterator di = dpset.begin(), de = dpset.end();
           di != de; ++di) {
        DataPath *dp = *di;

        Port *data = dp->find_port(pname + "_data");
        wires.push_back(data->mapping.name);
        
        Port *req = dp->find_port(pname + "_req");
        std::ostringstream req_stt;
        req_stt << pname << "_req_bool(" << count << ") <= to_boolean("
                << req->mapping.name << ");";
        dp->append_to_prelude(req_stt.str());

        Port *ack = dp->find_port(pname + "_ack");
        std::ostringstream ack_stt;
        ack_stt << ack->mapping.name << " <= to_std_logic(" << pname << "_ack_bool("
                << count << "));";
        dp->append_to_prelude(ack_stt.str());

        ++count;
      }

      if (io->component_name() == str(Input) + "Port") {
        unsigned count = 0;
        for (std::vector<std::string>::iterator si = wires.begin(), se = wires.end();
             si != se; ++si) {
          const std::string &name = (*si);
          out << indent << name << " <= extract("
              << pname << "_data_sig, " << count << ");"
              << "\n";
          ++count;
        }
      } else {
        assert(io->component_name() == str(Output) + "Port");
        unsigned count = 0;
        out << indent << "unflatten(" << pname << "_data_sig, "
            << indent_in;
        for (std::vector<std::string>::iterator si = wires.begin(), se = wires.end();
             si != se; ++si) {
          const std::string &name = (*si);
          if (count > 0)
            out << "& ";
          out << indent << name;
          ++count;
        }
        out << ");"
            << "\n" << indent_out;
      }
    }
  }

  void create_system(Program *program, System &system)
  {
    unsigned load_lines = 1;    // line 0 is reserved for the test-bench.
    unsigned store_lines = 1;

    for (Program::ModuleList::iterator mi = program->modules.begin()
           , me = program->modules.end(); mi != me; ++mi) {
      vhdl::Module *module = get_vhdl_module(program, (*mi).first);

      load_lines += module->dp->load_lines;
      store_lines += module->dp->store_lines;
    }

    system_create_standard_ports(system, program);

    system_create_io_ports(system, program);
    
    memory_create_ports(system.memory, load_lines, store_lines);
    system_connect_memory(program, system);
    memory_register_generics(system.memory, load_lines, store_lines);
  }

  void print_components(Program *program, hls::ostream &out) 
  {
    for (Program::ModuleList::iterator mi = program->modules.begin()
           , me = program->modules.end(); mi != me; ++mi) {
      vhdl::Module *module = get_vhdl_module(program, (*mi).first);
      
      entity_declare_mapped_signals(module->cp, out);
      print_object_declaration(module->cp, "component", out);
      
      entity_declare_mapped_signals(module->dp, out);
      print_object_declaration(module->dp, "component", out);
      
      entity_declare_mapped_signals(module->ln, out);
      print_object_declaration(module->ln, "component", out);

      if (module->id != "start")
        entity_declare_mapped_signals(module->arbiter, out);

    }
  }

  void print_component_instances(Program *program, hls::ostream &out)
  {
    for (Program::ModuleList::iterator mi = program->modules.begin()
           , me = program->modules.end(); mi != me; ++mi) {
      vhdl::Module *module = get_vhdl_module(program, (*mi).first);
      print_instance(module->cp, out);
      print_instance(module->dp, out);
      print_instance(module->ln, out);

      if (module->id == program->start->id)
        continue;
      
      system_connect_arbiter(program, module, out);
      print_instance(module->arbiter, out);
    }
  }

  void print_system_config(Program *program, System &system, hls::ostream &out)
  {
    out
      << indent << "configuration " << system.id << "_config of " << system.id << " is"
      << indent << "  for default_arch"
      << "\n";

    for (Program::ModuleList::iterator mi = program->modules.begin()
           , me = program->modules.end(); mi != me; ++mi) {
      vhdl::Module *ahir = get_vhdl_module(program, (*mi).first);
      DataPath *dp = ahir->dp;
      
      out
        << indent << "    for " << dp->instance_name() << " : " << dp->component_name()
        << indent << "      use configuration work." << dp->configuration << ";"
        << indent << "    end for;"
        << "\n";
    }
      
    out
      << indent << "  end for;"
      << indent << "end " << system.id << "_config;"
      << "\n";
  }

  void print_system(Program *program, System &system)
  {
    const std::string filename = program->id + "_system.vhdl";
    
    std::ofstream file(filename.c_str());
    file <<
      "\nlibrary ieee;"
      "\nuse ieee.std_logic_1164.all;"
      "\n"
      "\nlibrary ahir;"
      "\nuse ahir.types.all;"
      "\nuse ahir.subprograms.all;" 
      "\nuse ahir.components.all;"
      "\nuse ahir.memory_subsystem_package.all;"
      "\n";

    hls::ostream out(file);

    print_object_declaration(&system, "entity", out);
    out << "\n"
        << indent << "architecture default_arch of " << system.id << " is"
        << "\n" << indent_in;

    system.declare_wires(out);
    entity_declare_mapped_signals(&system.memory, out);
    entity_declare_registered_wires(&system, out);
    print_components(program, out);
  
    out << "\n" << indent_out
        << indent << "begin"
        << "\n" << indent_in;
    
    system.print_statements(out);
    
    system_print_io_connections(system, out);
    
    print_component_instances(program, out);
    
    entity_print_registered_instances(&system, out);
    
    print_instance(&system.memory, out);
    
    out << "\n" << indent_out
        << indent << "end default_arch;"
        << "\n";

    print_system_config(program, system, out);
  }
  
} // end anonymous namespace

void vhdl::generate_system(Program *program) 
{
  System system(program->id + "_system", "top-level entity");

  create_system(program, system);
  print_system(program, system);
}
