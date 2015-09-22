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


rtlThread::rtlThread(hierSystem* sys, string id): hierRoot(id)
{
	_parent = sys;
}

void rtlThread::Add_Statement(rtlStatement* stmt) 
{
	_statements.push_back(stmt); 
	_statement_map[stmt->Get_Label()] = stmt;
}

void rtlThread::Add_Object(rtlObject* obj)
{
	if(obj != NULL)
		_objects[obj->Get_Id()] = obj;
}

void rtlThread::Print(ostream& ofile)
{
	ofile << "$thread " << this->Get_Id() << endl;

	for(map<string,rtlObject*>::iterator oiter = _objects.begin(), foiter = _objects.end();
		oiter != foiter; oiter++)
	{
		(*oiter).second->Print(ofile);
	}

	for(int I = 0, fI = _statements.size(); I < fI; I++)
	{
		_statements[I]->Print(ofile);
	}
}

rtlString::rtlString(string inst_name, rtlThread* base):hierRoot(inst_name)
{
	_base_thread = base;
}

	
	
void rtlString::Add_Port_Map_Entry(vector<string>& formals, string actual)
{
	assert((formals.size() == 1) || (formals.size() == 3));
	_actual_to_formal_port_map[actual] = formals;

	hierSystem* base_sys = this->_base_thread->Get_Parent();

	string formal_obj = ((formals.size() == 1) ? formals[0] : formals[1]);
	rtlObject* obj = this->_base_thread->Find_Object(formal_obj);


	if(obj == NULL)
	{
		base_sys->Report_Error(" formal " + formals[0] + " not found for string port map for instance " + this->Get_Id());
	}
	else 
	{
		if(obj->Is_InPort())
		{
			base_sys->Set_Driving_Pipe(actual);
			this->Set_PipeXSignal_Is_Read_From(actual);
		}
		else if(obj->Is_OutPort())
		{
			base_sys->Set_Driven_Pipe(actual);
			this->Set_PipeXSignal_Is_Written_Into(actual);
		}
		else
		{
			base_sys->Report_Error(" formal " + formals[0] + " not found for string port map for instance " + this->Get_Id());
		}

		if(obj->Get_Type()->Size() != base_sys->Get_Pipe_Width(actual))
		{
			base_sys->Report_Error(" formal " + obj->Get_Id() + " size does not match actual " + actual
				+ " in port map for rtlString instance " + this->Get_Id());
		}
	}

	if(formals.size() == 1)
	{
		if(!base_sys->Is_Signal(actual))
		{
			base_sys->Report_Error(" actual " + actual + " mapped to single-port in instance " + this->Get_Id() + " is not a signal");
		}
	}
	else if(formals.size() == 3)
	{
		rtlObject* req_obj = this->_base_thread->Find_Object(formals[0]);
		rtlObject* ack_obj = this->_base_thread->Find_Object(formals[2]);

		if(base_sys->Is_Signal(actual))
		{
			base_sys->Report_Error(" actual " + actual + " mapped to 3-port-tuple in instance " + this->Get_Id() + " is not a pipe");
		}

		if(req_obj == NULL)
		{
			base_sys->Report_Error(" req " + formals[0] + " map to " + actual + " in rtlString " + this->Get_Id() + " not found");
		}
		else 
		{
			if(!(req_obj->Get_Type()->Is("rtlUnsignedType") || req_obj->Get_Type()->Is("rtlSignedType")))
				base_sys->Report_Error(" req " + formals[0] + " map to " + actual + " in rtlString " + this->Get_Id() + " not of unsigned/signed type");
			if(!req_obj->Is_OutPort())
				base_sys->Report_Error(" req " + formals[0] + " map to " + actual + " in rtlString " + this->Get_Id() + " not an OutPort");
			
		}
		if(ack_obj == NULL)
		{
			base_sys->Report_Error(" ack " + formals[2] + " map to " + actual + " in rtlString " + this->Get_Id() + " not found");
		}
		else 
		{
			if(!(ack_obj->Get_Type()->Is("rtlUnsignedType") || ack_obj->Get_Type()->Is("rtlSignedType")))
				base_sys->Report_Error(" ack " + formals[2] + " map to " + actual + " in rtlString " + this->Get_Id() + " not of unsigned/signed type");

			if(!ack_obj->Is_InPort())
				base_sys->Report_Error(" ack " + formals[2] + " map to " + actual + " in rtlString " + this->Get_Id() + " not an InPort");
		}
	}
	else
	{
			base_sys->Report_Error(" port mapping to actual " + actual + " is not 1 or 3-tuple  in rtlString " + this->Get_Id());
	}
}

void rtlString::Print(ostream& ofile)
{
	ofile << "$string " << this->Get_Id() << ":"  << _base_thread->Get_Id() << " ";
	ofile << endl;
	for(map<string,vector<string> >::iterator piter = _actual_to_formal_port_map.begin(), fpiter = _actual_to_formal_port_map.end();
			piter != fpiter; piter++)
	{
		ofile << "  (";
		for(int I = 0, fI = (*piter).second.size(); I < fI; I++)
		{
			ofile << (*piter).second[I] << " ";
		}
		ofile << ") => ";
		ofile <<  (*piter).first << endl;
	}
}


