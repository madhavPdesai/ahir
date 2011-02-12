#ifndef __AA2VC__
#define __AA2VC__

#include <AaIncludes.h>
enum vcOperation
  {
    __VC_PLUS_OP          , 
    __VC_MINUS_OP         , 
    __VC_MUL_OP           , 
    __VC_DIV_OP           , 
    __VC_SHL_OP           , 
    __VC_SHR_OP           , 
    __VC_GT_OP            , 
    __VC_GE_OP            , 
    __VC_EQ_OP            , 
    __VC_LT_OP            , 
    __VC_LE_OP            , 
    __VC_UGT_OP           ,
    __VC_UGE_OP           ,
    __VC_ULT_OP           ,
    __VC_ULE_OP           ,
    __VC_NEQ_OP           , 
    __VC_UNORDERED_OP    ,
    __VC_BITSEL_OP        , 
    __VC_CONCAT_OP        , 
    __VC_BRANCH_OP        , 
    __VC_SELECT_OP       ,
    __VC_ASSIGN_OP           ,
    __VC_NOT_OP           ,
    __VC_OR_OP            ,
    __VC_AND_OP           ,
    __VC_XOR_OP           ,
    __VC_NOR_OP           ,
    __VC_NAND_OP          ,
    __VC_XNOR_OP          
  };

void Write_VC_Constant_Declaration(string wire_name, string type_name, string initial_value);
void Write_VC_Wire_Declaration(string wire_name, string type_name);
void Write_VC_Unary_Operator(vcOperation op, string inst_name, string src_name, string target_name);
void Write_VC_Binary_Operator(vcOperation op, string inst_name, string src1, string src2, string target_name);
void Write_VC_Call_Operator(string inst_name, string module_name, vector<string>& inargs, vector<string>& outargs);
void Write_VC_Phi_Operator(string inst_name,vector<string>& sources,string target);
void Write_VC_Link(string inst_name, vector<string>& reqs, vector<string>& acks);
void Write_VC_Link(string inst_name, vector<string>& reqs, string ack);
void Write_VC_Branch_Instance(string inst_name, vector<string>& br_input);

#endif
