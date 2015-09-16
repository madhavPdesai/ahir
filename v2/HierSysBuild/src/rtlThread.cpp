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

rtlString::rtlString(string inst_name, rtlThread* base, vector<pair<string,string> >& port_map):hierRoot(inst_name)
{
	_base_thread = base;
	for(int I = 0, fI = port_map.size(); I < fI; I++)
	{
		_port_map[port_map[I].first] = port_map[I].second;
	}

	// TODO: check if ok..
}


void rtlString::Print(ostream& ofile)
{
	ofile << "$string " << this->Get_Id() << ":"  << _base_thread->Get_Id() << " ";
	for(map<string,string>::iterator piter = _port_map.begin(), fpiter = _port_map.end();
			piter != fpiter; piter++)
	{
		ofile << "  " << (*piter).first << " => " << (*piter).second << endl;
	}
}


