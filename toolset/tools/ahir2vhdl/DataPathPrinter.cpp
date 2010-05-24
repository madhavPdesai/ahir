#include "DataPath.hpp"

#include "DataPathPrinter.hpp"
#include "EntityPrinter.hpp"
#include "Assignable.hpp"

#include <Base/Addressable.hpp>
#include <Base/Type.hpp>

#include <boost/format.hpp>
#include <sstream>
#include <fstream>

#include <assert.h>

using namespace vhdl;
using namespace hls;

namespace {
  
  void print_dp_meta_information(DataPath *dp, hls::ostream &out)
  {
    bool add_line = false;

    for (DPEList::iterator ci = dp->calls.begin(), ce = dp->calls.end();
	 ci != ce; ++ci) {
      DPElement *dpe = (*ci).second;
      out << indent << "-- " << dpe->id << ": call " << dpe->callee;
    }
    add_line |= dp->calls.size() > 0;

    if (add_line) {
      out << "\n";
    }
  }

  void declare_mapped_signals(DPEList &list, hls::ostream &out)
  {
    bool insert_line = false;
    for (DPEList::iterator wi = list.begin(), we = list.end();
	 wi != we; ++wi) {
      DPElement *dpe = (*wi).second;
      for (PortList::iterator pi = dpe->ports.begin(), pe = dpe->ports.end();
	   pi != pe; ++pi) {
	Port *port = (*pi).second;
        if (!is_wrapper(dpe))
          if (port->io_type != OUT)
            continue;
        
	if (port->mapping.type != WIRE)
	  continue;
        
	insert_line = true;
	out << indent
	    << "signal " << port->mapping.name << " : " << port->type << ";";
      }
      declare_mapped_signals(dpe->members, out);
    }

    if (insert_line)
      out << "\n";
  }

  void print_dp_signal_declarations(DataPath *dp, hls::ostream &out) 
  {
    out << indent << "-- wrapper wires";
    declare_mapped_signals(dp->wrappers, out);
    out << indent << "-- element wires";
    declare_mapped_signals(dp->elements, out);
    out << indent << "-- other wires";
    dp->declare_wires(out);
  }

  void print_wrapper_contents(DPElement *wrapper, hls::ostream &out)
  {
    assert(wrapper->members.size() > 0);
    out << indent << "--  wrapper: " << wrapper->id;
    for (DPEList::iterator ci = wrapper->members.begin(), ce = wrapper->members.end();
	 ci != ce; ++ci) {
      DPElement *dpe = (*ci).second;
      out << indent << "--    dpe: " << dpe->id;
      dpe->print_prelude(out);
    }
    out << "\n";
  }

  std::string create_slice(const std::string &bulk, const Range &range)
  {
    std::ostringstream str;
    str << bulk << "(" << range << ")";
    return str.str();
  }
  
  void print_multidim_extract(Port *port
			      , DPEList &members
			      , hls::ostream &out) 
  {
    const std::string &bulk_name = port->mapping.name;
    const RangeList &bulk_ranges = port->type.ranges;
    assert(port->mapping.type == WIRE);
    
    unsigned count = members.size() - 1;
    for (DPEList::iterator di = members.begin(), de = members.end();
	 di != de; ++di) {
      DPElement *dpe = (*di).second;
      Port *dpe_port = dpe->find_port(port->id);
      assert(dpe_port);

      const RangeList &slice_ranges = (dpe_port->mapping.type == WIRE
				       ? dpe_port->type.ranges
				       : dpe_port->mapping.ranges);

      // See comments in print_multidim_insert
      assert(bulk_ranges.size() == slice_ranges.size());

      out << indent << dpe_port->mapping.name;

      if (bulk_ranges.size() == 2) {
        std::ostringstream array_element;
        array_element << "extract(" << bulk_name << ", " << count << ")";
        const std::string slice = create_slice(array_element.str(), dpe_port->type.ranges[1]);
        out << " <= to_" << dpe_port->type.name << "(" << slice << ");";
      } else {
	assert(bulk_ranges.size() == 1);
	const Range &r = slice_ranges[0];
	assert(dpe_port->mapping.type == SLICE);
	assert(r.upper == r.lower);
	out << "(" << r.upper << ") <= " << bulk_name << "(" << count << ");";
      }

      count--;
    }
    out << "\n";
  }

  void print_multidim_insert(Port *port
			     , DPEList &members
			     , hls::ostream &out)
  {
    const std::string &bulk_name = port->mapping.name;
    const RangeList &bulk_ranges = port->type.ranges;
    assert(port->mapping.type == WIRE);
    
    if (bulk_ranges.size() == 2) {
      // There are two ranges if and only if the port is an ApIntArray
      // or ApFloatArray. The first range on the wrapper is the same
      // as the number of members. The first range on the member is
      // ignored. The second range on the wrapper must be as wide as
      // the second range on the member.
      
      const Range &largest = bulk_ranges[1];
      assert(largest.rtype != INDEX);
      out << indent << "unflatten(" << bulk_name << ", " << indent_in;

      unsigned count = 0;
      unsigned last = members.size() - 1;
      for (DPEList::iterator di = members.begin(), de = members.end();
           di != de; ++di) {
        DPElement *dpe = (*di).second;
        Port *dpe_port = dpe->find_port(port->id);
        assert(dpe_port);
        
        out << indent << "zero_pad(extract(" << dpe_port->mapping.name << ", 0)"
            << ", " << largest.upper << ", " << largest.lower << ")";
        if (count++ < last)
          out << " &";
      }

      out << ");" << indent_out;
    } else {
      // There is only one range if and only if the port is a
      // BooleanArray. The port on the wrapper only specifies the
      // length of the array, while the port on the member specifies
      // the mapped index into a req/ack Symbol port.
      assert(bulk_ranges.size() == 1);

      unsigned count = members.size() - 1;
      for (DPEList::iterator di = members.begin(), de = members.end();
           di != de; ++di) {
        DPElement *dpe = (*di).second;
        Port *dpe_port = dpe->find_port(port->id);
        assert(dpe_port);
        assert(dpe_port->mapping.type == SLICE);
        const Range &r = dpe_port->mapping.ranges[0];
        assert(r.upper == r.lower);
        out << indent << bulk_name << "(" << count << ") <= "
            << dpe_port->mapping.name << "(" << r.upper << ");";
        count--;
      }
    }
    out << "\n";
  }
  
  void print_wire_slices(DPElement *wrapper, hls::ostream &out)
  {
    assert(wrapper->members.size() > 0);

    for (PortList::iterator pi = wrapper->ports.begin(), pe = wrapper->ports.end();
	 pi != pe; ++pi) {
      Port *port = (*pi).second;

      if (port->mapping.type != WIRE)
	continue;
      
      if (is_input(port))
	print_multidim_insert(port, wrapper->members, out);
      else
	print_multidim_extract(port, wrapper->members, out);
    }
  }

  void print_constant_assignment(DPElement *dpe
				 , DataPath *dp
				 , hls::ostream &out)
  {
    switch (dpe->ntype) {
      default:
	assert(false);
	return;
	break;
      
      case Constant: {
	Port *port = dpe->find_port("z");
	assert(port);
	assert(dpe->value.size() > 0);
	out << indent << "-- constant " << dpe->id;
	out << indent << port->mapping << " <= to_" << port->type.name
            << "(" << dpe->value << ");";
	break;
      }
      
      case Address: {
	hls::Addressable *addr = dpe->addressable;
	assert(addr);
	assert(addr->address > 0);
	Port *port = dpe->find_port("z");
	assert(port);
	out << indent << "-- address " << dpe->id;
	out << indent << port->mapping << " <= to_apintarray(to_apint(to_unsigned("
            << addr->address << ", " << memory::address_width << ")));";
	break;
      }
    }
  }

  void dp_print_instances(DataPath *dp, hls::ostream &out)
  {
    if (dp->instances.size() == 0)
      return;

    for (EntityList::iterator ei = dp->instances.begin(), ee = dp->instances.end();
         ei != ee; ++ei) {
      Entity *instance = (*ei).second;
      print_instance(instance, out);
    }
  }

  void print_dp_architecture(DataPath *dp, hls::ostream &out)
  {
    out << indent << "architecture default_arch of " << dp->id << " is"
	<< "\n";

    out << indent_in;
    print_dp_signal_declarations(dp, out);
    out << indent_out;

    out << indent << "begin"
	<< "\n";

    out << indent_in;

    if (dp->assign.size() > 0) {
      for (AssignMap::iterator wi = dp->assign.begin(), we = dp->assign.end();
           wi != we; ++wi) {
        out << indent << (*wi).first << " <= " << (*wi).second << ";";
      }
      out << "\n";
    }

    dp->print_statements(out);

    dp_print_instances(dp, out);

    for (DPEList::iterator wi = dp->wrappers.begin(), we = dp->wrappers.end();
	 wi != we; ++wi) {
      DPElement *wrapper = (*wi).second;
      print_wrapper_contents(wrapper, out);
      print_wire_slices(wrapper, out);
      print_instance(wrapper, out);
    }

    // For constant elements with no control --- viz. constant,
    // address, argument --- print assignments to the corresponding
    // signals. No component is instantiated in this case.
    for (DPEList::iterator di = dp->elements.begin(), de = dp->elements.end();
	 di != de; ++di) {
      DPElement *dpe = (*di).second;
      if (is_wrapper(dpe))
	continue;
      if (is_constant(dpe->ntype))
	print_constant_assignment(dpe, dp, out);
    }
    out << "\n";

    // This loop is not merged with the previous one simply to
    // segregate the two kinds of elements emitted into the VHDL.
    for (DPEList::iterator di = dp->elements.begin(), de = dp->elements.end();
	 di != de; ++di) {
      DPElement *dpe = (*di).second;
      if (has_no_instance(dpe->ntype))
	continue;
      print_instance(dpe, out);
    }

    out << indent_out;

    out << indent << "end default_arch;\n";
  }

  void print_dpe_config(DPElement *dpe, hls::ostream &out)
  {
    if (dpe->configuration.size() == 0)
      return;
    
    out << indent << "    for " << dpe->instance_name()
        << " : " << dpe->component_name()
        << indent << "      use configuration ahir." << dpe->configuration << ";"
        << indent << "    end for;"
        << "\n";
  }

  void print_dp_config(DataPath *dp, hls::ostream &out)
  {
    out << indent << "configuration " << dp->configuration
        << " of " << dp->component_name() << " is"
        << indent << "  for default_arch"
        << "\n";

    for (DPEList::iterator di = dp->elements.begin(), de = dp->elements.end();
         di != de; ++di){
      DPElement *dpe = (*di).second;
      print_dpe_config(dpe, out);
    }

    for (DPEList::iterator di = dp->wrappers.begin(), de = dp->wrappers.end();
         di != de; ++di){
      DPElement *dpe = (*di).second;
      print_dpe_config(dpe, out);
    }

    out << indent << "  end for;"
        << indent << "end " << dp->configuration << ";"
        << "\n";
  }

} // end anonymous namespace

void vhdl::print_dp(DataPath *dp)
{
  std::ofstream file;
  const std::string& filename = dp->id + ".vhdl";
  
  file.open(filename.c_str());
  file <<
    "\nlibrary ieee;"
    "\nuse ieee.std_logic_1164.all;"
    "\nuse ieee.numeric_std.all;"
    "\n"
    "\nlibrary ahir;"
    "\nuse ahir.types.all;"
    "\nuse ahir.components.all;"
    "\nuse ahir.basecomponents.all;"
    "\nuse ahir.subprograms.all;"
    "\nuse ahir.LoadStorePack.all;"
    "\n";

  hls::ostream out(file);
  
  print_object_declaration(dp, "entity", out);

  print_dp_meta_information(dp, out);

  print_dp_architecture(dp, out);

  print_dp_config(dp, out);
}

