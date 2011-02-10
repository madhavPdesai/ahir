#ifndef _Aa_Module__
#define _Aa_Module__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>
#include <AaObject.h>
#include <AaStatement.h>


// *******************************************  MODULE ************************************
// compilation unit: a module is basically a block
// statement, but with arguments
class AaModule: public AaSeriesBlockStatement
{
  vector<AaInterfaceObject*>  _input_args;
  vector<AaInterfaceObject*>  _output_args;

  bool _foreign_flag;
  bool _inline_flag;

 public:
  AaModule(string fname); // Modules have NULL parent (parent is the program)
  ~AaModule();

  void Set_Foreign_Flag(bool ff) { this->_foreign_flag = ff; }
  bool Get_Foreign_Flag() {return(this->_foreign_flag);}

  void Set_Inline_Flag(bool ff) { this->_inline_flag = ff; }
  bool Get_Inline_Flag() {return(this->_inline_flag);}

  void Add_Argument(AaInterfaceObject* obj);

  unsigned int Get_Number_Of_Input_Arguments() {return(this->_input_args.size());}
  AaInterfaceObject* Get_Input_Argument(unsigned int index)
  {
    return(this->_input_args[index]);
  }

  unsigned int Get_Number_Of_Output_Arguments() {return(this->_output_args.size());}
  AaInterfaceObject* Get_Output_Argument(unsigned int index)
  {
    return(this->_output_args[index]);
  }

  virtual string Get_C_Name()
  {
    return(this->Get_Label());
  }

  void Print(ostream& ofile);
  virtual string Kind() {return("AaModule");}

  virtual AaRoot* Find_Child(string tag);
  virtual void Map_Source_References();

  string Get_Structure_Name() { return(this->Get_Label() + "_State"); }
  void Write_Header(ofstream& ofile);
  void Write_Source(ofstream& ofile);

  void Write_VC_Model(int default_space_pointer_width,
		      int default_space_word_size,
		      ostream& ofile);

  void Write_VC_Control_Path(ostream& ofile);
  void Write_VC_Data_Path(ostream& ofile);
  void Write_VC_Link(ostream& ofile);
  void Write_VC_Memory_Spaces(ostream& ofile);
};

#endif
