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

  
void vcModule::Print_VHDL_Operator_Entity(ostream& ofile)
{
  ofile << "entity " << this->Get_VHDL_Entity_Name() << " is -- {" << endl;
  ofile << "port ( -- {" << endl;
  ofile << "  sample_req: in boolean;" << endl;
  ofile << "  sample_ack: out boolean;" << endl;
  ofile << "  update_req: in boolean;" << endl;
  ofile << "  update_ack: out boolean;" << endl;
  string sc = this->Print_VHDL_Argument_Ports("", ofile);
  ofile << sc << endl;
  ofile << "  clk, reset: in std_logic " << endl;
  ofile << "-- } " << endl << ");" << endl;
  ofile << "-- }" << endl << "end entity " << this->Get_VHDL_Entity_Name() << ";" << endl;
}


void vcModule::Print_VHDL_Operator_Component(ostream& ofile)
{
	ofile << "component " << this->Get_VHDL_Entity_Name() << " is -- {" << endl;
	ofile << "port ( -- {" << endl;
	ofile << "  sample_req: in boolean;" << endl;
	ofile << "  sample_ack: out boolean;" << endl;
	ofile << "  update_req: in boolean;" << endl;
	ofile << "  update_ack: out boolean;" << endl;
	string sc = this->Print_VHDL_Argument_Ports("", ofile);
  	ofile << sc << endl;
  	ofile << "  clk, reset: in std_logic " << endl;
	ofile << "-- } " << endl << ");" << endl;
	ofile << "-- }" << endl << "end component;" << endl;

}

void vcModule::Print_VHDL_Volatile_Entity(ostream& ofile)
{
	ofile << "entity " << this->Get_VHDL_Entity_Name() << " is -- {" << endl;
	ofile << "port ( -- {" << endl;
	string sc = this->Print_VHDL_Argument_Ports("", ofile);
	ofile << "-- } " << endl << ");" << endl;
	ofile << "-- }" << endl << "end entity " << this->Get_VHDL_Entity_Name() << ";" << endl;
}


void vcModule::Print_VHDL_Volatile_Component(ostream& ofile)
{
  ofile << "component " << this->Get_VHDL_Entity_Name() << " is -- {" << endl;
  ofile << "port ( -- {" << endl;
  string sc = this->Print_VHDL_Argument_Ports("", ofile);
  ofile << "-- } " << endl << ");" << endl;
  ofile << "-- }" << endl << "end component; " << endl;
}
