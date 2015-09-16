#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlEnums.h>
#include <rtlType.h>
#include <Value.hpp>
#include <rtlValue.h>
#include <rtlObject.h>
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
	// TODO
	ofile << "// $thread " << this->Get_Id() << endl;
}

// TODO: pass hierSystem pointer also to the string?
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
	// TODO
}


