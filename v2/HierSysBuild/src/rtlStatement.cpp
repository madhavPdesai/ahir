#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlInclusions.h>
#include <rtlEnums.h>
#include <rtlType.h>
#include <Value.hpp>
#include <rtlValue.h>
#include <rtlObject.h>
#include <rtlExpression.h>
#include <rtlStatement.h>
#include <rtlThread.h>
	
rtlStatement::rtlStatement(rtlThread* p):hierRoot()
{
	_parent_thread = p;
}

	
rtlAssignStatement::rtlAssignStatement(rtlThread* p,bool volatile_flag,  rtlExpression* tgt, rtlExpression* src):rtlStatement(p)
{
	_target = tgt;
	tgt->Set_Is_Target(true);

	_source = src;
	_volatile = volatile_flag;
}




	
void rtlAssignStatement::Print(ostream& ofile)
{
	if(_volatile)
		ofile << " $volatile ";
	_target->Print(ofile);
	ofile << " := ";
	_source->Print(ofile);
	ofile << endl;
}

void rtlEmitStatement::Print(ostream& ofile)
{
	ofile << " $emit " << _object->Get_Id() << endl;
}

void rtlGotoStatement::Print(ostream& ofile)
{
	ofile << " $goto " << _label << endl;
}

void rtlIfStatement::Print(ostream& ofile)
{
	ofile << " $if ";
	_test->Print(ofile);
	ofile << endl;
	_if_block->Print(ofile);
	ofile << " $else " << endl;
	_else_block->Print(ofile);
	ofile << endl;
}


void rtlBlockStatement::Print(ostream& ofile)
{
	ofile << "{" << endl;
	for(int I = 0, fI = _statement_block.size(); I < fI; I++)
	{
		_statement_block[I]->Print(ofile);
	}
	ofile << "}" << endl;
}


void rtlLabeledBlockStatement::Print(ostream& ofile)
{
	ofile << "[" << _label << "] ";
	this->rtlBlockStatement::Print(ofile);
}


rtlNullStatement::rtlNullStatement(rtlThread* p): rtlStatement(p)
{
}

void rtlNullStatement::Print(ostream& ofile)
{
	ofile << " $null " << endl;
}

