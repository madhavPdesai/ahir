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
  ofile << "-- } " << endl << ");" << endl;
  ofile << "-- }" << endl << "end entity " << this->Get_VHDL_Id() << "_Volatile;" << endl;
}

void vcModule::Print_VHDL_Operator_Architecture(ostream& ofile)
{
	string arch_name = this->Get_VHDL_Id() + "_Operator_arch";

	ofile << "architecture " << arch_name << " of " << this->Get_VHDL_Id() << "_Operator is -- {" << endl;
	// always true signal
	ofile << "-- always true..." << endl;
	ofile << "signal " << this->_control_path->Get_Always_True_Symbol() << ": Boolean;" << endl;
	ofile << "signal sample_ack_symbol, update_ack_symbol: Boolean;" << endl;

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

	// control-path start symbol
	string cp_entry_symbol = this->_control_path->Get_Start_Symbol();
	string cp_exit_symbol  = this->_control_path->Get_Exit_Symbol();

	ofile << "signal " << cp_entry_symbol << ": Boolean;" << endl;
	ofile << "signal " << cp_exit_symbol << ": Boolean;" << endl;

	ofile << "-- }" << endl << "begin --  {" << endl;

	ofile << "------------------------- ack  buffering ----------------------------------" << endl;
	ofile << "sample_ack <= sample_ack_symbol;" << endl;
	ofile << "update_ack <= update_ack_symbol;" << endl;

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

	ofile << " -- sample control interface " << endl;
	vector<string> preds;
	vector<int>    pred_markings;
	vector<int>    pred_capacities;
	vector<int>    pred_delays;
	if(this->_pipeline_flag)
	{
		for(int idx = 0, fidx = inarg_wires.size(); idx < fidx; idx++)
		{
			vcWire* w = inarg_wires[idx];
		
			// if wire is not used, then it is ignored.
			// because it's update is  never enabled..
			if(w->Get_Number_Of_Receivers() == 0) 
				continue;

			preds.push_back(w->Get_VHDL_Id() + "_update_enable");
			pred_capacities.push_back(this->Get_Pipeline_Depth());
			pred_markings.push_back(0);
			pred_delays.push_back(0); // revisit later..
		}

	}

	// sample_ack_symbol is a join of
	//       1. sample_req
	//       2. sample_ack_symbol (reenable)
	//       3. input-sample-reenable symbol 
	preds.push_back("sample_req");
	pred_markings.push_back(0);
	pred_capacities.push_back(1);
	pred_delays.push_back(0);  // revisit later..

	preds.push_back("sample_ack_symbol");
	pred_markings.push_back(1);
	pred_capacities.push_back(1);
	pred_delays.push_back(1);  // revisit later..
		
	preds.push_back("input_sample_reenable_symbol");
	pred_markings.push_back((this->_pipeline_flag ? this->Get_Pipeline_Depth() : 1));
	pred_capacities.push_back((this->_pipeline_flag ? this->Get_Pipeline_Depth() : 1));
	pred_delays.push_back(1);  // revisit later..

	string joined_symbol = "sample_ack_symbol";
	Print_VHDL_Join(joined_symbol + "_join", 
			preds,
			pred_markings,
			pred_capacities, 
			pred_delays, 
			joined_symbol,
			ofile);

	ofile << cp_entry_symbol << "sample_req;" << endl;

	ofile << " -- update control interface " << endl;
	preds.clear();
	pred_markings.clear();
	pred_capacities.clear();
	pred_delays.clear();

	// update-ack symbol is a join of 
	preds.push_back(cp_exit_symbol);
	pred_capacities.push_back(this->_pipeline_flag ? this->Get_Pipeline_Depth() : 1);
	pred_markings.push_back(0);
	pred_delays.push_back(0); 
	
	if(this->_pipeline_flag)
	{
		for(int idx = 0, fidx = outarg_wires.size(); idx < fidx; idx++)
		{
			vcWire* w = outarg_wires[idx];
			ofile << w->Get_VHDL_Id() + "_update_enable <= " << "out_buffer_write_ack_symbol;" << endl;
		}
	}

	/////////////////////////////////////////////  data-path ///////////////////////////////////////////
	assert(this->_data_path != NULL);
	ofile << "-- the data path" << endl;
	this->_data_path->Print_VHDL(ofile);

	ofile << endl;
	ofile << "-- }" << endl << "end " << arch_name << ";" << endl;
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
  ofile << "-- } " << endl << ");" << endl;
  ofile << "-- }" << endl << "end component; " << endl;
}
