/*
 * vc.g: the Ahir Virtual Circuit grammar
 *
 * Author: Madhav Desai
 *
 *
 */


header "post_include_cpp" {
}

header "post_include_hpp" {
#include <vcHeader.hpp>
#include <antlr/RecognitionException.hpp>
	ANTLR_USING_NAMESPACE(antlr)
}

options {
	language="Cpp";
}

class vcParser extends Parser;

options {
	// go with LL(2) grammar
	k=2;
	defaultErrorHandler=true;
} 
{
	void reportError(RecognitionException &re )
	{
		vcSystem::Error("Parsing Exception: " + re.toString());
	}
}

//-----------------------------------------------------------------------------------------------
// vc_System :  (vc_Module | vc_MemorySpace)+
//-----------------------------------------------------------------------------------------------
vc_System[vcSystem* sys]
{ 
	vcModule* nf = NULL;
	vcMemorySpace* ms = NULL;
}
:
(
 (nf = vc_Module[sys]) // module added to sys during rule match.
 |
 (ms = vc_MemorySpace[sys,NULL] {sys->Add_Memory_Space(ms);})
 |
 (vc_Pipe[sys])
 |
 (vc_Wire_Declaration[sys,NULL])
 )*
	;

//-----------------------------------------------------------------------------------------------
// vc_System :  PIPE vc_Label UINTEGER
//-----------------------------------------------------------------------------------------------
vc_Pipe[vcSystem* sys]
{
  string lbl;
}:  PIPE lbl = vc_Label  wid:UINTEGER {sys->Add_Pipe(lbl,atoi(wid->getText().c_str()));}
;


//--------------------------------------------------------------------------------------------------------------------------------------
// vc_MemorySpace:  MEMORYSPACE vc_Label  LBRACE vc_MemorySpaceParams (vc_MemoryLocation)* RBRACE
//--------------------------------------------------------------------------------------------------------------------------------------
vc_MemorySpace[vcSystem* sys, vcModule* m] returns[vcMemorySpace* ms]
{
	string lbl;
	ms = NULL;
}
: MEMORYSPACE lbl = vc_Label { ms = new vcMemorySpace(lbl,m);} LBRACE vc_MemorySpaceParams[ms] (vc_MemoryLocation[sys,ms])* RBRACE
;

//--------------------------------------------------------------------------------------------------------------------------------------
// vc_MemorySpaceParams:  CAPACITY UINTEGER DATAWIDTH UINTEGER ADDRWIDTH UINTEGER 
//--------------------------------------------------------------------------------------------------------------------------------------
vc_MemorySpaceParams[vcMemorySpace* ms]
: CAPACITY cap:UINTEGER {ms->Set_Capacity(atoi(cap->getText().c_str()));}
DATAWIDTH lau:UINTEGER {ms->Set_Word_Size(atoi(lau->getText().c_str()));}
ADDRWIDTH aw:UINTEGER {ms->Set_Address_Width(atoi(aw->getText().c_str()));}
;

//--------------------------------------------------------------------------------------------------------------------------------------
// vc_MemoryLocation:  OBJECT vc_Label COLON vc_Type 
//--------------------------------------------------------------------------------------------------------------------------------------
vc_MemoryLocation[vcSystem* sys, vcMemorySpace* ms]
{
	vcStorageObject* nl = NULL;
	string lbl;
	vcType* t;
	vcValue* v = NULL;
}
: OBJECT lbl = vc_Label COLON t = vc_Type[sys]
{
	nl = new vcStorageObject(lbl,t);
        ms->Add_Storage_Object(nl);
}
;

//--------------------------------------------------------------------------------------------------------------------------------------
// vc_Module :  MODULE vc_Label  LBRACE vc_Inargs vc_Outargs vc_MemorySpace* vc_Controlpath vc_Datapath? vc_Link* vc_AttributeSpec* RBRACE
//--------------------------------------------------------------------------------------------------------------------------------------
vc_Module[vcSystem* sys] returns[vcModule* m]
{
	string lbl;
	m = NULL;
        vcMemorySpace* ms;
}
: MODULE lbl = vc_Label { m = new vcModule(sys,lbl); sys->Add_Module(m);} 
  LBRACE (vc_Inargs[sys,m])? (vc_Outargs[sys,m])? 
  (ms = vc_MemorySpace[sys,m] {m->Add_Memory_Space(ms);})* 
   vc_Controlpath[sys,m] (vc_Datapath[sys,m])? (vc_Link[m])*
  (vc_AttributeSpec[m])* 
  RBRACE
;


//----------------------------------------------------------------------------------------------------------------------------------------
// vc_Link : vc_Identifier EQUIVALENT LPAREN vc_Hiearchical_CP_Ref+ RPAREN LPAREN vc_Hierarchical_CP_Ref+ RPAREN
//----------------------------------------------------------------------------------------------------------------------------------------
vc_Link[vcModule* m]
{
   vcDatapathElement* dpe;
   vector<string> ref_vec;
   vector<vcTransition*> reqs;
   vector<vcTransition*> acks;
}
:  dpeid:SIMPLE_IDENTIFIER 
       {
          dpe = m->Get_Data_Path()->Find_DPE(dpeid->getText()); 
          assert(dpe != NULL);
       }
       EQUIVALENT
        LPAREN  
         (vc_Hierarchical_CP_Ref[ref_vec] 
              { 
                 vcTransition* t = m->Get_Control_Path()->Find_Transition(ref_vec);
                 if(t != NULL)
                     {
                         reqs.push_back(t);
                     }
                 else
                    {

                        string tid;
                        for(int idx=0; idx < ref_vec.size();idx++)
                            {
                                if(idx > 0)
                                    tid += "/";
                                tid += ref_vec[idx];
                            }

                        vcSystem::Error("could not find transition " + tid + ": line " +
                                        IntToStr(dpeid->getLine()));
                    }
                 ref_vec.clear();

              }
          )+
        RPAREN
        LPAREN  
         ((vc_Hierarchical_CP_Ref[ref_vec] 
              { 
                 vcTransition* t = m->Get_Control_Path()->Find_Transition(ref_vec);
                 if(t != NULL)
                     {
                         acks.push_back(t);
                     }
                 else
                    {

                        string tid;
                        for(int idx=0; idx < ref_vec.size();idx++)
                            {
                                if(idx > 0)
                                    tid += "/";
                                tid += ref_vec[idx];
                            }

                        vcSystem::Error("could not find transition " + tid + ": line " +
                                        IntToStr(dpeid->getLine()));
                    }
                 ref_vec.clear();

            
                }
            )
           |
           (OPEN {acks.push_back(NULL);})
          )+
        RPAREN
   { m->Add_Link(dpe,reqs,acks);}
;


//-----------------------------------------------------------------------------------------------
// vc_Hierarchical_CP_Ref :  ( vc_Identifier DIV_OP )* vc_Identifier
//-----------------------------------------------------------------------------------------------
vc_Hierarchical_CP_Ref[vector<string>& ref_vec]
{
  string id;
}
: (id = vc_Identifier {ref_vec.push_back(id);} DIV_OP)* 
  ((id = vc_Identifier {ref_vec.push_back(id);}) |
   (entry_id:ENTRY {ref_vec.push_back(entry_id->getText());}) |
   (exit_id:EXIT {ref_vec.push_back(exit_id->getText());}))
;

//-----------------------------------------------------------------------------------------------
// vc_Controlpath: CONTROLPATH LBRACE (vc_CPRegion)+  vc_AttributeSpec* RBRACE
//-----------------------------------------------------------------------------------------------
vc_Controlpath[vcSystem* sys, vcModule* m]
{
	vcControlPath* cp = new vcControlPath(m->Get_Id() + "_CP");
}
: CONTROLPATH  LBRACE (vc_CPRegion[cp])* (vc_AttributeSpec[cp])* RBRACE {m->Set_Control_Path(cp);}
;

//-----------------------------------------------------------------------------------------------
// vc_CPElement: vc_CPPlace | vc_CPTransition
//-----------------------------------------------------------------------------------------------
vc_CPElement[vcCPElement* p] returns [vcCPElement* cpe]
: (cpe = vc_CPPlace[p]) | (cpe = vc_CPTransition[p]);


//-----------------------------------------------------------------------------------------------
// vc_CPPlace: PLACE vc_Label
//-----------------------------------------------------------------------------------------------
vc_CPPlace[vcCPElement* p] returns[vcCPElement* cpe]
{
  string id;
}
: PLACE id = vc_Label 
   {
         cpe = NULL;
         if(p->Find_CPElement(id) == NULL) 
              cpe = (vcCPElement*) new vcPlace(p, id,0);
   }
;


//-----------------------------------------------------------------------------------------------
// vc_CPTransition: TRANSITION vc_Label (IN | OUT | HIDDEN)
//-----------------------------------------------------------------------------------------------
vc_CPTransition[vcCPElement* p] returns[vcCPElement* cpe]
{ 
   string id;
}
: TRANSITION id = vc_Label
  {
    cpe = NULL;
    if(p->Find_CPElement(id) == NULL) 
       cpe = (vcCPElement*) (new vcTransition(p,id));
  }
  ;

//-----------------------------------------------------------------------------------------------
// vc_CPRegion: (vc_CPSeriesBlock | vc_CPParallelBlock | vc_CPBranchBlock | vc_CPForkBlock )
//-----------------------------------------------------------------------------------------------
vc_CPRegion[vcCPBlock* cp]
:
vc_CPSeriesBlock[cp] |
vc_CPParallelBlock[cp] |
vc_CPBranchBlock[cp] |
vc_CPForkBlock[cp] 
;

//-----------------------------------------------------------------------------------------------
// vc_CPSeriesBlock: SERIESBLOCK vc_Label LBRACE (vc_CPElement | vc_CPRegion)+ RBRACE
//-----------------------------------------------------------------------------------------------
vc_CPSeriesBlock[vcCPBlock* cp] 
{
	string lbl;
	vcCPSeriesBlock* sb;
	vcCPElement* cpe;
}
: SERIESBLOCK lbl = vc_Label { sb = new vcCPSeriesBlock(cp,lbl);} LBRACE 
(( cpe =  vc_CPElement[sb] { sb->Add_CPElement(cpe); }) | 
 ( vc_CPRegion[sb] ))* RBRACE
{ cp->Add_CPElement(sb); }
;

//-----------------------------------------------------------------------------------------------
// vc_CPParallelBlock: PARALLELBLOCK vcLabel LBRACE (vc_CPRegion)+ RBRACE
//-----------------------------------------------------------------------------------------------
vc_CPParallelBlock[vcCPBlock* cp] 
{
	string lbl;
	vcCPParallelBlock* sb;
	vcCPElement* cpe;
        vcCPElement* t;
}
: PARALLELBLOCK lbl = vc_Label { sb = new vcCPParallelBlock(cp,lbl);} LBRACE 
 ( vc_CPRegion[sb] | t = vc_CPTransition[sb] {sb->Add_CPElement(t);} )* RBRACE
{ cp->Add_CPElement(sb); }
;

//-----------------------------------------------------------------------------------------------
// vc_CPBranchBlock: BRANCHBLOCK vc_Label LBRACE (vc_CPRegion | vc_CPBranch | vc_CPMerge | vc_CPPlace)+ RBRACE
//-----------------------------------------------------------------------------------------------
vc_CPBranchBlock[vcCPBlock* cp] 
{
	string lbl;
	vcCPBranchBlock* sb;
	vcCPElement* cpe;
}
: BRANCHBLOCK lbl = vc_Label { sb = new vcCPBranchBlock(cp,lbl);} LBRACE 
(( vc_CPRegion[sb] ) | 
 ( vc_CPBranch[sb] ) |
 ( vc_CPMerge[sb] ) |
 (cpe = vc_CPPlace[sb] {sb->Add_CPElement(cpe);}) )+ RBRACE
{ cp->Add_CPElement(sb); }
;

//-----------------------------------------------------------------------------------------------
// vc_CPMerge: MERGE vc_Identifier LPAREN ENTRY? (vc_Identifier)* RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPMerge[vcCPBranchBlock* bb]
{ 
	string lbl,mid;
	string merge_region;
}
:
lbl = vc_Identifier  MERGE LPAREN  (e:ENTRY {bb->Add_Merge_Point(lbl,e->getText());})?
      (mid = vc_Identifier {bb->Add_Merge_Point(lbl,mid);})* RPAREN
;



//-----------------------------------------------------------------------------------------------
// vc_CPBranch: BRANCH vc_Identifier LPAREN EXIT? (vc_Identifier)*  RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPBranch[vcCPBranchBlock* bb]
{
	string lbl,b;
	vector<string> branch_ids;
}
:
lbl = vc_Identifier  BRANCH LPAREN (e:EXIT {branch_ids.push_back(e->getText());})?
(b =  vc_Identifier {branch_ids.push_back(b);})* {bb->Add_Branch_Point(lbl,branch_ids);} RPAREN
;

//-----------------------------------------------------------------------------------------------
// vc_CPForkBlock: FORKBLOCK vc_Label LBRACE (vc_CPFork | vc_CPRegion | vc_CPJoin | vc_CPTransition )+ RBRACE
//-----------------------------------------------------------------------------------------------
vc_CPForkBlock[vcCPBlock* cp] 
{
	string lbl;
	vcCPForkBlock* fb;
	vcCPElement* cpe;
}
: FORKBLOCK lbl = vc_Label { fb = new vcCPForkBlock(cp,lbl);} LBRACE 
 ((vc_CPRegion[fb]) | 
 ( vc_CPFork[fb] ) |
 ( vc_CPJoin[fb] ) | 
 ( cpe = vc_CPTransition[fb] { fb->Add_CPElement(cpe);} )  )+ RBRACE
{ cp->Add_CPElement(fb); }
;

//-----------------------------------------------------------------------------------------------
// vc_CPJoin: (vc_Identifier | EXIT) JOIN LPAREN  ENTRY? (vc_Idenitfier)+  RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPJoin[vcCPForkBlock* fb]
{
	string lbl,b;
	vector<string> join_ids;
}
:
((lbl = vc_Identifier) | (je:EXIT {lbl = je->getText();})) JOIN  LPAREN (e:ENTRY {join_ids.push_back(e->getText());})?
(b =  vc_Identifier {join_ids.push_back(b);})* RPAREN
 {fb->Add_Join_Point(lbl,join_ids);}
;

//-----------------------------------------------------------------------------------------------
// vc_CPFork: (vc_Identifier | ENTRY) FORK  LPAREN  EXIT? (vc_Identifier)+  RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPFork[vcCPForkBlock* fb]
{
	string lbl,b;
	vector<string> fork_ids;
}
:

((lbl = vc_Identifier) | (fe:ENTRY {lbl = fe->getText();})) FORK  LPAREN (e:EXIT {fork_ids.push_back(e->getText());})?
(b = vc_Identifier {fork_ids.push_back(b);})* RPAREN
 {fb->Add_Fork_Point(lbl,fork_ids);}
;

//-----------------------------------------------------------------------------------------------
// vc_Datapath: DATAPATH LBRACE 
// (vc_Wire_Declaration | vc_Operator_Instantiation | vc_Phi_Instantiation | vc_Call_Instantiation |
//                vc_LoadStore_Instantiation | vc_IOPort_Instantiation | vc_AttributeSpec[dp] )*  RBRACE
//-----------------------------------------------------------------------------------------------
vc_Datapath[vcSystem* sys,vcModule* m]
{
	vcDataPath* dp = new vcDataPath(m,m->Get_Id() + "_DP");
}
    : DATAPATH LBRACE ( vc_Wire_Declaration[sys,dp] | 
            vc_Operator_Instantiation[sys,dp] |
            vc_Phi_Instantiation[dp] |
            vc_Call_Instantiation[sys,dp] | 
            vc_IOPort_Instantiation[dp] |
            vc_LoadStore_Instantiation[sys,dp] |
            vc_AttributeSpec[dp])* RBRACE
 { m->Set_Data_Path(dp);}
;


//-----------------------------------------------------------------------------------------------------------------------------
// vc_Operator_Instantiation: vc_BinaryOperator_Instantiation | vc_UnaryOperator_Instantiation | vc_Select_Instantiation | vc_Branch_Instantiation | vc_Register_Instantiation
//----------------------------------------------------------------------------------------------------------------------------
vc_Operator_Instantiation[vcSystem* sys, vcDataPath* dp] : 
        vc_BinaryOperator_Instantiation[dp] |
        vc_UnaryOperator_Instantiation[dp] |
        vc_Select_Instantiation[dp] |
        vc_Branch_Instantiation[dp] |
        vc_Register_Instantiation[dp] |
        vc_Equivalence_Instantiation[dp] 
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_BinaryOperator_Instantiation: vc_BinaryOp vc_Label LPAREN vc_Identifier vc_Identifier RPAREN
//                                             LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_BinaryOperator_Instantiation[vcDataPath* dp] 
{
  vcBinarySplitOperator* new_op = NULL;
  string id;
  string op_id;
  string wid;
  vcWire* x = NULL;
  vcWire* y = NULL;
  vcWire* z = NULL;
  vcValue* val = NULL;
}
:
  ((plus_id: PLUS_OP {op_id = plus_id->getText();}) |
  (minus_id: MINUS_OP {op_id = minus_id->getText();}) |
  (mul_id: MUL_OP {op_id = mul_id->getText();}) |
  (div_id:DIV_OP {op_id = div_id->getText();}) |
  (shl_id:SHL_OP  {op_id = shl_id->getText();}) |
  (shr_id:SHR_OP  {op_id = shr_id->getText();}) |
  (gt_id:GT_OP  {op_id = gt_id->getText();}) |
  (ge_id:GE_OP  {op_id = ge_id->getText();}) |
  (eq_id:EQ_OP  {op_id = eq_id->getText();}) |
  (lt_id:LT_OP  {op_id = lt_id->getText();}) |
  (le_id:LE_OP  {op_id = le_id->getText();}) |
  (neq_id:NEQ_OP  {op_id = neq_id->getText();}) |
  (bitsel_id:BITSEL_OP  {op_id = bitsel_id->getText();}) |
  (concat_id:CONCAT_OP  {op_id = concat_id->getText();}) |
  (or_id:OR_OP  {op_id = or_id->getText();}) |
  (and_id:AND_OP  {op_id = and_id->getText();}) |
  (xor_id:XOR_OP  {op_id = xor_id->getText();}) |
  (nor_id:NOR_OP  {op_id = nor_id->getText();}) |
  (nand_id:NAND_OP  {op_id = nand_id->getText();}) |
  (xnor_id:XNOR_OP  {op_id = xnor_id->getText();})) id = vc_Label 
 LPAREN 
    wid = vc_Identifier {x = dp->Find_Wire(wid); assert(x != NULL);}
    wid = vc_Identifier {y = dp->Find_Wire(wid); assert(x != NULL);}
 RPAREN
 LPAREN
    wid = vc_Identifier {z = dp->Find_Wire(wid); assert(z != NULL);}
 RPAREN
 { new_op = new vcBinarySplitOperator(id,op_id,x,y,z); dp->Add_Split_Operator(new_op);}   
;


//-------------------------------------------------------------------------------------------------------------------------
// vc_UnaryOperator_Instantiation: vc_UnaryOp vc_Label LPAREN vc_Identifier RPAREN
//                                             LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_UnaryOperator_Instantiation[vcDataPath* dp] 
{
  vcUnarySplitOperator* new_op = NULL;
  string id;
  string op_id;
  string wid;
  vcWire* x = NULL;
  vcWire* z = NULL;
}
:
  (not_id: NOT_OP {op_id = not_id->getText();})
    id = vc_Label 
 LPAREN 
    wid = vc_Identifier {x = dp->Find_Wire(wid); assert(x != NULL);}
 RPAREN
 LPAREN
    wid = vc_Identifier {z = dp->Find_Wire(wid); assert(z != NULL);}
 RPAREN
 { new_op = new vcUnarySplitOperator(id,op_id,x,z); dp->Add_Split_Operator(new_op);}
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_Branch_Instantiation: BRANCH_OP vc_Label LPAREN (vc_Identifier)+ RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Branch_Instantiation[vcDataPath* dp] 
{
  vcBranch* new_op = NULL;
  string id;
  string wid;
  vector<vcWire*> wires;
  vcWire* x;
}
:
 BRANCH_OP id = vc_Label
 LPAREN 
    (wid = vc_Identifier {x = dp->Find_Wire(wid); assert(x != NULL); wires.push_back(x);})+
 RPAREN
 { new_op = new vcBranch(id,wires); dp->Add_Branch(new_op);}   
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_Select_Instantiation: SELECT_OP vc_Label LPAREN vc_Identifier vc_Identifier vc_Identifier RPAREN
//                                             LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Select_Instantiation[vcDataPath* dp] 
{
  vcSelect* new_op = NULL;
  string id;
  string op_id;
  string wid;
  vcWire* sel = NULL;
  vcWire* x = NULL;
  vcWire* y = NULL;
  vcWire* z = NULL;
  vcValue* val = NULL;
}
:
 SELECT_OP id = vc_Label
 LPAREN 
    wid = vc_Identifier {sel = dp->Find_Wire(wid); assert(sel != NULL);}
    wid = vc_Identifier {x = dp->Find_Wire(wid); assert(x != NULL);}
    wid = vc_Identifier {y = dp->Find_Wire(wid); assert(x != NULL);}
 RPAREN
 LPAREN
    wid = vc_Identifier {z = dp->Find_Wire(wid); assert(z != NULL);}
 RPAREN
 { new_op = new vcSelect(id,sel,x,y,z); dp->Add_Select(new_op);}   
;


//-------------------------------------------------------------------------------------------------------------------------
// vc_Register_Instantiation: ASSIGN_OP vc_Label LPAREN vc_Identifier RPAREN LPAREN vc_Identifier RPAREN

//-------------------------------------------------------------------------------------------------------------------------
vc_Register_Instantiation[vcDataPath* dp]
{
  vcRegister* new_reg = NULL;
  vcWire* x;
  vcWire* y;
  string id;
  string din;
  string dout;
}: ASSIGN_OP id = vc_Label LPAREN din = vc_Identifier { x = dp->Find_Wire(din); assert(x != NULL);} RPAREN
                           LPAREN dout = vc_Identifier { y = dp->Find_Wire(dout); assert(y != NULL);} RPAREN
   {  
      new_reg = new vcRegister(id, x, y); dp->Add_Register(new_reg);
   }
;
 

//-------------------------------------------------------------------------------------------------------------------------
// vc_Equivalence_Instantiation: EQUIVALENCE_OP vc_Label LPAREN vc_Identifier+ RPAREN LPAREN vc_Identifier+ RPAREN

//-------------------------------------------------------------------------------------------------------------------------
vc_Equivalence_Instantiation[vcDataPath* dp]
{
    string id;
    vcEquivalence* nm = NULL;
    vector<vcWire*> inwires;
    vector<vcWire*> outwires;
    vcWire* w;
    string wid;
}
    :
        EQUIVALENCE_OP id = vc_Label LPAREN
        (wid = vc_Identifier { w = dp->Find_Wire(wid); assert(w); inwires.push_back(w);})+
        RPAREN
        LPAREN
        (wid = vc_Identifier { w = dp->Find_Wire(wid); assert(w); outwires.push_back(w);})+
        RPAREN 
        {
            nm = new vcEquivalence(id,inwires,outwires);
            dp->Add_Equivalence(nm);
        }
    ;



//-------------------------------------------------------------------------------------------------------------------------
// vc_Call_Instantiation: CALL (INLINE)? vc_Label MODULE vc_Identifier 
//              LPAREN vc_Identifier* RPAREN LPAREN vc_Identifier* RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Call_Instantiation[vcSystem* sys, vcDataPath* dp]
{
  bool inline_flag;
  vcCall* nc = NULL;
  string id;
  string mid;
  vcModule* m;
  vector<vcWire*> inwires;
  vector<vcWire*> outwires;
}
:
  CALL (INLINE {inline_flag = true;})? id = vc_Label MODULE mid=vc_Identifier {m = sys->Find_Module(mid); assert(m != NULL);}
       LPAREN (mid = vc_Identifier {vcWire* w = dp->Find_Wire(mid); assert(w != NULL); inwires.push_back(w);})* RPAREN
       LPAREN (mid = vc_Identifier {vcWire* w = dp->Find_Wire(mid); assert(w != NULL); outwires.push_back(w);})* RPAREN
       { nc = new vcCall(id, m, inwires, outwires, inline_flag); dp->Add_Call(nc);} 
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_IOPort_Instantiation[dp]: IOPORT  (IN | OUT) vc_LABEL LPAREN vc_Identifier RPAREN LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_IOPort_Instantiation[vcDataPath* dp]
{
 string id, in_id, out_id, pipe_id;
 vcWire* w;
 bool in_flag = false;
}
: IOPORT (( IN {in_flag = true;})  | OUT)  id = vc_Label LPAREN in_id = vc_Identifier RPAREN 
    LPAREN out_id = vc_Identifier RPAREN
       {
          if(in_flag)
          {
            w = dp->Find_Wire(out_id);
            if(w == NULL)
               vcSystem::Error("could not find wire named " + out_id);

            pipe_id = in_id;
          }
          else
          {
            w = dp->Find_Wire(in_id);
            if(w == NULL)
               vcSystem::Error("could not find wire named " + in_id);
 
            pipe_id = out_id;
          }

          assert(w != NULL);
          if(w->Get_Type()->Size() != dp->Get_Parent()->Get_Parent()->Get_Pipe_Width(pipe_id))
             vcSystem::Error("Pipe " + pipe_id + " width does not match wire width on IOport " + id);

          if(in_flag)
          {
             vcInport* np = new vcInport(id,pipe_id,w);
             dp->Add_Inport(np);
          }
          else
          {
             vcOutport* np = new vcOutport(id,pipe_id,w);
             dp->Add_Outport(np);
          }
      }
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_LoadStore_Instantiation: vc_LoadInstantiation | vc_StoreInstantiation
//-------------------------------------------------------------------------------------------------------------------------
vc_LoadStore_Instantiation[vcSystem* sys, vcDataPath* dp]:
   vc_Load_Instantiation[sys,dp] | vc_Store_Instantiation[sys,dp]
;



//-------------------------------------------------------------------------------------------------------------------------
// vc_Load_Instantiation: LOAD vc_Label FROM (vc_Identifier DIV_OP)? vc_Identifier LPAREN vc_Identifier RPAREN LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Load_Instantiation[vcSystem* sys, vcDataPath* dp]
{
   string id, wid;
   string ms_id;
   string m_id = "";
   vcWire* addr;
   vcWire* data;
   vcMemorySpace* ms;
   bool is_load = false;
}
:  LOAD id = vc_Label FROM (m_id = vc_Identifier DIV_OP)? ms_id = vc_Identifier 
     {
       ms = sys->Find_Memory_Space(m_id,ms_id); 
       assert(ms != NULL);
     }
   LPAREN    wid = vc_Identifier {addr = dp->Find_Wire(wid); assert(addr != NULL);} RPAREN
   LPAREN    wid = vc_Identifier {data = dp->Find_Wire(wid); assert(data != NULL);} RPAREN
   {
         vcLoad* nl = new vcLoad(id, ms, addr, data);
         dp->Add_Load(nl);
   }
;


//-------------------------------------------------------------------------------------------------------------------------
// vc_Store_Instantiation: STORE vc_Label TO (vc_Identifier DIV_OP)? vc_Identifier LPAREN vc_Identifier vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Store_Instantiation[vcSystem* sys, vcDataPath* dp]
{
   string id, wid;
   string ms_id;
   string m_id = "";
   vcWire* addr;
   vcWire* data;
   vcMemorySpace* ms;
   bool is_load = false;
}
:  STORE id = vc_Label TO (m_id = vc_Identifier DIV_OP)? ms_id = vc_Identifier 
     {
       ms = sys->Find_Memory_Space(m_id,ms_id); 
       assert(ms != NULL);
     }
   LPAREN    wid = vc_Identifier {addr = dp->Find_Wire(wid); assert(addr != NULL);} 
             wid = vc_Identifier {data = dp->Find_Wire(wid); assert(data != NULL);} RPAREN
   {
         vcStore* ns = new vcStore(id, ms, addr, data);
         dp->Add_Store(ns);
   }
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_Phi_Instantiation: PHI vc_Label LPAREN ( vc_Identifier )+ RPAREN LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Phi_Instantiation[vcDataPath* dp]
{
  string lbl;
  string id;
  vcWire* tw;
  vcWire* outwire;
  vcPhi* phi;
  vector<vcWire*> inwires;
}: PHI lbl = vc_Label LPAREN ( id = vc_Identifier { tw = dp->Find_Wire(id); assert(tw != NULL); inwires.push_back(tw);})+ RPAREN
   LPAREN
   id = vc_Identifier 
    { 
         outwire = dp->Find_Wire(id); 
         assert(outwire != NULL); 
         phi = new vcPhi(lbl,inwires, outwire); 
         dp->Add_Phi(phi);
    }
  RPAREN
;

//-----------------------------------------------------------------------------------------------
// vc_Label : LBRACKET SIMPLE_IDENTIFIER RBRACKET
//-----------------------------------------------------------------------------------------------
vc_Label returns [string lbl]
:  LBRACKET
	(id:SIMPLE_IDENTIFIER  { lbl = id->getText(); })  
   RBRACKET
	;

//-----------------------------------------------------------------------------------------------
// vc_Inargs : IN (vc_Interface_Object_Declaration)* 
vc_Inargs[vcSystem* sys, vcModule* parent] 
{
	string mode = "in";
}
: IN (vc_Interface_Object_Declaration[sys, parent,mode])* 
;
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// vc_Outargs : OUT (vc_Interface_Object_Declaration)* 
//-----------------------------------------------------------------------------------------------
vc_Outargs[vcSystem* sys, vcModule* parent] 
{
	string mode = "out";
}
: OUT  (vc_Interface_Object_Declaration[sys,parent,mode])* 
;

//----------------------------------------------------------------------------------------------------------
// vc_Interface_Object_Declaration : vc_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------
vc_Interface_Object_Declaration[vcSystem* sys, vcModule* parent, string mode]
{
	vcType* t;
	vcValue* v;
	string obj_name;
}
: id: SIMPLE_IDENTIFIER {obj_name = id->getText();} COLON t = vc_Type[sys]
{ 
	parent->Add_Argument(obj_name,mode,t);
}
;

//----------------------------------------------------------------------------------------------------------
// vc_Object_Declaration_Base: vc_Label COLON vc_Type (ASSIGN_OP vc_Value)?
//----------------------------------------------------------------------------------------------------------
vc_Object_Declaration_Base[vcSystem* sys, vcType** t, string& obj_name, vcValue** v]
{
	vcType* tt = NULL;
	vcValue* vv = NULL;
        string oname;
}
: oname = vc_Label {obj_name = oname;} COLON tt = vc_Type[sys] {*t = tt;}
(ASSIGN_OP vv =  vc_Value[*t])? {if(v != NULL) *v = vv;}
;



//----------------------------------------------------------------------------------------------------------
// vc_Wire_Declaration: (CONSTANT)? WIRE vc_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------
vc_Wire_Declaration[vcSystem* sys,vcDataPath* dp]
{
	vcType* t;
        vcValue* v;
	string obj_name;
        bool const_flag = false;
        bool intermediate_flag = false;
}
:
((cid:CONSTANT {const_flag = true;}) | (iid:INTERMEDIATE {intermediate_flag = true;}) )? wid:WIRE vc_Object_Declaration_Base[sys, &t, obj_name, &v] 
     { 
        if(!const_flag) 
        {
           if(dp != NULL)
           {
              if(intermediate_flag)
                dp->Add_Intermediate_Wire(obj_name,t);
              else
                dp->Add_Wire(obj_name, t);
           }
           else
              sys->Error("Warning: wire declaration at system scope ignored: line number " + 
                            IntToStr(wid->getLine()));
        }
        else
        {
           if (v == NULL)
           {
              sys->Error("constant wire without specified value? line number " +
                           IntToStr(cid->getLine()));
           }
           else 
           {
             if(dp != NULL)
                dp->Add_Constant_Wire(obj_name,v);
             else
                sys->Add_Constant_Wire(obj_name,v);
           }
        }
     }
;


//----------------------------------------------------------------------------------------------------------
// vc_Value: (vc_IntValue | vc_FloatValue) | (LPAREN vc_Value (COMMA vc_Value)* RPAREN)
//----------------------------------------------------------------------------------------------------------
vc_Value[vcType* t] returns [vcValue* v]
{
	v = NULL;
	string v_string;
	int idx = 0;
	vector<vcType*> etypes;
	vector<vcValue*> evalues;
	vcValue* ev;

	if(t->Is("vcArrayType"))
		etypes.push_back(((vcArrayType*)t)->Get_Element_Type());
	else if(t->Is("vcRecordType"))
	{
		int i;
		for(i = 0; i < ((vcRecordType*)t)->Get_Number_Of_Elements(); i++)
			etypes.push_back(((vcRecordType*)t)->Get_Element_Type(i));
	}
}:
(v = vc_IntValue[t] | v = vc_FloatValue[t]) | 
(
 sid: LPAREN 
 ev = vc_Value[etypes[idx]] {evalues.push_back(ev);} 
 (COMMA {if(t->Is("vcRecordType")) idx++;} ev = vc_Value[etypes[idx]] {evalues.push_back(ev);})*

 { 
 if(t->Is("vcRecordType")) 
 v = (vcValue*) (new vcRecordValue((vcRecordType*)t,evalues));
 else 
 if(t->Is("vcArrayType")) v = (vcValue*) (new vcArrayValue((vcArrayType*)t,evalues));
 else 
 vcSystem::Error("composite value specified for scalar type");
 }
 RPAREN
 )
;


//----------------------------------------------------------------------------------------------------------
// vc_IntValue: BINARYSTRING | HEXSTRING
//----------------------------------------------------------------------------------------------------------
vc_IntValue[vcType* t] returns[vcValue* v]
{
	string vstring;
	string format;
	assert(t->Is("vcIntType") || t->Is("vcPointerType"));
}: ((bid: BINARYSTRING { vstring = bid->getText(); format = "binary";} ) |
(hid: HEXSTRING { vstring = hid->getText(); format = "hexadecimal";}))
{
	v = (vcValue*) (new vcIntValue((vcIntType*)t,vstring.substr(2),format));
}
;

//----------------------------------------------------------------------------------------------------------
// vc_FloatValue: (MINUS)?  "C" vc_IntValue "M" vc_IntValue
//----------------------------------------------------------------------------------------------------------
vc_FloatValue[vcType* t] returns[vcValue* v]
{
	string vstring;
	string format;
	assert(t->Is("vcFloatType"));
	char sign_value = 0;
	vcValue* cv;
	vcValue* mv;
        assert(t != NULL && t->Is("vcFloatType"));
}:  (MINUS {sign_value = 1;})? "C" cv = vc_IntValue[((vcFloatType*)t)->Get_Characteristic_Type()] "M" mv = vc_IntValue[((vcFloatType*)t)->Get_Mantissa_Type()]
{
	v = (vcValue*) (new vcFloatValue((vcFloatType*)t,sign_value, (vcIntValue*)cv, (vcIntValue*)mv));
}
;

//----------------------------------------------------------------------------------------------------------
// vc_Type : vc_ScalarType | vc_ArrayType | vc_RecordType 
//----------------------------------------------------------------------------------------------------------
vc_Type[vcSystem* sys] returns[vcType* t]
: ((t =  vc_ScalarType[sys] ) | (t =  vc_ArrayType[sys] ) | (t =  vc_RecordType[sys] )) ;

//----------------------------------------------------------------------------------------------------------
// vc_ScalarType : vc_IntType | vc_FloatType | vc_PointerType 
//----------------------------------------------------------------------------------------------------------
vc_ScalarType[vcSystem* sys] returns[vcType* t]
: (t =  vc_IntType[sys] ) | (t = vc_FloatType[sys]) | (t =  vc_PointerType[sys] ) ;

//----------------------------------------------------------------------------------------------------------
// vc_IntType : INT LT_OP UINTEGER GT_OP
//----------------------------------------------------------------------------------------------------------
vc_IntType[vcSystem* sys] returns [vcType* t]
{
	vcIntType* it;
	unsigned int w;
}
: INT LT_OP i:UINTEGER {w = atoi(i->getText().c_str());} GT_OP {it = Make_Integer_Type(w); t = (vcType*)it;}
;

//----------------------------------------------------------------------------------------------------------
// vc_FloatType: FLOAT LT_OP UINTEGER COMMA UINTEGER GT_OP
//----------------------------------------------------------------------------------------------------------
vc_FloatType[vcSystem* sys] returns [vcType* t]
{
	vcFloatType* ft;
	unsigned int c,m;
}
: FLOAT LT_OP cid:UINTEGER {c = atoi(cid->getText().c_str());} COMMA mid:UINTEGER {m = atoi(mid->getText().c_str());}
GT_OP {ft = Make_Float_Type(c,m); t = (vcType*)ft;}
;


//----------------------------------------------------------------------------------------------------------
// vc_PointerType : POINTER LT_OP (vc_Identifier DIV_OP)? vc_Identifier GT_OP
//----------------------------------------------------------------------------------------------------------
vc_PointerType[vcSystem* sys] returns [vcType* t]
{ 
	vcPointerType* pt;
        string scope_id, space_id;
}:
POINTER LT_OP (sid:SIMPLE_IDENTIFIER DIV_OP {scope_id = sid->getText();})? mid:SIMPLE_IDENTIFIER
{space_id = mid->getText(); pt = Make_Pointer_Type(sys, scope_id,space_id); t = (vcType*) pt;} 
GT_OP
;
//----------------------------------------------------------------------------------------------------------
// vc_Array_Type: ARRAY (LBRACKET UINTEGER RBRACKET) OF vc_ScalarType
//----------------------------------------------------------------------------------------------------------
vc_ArrayType[vcSystem* sys] returns [vcType* t]
{
	vcArrayType* at;
	vcType* et;
	unsigned int dimension;
}: ARRAY LBRACKET dim: UINTEGER {dimension = atoi(dim->getText().c_str());} RBRACKET OF et = vc_Type[sys]
{ at = Make_Array_Type(et,dimension); t = (vcType*) at;}
;

//----------------------------------------------------------------------------------------------------------
// vc_Record_Type: Record (LPAREN (vc_Type) (COMMA vc_Type)*  RPAREN)
//----------------------------------------------------------------------------------------------------------
vc_RecordType[vcSystem* sys] returns [vcType* t]
{
	vcRecordType* rt;
	vcType* et;
	vector<vcType*> etypes;
}: RECORD LBRACKET (et = vc_Type[sys] {etypes.push_back(et);}) (COMMA t = vc_Type[sys] {etypes.push_back(et);})* RBRACKET
{ rt = Make_Record_Type(etypes); t = (vcType*) rt; etypes.clear();}
;

//----------------------------------------------------------------------------------------------------------
// vc_AttributeSpec: ATTRIBUTE (SIMPLE_IDENTIFIER IMPLIES QUOTED_STRING) 
//----------------------------------------------------------------------------------------------------------
vc_AttributeSpec[vcRoot* m]
{
	string key;
	string value;
}
:
ATTRIBUTE  kid: SIMPLE_IDENTIFIER {key = kid->getText();} IMPLIES vid:QUOTED_STRING { value = vid->getText();} 
{  m->Add_Attribute(key,value);}

;


//----------------------------------------------------------------------------------------------------------
// vc_Identifier: SIMPLE_IDENTIFIER
//----------------------------------------------------------------------------------------------------------
vc_Identifier returns [string s]: id:SIMPLE_IDENTIFIER { s = id->getText();};

// lexer rules
class vcLexer extends Lexer;

options {
	k = 6;
	testLiterals = true;
	charVocabulary = '\3'..'\377';
	defaultErrorHandler=true;
}

// language keywords (all start with $)
ATTRIBUTE     : "$attribute";
DPE           : "$dpe";
LIBRARY       : "$lib";
MEMORYSPACE   : "$memoryspace";
OBJECT        : "$object";
CAPACITY      : "$capacity";
DATAWIDTH     : "$datawidth";
ADDRWIDTH     : "$addrwidth";
MODULE        : "$module";
SERIESBLOCK   : ";;";
PARALLELBLOCK : "||";
FORKBLOCK     : "::";
BRANCHBLOCK   : "<>";
OF            : "$of";
FORK          : "&->";
JOIN          : "<-&";
BRANCH        : "|->";
MERGE         : "<-|";
ENTRY         : "$entry";
EXIT          : "$exit";
IN            : "$in";
OUT           : "$out";
REQS          : "$reqs";
ACKS          : "$acks";
TRANSITION    : "$T";
PLACE         : "$P";
HIDDEN        : "$hidden";
PARAMETER     : "$parameter";
PORT          : "$port";
MAP           : "$map";
DATAPATH      : "$DP";
CONTROLPATH   : "$CP";
WIRE          : "$W";
MIN           : "$min";
MAX           : "$max";
DPEINSTANCE   : "$dpeinstance";
LINK          : "$link";
PHI           : "$phi";
LOAD          : "$load";
STORE         : "$store";
TO            : "$to";
CALL          : "$call";
INLINE        : "$inline";
IOPORT        : "$ioport";
PIPE          : "$pipe";
FROM          : "$from";
AT            : "$at";
CONSTANT      : "$constant";
INTERMEDIATE  : "$intermediate";


// Special symbols
COLON		 : ':' ; // label separator
COMMA            : ',' ; // argument-separator, index-separator etc.
IMPLIES          : "=>"; 
EQUIVALENT       : "<=>";
LBRACE           : '{' ; // scope open
RBRACE           : '}' ; // scope close
LBRACKET         : '[' ; // array index marker
RBRACKET         : ']' ; // array index marker
LPAREN           : '(' ; // argument-list
RPAREN           : ')' ; // argument-list


// types
INT            : "$int"     ;
FLOAT          : "$float"   ;
POINTER        : "$pointer" ;
ARRAY          : "$array";
RECORD         : "$record";

// operators
PLUS_OP          : "+";
MINUS_OP         : "-";
MUL_OP           : "*";
DIV_OP           : '/'; // note: character literal
SHL_OP           : "<<";
SHR_OP           : ">>";
GT_OP            : ">";
GE_OP            : ">=";
EQ_OP            : "==";
LT_OP            : "<";
LE_OP            : "<=";
UGT_OP           : "|>|";
UGE_OP           : "|>=|";
ULT_OP           : "|<|";
ULE_OP           : "|<=|";
NEQ_OP           : "!=";
UNORDERED_OP     : "><";
BITSEL_OP        : "[]";
CONCAT_OP        : "&&";
BRANCH_OP        : "==0?";
SELECT_OP        : "?";
ASSIGN_OP        : ":="; 
NOT_OP           : "~";
OR_OP            : "|";
AND_OP           : "&";
XOR_OP           : "^";
NOR_OP           : "~|";
NAND_OP          : "~&";
XNOR_OP          : "~^";

EQUIVALENCE_OP    : "&/";

OPEN             : "$open";

// data format
UINTEGER          : DIGIT (DIGIT)*;

// White spaces (only "\n" is newline)
WHITESPACE: (	' ' |'\t' | '\f' | '\r' | '\n' { newline(); } ) 
{ 
	$setType(ANTLR_USE_NAMESPACE(antlr)Token::SKIP); 
}
;

// Comment: anything which follows //
SINGLELINECOMMENT:
( 
 "//" (~'\n')* '\n' { newline(); }
 ) 
{ 
	$setType(ANTLR_USE_NAMESPACE(antlr)Token::SKIP); 
}
;

BINARYSTRING : '_' 'b' ('0' | '1')+;

HEXSTRING    : '_' 'h' (DIGIT | 'a' | 'b' | 'c' | 'd' | 'e' | 'f')+;

QUOTED_STRING : '"' (ALPHA | DIGIT | '_' | ' ' | '.' | '\t' )* '"';

// Scope-id
HIERARCHICAL_IDENTIFIER : ':' (SIMPLE_IDENTIFIER)? ':' SIMPLE_IDENTIFIER ;

// Identifiers
SIMPLE_IDENTIFIER options {testLiterals=true;} : ALPHA (ALPHA | DIGIT | '_')*; 

// base
protected ALPHA: 'a'..'z'|'A'..'Z';
protected DIGIT:'0'..'9';

