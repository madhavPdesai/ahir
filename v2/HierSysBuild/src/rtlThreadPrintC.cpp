#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlEnums.h>
#include <rtlType.h>
#include <Value.hpp>
#include <rtlValue.h>
#include <rtlObject.h>
#include <rtlStatement.h>
#include <rtlThread.h>

string threadStructTypeName(rtlThread* t) {return(string("__") + t->Get_Id() + "State");}
string stateEnum(string state_label) {return("__" + state_label);}
string threadStateEnumTypeName(rtlThread* t) {return(string("__") + t->Get_Id() + "StateEnum");}
string threadRunFunctionName(rtlThread* t) {return(string("__") + t->Get_Id() + "__run__");}
string threadTickFunctionName(rtlThread* t) {return(string("__") + t->Get_Id() + "__tick__");}
string stringStructObjName(rtlString* s) {return(string("__") + s->Get_Id() + "__state");}
string stringStructAllocatorFunctionName(rtlString* s) {return(string("__") + s->Get_Id() + "__struct_allocator");}
string stringMatcherAllocatorFunctionName(rtlString* s) {return(string("__") + s->Get_Id() + "__matcher_allocator");}
string stringToPipeMatcherObjName(rtlString* s, string pipe_name) {return(string("__") + s->Get_Id() + "__to__" + pipe_name);}
string pipeToStringMatcherObjName(rtlString* s, string pipe_name) {return(string("__") + pipe_name + "__to__" + s->Get_Id());}
string pipeToStringMatcherThreadName(rtlString* s, string pipe_name) 
	{return(string("__") + pipe_name + "__to__" + s->Get_Id() + "__match_daemon");}
string stringToPipeMatcherThreadName(rtlString* s, string pipe_name)
	{return(string("__") + s->Get_Id() + "__to__" + pipe_name + "__match_daemon");}




void rtlThread::Print_C_Struct_Declaration(ostream& header_file)
{
	string tname = threadStructTypeName(this);
	string ename = threadStateEnumTypeName(this);

	// state enumerator type.
	header_file << "typedef enum " << ename << "_ " << endl;
	header_file << "{" << endl;
	for(int I = 0, fI = _statements.size(); I < fI; I++)
	{
		header_file << stateEnum(_statements[I]->Get_Label());
		if(I < (fI - 1))
			header_file << ",";
		header_file << endl;
	}
	header_file << "} " << ename << ";" << endl;

	// internal thread state type.
	header_file << "typedef struct " + tname + "_ " + tname + ";" << endl;
	header_file << "struct " + tname + "_ " << endl;
	header_file << "{" << endl;
	header_file << ename << "  _state;" << endl;
	header_file << ename << "  _next_state;" << endl;

	for(map<string, rtlObject*>::iterator iter = this->_objects.begin(), fiter = this->_objects.end();
		iter != fiter;
		iter++)
	{
		rtlObject* obj = (*iter).second;
		header_file << obj->Get_Type()->Get_C_Name() << " " << obj->Get_Id() << ";" << endl;
		if(obj->Needs_Next())
		{
			header_file << obj->Get_Type()->Get_C_Name() << " __next__" << obj->Get_Id() <<  ";" << endl;
		}
	}

	header_file << "}" << endl;
}

void rtlThread::Print_C_Run_Function(ostream& source_file)
{
	string fn_name = threadRunFunctionName(this);
	string struct_type_name = threadStructTypeName(this);

	source_file << "void " << fn_name << "(" << struct_type_name << "* incoming_state)" << endl;
	source_file << "{" << endl;
	source_file << struct_type_name << "* __sstate = incoming_state;" << endl;
		
	for(int I = 0, fI = _statements.size(); I < fI; I++)
	{
		if(I > 0)
			source_file << "else" << endl;
		source_file << "if(__sstate->_state == " <<  stateEnum(_statements[I]->Get_Label()) << ")" << endl;
		source_file << "{" << endl;
		source_file << "// default next-state " << endl;
		source_file << "__sstate->_next_state = "
			<< ((I < (fI-1)) ? stateEnum(_statements[I+1]->Get_Label()) : stateEnum(_statements[I]->Get_Label()))
			<< ";" << endl;
		source_file << "// label: " << _statements[I]->Get_Label() << endl;
		_statements[I]->Print_C(source_file);
		source_file << "}" << endl;
	}
	source_file << "}" << endl;
}

void rtlThread::Print_C_Tick_Function(ostream& source_file)
{
	string fn_name = threadTickFunctionName(this);
	string struct_type_name = threadStructTypeName(this);

	source_file << "void " << fn_name << "(" << struct_type_name << "* incoming_state)" << endl;
	source_file << "{" << endl;

	source_file << struct_type_name << "* __sstate = incoming_state;" << endl;
	source_file << "__sstate->_state = __sstate->_next_state;" << endl;

	for(map<string, rtlObject*>::iterator iter = this->_objects.begin(), fiter = this->_objects.end();
		iter != fiter;
		iter++)
	{
		rtlObject* obj = (*iter).second;
		if(obj->Needs_Next())
		{
			source_file << obj->Get_C_Name() << " = " << obj->Get_C_Target_Name() << ";" << endl;
		}
	}
	source_file << "}" << endl;
}


void rtlString::Print_C_State_Structure_Declaration(ostream& source_file)
{
	string tname = threadStructTypeName(this->Get_Base_Thread());
	string vname = stringStructObjName(this);
	source_file << tname << "* " << vname << " = NULL;" << endl;
}

void rtlString::Print_C_State_Structure_Allocator(ostream& source_file)
{
	string allocator_name  = stringStructAllocatorFunctionName(this);
	string tname = threadStructTypeName(this->Get_Base_Thread());
	string vname = stringStructObjName(this);
	source_file << "void " << allocator_name << "()" << endl;
	source_file << "{" << endl;
	source_file << vname << " = (" << tname << "*) calloc(1,sizeof(" << tname << "));" << endl;
	source_file << vname << "->_state = " << 
			stateEnum(this->Get_Base_Thread()->Get_Statement(0)->Get_Label()) << ";" << endl;
	source_file << vname << "->_next_state = " << 
			stateEnum(this->Get_Base_Thread()->Get_Statement(0)->Get_Label()) << ";" << endl;
	vector<rtlObject*> t_objs;
	this->Get_Base_Thread()->List_Objects(t_objs);
	for(int I = 0, fI = t_objs.size(); I < fI; I++)
	{
		rtlObject* obj = t_objs[I];
		string obj_name = obj->Get_C_Name();
		obj->Print_C_Struct_Field_Initialization(obj_name, source_file);
		if(obj->Needs_Next())
		{
			string next_obj_name = obj->Get_C_Target_Name();
			obj->Print_C_Struct_Field_Initialization(next_obj_name, source_file);
		}
	}
	source_file << "}" << endl;
}

void rtlString::Print_C_State_Structure_Allocator_Call(ostream& source_file)
{
	string allocator_name  = stringStructAllocatorFunctionName(this);
	source_file << allocator_name << "();" << endl;
}

void rtlString::Print_C_Rtl_Aa_Matcher_Structure_Declarations(ostream& source_file)
{
	rtlThread* bt = this->Get_Base_Thread();
	hierSystem* sys = bt->Get_Parent();

	// iterate over the string port map.	
	for(map<string, vector<string> >::iterator iter = _actual_to_formal_port_map.begin(),
			fiter = _actual_to_formal_port_map.end(); iter != fiter; iter++)
	{
		string port_name = (*iter).first;
		vector<rtlObject*> obj_vector;

		this->Get_Base_Thread()->Lookup_Objects((*iter).second, obj_vector);

		rtlObject* dobj;
		if(obj_vector.size() == 1)
			dobj = obj_vector[0];
		else if(obj_vector.size() == 3)
			dobj = obj_vector[1];
		else
			assert(0);

		if(dobj->Is_InPort())
		{
			if(sys->Is_Signal(port_name))
			{
				// Aa2RtlSignalTransferMatcher
				source_file << "Aa2RtlSignalTransferMatcher* " << pipeToStringMatcherObjName(this, port_name) << ";" << endl;
			}
			else
			{
				// Aa2RtlPipeTransferMatcher
				source_file << "Aa2RtlPipeTransferMatcher* " << pipeToStringMatcherObjName(this, port_name) << ";" << endl;
			}

		}
		else if(dobj->Is_OutPort())
		{
			if(sys->Is_Signal(port_name))
			{
				// Rtl2AaSignalTransferMatcher
				source_file << "Rtl2AaSignalTransferMatcher* " << stringToPipeMatcherObjName(this,port_name) << ";" << endl;
			}
			else
			{
				// Rtl2AaPipeTransferMatcher
				source_file << "Rtl2AaPipeTransferMatcher* " << stringToPipeMatcherObjName(this, port_name) << ";" << endl;
			}
		}
	}	
	
}
	
void rtlString::Print_C_Rtl_Aa_Matcher_Allocator(ostream& source_file)
{
	string fname = stringMatcherAllocatorFunctionName(this);
	rtlThread* bt = this->Get_Base_Thread();
	hierSystem* sys = bt->Get_Parent();

	source_file << "void " << fname << "();" << endl;
	source_file << "{" << endl;


	// iterate over the string port map.	
	for(map<string, vector<string> >::iterator iter = _actual_to_formal_port_map.begin(),
			fiter = _actual_to_formal_port_map.end(); iter != fiter; iter++)
	{
		string port_name = (*iter).first;
		int pipe_width = sys->Get_Pipe_Width(port_name);

		vector<rtlObject*> obj_vector;

		bt->Lookup_Objects((*iter).second, obj_vector);

		rtlObject* dobj;
		if(obj_vector.size() == 1)
			dobj = obj_vector[0];
		else if(obj_vector.size() == 3)
			dobj = obj_vector[1];
		else
			assert(0);

		if(dobj->Is_InPort())
		{
			if(sys->Is_Signal(port_name))
			{
				// Aa2RtlSignalTransferMatcher
				source_file << pipeToStringMatcherObjName(this, port_name) 
						<< " = makeSignalMatcher(\"" << port_name << "\", " << pipe_width << ");" << endl;
			}
			else
			{
				// Aa2RtlPipeTransferMatcher
				source_file << pipeToStringMatcherObjName(this, port_name) 
						<< " = makePipeMatcher(\"" << port_name << "\", " << pipe_width << ");" << endl;
			}

		}
		else if(dobj->Is_OutPort())
		{
			if(sys->Is_Signal(port_name))
			{
				// Rtl2AaSignalTransferMatcher
				source_file << stringToPipeMatcherObjName(this, port_name) 
						<< " = makeSignalMatcher(\"" << port_name << "\", " << pipe_width << ");" << endl;
			}
			else
			{
				// Rtl2AaPipeTransferMatcher
				source_file << stringToPipeMatcherObjName(this, port_name) 
						<< " = makePipeMatcher(\"" << port_name << "\", " << pipe_width << ");" << endl;
			}
		}
	}	

	source_file << "}" << endl;
}

void rtlString::Print_C_Rtl_Aa_Ack_Transfers(ostream& source_file)
{
	rtlThread* bt = this->Get_Base_Thread();
	hierSystem* sys = bt->Get_Parent();
	
	string string_struct_name =  stringStructObjName(this);

	// iterate over the string port map.	
	for(map<string, vector<string> >::iterator iter = _actual_to_formal_port_map.begin(),
			fiter = _actual_to_formal_port_map.end(); iter != fiter; iter++)
	{
		string port_name = (*iter).first;
		int pipe_width = sys->Get_Pipe_Width(port_name);

		vector<rtlObject*> obj_vector;

		bt->Lookup_Objects((*iter).second, obj_vector);

		rtlObject* dobj = NULL;;
		rtlObject* req_obj = NULL;
		rtlObject* ack_obj = NULL;
		if(obj_vector.size() == 1)
		{
			dobj = obj_vector[0];
		}
		else if(obj_vector.size() == 3)
		{
			req_obj = obj_vector[0];
			dobj = obj_vector[1];
			ack_obj = obj_vector[2];
		}
		else
			assert(0);

		string matcher_struct_name = (dobj->Is_InPort() ?
							pipeToStringMatcherObjName(this,port_name) :
							stringToPipeMatcherObjName(this,port_name));
		if(!sys->Is_Signal(port_name))
		{
			// Aa2RtlSignalTransferMatcher
			source_file << string_struct_name << "->" << ack_obj->Get_Id() << " = "
				<< "getAndClearAck(" << matcher_struct_name << ");" << endl;
		}

		if(dobj->Is_InPort())
		{
			source_file << "bit_vector_bitcast_to_bit_vector(" 
					<< string_struct_name << "->" << dobj->Get_Id() 
					<< ", getValue(" 
					<< matcher_struct_name << "));" << endl;
		}
	}
}

void rtlString::Print_C_Run_Function_Call(ostream& source_file)
{
	string fn_name = threadRunFunctionName(this->Get_Base_Thread());
	string arg_name = stringStructObjName(this);
	source_file << fn_name << "(" << arg_name << ");" << endl;
}

void rtlString::Print_C_Rtl_Aa_Req_Transfers(ostream& source_file)
{
	rtlThread* bt = this->Get_Base_Thread();
	hierSystem* sys = bt->Get_Parent();
	
	string string_struct_name =  stringStructObjName(this);

	// iterate over the string port map.	
	for(map<string, vector<string> >::iterator iter = _actual_to_formal_port_map.begin(),
			fiter = _actual_to_formal_port_map.end(); iter != fiter; iter++)
	{
		string port_name = (*iter).first;
		int pipe_width = sys->Get_Pipe_Width(port_name);

		vector<rtlObject*> obj_vector;

		bt->Lookup_Objects((*iter).second, obj_vector);

		rtlObject* dobj;
		rtlObject* req_obj = NULL;
		if(obj_vector.size() == 1)
			dobj = obj_vector[0];
		else if(obj_vector.size() == 3)
		{
			req_obj = obj_vector[0];
			dobj = obj_vector[1];
		}
		else
			assert(0);

		string matcher_struct_name = (dobj->Is_InPort() ?
							pipeToStringMatcherObjName(this,port_name) :
							stringToPipeMatcherObjName(this,port_name));
		if(!sys->Is_Signal(port_name))
		{
			// Aa2RtlSignalTransferMatcher
			source_file << "setRequest(" << matcher_struct_name << ",";
			source_file << string_struct_name << "->" << req_obj->Get_Id() << ");" << endl;
		}

		if(dobj->Is_OutPort())
		{
			source_file << "setValue(" << matcher_struct_name << ","
					<< string_struct_name << "->" << dobj->Get_Id() 
					<< ");" << endl;
		}
	}
}

void rtlString::Print_C_Tick_Function_Call(ostream& source_file)
{
	string fn_name = threadTickFunctionName(this->Get_Base_Thread());
	string arg_name = stringStructObjName(this);
	source_file << fn_name << "(" << arg_name << ");" << endl;
}

void rtlString::Print_C_Matcher_Start_Daemons(ostream& source_file, vector<string>& match_daemons)
{
	rtlThread* bt = this->Get_Base_Thread();
	hierSystem* sys = bt->Get_Parent();
	
	string string_struct_name =  stringStructObjName(this);

	// iterate over the string port map.	
	for(map<string, vector<string> >::iterator iter = _actual_to_formal_port_map.begin(),
			fiter = _actual_to_formal_port_map.end(); iter != fiter; iter++)
	{
		string port_name = (*iter).first;
		int pipe_width = sys->Get_Pipe_Width(port_name);

		vector<rtlObject*> obj_vector;

		bt->Lookup_Objects((*iter).second, obj_vector);

		rtlObject* dobj = NULL;;
		rtlObject* req_obj = NULL;
		rtlObject* ack_obj = NULL;
		if(obj_vector.size() == 1)
		{
			dobj = obj_vector[0];
		}
		else if(obj_vector.size() == 3)
		{
			req_obj = obj_vector[0];
			dobj = obj_vector[1];
			ack_obj = obj_vector[2];
		}
		else
			assert(0);

		string matcher_struct_name = (dobj->Is_InPort() ?
							pipeToStringMatcherObjName(this,port_name) :
							stringToPipeMatcherObjName(this,port_name));

		if(dobj->Is_OutPort())
		{
			string daemon_fn_name = stringToPipeMatcherThreadName(this, port_name);
			string inner_fn_name  = 
					(sys->Is_Signal(port_name) ?  "rtl2AaSignalTransferMatcher" : "rtl2AaPipeTransferMatcher");
			string match_rec_name = stringToPipeMatcherObjName(this, port_name);
			source_file << "void " << daemon_fn_name << "() " << endl;
			source_file << "{" << endl;
			source_file << inner_fn_name << "((void*) " << match_rec_name << ");" << endl;
			source_file << "}" << endl;
			source_file << "DEFINE_THREAD(" << daemon_fn_name << ");" << endl;
			match_daemons.push_back(daemon_fn_name);
		}
		else
		{
			string daemon_fn_name = pipeToStringMatcherThreadName(this, port_name);
			string inner_fn_name  = 
					(sys->Is_Signal(port_name) ?  "Aa2RtlSignalTransferMatcher" : "Aa2RtlPipeTransferMatcher");
			string match_rec_name = pipeToStringMatcherObjName(this, port_name);
			source_file << "void " << daemon_fn_name << "() " << endl;
			source_file << "{" << endl;
			source_file << inner_fn_name << "((void*) " << match_rec_name << ");" << endl;
			source_file << "}" << endl;
			source_file << "DEFINE_THREAD(" << daemon_fn_name << ");" << endl;
			match_daemons.push_back(daemon_fn_name);
		}
	}
}


void Print_C_Binary_Operation(string tgt_name, string first_op, string second_op, rtlType* tgt_type, rtlOperation opcode , ostream& ofile)
{
	if(tgt_type->Is("rtlIntegerType"))
	{
		switch(opcode)
		{
			case __OR: 
				ofile << tgt_name << "(" << first_op <<  " | " << second_op << ");" << endl;	 break;
			case __AND:
				ofile << tgt_name << "(" << first_op <<  " & " << second_op << ");" << endl;	 break;
			case __XOR:
				ofile << tgt_name << "(" << first_op <<  " ^ " << second_op << ");" << endl;	 break;
			case __NOR:
				ofile << tgt_name << "~(" << first_op <<  " | " << second_op << ");" << endl;	 break;
			case __NAND:
				ofile << tgt_name << "~(" << first_op <<  " & " << second_op << ");" << endl;	 break;
			case __XNOR:
				ofile << tgt_name << "~(" << first_op <<  " ^ " << second_op << ");" << endl;	 break;
			case __SHL:
				ofile << tgt_name << "(" << first_op <<  " << " << second_op << ");" << endl;	 break;
			case __SHR:
				ofile << tgt_name << "(" << first_op <<  " >> " << second_op << ");" << endl;	 break;
			case __EQUAL:
				ofile << tgt_name << "(" << first_op <<  " == " << second_op << ");" << endl;	 break;
			case __NOTEQUAL:
				ofile << tgt_name << "(" << first_op <<  " != " << second_op << ");" << endl;	 break;
			case __LESS:
				ofile << tgt_name << "(" << first_op <<  " < " << second_op << ");" << endl;	 break;
			case __LESSEQUAL:
				ofile << tgt_name << "(" << first_op <<  " <= " << second_op << ");" << endl;	 break;
			case __GREATER:
				ofile << tgt_name << "(" << first_op <<  " > " << second_op << ");" << endl;	 break;
			case __GREATEREQUAL:
				ofile << tgt_name << "(" << first_op <<  " >= " << second_op << ");" << endl;	 break;
			case __PLUS:
				ofile << tgt_name << "(" << first_op <<  " + " << second_op << ");" << endl;	 break;
			case __MINUS:
				ofile << tgt_name << "(" << first_op <<  " - " << second_op << ");" << endl;	 break;
			case __MUL:
				ofile << tgt_name << "(" << first_op <<  " * " << second_op << ");" << endl;	 break;
			case __DIV:
				ofile << tgt_name << "(" << first_op <<  " / " << second_op << ");" << endl;	 break;
			default: assert(0); break;
		}
	}
	else if(tgt_type->Is("rtlUnsignedType") || tgt_type->Is("rtlSignedType"))
	{
		int signed_flag = tgt_type->Is("rtlSignedType");
		switch(opcode)	
		{
			case __OR: 
				ofile << "bit_vector_or(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __AND:
				ofile << "bit_vector_and(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __XOR:
				ofile << "bit_vector_xor(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __NOR:
				ofile << "bit_vector_nor(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __NAND:
				ofile << "bit_vector_nand(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __XNOR:
				ofile << "bit_vector_xnor(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __SHL:
				ofile << "bit_vector_shl(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __SHR:
				ofile << "bit_vector_shr(" << signed_flag << ", &(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __ROR:
				ofile << "bit_vector_ror(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __ROL:
				ofile << "bit_vector_rol(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __EQUAL:
				ofile << "bit_vector_equal(" << signed_flag << ", &(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __NOTEQUAL:
				ofile << "bit_vector_not_equal(" << signed_flag << ", &(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __LESS:
				ofile << "bit_vector_less(" << signed_flag << ", &(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __LESSEQUAL:
				ofile << "bit_vector_less_equal(" << signed_flag << ", &(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __GREATER:
				ofile << "bit_vector_greater(" << signed_flag << ", &(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __GREATEREQUAL:
				ofile << "bit_vector_greater_equal(" << signed_flag << ", &(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __PLUS:
				ofile << "bit_vector_plus(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __MINUS:
				ofile << "bit_vector_minus(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __MUL:
				ofile << "bit_vector_mul(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __DIV:
				ofile << "bit_vector_div(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;
			case __CONCAT:
				ofile << "bit_vector_concat(&(" << first_op << "), &(" << second_op << "), &(" << tgt_name << "));" << endl; break;

			default: assert(0); break;
		}
	}
	else
		assert(0);
}

void Print_C_Assignment(string tgt, string src, rtlType* tt, ostream& ofile)
{
	if(tt->Is("rtlIntegerType"))
	{
		ofile << tgt << " = " << src << ";" << endl;
	}
	else
	{
		ofile << "bit_vector_bitcast_to_bit_vector(&(" << tgt << "), &(" << src << "));" << endl;
	}
}


