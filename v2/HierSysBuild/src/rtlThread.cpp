#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlThread.h>


rtlThread::rtlThread(hierSystem* sys, string id): hierRoot(id)
{
	_parent_system = sys;
}

void rtlThread::Print(ostream& ofile)
{
	// TODO
	ofile << "// $thread " << this->Get_Id() << endl;
}

