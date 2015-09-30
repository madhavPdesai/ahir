#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcValue.hpp>
#include <vcObject.hpp>
#include <vcMemorySpace.hpp>
#include <vcControlPath.hpp>
#include <vcOperator.hpp>
#include <vcDataPath.hpp>
#include <vcModule.hpp>
#include <vcSystem.hpp>


  
void vcModule::Print_VHDL_Operator_Form(ostream& ofile)
{
      vcSystem::Print_VHDL_Inclusions(ofile);
      this->Print_VHDL_Operator_Entity(ofile);
      this->Print_VHDL_Operator_Architecture(ofile);
}

void vcModule::Print_VHDL_Volatile_Form(ostream& ofile)
{
      vcSystem::Print_VHDL_Inclusions(ofile);
      this->Print_VHDL_Volatile_Entity(ofile);
      this->Print_VHDL_Volatile_Architecture(ofile);
}

  
void vcModule::Print_VHDL_Operator_Entity(ostream& ofile)
{
  ofile << "entity " << this->Get_VHDL_Id() << "_Operator is -- {" << endl;
  ofile << "port ( -- {" << endl;
  ofile << "  sample_req: in boolean;" << endl;
  ofile << "  sample_ack: out boolean;" << endl;
  ofile << "  update_req: in boolean;" << endl;
  ofile << "  update_ack: out boolean;" << endl;
  string sc = this->Print_VHDL_Argument_Ports("", ofile);
  if(this->_data_path != NULL)
  {
	// these are checks.  if ports are found, an error will be flagged
  	sc = this->_data_path->Print_VHDL_Memory_Interface_Ports(sc, ofile);
        sc = this->_data_path->Print_VHDL_IO_Interface_Ports(sc, ofile);
        sc = this->_data_path->Print_VHDL_Call_Interface_Ports(sc, ofile);
  }
  ofile << sc << endl;
  ofile << "clk, reset: in std_logic" << endl;
  ofile << "-- } " << endl << ");" << endl;
  ofile << "-- }" << endl << "end entity " << this->Get_VHDL_Id() << "_Volatile;" << endl;
}

void vcModule::Print_VHDL_Operator_Architecture(ostream& ofile)
{
	this->vcModule::Print_VHDL_Architecture(ofile);
}

void vcModule::Print_VHDL_Operator_Component(ostream& ofile)
{
	ofile << "component " << this->Get_VHDL_Id() << "_Operator is -- {" << endl;
	ofile << "port ( -- {" << endl;
	ofile << "  sample_req: in boolean;" << endl;
	ofile << "  sample_ack: out boolean;" << endl;
	ofile << "  update_req: in boolean;" << endl;
	ofile << "  update_ack: out boolean;" << endl;
	string sc = this->Print_VHDL_Argument_Ports("", ofile);
	ofile << "-- } " << endl << ");" << endl;
	ofile << "-- }" << endl << "end component;" << endl;

}

void vcModule::Print_VHDL_Volatile_Entity(ostream& ofile)
{
	ofile << "entity " << this->Get_VHDL_Id() << "_Volatile is -- {" << endl;
	ofile << "port ( -- {" << endl;
	string sc = this->Print_VHDL_Argument_Ports("", ofile);
	ofile << "-- } " << endl << ");" << endl;
	ofile << "-- }" << endl << "end entity " << this->Get_VHDL_Id() << "_Volatile;" << endl;
}

void vcModule::Print_VHDL_Volatile_Architecture(ostream& ofile)
{

	this->vcModule::Print_VHDL_Volatile_Architecture(ofile);
	return;

	// this is absorbed into the vcModule method.
	string arch_name = this->Get_VHDL_Id() + "_Volatile_arch";

	ofile << "architecture " << arch_name << " of " << this->Get_VHDL_Id() << "_Volatile is -- {" << endl;


	// always true signal
	ofile << "-- always true..." << endl;
	ofile << "signal " << this->_control_path->Get_Always_True_Symbol() << ": Boolean;" << endl;

	// input port buffer signals.
	ofile << "-- input port buffer signals" << endl;
	vector<vcWire*> inarg_wires;
	for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
	{
		vcWire* w = _input_arguments[_ordered_input_arguments[idx]];
		int wsize = w->Get_Type()->Size();

		inarg_wires.push_back(w);

		ofile << "signal " << w->Get_VHDL_Signal_Id() << " : " 
			<<  " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0);" << endl;

	}

	// output port buffer signals.
	ofile << "-- output port buffer signals" << endl;
	vector<vcWire*> outarg_wires;
	for(int idx = 0; idx < _ordered_output_arguments.size(); idx++)
	{
		vcWire* w = _output_arguments[_ordered_output_arguments[idx]];
		outarg_wires.push_back(w);

		ofile << "signal " << w->Get_VHDL_Signal_Id() << " : " 
			<<  " std_logic_vector(" << w->Get_Type()->Size()-1 << " downto 0);" << endl;

		// exit of CP will trigger write to the output-buffer..
		// TODO: completion of write to output-buffer must
		//       be used to reenable all output updates in 
		//       pipelined body.
		ofile << "signal " << w->Get_VHDL_Id() << "_update_enable: Boolean;" << endl;

	}

	ofile << "-- }" << endl << "begin --  {" << endl;

	ofile << "-- input buffering --------------------------------------------------------" << endl;
	for(int idx = 0; idx < _ordered_input_arguments.size(); idx++)
	{
		vcWire* w = _input_arguments[_ordered_input_arguments[idx]];
		ofile << w->Get_VHDL_Signal_Id() << " <= " << w->Get_VHDL_Id() << ";" << endl;
	}

	ofile << "-- output buffering  -------------------------------------------------------" << endl;
	{
		for(int idx = 0, fidx = outarg_wires.size(); idx < fidx; idx++)
		{
			vcOutputWire* w = (vcOutputWire*) outarg_wires[idx];
			if(w->Is_Constant())
				ofile << w->Get_VHDL_Signal_Id() << " <= " << w->Get_Value()->To_VHDL_String() << ";" << endl;
			ofile << w->Get_VHDL_Id() <<  " <= " << w->Get_VHDL_Signal_Id() << ";" << endl;
		}

	}
	ofile << endl;

	assert(this->_data_path != NULL);
	ofile << "-- the data path" << endl;
	this->_data_path->Print_VHDL(ofile);

	ofile << endl;
	ofile << "-- }" << endl << "end " << arch_name << ";" << endl;
}

void vcModule::Print_VHDL_Volatile_Component(ostream& ofile)
{
	ofile << "component " << this->Get_VHDL_Id() << "_Volatile is -- {" << endl;
	ofile << "port ( -- {" << endl;
	string sc = this->Print_VHDL_Argument_Ports("", ofile);
	// these are checks.  if ports are found, an error will be flagged
	sc = this->_data_path->Print_VHDL_Memory_Interface_Ports(sc, ofile);
	sc = this->_data_path->Print_VHDL_IO_Interface_Ports(sc, ofile);
	sc = this->_data_path->Print_VHDL_Call_Interface_Ports(sc, ofile);
	ofile << "-- } " << endl << ");" << endl;
	ofile << "-- }" << endl << "end component; " << endl;
}
