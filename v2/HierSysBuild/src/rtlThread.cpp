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
		}
		else if(obj->Is_OutPort())
		{
			base_sys->Set_Driven_Pipe(actual);
		}
		else
		{
			base_sys->Report_Error(" formal " + formals[0] + " not found for string port map for instance " + this->Get_Id());
		}
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


