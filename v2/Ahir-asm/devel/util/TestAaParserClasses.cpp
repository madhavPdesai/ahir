#include <AaParserClasses.h>
#include <AaParser.h>
#include <AaLexer.h>

using namespace std;
using namespace antlr;


int main(int argc, char* argv[])
{

  // make the program
  AaProgram* pgm = new AaProgram();

  // make some types 
  AaUintType* uint_32 = new AaUintType(pgm,32);
  AaUintType* int_32 = new AaIntType(pgm,32);
  AaFloatType* float_10_10 = new AaFloatType(pgm,10,10);

  vector<unsigned int> dim_vector;
  dim_vector.push_back(5);
  dim_vector.push_back(10);
  AaArrayType* int_array_type = new AaArrayType(pgm,uint_32,dim_vector);

  // make a function
  AaModule* fn = new AaModule(pgm,"TestModule");
  pgm->Add_Module(fn);

  // make some interface objects
  AaInterfaceObject* in1 = new AaInterfaceObject(fn, "in1", uint_32, "in");
  fn->Add_Argument(in1);
  AaInterfaceObject* in2 = new AaInterfaceObject(fn, "in2", int_32, "in");
  fn->Add_Argument(in2);
  AaInterfaceObject* in3 = new AaInterfaceObject(fn, "in3", float_10_10, "in");
  fn->Add_Argument(in3);
  AaInterfaceObject* in4 = new AaInterfaceObject(fn, "in4", int_array_type, "in");
  fn->Add_Argument(in4);
  AaInterfaceObject* out = new AaInterfaceObject(fn, "out", int_array_type, "out");
  fn->Add_Argument(out);

  // now some statements
  vector<AaStatement*> slist;
  slist.push_back(new AaAssignmentStatement(fn,
					    new AaSimpleObjectReference(fn,"p"),
					    new AaBinaryExpression(fn,
								   new AaStringValue(fn,"plus"),
								   new AaSimpleObjectReference(fn,"in1"),
								   new AaSimpleObjectReference(fn,"in2"))));
  fn->Set_Statement_Sequence(new AaStatementSequence(fn,slist));

  pgm->Print(cout);
}
