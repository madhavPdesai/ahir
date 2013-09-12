using namespace std;
#include <AaIncludes.h>
#include <AaEnums.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>
#include <AaObject.h>
#include <AaStatement.h>
#include <AaModule.h>
#include <AaProgram.h>
#include <Aa2VC.h>


// common operations across loads/stores.
void AaObjectReference::Write_VC_Load_Control_Path(vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{

	ofile << ";;[" << this->Get_VC_Name() << "] { // load " << endl;

	// address calculation
	// 1. compute agross = base + (offset*scale-factor)
	// 2. in parallel, compute aI = agross + I
	//       optimization: if number is 2**N then append.
	this->Write_VC_Address_Calculation_Control_Path(address_expressions,scale_factors, shift_factors, ofile);

	// load operations
	//    in parallel, load..
	this->Write_VC_Load_Store_Control_Path(address_expressions, scale_factors, shift_factors, "read", ofile);

	ofile << "}" << endl;

}

void AaObjectReference::Write_VC_Store_Control_Path(vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{

	ofile << ";;[" << this->Get_VC_Name() << "] { // store " << endl;
	// address calculation
	// 1. compute agross = base + (offset*scale-factor)
	// 2. in parallel, compute aI = agross + I
	//       optimization: if number is 2**N then append.
	this->Write_VC_Address_Calculation_Control_Path(address_expressions, scale_factors, shift_factors, ofile);

	//    in parallel, store
	this->Write_VC_Load_Store_Control_Path(address_expressions, scale_factors, shift_factors, "write", ofile);

	ofile << "}" << endl;
}

void AaObjectReference::Write_VC_Load_Store_Constants(vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{

	// the constant base address and index-multiplier
	// of the object are assumed to have been
	// declared earlier..

	// constant wires for each individual word operation are
	// also assumed to have been declared "earlier".
	// these will figure in the address calculation and will appear as
	// operands to  compute final word addresses.

	// if this is a constant.. no need to proceed..
	if(this->Is_Constant())
		return;

	this->Write_VC_Address_Calculation_Constants(address_expressions,
			scale_factors,
			shift_factors,
			ofile);


}



void AaObjectReference::Write_VC_Load_Store_Wires(vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{



	int offset_value = this->Evaluate(address_expressions,
			scale_factors,
			shift_factors);
	int base_address = this->Get_Base_Address();
	AaUintType* addr_type = AaProgram::Make_Uinteger_Type(this->Get_Address_Width());

	int nwords = (address_expressions ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));

	if(offset_value < 0 || base_address < 0)
	{
		// this yields the offset+base
		this->Write_VC_Root_Address_Calculation_Wires(address_expressions,
				scale_factors,
				shift_factors,
				ofile);


		// well, now you need to generate the individual word addresses
		// out of the root address.
		for(int idx = 0; idx < nwords; idx++)
		{
			// the address for each of the individual words being accessed.
			Write_VC_Pointer_Declaration(this->Get_VC_Memory_Space_Name(),
					this->Get_VC_Word_Address_Name(idx),
					addr_type,
					ofile);
		}
	}

	// there is also a data wire for each word.
	AaUintType* data_type = AaProgram::Make_Uinteger_Type(this->Get_Word_Size());
	for(int idx = 0; idx < nwords; idx++)
	{
		// the data for each of the individual words being accessed.
		Write_VC_Wire_Declaration(this->Get_VC_Name() + "_data_" 
				+ IntToStr(idx),
				data_type,
				ofile);
	}
}

void AaObjectReference::Write_VC_Load_Data_Path(vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		AaExpression* load_target_expression,
		ostream& ofile)
{
	this->Write_VC_Address_Calculation_Data_Path(address_expressions,scale_factors,shift_factors,ofile);
	this->Write_VC_Load_Store_Data_Path(address_expressions, 
			scale_factors,
			shift_factors,
			load_target_expression, 
			"read", 
			ofile);
}

void AaObjectReference::Write_VC_Store_Data_Path(vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		AaExpression* store_source_expression,
		ostream& ofile)
{
	this->Write_VC_Address_Calculation_Data_Path(address_expressions, scale_factors, shift_factors,ofile);
	this->Write_VC_Load_Store_Data_Path(address_expressions,
			scale_factors,
			shift_factors,
			store_source_expression,
			"write", ofile);
}


void AaObjectReference::Write_VC_Load_Links(string hier_id,
		vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{

	string n_hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());

	this->Write_VC_Address_Calculation_Links(n_hier_id, address_expressions, scale_factors, shift_factors, ofile);
	string rd_id = "read";
	this->Write_VC_Load_Store_Links(n_hier_id, rd_id, address_expressions, scale_factors,shift_factors, ofile);
}

void AaObjectReference::Write_VC_Store_Links(string hier_id,
		vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{


	string n_hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());

	this->Write_VC_Address_Calculation_Links(n_hier_id, address_expressions, scale_factors, shift_factors, ofile);
	string wr_id = "write";
	this->Write_VC_Load_Store_Links(n_hier_id, wr_id, address_expressions, scale_factors, shift_factors,  ofile);
}



void AaObjectReference::Write_VC_Load_Store_Control_Path(vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		string read_or_write,
		ostream& ofile)
{
	ofile << ";;[" << this->Get_VC_Name() << "_" << read_or_write << "] {" << endl;

	if(read_or_write == "write")
	{
		// split the data into words..
		ofile << "$T [split_req] $T [split_ack]" << endl;
	}

	// in parallel access the words.
	// how many words?
	int nwords = (address_expressions ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));
	ofile << "||[word_access] {" << endl;
	for(int idx = 0; idx < nwords; idx++)
	{
		// each word access.
		ofile << ";;[word_access_" << idx << "_sample] {" << endl
			<< "$T [rr] $T [ra] " << endl
			<< "}" << endl;
		ofile << ";;[word_access_" << idx << "_update] {" << endl
			<< "$T [cr] $T [ca]" << endl
			<< "}" << endl;
	}
	ofile << "}" << endl;

	if(read_or_write == "read")
	{
		// merge the words into the data..
		ofile << "$T [merge_req] $T [merge_ack]" << endl;
	}

	ofile << "}" << endl;
}

void AaObjectReference::Write_VC_Load_Store_Data_Path(vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		AaExpression* data_expression,
		string read_or_write,  
		ostream& ofile)
{
	string final_root_address_name = this->Get_VC_Root_Address_Name();


	bool scale_flag = (this->Get_Type()->Size() > this->Get_Word_Size());
	int nwords = (address_expressions ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));

	for(int idx = 0; idx < nwords;  idx++)
	{

		string dpe_name;
		vector<string> src_names;
		vector<string> tgt_names;
			
		string data_name = this->Get_VC_Name() + "_data_" + IntToStr(idx);
		string addr_name = this->Get_VC_Word_Address_Name(idx);


		bool extreme_pipelining_flag = this->Is_Part_Of_Extreme_Pipeline();

		// load-store operator
		if(read_or_write == "read")
		{
			dpe_name = this->Get_VC_Name() + "_load_" + IntToStr(idx);

			// load
			Write_VC_Load_Operator(this->Get_VC_Memory_Space_Name(),
					dpe_name,
					data_name,
					addr_name,
					this->Get_VC_Guard_String(),
					ofile);

			if(extreme_pipelining_flag)
			{
				src_names.push_back(addr_name);
				tgt_names.push_back(data_name);
			}
		}
		else
		{
			dpe_name = this->Get_VC_Name() + "_store_" + IntToStr(idx);

			// store
			Write_VC_Store_Operator(this->Get_VC_Memory_Space_Name(), 
					dpe_name,
					data_name,
					addr_name,
					this->Get_VC_Guard_String(),
					ofile);
			// extreme pipelining
			if(extreme_pipelining_flag)
			{
				src_names.push_back(addr_name);
				src_names.push_back(data_name);
			}
		}
		if(extreme_pipelining_flag)
		{
			for(int i = 0, fi = src_names.size(); i < fi; i++)
			{
				string src_name = src_names[i];
				ofile << "$buffering  $in " << dpe_name << " "
					<< src_name << " 2" << endl;
			}
			for(int i = 0, fi = tgt_names.size(); i < fi; i++)
			{
				string tgt_name = tgt_names[i];
				ofile << "$buffering  $out " << dpe_name << " "
					<< tgt_name << " 2" << endl;
			}
		}
	}


	// equivalence operator.
	vector<string> inwires;
	vector<string> outwires;

	// lower addresses to the right.
	for(int idx = nwords-1; idx >= 0; idx--)
	{
		if(read_or_write == "read")
		{
			inwires.push_back(this->Get_VC_Name() + "_data_" + IntToStr(idx));
		}
		else
		{
			outwires.push_back(this->Get_VC_Name() + "_data_" + IntToStr(idx));
		}
	}
	if(read_or_write == "read")
		outwires.push_back(data_expression->Get_VC_Driver_Name());
	else
		inwires.push_back(data_expression->Get_VC_Driver_Name());

	Write_VC_Equivalence_Operator(this->Get_VC_Name() + "_gather_scatter",
			inwires,
			outwires,
			this->Get_VC_Guard_String(),
			ofile);
}


void AaObjectReference::Write_VC_Load_Store_Links(string hier_id,
		string read_or_write,
		vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{
	vector<string> reqs;
	vector<string> acks;

	hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Name() + "_" + read_or_write);

	// if read, then merge
	string ms_instance = this->Get_VC_Name() + "_gather_scatter";
	if(read_or_write == "read")
	{
		reqs.push_back(hier_id + "/merge_req");
		acks.push_back(hier_id + "/merge_ack");

	}
	else
	{
		reqs.push_back(hier_id + "/split_req");
		acks.push_back(hier_id + "/split_ack");
	}
	Write_VC_Link(ms_instance,reqs,acks, ofile);
	reqs.clear();
	acks.clear();

	// in parallel access the words.
	hier_id = Augment_Hier_Id(hier_id, "word_access");
	for(int idx = 0; idx < (this->Get_Type()->Size() / this->Get_Word_Size()); idx++)
	{
		// each word access.
		string sample_region = Augment_Hier_Id(hier_id , "word_access_" + IntToStr(idx) +
				"_sample");
		string update_region = Augment_Hier_Id(hier_id , "word_access_" + IntToStr(idx) +
				"_update");
		reqs.push_back(sample_region + "/rr");
		reqs.push_back(update_region + "/cr");
		acks.push_back(sample_region + "/ra");
		acks.push_back(update_region + "/ca");

		string inst_name = this->Get_VC_Name() 
			+ ((read_or_write == "read") ? "_load_" : "_store_") 
			+ IntToStr(idx);
		Write_VC_Link(inst_name,
				reqs,
				acks,
				ofile);
		reqs.clear();
		acks.clear();
	}
}


void AaObjectReference::Write_VC_Address_Calculation_Constants(vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{
	int offset_value = this->Evaluate(address_expressions,
			scale_factors,
			shift_factors);
	int base_address = this->Get_Base_Address();

	if(offset_value < 0 || base_address < 0)
		this->Write_VC_Root_Address_Calculation_Constants(address_expressions,
				scale_factors,
				shift_factors,
				ofile);

	int nwords = (address_expressions ? scale_factors->back() : 
			(this->Get_Type()->Size() / this->Get_Word_Size()));
	AaUintType* addr_type = AaProgram::Make_Uinteger_Type(this->Get_Address_Width());      

	// must be a constant address..
	if(base_address >= 0 && offset_value >= 0)
	{
		int final_root_address = base_address + offset_value;
		for(int idx = 0; idx < nwords; idx++)
		{

			Write_VC_Constant_Pointer_Declaration(this->Get_VC_Memory_Space_Name(),
					this->Get_VC_Word_Address_Name(idx),
					addr_type,
					IntToStr(final_root_address + idx),
					ofile);
		}
	}
	else 
		// address was not a constant, individual word offsets
		// will come into play!
	{
		for(int idx =0; idx < nwords; idx++)
		{
			Write_VC_Constant_Declaration(this->Get_VC_Word_Offset_Name(idx),
					addr_type,
					IntToStr(idx),
					ofile);
		}
	}
}


void AaObjectReference::Write_VC_Root_Address_Calculation_Constants(vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{
	int address_offset = 0;
	bool const_flag = false;

	int offset_value = this->Evaluate(address_expressions, scale_factors, shift_factors);
	int base_address = this->Get_Base_Address();

	AaType* addr_type = AaProgram::Make_Uinteger_Type(this->Get_Address_Width());      

	if(offset_value < 0)
	{
		for(int idx = 0; idx < address_expressions->size(); idx++)
		{
			if((*address_expressions)[idx]->Is_Constant())
			{

				if((*shift_factors)[idx] < 0)
					address_offset += (*address_expressions)[idx]->Get_Expression_Value()->To_Integer() *
						(*scale_factors)[idx];
				else
					address_offset += (*shift_factors)[idx];

				const_flag = true;
			}
			else
			{

				(*address_expressions)[idx]->Write_VC_Constant_Wire_Declarations(ofile);
			}
		}

		// partial sum of constant indices.
		if(const_flag)
		{
			Write_VC_Constant_Declaration(this->Get_VC_Offset_Constant_Part_Name(),
					addr_type,
					IntToStr(address_offset),
					ofile);
		}
	}

	int base_addr = this->Get_Base_Address();
	if(base_addr >= 0)
	{
		// base address is a constant
		if(offset_value < 0)
		{
			// base address is constant, offset is not.
			Write_VC_Constant_Declaration(this->Get_VC_Resized_Base_Address_Name(),
					addr_type,
					IntToStr(base_addr),
					ofile);
		}
		else
		{

			// both base and offset are constants
			int final_root_address = base_addr + offset_value;
			Write_VC_Constant_Declaration(this->Get_VC_Root_Address_Name(),
					addr_type,
					IntToStr(final_root_address),
					ofile);

		}
	}
	else if(offset_value > 0) // final offset needs to be declared.
	{

		// base is not constant, offset is a constant.
		Write_VC_Constant_Declaration(this->Get_VC_Offset_Name(),
				addr_type,
				IntToStr(offset_value),
				ofile);
	}


	// scale factors are needed in the data path
	if(offset_value < 0)
	{
		// offset will need to be calculated.. ergo constants
		// will be needed
		if(scale_factors != NULL)
		{
			for(int idx = 0; idx < scale_factors->size(); idx++)
			{
				Write_VC_Constant_Declaration(this->Get_VC_Offset_Scale_Factor_Name(idx),
						addr_type,
						IntToStr((*scale_factors)[idx]),
						ofile);
			}
		}
	}
}


void AaObjectReference::Write_VC_Root_Address_Calculation_Wires(vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{
	int offset_val = 0;
	if(address_expressions)
		offset_val = this->Evaluate(address_expressions,scale_factors, shift_factors);
	AaUintType* addr_type = AaProgram::Make_Uinteger_Type(this->Get_Address_Width());
	bool const_flag = false;

	// if offset_val is not statically known, calculate it..
	if(offset_val < 0)
	{

		// offset is not constant... calculation is needed.

		vector<int> non_constant_indices;
		int sum_counter = 0;
		for(int idx = 0; idx < address_expressions->size(); idx++)
		{
			AaExpression* idx_expr = (*address_expressions)[idx];
			if(!idx_expr->Is_Constant())
			{
				// for each non-constant index, there will be a resized version.
				// and a a scaled version
				idx_expr->Write_VC_Wire_Declarations(false, ofile); // this is the index wire.
				Write_VC_Intermediate_Wire_Declaration(idx_expr->Get_VC_Name() + "_resized",
						addr_type,
						ofile); // the resized version
				Write_VC_Intermediate_Wire_Declaration(idx_expr->Get_VC_Name() + "_scaled",
						addr_type,
						ofile); // the scaled version.
				non_constant_indices.push_back(idx); // remember, to add them later.
			}
			else
			{
				const_flag = true;

			}
		}


		// partial sums..
		int num_to_be_added = (non_constant_indices.size() > 0 ? 
				non_constant_indices.size() + (const_flag ? 1 : 0) : 0);
		if(num_to_be_added > 1)
		{
			for(int idx = 1; idx < num_to_be_added; idx++)
			{
				Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Name() + "_index_partial_sum_" +
						IntToStr(idx),
						addr_type,
						ofile);
			}
		}

		// the final offset is an equivalence of the last partial sum
		Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Offset_Name(),
				addr_type,
				ofile);

	}

	int base_addr = this->Get_Base_Address();
	if(base_addr < 0)
	{
		// resized version of the base-address.
		Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Resized_Base_Address_Name(),
				addr_type,
				ofile);
	}

	if(offset_val < 0 || base_addr < 0)
	{
		// if either offset or base are constants, need
		// to declare the final root address wire.
		Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Root_Address_Name(),
				addr_type,
				ofile);
	}
}


void AaObjectReference::Write_VC_Address_Calculation_Control_Path(vector<AaExpression*>* indices, 
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{
	int offset_val = 0;
	if(indices)
		offset_val = this->Evaluate(indices,scale_factors, shift_factors);
	int base_addr = this->Get_Base_Address();

	if(offset_val < 0 || base_addr < 0)
	{
		ofile << ";;[" << this->Get_VC_Name() << "_addr_gen] {" << endl;


		this->Write_VC_Root_Address_Calculation_Control_Path(indices,scale_factors, shift_factors, ofile);

		// individual word addresses (in parallel)
		int nwords = (indices ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));
		if(nwords > 1)
		{
			ofile << "||[words] {" << endl;

			for(int idx = 0; idx < nwords; idx++)
			{
				// each word address is a sum
				ofile << ";;[word_" << idx << "_sample] {" << endl
					<< "$T [rr] $T [ra]" << endl
					<< "}" << endl;
				ofile << ";;[word_" << idx << "_update] {" << endl
					<< "$T [cr] $T [ca]" << endl
					<< "}" << endl;
			}
			ofile << "}" << endl;
		}
		else
		{
			// single word, no operation.. but rename it.
			ofile << "$T [root_rename_req] $T [root_rename_ack]" << endl;
		}
		ofile << "}" << endl;
	}
}


void AaObjectReference::Write_VC_Address_Calculation_Data_Path(vector<AaExpression*>* indices, 
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{
	int offset_val = 0;
	if(indices)
		offset_val = this->Evaluate(indices,scale_factors, shift_factors);
	int base_addr = this->Get_Base_Address();

	if(offset_val < 0 || base_addr < 0)
	{
		AaUintType* addr_type = AaProgram::Make_Uinteger_Type(this->Get_Address_Width());

		this->Write_VC_Root_Address_Calculation_Data_Path(indices,
				scale_factors,
				shift_factors,
				ofile);

		int nwords = (indices ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));

		if(nwords > 1)
		{
			for(int idx = 0;  idx < nwords;    idx++)
			{
				string dpe_name = this->Get_VC_Name() + "_addr_" + IntToStr(idx);
				string src_1_name = this->Get_VC_Root_Address_Name();
				string src_2_name = this->Get_VC_Word_Offset_Name(idx);
				string tgt_name = this->Get_VC_Word_Address_Name(idx);

				// write add operator to generate each word address.
				Write_VC_Binary_Operator(__PLUS,
						dpe_name,
						src_1_name,
						addr_type,
						src_2_name,
						addr_type,
						tgt_name,
						addr_type,
						this->Get_VC_Guard_String(),
						ofile
						);
				// extreme pipelining.
				if(this->Is_Part_Of_Extreme_Pipeline())
				{
					ofile << "$buffering  $in " << dpe_name << " "
						<< src_1_name << " 2" << endl;
					ofile << "$buffering  $in " << dpe_name << " "
						<< src_2_name << " 2" << endl;
					ofile << "$buffering  $out " << dpe_name << " "
						<< tgt_name << " 2" << endl;
				}
			}
		}
		else
		{
			// rename operation.
			vector<string> inwires;
			inwires.push_back(this->Get_VC_Root_Address_Name());

			vector<string> outwires;
			outwires.push_back(this->Get_VC_Word_Address_Name(0));

			Write_VC_Equivalence_Operator(this->Get_VC_Name() + "_addr_0",
					inwires,
					outwires,
					this->Get_VC_Guard_String(),
					ofile);
		}
	}
}



void AaObjectReference::Write_VC_Address_Calculation_Links(string hier_id,
		vector<AaExpression*>* indices,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{
	int offset_val = 0;
	if(indices)
		offset_val = this->Evaluate(indices,scale_factors, shift_factors);
	int base_addr = this->Get_Base_Address();

	vector<string> reqs;
	vector<string> acks;

	if(offset_val < 0 || base_addr < 0)
	{
		//  ofile << ";;[" << this->Get_VC_Name() << "_addr_gen] {" << endl;
		hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name() + "_addr_gen");

		this->Write_VC_Root_Address_Calculation_Links(hier_id,indices,scale_factors,shift_factors,ofile);

		// individual word addresses (in parallel)
		int nwords = (indices ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));
		if(nwords > 1)
		{
			hier_id = hier_id + "/words" ;
			for(int idx = 0; idx < nwords; idx++)
			{
				string sample_region = hier_id + "/word_" + IntToStr(idx) + "_sample"; 
				string update_region = hier_id + "/word_" + IntToStr(idx) + "_update"; 
				reqs.push_back(sample_region + "/rr");
				reqs.push_back(update_region + "/cr");
				acks.push_back(sample_region + "/ra");
				acks.push_back(update_region + "/ca");
				Write_VC_Link(this->Get_VC_Name() + "_addr_" + IntToStr(idx),
						reqs,
						acks,
						ofile);
				reqs.clear();
				acks.clear();
			}
		}
		else
		{
			// single word, no operation.. but rename it.
			// ofile << "$T [rename_req] $T [rename_ack]" << endl;
			reqs.push_back(hier_id + "/root_rename_req");
			acks.push_back(hier_id + "/root_rename_ack");
			Write_VC_Link(this->Get_VC_Name() + "_addr_0",
					reqs,
					acks,
					ofile);
			reqs.clear();
			acks.clear();
		}
	}
}




void AaObjectReference::Write_VC_Root_Address_Calculation_Control_Path(vector<AaExpression*>* index_vector,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{ 

	int offset_val = 0;
	if(index_vector)
		offset_val = this->Evaluate(index_vector,scale_factors, shift_factors);
	int base_addr = this->Get_Base_Address();


	bool all_indices_zero = (offset_val == 0);
	int num_non_constant = 0;
	bool const_index_flag = false;

	// if offset value is < 0, then it is not known at compile time.
	// calculate it at run time.
	if(offset_val < 0)
	{

		// indices will need to be scaled
		ofile << "||[scale_indices] {" << endl;

		for(int idx = 0; idx < index_vector->size(); idx++)
		{
			// if the index is a constant dont bother to compute it..
			if(!(*index_vector)[idx]->Is_Constant())
			{
				num_non_constant++;
				ofile << ";;[idx_" << IntToStr(idx) << "] {" << endl;
				(*index_vector)[idx]->Write_VC_Control_Path(ofile);

				if((*index_vector)[idx]->Get_Type()->Is_Uinteger_Type())
					ofile << "$T [index_resize_req] $T [index_resize_ack] // resize index to address-width" << endl;
				else
				{

					ofile << "||[index_resize_SplitProtocol] {" << endl;
					ofile << ";;[Sample] {" << endl;
					ofile << "$T [rr] $T [ra]" << endl;
					ofile << "}" << endl;
					ofile << ";;[Update] {" << endl;
					ofile << "$T [cr] $T [ca]" << endl;
					ofile << "}" << endl;
					ofile << "}" << endl;
				}

				if((*scale_factors)[idx] > 1)
				{

					ofile << "||[scale_index_SplitProtocol] {" << endl;
					ofile << ";;[Sample] {" << endl;
					ofile << "$T [scale_rr] $T [scale_ra]" << endl;
					ofile << "}" << endl;
					ofile << ";;[Update] {" << endl;
					ofile << "$T [scale_cr] $T [scale_ca]" << endl;
					ofile << "}" << endl;
					ofile << "}" << endl;
				}
				else
					ofile << "$T [scale_rename_req] $T [scale_rename_ack] // rename " << endl;

				ofile << "}" << endl;
			}
			else
			{
				const_index_flag = true;
			}
		}
		ofile << "}" << endl;

		// then add them up.
		ofile << ";;[add_indices] {" << endl;
		if(index_vector->size() > 1)
		{
			ofile << "||[SplitProtocol] { " << endl;
			int num_index_adds = (num_non_constant + (const_index_flag ? 1 : 0)) - 1;
			for(int idx = 1; idx <= num_index_adds; idx++)
			{
				string sample_region = "partial_sum_" + IntToStr(idx) + "_sample";
				string update_region = "partial_sum_" + IntToStr(idx) + "_update";
				ofile << ";;[" << sample_region << "] {" << endl;
				ofile << "$T [rr] $T [ra]" << endl;
				ofile << "}" << endl;
				ofile << ";;[" << sample_region << "] {" << endl;
				ofile << "$T [cr] $T [ca]" << endl;
				ofile << "}" << endl;
			}
			ofile << "}" << endl;
		}

		// the final index..
		ofile << "$T [final_index_req] $T [final_index_ack] // rename" << endl;
		ofile << "}" << endl;
	}

	// at this point you have a final-offset-index.
	// this needs to be added to a base address, which 
	// is either a constant (if _object is a declared storage object)
	if(base_addr < 0)
		// base is not constant, resize it to the required address width..
		// otherwise, we will just declare the base as a constant
		// with the required width
		ofile << "$T [base_resize_req] $T [base_resize_ack]" << endl;

	if(!all_indices_zero && (base_addr != 0))
	{
		// index was not zero and base was not zero..
		// we need to add two numbers, at most one of which
		// can be a constant..
		ofile << "||[base_plus_index_SplitProtocol] { " << endl;
		ofile << ";;[Sample] { " << endl;
		ofile << "$T [rr] $T [ra]" << endl;
		ofile << "}" << endl;
		ofile << ";;[Update] { " << endl;
		ofile << "$T [cr] $T [ca]" << endl;
		ofile << "}" << endl;
	}
	else 
		// at least one is zero.
		// just rename, no addition is needed.
		// the input operand is offset if it is non-zero, base if it is non-zero.
		ofile << "$T [sum_rename_req] $T [sum_rename_ack] // one gets through " << endl;
}


// A monster, and an ugly one....
// maybe it would have been better to convert the object reference itself
// into more expression nodes.. but...
void AaObjectReference::Write_VC_Root_Address_Calculation_Data_Path(vector<AaExpression*>* index_vector,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{
	int offset_val = 0;
	if(index_vector)
		offset_val = this->Evaluate(index_vector,scale_factors, shift_factors);
	int base_addr = this->Get_Base_Address();

	AaUintType* addr_type = AaProgram::Make_Uinteger_Type(this->Get_Address_Width());
	vector<AaExpression*> non_constant_indices;
	bool all_indices_zero = (offset_val == 0);
	bool const_index_flag = false;
	if(offset_val < 0 || base_addr < 0)
	{
		if(offset_val < 0)
		{ 
			// at least one index is not a constant.
			for(int idx = 0; idx < index_vector->size(); idx++)
			{
				// if the index is a constant dont bother to compute it..
				if(!(*index_vector)[idx]->Is_Constant())
				{
					AaExpression* iexpr = (*index_vector)[idx];
					iexpr->Write_VC_Datapath_Instances(NULL,ofile);

					non_constant_indices.push_back(iexpr);
				
					if((*index_vector)[idx]->Get_Type()->Is_Uinteger_Type())
					{
						// trivial processing..  dont waste
						// a register.
						vector<string> inputs;
						inputs.push_back(iexpr->Get_VC_Driver_Name());
						vector<string> outputs;
						outputs.push_back(iexpr->Get_VC_Name() + "_resized");
						Write_VC_Equivalence_Operator(
								this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_resize",
								inputs,
								outputs,
								this->Get_VC_Guard_String(),
								ofile);
					}
					else
					{
						string dpe_name = this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_resize";
						string src_name = iexpr->Get_VC_Driver_Name();
						string tgt_name = iexpr->Get_VC_Name() + "_resized";

						// resize index.
						Write_VC_Unary_Operator(__NOP,
								dpe_name,
								src_name,
								iexpr->Get_Type(),
								tgt_name,
								addr_type,
								this->Get_VC_Guard_String(),
								ofile);
						// extreme pipelining.
						if(this->Is_Part_Of_Extreme_Pipeline())
						{
							ofile << "$buffering  $in " << dpe_name << " "
								<< src_name << " 2" << endl;
							ofile << "$buffering  $out " << dpe_name << " "
								<< tgt_name << " 2" << endl;
						}
					}

					// scale index.
					if((*scale_factors)[idx] > 1)
					{
						string dpe_name = this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_scale";
						string src_1_name = iexpr->Get_VC_Name() + "_resized";
						string src_2_name = this->Get_VC_Offset_Scale_Factor_Name(idx);
						string tgt_name = iexpr->Get_VC_Name() + "_scaled";

						Write_VC_Binary_Operator(__MUL,
								this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_scale",
								iexpr->Get_VC_Name() + "_resized",
								addr_type,
								this->Get_VC_Offset_Scale_Factor_Name(idx),
								addr_type,
								iexpr->Get_VC_Name() + "_scaled",
								addr_type,
								this->Get_VC_Guard_String(),
								ofile);
						// extreme pipelining.
						if(this->Is_Part_Of_Extreme_Pipeline())
						{
							ofile << "$buffering  $in " << dpe_name << " "
								<< src_1_name << " 2" << endl;
							ofile << "$buffering  $in " << dpe_name << " "
								<< src_2_name << " 2" << endl;
							ofile << "$buffering  $out " << dpe_name << " "
								<< tgt_name << " 2" << endl;
						}
					}
					else
					{
						vector<string> inputs;
						inputs.push_back(iexpr->Get_VC_Name() + "_resized");
						vector<string> outputs;
						outputs.push_back(iexpr->Get_VC_Name() + "_scaled");
						Write_VC_Equivalence_Operator(this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_rename",
								inputs,
								outputs,
								this->Get_VC_Guard_String(),
								ofile);
					}
				}
				else
				{
					const_index_flag = true;
				}
			}


			string last_sum;

			if(const_index_flag)
				last_sum = this->Get_VC_Offset_Constant_Part_Name();
			else 
				last_sum = non_constant_indices[0]->Get_VC_Name() + "_scaled";

			// add indices.. chain of adders.
			int num_index_adds = (non_constant_indices.size() + (const_index_flag ? 1 : 0)) - 1;
			for(int idx = 1; idx <= num_index_adds; idx++)
			{

				AaExpression* expr;
				if(const_index_flag)
					expr = non_constant_indices[idx-1];	      
				else
					expr = non_constant_indices[idx];	      

				string dpe_name = this->Get_VC_Name() + "_index_sum_" + IntToStr(idx);
				string src_1_name = expr->Get_VC_Name() + "_scaled";
				string src_2_name = last_sum;
				string tgt_name = this->Get_VC_Name() + "_index_partial_sum_" + IntToStr(idx);

				Write_VC_Binary_Operator(__PLUS,
					  	dpe_name,
						src_1_name,
						addr_type,
						src_2_name,
						addr_type,
						tgt_name,	
						addr_type,
						this->Get_VC_Guard_String(),
						ofile);

				last_sum =  this->Get_VC_Name() + "_index_partial_sum_" + IntToStr(idx);

				// extreme pipelining.
				if(this->Is_Part_Of_Extreme_Pipeline())
				{
					ofile << "$buffering  $in " << dpe_name << " "
						<< src_1_name << " 2" << endl;
					ofile << "$buffering  $in " << dpe_name << " "
						<< src_2_name << " 2" << endl;
					ofile << "$buffering  $out " << dpe_name << " "
						<< tgt_name << " 2" << endl;
				}
			}

			vector<string> inputs;
			inputs.push_back(last_sum);
			vector<string> outputs;
			outputs.push_back(this->Get_VC_Offset_Name());

			Write_VC_Equivalence_Operator(this->Get_VC_Name() + "_offset_inst",
					inputs,
					outputs,
					this->Get_VC_Guard_String(),
					ofile);
		}


		if(base_addr < 0)
		{
			AaType* base_addr_type = this->Get_Base_Address_Type();
			if(!(base_addr_type->Is_Uinteger_Type() && addr_type->Is_Uinteger_Type()))
			{
				string dpe_name = this->Get_VC_Name() + "_base_resize";
				string src_name = this->Get_VC_Base_Address_Name();
				string tgt_name = this->Get_VC_Resized_Base_Address_Name();

				Write_VC_Unary_Operator(__NOP,
						dpe_name,
						src_name,
						base_addr_type,
						tgt_name,
						addr_type,
						this->Get_VC_Guard_String(),
						ofile);
				// extreme pipelining.
				if(this->Is_Part_Of_Extreme_Pipeline())
				{
					ofile << "$buffering  $in " << dpe_name << " "
						<< src_name << " 2" << endl;
					ofile << "$buffering  $out " << dpe_name << " "
						<< tgt_name << " 2" << endl;
				}
			}
			else
			{
				Write_VC_Equivalence_Operator(this->Get_VC_Name() + "_base_resize",				  
						this->Get_VC_Base_Address_Name(),					    
						this->Get_VC_Resized_Base_Address_Name(),
						this->Get_VC_Guard_String(),
						ofile);
			}
		}

		// the final sum
		if((offset_val != 0) && (base_addr != 0))
		{
			string dpe_name = this->Get_VC_Name() + "_root_address_inst";
			string src_1_name = this->Get_VC_Offset_Name();
			string src_2_name = this->Get_VC_Resized_Base_Address_Name();
			string tgt_name = this->Get_VC_Root_Address_Name();

			Write_VC_Binary_Operator(__PLUS,
					dpe_name,
					src_1_name,
					addr_type,
					src_2_name,
					addr_type,
					tgt_name,
					addr_type,
					this->Get_VC_Guard_String(),
					ofile);
			// extreme pipelining.
			if(this->Is_Part_Of_Extreme_Pipeline())
			{
				ofile << "$buffering  $in " << dpe_name << " "
					<< src_1_name << " 2" << endl;
				ofile << "$buffering  $in " << dpe_name << " "
					<< src_2_name << " 2" << endl;
				ofile << "$buffering  $out " << dpe_name << " "
					<< tgt_name << " 2" << endl;
			}
		}
		else
		{
			string op_name = ((base_addr != 0) ? (this->Get_VC_Resized_Base_Address_Name())
					: this->Get_VC_Offset_Name());
			Write_VC_Equivalence_Operator(this->Get_VC_Name() + "_root_address_inst",
					op_name,
					this->Get_VC_Root_Address_Name(),
					this->Get_VC_Guard_String(),
					ofile);

		}
	}
}

void AaObjectReference::Write_VC_Root_Address_Calculation_Links(string hier_id,
		vector<AaExpression*>* indices,
		vector<int>* scale_factors, vector<int>* shift_factors,
		ostream& ofile)
{
	int offset_val = 0;
	if(indices)
		offset_val = this->Evaluate(indices,scale_factors, shift_factors);
	int base_addr = this->Get_Base_Address();


	bool all_indices_zero = (offset_val == 0);
	int num_non_constant = 0;
	bool const_index_flag = false;

	vector<string> reqs;
	vector<string> acks;
	string inst_name;


	if(offset_val < 0)
	{
		string nhid = Augment_Hier_Id(hier_id,"scale_indices");

		/////// nhid
		for(int idx = 0; idx < indices->size(); idx++)
		{
			// if the index is a constant dont bother to compute it..
			if(!(*indices)[idx]->Is_Constant())
			{
				num_non_constant++;

				string nnhid = Augment_Hier_Id(nhid,"idx_" + IntToStr(idx));
				///// nnhid
				(*indices)[idx]->Write_VC_Links(nnhid,ofile);


				if((*indices)[idx]->Get_Type()->Is_Uinteger_Type())	      
				{
					reqs.push_back(nnhid + "/index_resize_req");
					acks.push_back(nnhid + "/index_resize_ack");
				}
				else
				{
					string sample_region = nnhid + "/index_resize_SplitProtocol/Sample";
					string update_region = nnhid + "/index_resize_SplitProtocol/Update";
					reqs.push_back(sample_region + "/rr");
					acks.push_back(sample_region + "/ra");
					reqs.push_back(update_region + "/cr");
					acks.push_back(update_region + "/ca");
				}
				inst_name = this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_resize";
				Write_VC_Link(inst_name,reqs,acks,ofile);
				reqs.clear();
				acks.clear();

				if((*scale_factors)[idx] > 1)
				{
					string sample_region = nnhid + "/scale_index_SplitProtocol/Sample";
					string update_region = nnhid + "/scale_index_SplitProtocol/Update";
					reqs.push_back(sample_region + "/rr");
					reqs.push_back(update_region + "/cr");
					acks.push_back(sample_region + "/ra");
					acks.push_back(update_region + "/ca");
					inst_name = this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_scale";
					Write_VC_Link(inst_name,reqs,acks,ofile);
					reqs.clear();
					acks.clear();
				}
				else
				{
					reqs.push_back(nnhid + "/scale_rename_req");
					acks.push_back(nnhid + "/scale_rename_ack");
					inst_name = this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_rename";
					Write_VC_Link(inst_name,reqs,acks,ofile);
					reqs.clear();
					acks.clear();
				}
			}
			else
				const_index_flag = true;
		}


		// then add them up.
		nhid = Augment_Hier_Id(hier_id, "add_indices");
		if(indices->size() > 1)
		{
			int num_index_adds = (num_non_constant + (const_index_flag ? 1 : 0)) - 1;
			for(int idx = 1; idx <= num_index_adds; idx++)
			{
				string sample_region = nhid + "/SplitProtocol/partial_sum_" + IntToStr(idx) + "_sample";
				string update_region = nhid + "/SplitProtocol/partial_sum_" + IntToStr(idx) + "_update";
				reqs.push_back(sample_region + "/rr");
				reqs.push_back(update_region + "/cr");
				acks.push_back(sample_region + "/ra");
				acks.push_back(update_region + "/ca");
				inst_name= this->Get_VC_Name() + "_index_sum_" + IntToStr(idx);
				Write_VC_Link(inst_name,reqs,acks,ofile);
				reqs.clear();
				acks.clear();
			}
		}


		// the final index..
		reqs.push_back(nhid + "/final_index_req");
		acks.push_back(nhid + "/final_index_ack");
		inst_name = this->Get_VC_Name() + "_offset_inst";
		Write_VC_Link(inst_name,reqs,acks,ofile);
		reqs.clear();
		acks.clear();
	}

	// back to hier_id.

	// at this point you have a final-offset-index.
	// this needs to be added to a base address, which 
	// is either a constant (if _object is a declared storage object)
	if(base_addr < 0)
	{
		// base is not constant, resize it to the required address width..
		// otherwise, we will just declare the base as a constant
		// with the required width
		reqs.push_back(hier_id + "/base_resize_req");
		acks.push_back(hier_id + "/base_resize_ack");
		inst_name = this->Get_VC_Name() + "_base_resize";
		Write_VC_Link(inst_name,reqs,acks,ofile);
		reqs.clear();
		acks.clear();
	}

	if(!all_indices_zero && (base_addr != 0))
	{
		// index was not zero and base was not zero..
		// we need to add two numbers, at most one of which
		// can be a constant..

		string sample_region = hier_id + "/base_plus_index_SplitProtocol/Sample";
		string update_region = hier_id + "/base_plus_index_SplitProtocol/Update";
		reqs.push_back(sample_region + "/rr");
		reqs.push_back(update_region + "/cr");
		acks.push_back(sample_region + "/ra");
		acks.push_back(update_region + "/ca");
		inst_name =  this->Get_VC_Name() + "_root_address_inst",
			  Write_VC_Link(inst_name,reqs,acks,ofile);
		reqs.clear();
		acks.clear();
	}
	else 
	{
		// at least one is zero.
		// just rename, no addition is needed.
		// the input operand is offset if it is non-zero, base if it is non-zero.
		reqs.push_back(hier_id + "/sum_rename_req");
		acks.push_back(hier_id + "/sum_rename_ack");
		inst_name = this->Get_VC_Name() + "_root_address_inst";
		Write_VC_Link(inst_name,reqs,acks,ofile);
		reqs.clear();
		acks.clear();
	}
}

string AaObjectReference::Get_VC_Memory_Space_Name()
{

	if(this->_object->Is_Storage_Object())
	{
		AaStorageObject* so = ((AaStorageObject*)(this->_object));
		return(so->Get_VC_Memory_Space_Name());
	}
	else if(this->_object->Is_Expression())
	{
		AaStorageObject* so = ((AaExpression*)(this->_object))->Get_Addressed_Object_Representative();
		return(so->Get_VC_Memory_Space_Name());
	}
}

int AaObjectReference::Get_VC_Memory_Space_Index()
{

	if(this->_object->Is_Storage_Object())
	{
		AaStorageObject* so = ((AaStorageObject*)(this->_object));
		return(so->Get_Mem_Space_Index());
	}
	else if(this->_object->Is_Expression())
	{
		AaStorageObject* so = ((AaExpression*)(this->_object))->Get_Addressed_Object_Representative();
		return(so->Get_Mem_Space_Index());
	}
}

// if the object reference is to an indexed expression..
int AaObjectReference::Get_Base_Address()
{
	if(this->_object->Is_Storage_Object())
	{
		AaStorageObject* so = ((AaStorageObject*)(this->_object));
		return(so->Get_Base_Address());
	}
	else if(this->_object->Is_Expression())
	{
		AaValue* eval = this->_object->Get_Expression_Value();
		if(eval != NULL)
			return(eval->To_Integer());
		else
			return(-1);
	}
	else
		return(-1);
}

// what is the access width?
int AaObjectReference::Get_Access_Width()
{
	assert(0);
}


int AaObjectReference::Get_Address_Width()
{
	AaStorageObject* so = NULL;
	if(this->_object->Is_Storage_Object())
	{
		so = ((AaStorageObject*)(this->_object));
	}
	else if(this->_object->Is_Expression())
	{
		so = ((AaExpression*)(this->_object))->Get_Addressed_Object_Representative();
		if(so == NULL)
			return(AaProgram::_foreign_address_width);
	}
	assert(so);
	return(so->Get_Address_Width());
}

string AaObjectReference::Get_VC_Base_Address_Name()
{
	if(this->_object->Is_Storage_Object())
	{
		AaStorageObject* so = ((AaStorageObject*)(this->_object));
		return(so->Get_VC_Base_Address_Name());
	}
	else if(this->_object->Is_Expression())
	{
		return(((AaExpression*)(this->_object))->Get_VC_Driver_Name());
	}
	else if(this->_object->Is("AaInterfaceObject"))
	{
		return(((AaObject*)(this->_object))->Get_VC_Name());
	}
}

string AaObjectReference::Get_VC_Offset_Scale_Factor_Name(int idx)
{
	return(this->Get_VC_Name() + "_offset_scale_factor_" + IntToStr(idx));
}

string AaObjectReference::Get_VC_Word_Offset_Name(int idx)
{
	return(this->Get_VC_Name() + "_word_offset_" + IntToStr(idx));
}

string AaObjectReference::Get_VC_Word_Address_Name(int idx)
{
	return(this->Get_VC_Name() + "_word_address_" + IntToStr(idx));
}

string AaObjectReference::Get_VC_Offset_Name()
{
	return(this->Get_VC_Name() + "_final_offset");
}
string AaObjectReference::Get_VC_Offset_Constant_Part_Name()
{
	return(this->Get_VC_Name() + "_constant_part_of_offset");
}
string AaObjectReference::Get_VC_Root_Address_Name()
{
	return(this->Get_VC_Name() + "_root_address");
}

// return as a uint.
AaType* AaObjectReference::Get_Base_Address_Type()
{
	assert(this->_object);
	if(this->Get_Object_Type() && this->Get_Object_Type()->Is_Pointer_Type())
	{
		return(AaProgram::Make_Uinteger_Type(AaProgram::_pointer_width));
	}
	else
	{
		return(AaProgram::Make_Uinteger_Type(this->Get_Address_Width()));
	}
}

int AaArrayObjectReference::Get_Base_Address()
{
	assert(this->_object);
	if(this->Get_Object_Type() && this->Get_Object_Type()->Is_Pointer_Type())
	{
		if(this->_object->Get_Expression_Value() != NULL)
			return(this->_object->Get_Expression_Value()->To_Integer());
		else
			return(-1);
	}
	else
		return(this->AaObjectReference::Get_Base_Address());
}


// what is the address width corresponding to 
// a memory-access or address calculation for a
// an indexed reference.
// 
// if _object has pointer type, then the
// address width is determined by the
// addressed object representative.
// 
// else if _object has non-pointer type,
// the address width is determined by the
// _object itself, since it must be 
// a storage object.
int AaArrayObjectReference::Get_Address_Width()
{
	AaStorageObject* so = NULL;
	assert(this->_object);
	if(this->Get_Object_Type() && this->Get_Object_Type()->Is_Pointer_Type())
	{
		so = this->Get_Addressed_Object_Representative();
		if(so == NULL || so->Is_Foreign_Storage_Object())
			return(AaProgram::_foreign_address_width);
	}
	else
	{
		assert(this->_object->Is_Storage_Object());
		so = ((AaStorageObject*) (this->_object));
	}
	assert(so != NULL);
	return(so->Get_Address_Width());
}


int AaArrayObjectReference::Get_Word_Size()
{
	AaStorageObject* so = NULL;
	assert(this->_object);
	if(this->Get_Object_Type() && this->Get_Object_Type()->Is_Pointer_Type())
	{
		so = this->Get_Addressed_Object_Representative();
		if(so == NULL || so->Is_Foreign_Storage_Object())
			return(AaProgram::_foreign_word_size);
	}
	else
	{
		assert(this->_object->Is_Storage_Object());
		so = ((AaStorageObject*) (this->_object));
	}
	assert(so != NULL);
	return(so->Get_Word_Size());
}


// what is the access width?
int AaArrayObjectReference::Get_Access_Width()
{
	assert(0);
}

string AaArrayObjectReference::Get_VC_Base_Address_Name()
{
	if(this->_object->Is_Storage_Object())
	{
		if(this->Get_Object_Type()->Is_Pointer_Type())
		{
			return(this->_pointer_ref->Get_VC_Driver_Name());
		}
		else
		{
			AaStorageObject* so = ((AaStorageObject*)(this->_object));
			return(so->Get_VC_Base_Address_Name());
		}
	}
	else if(this->_object->Is_Expression())
	{
		return(((AaExpression*)(this->_object))->Get_VC_Driver_Name());
	}
	else if(this->_object->Is("AaInterfaceObject"))
	{
		return(((AaObject*)(this->_object))->Get_VC_Name());
	}

	return("ErrorNoBaseAddress");
}

string AaPointerDereferenceExpression::Get_VC_Memory_Space_Name()
{
	AaStorageObject* obj = this->Get_Addressed_Object_Representative();
	if(obj != NULL)
	{
		return (obj->Get_VC_Memory_Space_Name());
	}
	else
	{
		AaRoot::Error("could not associate memory space with pointer ", this);
	}
	return("ErrorNoMemorySpace");
}

int AaPointerDereferenceExpression::Get_VC_Memory_Space_Index()
{
	AaStorageObject* obj = this->Get_Addressed_Object_Representative();
	if(obj != NULL)
	{
		return (obj->Get_Mem_Space_Index());
	}
	else
	{
		AaRoot::Error("could not associate memory space with pointer ", this);
	}
	return(-1);
}

int AaPointerDereferenceExpression::Get_Access_Width()
{
	assert(0);
}

int AaPointerDereferenceExpression::Get_Word_Size()
{
	AaStorageObject* obj = this->Get_Addressed_Object_Representative();
	if(obj != NULL)
	{
		return (obj->Get_Word_Size());
	}
	else
	{
		AaRoot::Error("could not associate memory space with pointer ", this);
	}
}

int AaPointerDereferenceExpression::Get_Address_Width()
{
	AaStorageObject* obj = this->Get_Addressed_Object_Representative();
	if(obj != NULL)
	{
		return (obj->Get_Address_Width());
	}
	else
	{
		AaRoot::Error("could not associate memory space with pointer ", this);
	}
}

int AaPointerDereferenceExpression::Get_Base_Address()
{
	if(this->_reference_to_object->Get_Expression_Value())
		return(this->_reference_to_object->Get_Expression_Value()->To_Integer());
	else
		return(-1);
}

AaType* AaPointerDereferenceExpression::Get_Base_Address_Type()
{
	return(this->_reference_to_object->Get_Base_Address_Type());
}

string AaPointerDereferenceExpression::Get_VC_Base_Address_Name()
{
	return(this->_reference_to_object->Get_VC_Driver_Name());
}


string AaAddressOfExpression::Get_VC_Memory_Space_Name()
{
	return(this->_storage_object->Get_VC_Memory_Space_Name());
}

int AaAddressOfExpression::Get_VC_Memory_Space_Index()
{
	return(this->_storage_object->Get_Mem_Space_Index());
}

int AaAddressOfExpression::Get_Base_Address()
{
	return this->_storage_object->Get_Base_Address();
}
int AaAddressOfExpression::Get_Access_Width()
{
	assert(0);
}
int AaAddressOfExpression::Get_Word_Size()
{
	return this->_storage_object->Get_Word_Size();
}
int AaAddressOfExpression::Get_Address_Width()
{
	return this->_storage_object->Get_Address_Width();
}
AaType* AaAddressOfExpression::Get_Base_Address_Type()
{
	return(AaProgram::Make_Uinteger_Type(this->Get_Address_Width()));
}
string AaAddressOfExpression::Get_VC_Base_Address_Name()
{
	return(this->_storage_object->Get_VC_Base_Address_Name());
}



