/*
 * vc.g: the Ahir Virtual Circuit grammar
 *
 * Author: Madhav Desai
 *
 *
 */


header "post_include_cpp" {
#include <string.h>
}

header "post_include_hpp" {
#include <string.h>
#include <vcHeader.hpp>
#include <antlr/RecognitionException.hpp>
	ANTLR_USING_NAMESPACE(antlr)
#define NOT_FOUND__(str, w, wid,token_id)      if(w == NULL)\
         vcSystem::Error(string("did not find ") + str + " " +  wid + ": line " + IntToStr(token_id->getLine()));
}

options {
	language="Cpp";
}

class vcParser extends Parser;

options {
	// go with LL(3) grammar
	k=3;
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
 vc_GatedClock[sys]
 |
 (nf = vc_Module[sys]) // module added to sys during rule match.
 |
 (ms = vc_MemorySpace[sys,NULL] {sys->Add_Memory_Space(ms);})
 |
 (vc_Pipe[sys,NULL])
 |
 (vc_Wire_Declaration[sys,NULL])
 |
 (vc_SysAttributeSpec[sys])
 |
 (vc_SysBufferingSpec[sys])
 )*
	;

//-----------------------------------------------------------------------------------------------
// vc_GatedClock :  (LIFO | NOBLOCK)? PIPE vc_Label UINTEGER
//-----------------------------------------------------------------------------------------------
vc_GatedClock [vcSystem* sys]
{
   string gc_name, enable_name;
}:
    GATED_CLOCK gcid: SIMPLE_IDENTIFIER eid: SIMPLE_IDENTIFIER
    	{
		gc_name = gcid->getText();
		enable_name = eid->getText();
		sys->Add_Gated_Clock(gc_name, enable_name);
	}
;


//-----------------------------------------------------------------------------------------------
// vc_Pipe :  (LIFO | NOBLOCK)? PIPE vc_Label UINTEGER
//-----------------------------------------------------------------------------------------------
vc_Pipe[vcSystem* sys, vcModule* m]
{
  string lbl;
  int depth = 1;
  bool lifo_mode = false;
  bool noblock_mode = false;
  bool in_flag = false;
  bool out_flag = false;
  bool port_flag = false;
  bool signal_flag = false;
  bool p2p_flag = false;
  bool full_rate = false;
  bool shiftreg_flag = false;
  bool bypass_flag = false;
}:  ((LIFO {lifo_mode = true;}) | (NOBLOCK {noblock_mode = true;}))? 
	(SHIFTREG {shiftreg_flag = true;})?
	PIPE lbl = vc_Label  wid:UINTEGER  (DEPTH did:UINTEGER {depth = atoi(did->getText().c_str()); })?
	( IN {in_flag = true;} | OUT {out_flag = true;} )?
	(SIGNAL {signal_flag = true;})?
	(P2P {p2p_flag = true;})?
	(FULLRATE {full_rate = true;})?
	(BYPASS {bypass_flag = true;})?
        {
            if (sys) 
                sys->Add_Pipe(lbl,atoi(wid->getText().c_str()),depth, lifo_mode, noblock_mode, in_flag, out_flag, signal_flag, p2p_flag, shiftreg_flag, full_rate, bypass_flag);
            else if(m)
                m->Add_Pipe(lbl,atoi(wid->getText().c_str()),depth, lifo_mode, noblock_mode,  in_flag, out_flag, signal_flag, p2p_flag, shiftreg_flag,full_rate, bypass_flag);
        } 
;


//--------------------------------------------------------------------------------------------------------------------------------------
// vc_MemorySpace:  MEMORYSPACE vc_Label  LBRACE vc_MemorySpaceParams (vc_MemoryLocation)* RBRACE
//--------------------------------------------------------------------------------------------------------------------------------------
vc_MemorySpace[vcSystem* sys, vcModule* m] returns[vcMemorySpace* ms]
{
	string lbl;
	bool unordered_flag = false;
	ms = NULL;
}
: MEMORYSPACE (UNORDERED {unordered_flag = true;})? 
	lbl = vc_Label 
	{ 
		ms = new vcMemorySpace(lbl,m);
		ms->Set_Ordered_Flag(!unordered_flag);
	} LBRACE vc_MemorySpaceParams[ms] (vc_MemoryLocation[sys,ms])* 
        (vc_AttributeSpec[ms])*
        RBRACE
;

//--------------------------------------------------------------------------------------------------------------------------------------
// vc_MemorySpaceParams:  CAPACITY UINTEGER DATAWIDTH UINTEGER ADDRWIDTH UINTEGER MAXACCESSWIDTH UINTEGER
//--------------------------------------------------------------------------------------------------------------------------------------
vc_MemorySpaceParams[vcMemorySpace* ms]
: CAPACITY cap:UINTEGER {ms->Set_Capacity(atoi(cap->getText().c_str()));}
DATAWIDTH lau:UINTEGER {ms->Set_Word_Size(atoi(lau->getText().c_str()));}
ADDRWIDTH aw:UINTEGER {ms->Set_Address_Width(atoi(aw->getText().c_str()));}
MAXACCESSWIDTH maw:UINTEGER {ms->Set_Max_Access_Width(atoi(maw->getText().c_str()));}
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
// vc_Module : (FOREIGN | PIPELINE)? (OPERATOR | MODULE)?  MODULE vc_Label  LBRACE vc_Inargs vc_Outargs vc_MemorySpace* vc_Pipe* vc_Controlpath vc_Datapath? vc_Link* vc_AttributeSpec* RBRACE
//--------------------------------------------------------------------------------------------------------------------------------------
vc_Module[vcSystem* sys] returns[vcModule* m]
{
	string lbl;
	m = NULL;
    bool foreign_flag = false;
    bool pipeline_flag = false;
    bool operator_flag = false;
    bool volatile_flag = false;
    vcMemorySpace* ms;
    int depth = 1;
    int buffering = 1;
    bool full_rate_flag = false;
    bool deterministic_flag = false;
    bool use_once_flag = false;
    bool use_gated_clock = false;
    string gated_clock_name;
}
    : 
	(USE_GATED_CLOCK {use_gated_clock = true;} (gcid:SIMPLE_IDENTIFIER {gated_clock_name = gcid->getText();})?)?
        ((FOREIGN {foreign_flag = true;}) | 
	  (PIPELINE {pipeline_flag = true;} 
		(DEPTH did: UINTEGER {depth = atoi(did->getText().c_str());})? 
		(BUFFERING bid: UINTEGER {buffering = atoi(bid->getText().c_str());})? 
		(FULLRATE {full_rate_flag = true;})? 
		(DETERMINISTIC {deterministic_flag = true;})? 
	))?
	((OPERATOR {operator_flag = true;} ) | (VOLATILE {volatile_flag = true;}))?
	(USEONCE {use_once_flag = true;})?
        MODULE lbl = vc_Label 
        { 
            m = new vcModule(sys,lbl); 
            sys->Add_Module(m); 
            if(foreign_flag) m->Set_Foreign_Flag(true);
            if(pipeline_flag) { 
		m->Set_Pipeline_Flag(true); 
		m->Set_Pipeline_Depth(depth);
		m->Set_Pipeline_Buffering(buffering);
		m->Set_Pipeline_Full_Rate_Flag(full_rate_flag);
		m->Set_Pipeline_Deterministic_Flag(deterministic_flag);
	    }
	    m->Set_Operator_Flag(operator_flag);
	    m->Set_Volatile_Flag(volatile_flag);
	    m->Set_Use_Once_Flag(use_once_flag);
            m->Set_Use_Gated_Clock(use_gated_clock, gated_clock_name);
        } 
        LBRACE (vc_Inargs[sys,m])? (vc_Outargs[sys,m])? 
        (vc_Pipe[NULL,m])*
        (ms = vc_MemorySpace[sys,m] {m->Add_Memory_Space(ms);})* 
        (vc_Controlpath[sys,m] { assert(!foreign_flag);})? 
        (vc_Datapath[sys,m] {assert(!foreign_flag);})? 
        (vc_Link[m] {assert(!foreign_flag);})*
        (vc_AttributeSpec[m])* 
    RBRACE
    {
	if(pipeline_flag)
		m->Get_Control_Path()->Set_Pipeline_Parent(m->Get_Control_Path());
    }
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
          NOT_FOUND__("datapath-element",dpe,dpeid->getText(),dpeid)
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
                        NOT_FOUND__("transition",t,tid,dpeid)
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

                        NOT_FOUND__("transition",t,tid,dpeid)
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
    vcControlPath* cp;
    cp = new vcControlPath(m->Get_Id() + "_CP");
    cp->Set_Parent_Module(m);
    vcCPElement* cpe;
}
: CONTROLPATH  LBRACE 
	( (
        vc_CPPipelinedForkBlock[cp,m] 
		{	
			assert(m->Get_Pipeline_Flag());
			cp->Set_Is_Pipelined(true);
			cp->Set_Pipeline_Depth(m->Get_Pipeline_Depth());
			cp->Set_Pipeline_Buffering(m->Get_Pipeline_Buffering());
			cp->Set_Pipeline_Full_Rate_Flag(m->Get_Pipeline_Full_Rate_Flag());
		}
        (cpe = vc_CPPlace[cp] { cp->Add_CPElement(cpe); })*
        (vc_CPBind[cp])* ) | 
	((vc_CPRegion[cp])+ (vc_AttributeSpec[cp])*) )? RBRACE 
{
	m->Set_Control_Path(cp);
}
;

//-----------------------------------------------------------------------------------------------
// vc_CPElement: vc_CPPlace | vc_CPTransition
//-----------------------------------------------------------------------------------------------
vc_CPElement[vcCPElement* p] returns [vcCPElement* cpe]
: (cpe = vc_CPPlace[p]) | (cpe = vc_CPTransition[p]);

//-----------------------------------------------------------------------------------------------
// vc_CPAlias: ALIAS SIMPLE_IDENTIFIER SIMPLE_IDENTIFIER 
//-----------------------------------------------------------------------------------------------
vc_CPAlias[vcCPElement* p]
{
	string alias_id, reference_id;
}
: ALIAS alias_id = vc_Label reference_id = vc_Label
	{
		p->Add_Alias (alias_id, reference_id);
	}

;



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
   (LEFT_OPEN  {cpe->Set_Is_Left_Open(true);})?
;


//-----------------------------------------------------------------------------------------------
// vc_CPTransition: TRANSITION vc_Label (DEAD)?
//-----------------------------------------------------------------------------------------------
vc_CPTransition[vcCPElement* p] returns[vcCPElement* cpe]
{ 
   string id;
   bool dead_flag = false;
   bool tie_high = false;
   bool leave_open = false;
   bool delay_flag = false;
}
: TRANSITION id = vc_Label ( (DEAD {dead_flag = true;} ) | (TIED_HIGH {tie_high = true;})
		| (LEFT_OPEN {leave_open = true;}) | (DELAY {delay_flag = true;} ) ) ?
  {
    cpe = NULL;
    if(p->Find_CPElement(id) == NULL) 
    {
       cpe = (vcCPElement*) (new vcTransition(p,id));
	((vcTransition*)cpe)->Set_Is_Dead(dead_flag);
	((vcTransition*)cpe)->Set_Is_Tied_High(tie_high);
	((vcTransition*)cpe)->Set_Is_Left_Open(leave_open);
	((vcTransition*)cpe)->Set_Is_Delay_Element(delay_flag);
    }
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
 ( vc_CPRegion[sb] ) | (vc_AttributeSpec[sb] ) )* RBRACE
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
 ( vc_CPRegion[sb] | t = vc_CPTransition[sb] {sb->Add_CPElement(t);} |
            (vc_AttributeSpec[sb]) )* RBRACE
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
 ( vc_CPSimpleLoopBlock[sb] ) |
 (cpe = vc_CPPlace[sb] {sb->Add_CPElement(cpe);}) |
            (vc_AttributeSpec[sb]) )+ RBRACE
{ cp->Add_CPElement(sb); }
;

//-----------------------------------------------------------------------------------------------
// vc_CPSimpleLoopBlock: LOOPBLOCK vc_Label DEPTH UINTEGER BUFFERING UINTEGER  LBRACE ... RBRACE (see below)
//-----------------------------------------------------------------------------------------------
vc_CPSimpleLoopBlock[vcCPBlock* cp] 
{
	string lbl;
	vcCPSimpleLoopBlock* sb;
	vcCPElement* cpe;
	int depth, buffering;
 	bool full_rate_flag = false;
}
: LOOPBLOCK lbl = vc_Label { sb = new vcCPSimpleLoopBlock(cp,lbl);} 
	DEPTH did: UINTEGER {depth = atoi(did->getText().c_str()); sb->Set_Pipeline_Depth(depth); }
	BUFFERING bid: UINTEGER {buffering = atoi(bid->getText().c_str()); sb->Set_Pipeline_Buffering(buffering); }
	( FULLRATE {full_rate_flag = true;})?
  LBRACE 
        (cpe = vc_CPPlace[sb] {sb->Add_CPElement(cpe);})* // first the places
        vc_CPPipelinedLoopBody[sb] // then the loop body..
        (vc_CPSeriesBlock[sb])+ // then the series blocks to trigger branches and receive acks.
        (vc_CPMerge[sb])+  // merge places.
        (vc_CPBranch[sb])+ // a branch places
        // all special elements from here on..
        (vc_CPBind[sb])*
        vc_CPLoopTerminate[sb]  
  RBRACE
         { cp->Add_CPElement(sb);  sb->Set_Pipeline_Full_Rate_Flag(true); sb->Set_Pipeline_Parent(sb); }
;

//-----------------------------------------------------------------------------------------------
// vc_CPLoopTerminate: TERMINATE LPAREN vc_Identifier vc_Identifier vc_Identifier RPAREN LPAREN vc_Identifier vc_Identifier RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPLoopTerminate[vcCPSimpleLoopBlock* slb] 
{
 	string loop_exit, loop_taken, loop_body, loop_back, exit_place;
}
:  TERMINATE LPAREN 
	loop_exit = vc_Identifier 
	loop_taken = vc_Identifier 
	loop_body = vc_Identifier RPAREN 
   LPAREN 
	loop_back  = vc_Identifier 
	exit_place = vc_Identifier 
   RPAREN
   { slb->Set_Loop_Termination_Information(loop_exit, loop_taken, loop_body, loop_back, exit_place); }
;


//-----------------------------------------------------------------------------------------------
// vc_CPPhiSequencer: PHISEQUENCER vcLabel 
//      COLON (vc_Identifier vc_Indentifier vc_Indentifier vc_Identifier vc_Indentifier)+  // triggers
//      COLON vcIdentifier vcIdentifier vcIdentifier vcIdentifier 			   // phi-split proto.
//      COLON vcIdentifier vcIdentifier							   // phi-mux reqs
//      COLON vcIdentifier								   // phi-mux ack
//-----------------------------------------------------------------------------------------------
vc_CPPhiSequencer[vcCPPipelinedLoopBody* slb] 
{
    vector<string> triggers;
    vector<string> src_sample_reqs;
    vector<string> src_sample_acks;
    vector<string> src_update_reqs;
    vector<string> src_update_acks;
    string phi_sample_req, phi_sample_ack, phi_update_req, phi_update_ack;
    vector<string> phi_mux_reqs;
    string phi_mux_ack;
    string lbl;
    string tmp_string;
}
:  PHISEQUENCER lbl = vc_Label 
	COLON
        ( 
		tmp_string = vc_Identifier {triggers.push_back(tmp_string);}
		tmp_string = vc_Identifier {src_sample_reqs.push_back(tmp_string);}
		tmp_string = vc_Identifier {src_sample_acks.push_back(tmp_string);}
		tmp_string = vc_Identifier {src_update_reqs.push_back(tmp_string);}
		tmp_string = vc_Identifier {src_update_acks.push_back(tmp_string);}
	)+
        COLON
        ( 
		phi_sample_req = vc_Identifier
		phi_sample_ack = vc_Identifier
		phi_update_req = vc_Identifier
		phi_update_ack = vc_Identifier
	)
        COLON
	(
      		tmp_string = vc_Identifier {phi_mux_reqs.push_back(tmp_string);}
	)+
        COLON
       		phi_mux_ack = vc_Identifier 
   	{ 
		slb->Add_Phi_Sequencer(lbl, 
					triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks,
					phi_sample_req, phi_sample_ack, phi_update_req, phi_update_ack,
					phi_mux_reqs, phi_mux_ack);
	}
;




//-----------------------------------------------------------------------------------------------
// vc_CPTransitionMerge: TRANSITIONMERGE vc_Label LPAREN vc_Identifier+ RPAREN 
//                               LPAREN vc_Identifier RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPTransitionMerge[vcCPPipelinedLoopBody* slb] 
{
    string tm_id;
    vector<string> in_transitions;
    string out_transition;
    string tmp_string;
}
:  TRANSITIONMERGE tm_id = vc_Label LPAREN 
        ( tmp_string = vc_Identifier {in_transitions.push_back(tmp_string);})+
        RPAREN
        LPAREN
        out_transition = vc_Identifier
        RPAREN
   { slb->Add_Transition_Merge(tm_id, in_transitions, out_transition); }
;

//-----------------------------------------------------------------------------------------------
// vc_CPBind: BIND vc_Identifier vc_Identifier COLON vc_Identifier;
//-----------------------------------------------------------------------------------------------
vc_CPBind[vcCPBlock* cp]
{
	string pl_lbl, rgn_label, rgn_internal_lbl;
    bool input_binding;
}
: BIND pl_id : SIMPLE_IDENTIFIER ( ( IMPLIES { input_binding = true; } ) | (ULE_OP {input_binding = false;}) )  
	rgn_id: SIMPLE_IDENTIFIER
	COLON 
	rgn_internal_id: SIMPLE_IDENTIFIER
  {
	cp->Bind(pl_id->getText(),rgn_id->getText(),rgn_internal_id->getText(),input_binding);
  }
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
// vc_CPForkBlock: FORKBLOCK vc_Label LBRACE (vc_CPFork | vc_CPRegion | vc_CPJoin | vc_CPTransition )+ RBRACE (LPAREN (vc_Identifier  IMPLIES vc_Identifier)+ RPAREN)?
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
 ( cpe = vc_CPTransition[fb] { fb->Add_CPElement(cpe);} ) |
        (vc_AttributeSpec[fb])  )* RBRACE
{ cp->Add_CPElement(fb);}
;

//-----------------------------------------------------------------------------------------------
// vc_CPPipelinedForkBlock: PIPELINEDFORKBLOCK vc_Label LBRACE (vc_CPFork | vc_CPRegion | vc_CPJoin | vc_CPTransition )+ RBRACE (LPAREN (vc_Identifier  IMPLIES vc_Identifier)+ RPAREN)?
//-----------------------------------------------------------------------------------------------
vc_CPPipelinedForkBlock[vcCPBlock* cp, vcModule* m] 
{
	string lbl;
	vcCPPipelinedForkBlock* fb;
	vcCPElement* cpe;
    	string internal_id;
}
: PIPELINEDFORKBLOCK lbl = vc_Label { fb = new vcCPPipelinedForkBlock(cp,lbl); fb->Set_Max_Iterations_In_Flight(m->Get_Pipeline_Depth());} LBRACE 
 (
	(vc_CPRegion[fb]) | 
 	( vc_CPFork[fb] ) |
 	( vc_CPJoin[fb] ) | 
 	( vc_CPMarkedJoin[fb] ) | 
	( vc_CPSccArc [fb]   ) | 
 	( cpe = vc_CPTransition[fb] { fb->Add_CPElement(cpe);} ) |
 	(vc_AttributeSpec[fb])  
 )* RBRACE
{ cp->Add_CPElement(fb); fb->Set_Pipeline_Parent(fb);}
( LPAREN ( internal_id = vc_Identifier { fb->Add_Exported_Input(internal_id);})* RPAREN ) 
( LPAREN ( internal_id = vc_Identifier { fb->Add_Exported_Output(internal_id);})* RPAREN ) 
;

//-----------------------------------------------------------------------------------------------
// vc_CPPipelinedLoopBody: PIPELINE vc_Label LBRACE (vc_CPFork | vc_CPRegion | vc_CPJoin | vc_CPMarkedJoin | vc_CPTransition )+ 
//                                            RBRACE (LPAREN vc_Identifier+ RPAREN) (LPAREN vc_Identifier+ RPAREN)
//-----------------------------------------------------------------------------------------------
vc_CPPipelinedLoopBody[vcCPBlock* cp] 
{
    string lbl;
    vcCPPipelinedLoopBody* fb;
    vcCPElement* cpe;
    string internal_id, external_id;
    bool pipeline_flag = false;
}
: PIPELINE lbl = vc_Label { fb = new vcCPPipelinedLoopBody(cp,lbl);} LBRACE 
 ((vc_CPRegion[fb]) | 
            ( vc_CPFork[fb] ) |
            ( vc_CPJoin[fb] ) | 
            ( vc_CPMarkedJoin[fb] ) | 
            ( cpe = vc_CPTransition[fb] { fb->Add_CPElement(cpe);} ) |
            ( vc_CPPhiSequencer[fb]) |
            ( vc_CPTransitionMerge[fb]) |
 	    ( vc_CPAlias[fb] ) | 
 	    ( vc_CPSccArc[fb] ) | 
            (vc_AttributeSpec[fb]) 
 )* RBRACE
{ cp->Add_CPElement(fb); fb->Set_Pipeline_Parent(fb);}
( LPAREN ( internal_id = vc_Identifier { fb->Add_Exported_Input(internal_id);})* RPAREN ) 
( LPAREN ( internal_id = vc_Identifier { fb->Add_Exported_Output(internal_id);})* RPAREN ) 
;


//-----------------------------------------------------------------------------------------------
// vc_CPJoin: (vc_Identifier | EXIT | ENTRY | NULL) JOIN LPAREN  ENTRY? EXIT? (vc_Identifier)+  RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPJoin[vcCPForkBlock* fb]
{
	string lbl,b;
	vector<string> join_ids;
}
:
((lbl = vc_Identifier) | 
	(je:EXIT {lbl = je->getText();}) | 
	(jen:ENTRY {lbl = jen->getText();}) |
	(jnull:N_ULL {lbl = jnull->getText();})
   ) JOIN  
   LPAREN 
	(e:ENTRY {join_ids.push_back(e->getText());})?
	(ee:EXIT {join_ids.push_back(ee->getText());})?
(b =  vc_Identifier {join_ids.push_back(b);})* RPAREN
 {fb->Add_Join_Point(lbl,join_ids);}
;

//-----------------------------------------------------------------------------------------------
// vc_CPMarkedJoin: (vc_Identifier | EXIT | NULL) MARKEDJOIN LPAREN  ENTRY? EXIT? (vc_Identifier)+  RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPMarkedJoin[vcCPPipelinedForkBlock* fb]
{
	string lbl,b;
	vector<string> join_ids;
	vector<int>  join_markings;
//
// TODO: join markings need to be established here..
//
}
:
((lbl = vc_Identifier) | 
	(je:ENTRY {lbl = je->getText();}) |
	(jnull:N_ULL {lbl = jnull->getText();})
	) MARKEDJOIN  LPAREN 
		(e:ENTRY {join_ids.push_back(e->getText());} 
                  me:UINTEGER {join_markings.push_back(atoi(me->getText().c_str()));})?
		(ee:EXIT {join_ids.push_back(ee->getText());} 
                  mee:UINTEGER {join_markings.push_back(atoi(mee->getText().c_str()));})?
(b =  vc_Identifier {join_ids.push_back(b);} be:UINTEGER {join_markings.push_back(atoi(be->getText().c_str())); } )* RPAREN
 {fb->Add_Marked_Join_Point(lbl,join_ids, join_markings);}
;

//-----------------------------------------------------------------------------------------------
// vc_CPSccArc: vc_Identifier SCC_ARC vc_Identifier
//-----------------------------------------------------------------------------------------------
vc_CPSccArc[vcCPBlock* fb]
{
	string tail_lbl;
	string head_lbl;
}
:
	SCC_ARC
	((tail_lbl = vc_Identifier) | (ENTRY {tail_lbl = "$entry";}) | (EXIT {tail_lbl = "$exit";}))
	IMPLIES
	((head_lbl = vc_Identifier) | (ENTRY {head_lbl = "$entry";}) | (EXIT {head_lbl = "$exit";}))
	{
		fb->Add_Scc_Arc (tail_lbl, head_lbl);
	}
;

//-----------------------------------------------------------------------------------------------
// vc_CPFork: (vc_Identifier | ENTRY ) FORK  LPAREN NULL? EXIT? (vc_Identifier)+  RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPFork[vcCPForkBlock* fb]
{
	string lbl,b;
	vector<string> fork_ids;
}
:

((lbl = vc_Identifier) | (fe:ENTRY {lbl = fe->getText();}) | (N_ULL {lbl = "$null";} )) FORK  LPAREN 
	(e:EXIT {fork_ids.push_back(e->getText());})?
	(n:N_ULL {fork_ids.push_back(n->getText());})?
(b = vc_Identifier {fork_ids.push_back(b);})* RPAREN
 {fb->Add_Fork_Point(lbl,fork_ids);}
;

//-----------------------------------------------------------------------------------------------
// vc_Datapath: DATAPATH LBRACE 
// (vc_Wire_Declaration | vc_Operator_Instantiation | vc_Branch_Instantiation |  vc_Phi_Instantiation | vc_Call_Instantiation |
//                vc_LoadStore_Instantiation | vc_IOPort_Instantiation | vc_AttributeSpec[dp] | vc_ModuleBufferingSpec[m] )*  RBRACE
//-----------------------------------------------------------------------------------------------
vc_Datapath[vcSystem* sys,vcModule* m]
{
	vcDataPath* dp = new vcDataPath(m,m->Get_Id() + "_DP");
	m->Set_Data_Path(dp);
}
    : DATAPATH LBRACE ( vc_Wire_Declaration[sys,dp] | 
            vc_Guarded_Operator_Instantiation[sys,dp] |
            vc_Branch_Instantiation[dp] |
            vc_Phi_Instantiation[dp] | 
            vc_PhiPipelined_Instantiation[dp] | 
	    vc_AttributeSpec[dp] | vc_ModuleBufferingSpec[m]  | vc_ModuleDelaySpec[m] |
		vc_PipelineSpec[dp] )*
            RBRACE
;

//-----------------------------------------------------------------------------------------------------------------------------
// WAR? vc_Identifier
//-----------------------------------------------------------------------------------------------------------------------------

vc_Wire_Connection [vector<bool>& war_flags, vcDataPath* dp ] returns [vcWire* w]
{
   string wid;
   w = NULL;
   bool wflag = false;
}:
  (WAR {wflag = true;})?
	wid = vc_Identifier 
	{ 
		w = dp->Find_Wire(wid); 
		war_flags.push_back(wflag);
	}
;

//-----------------------------------------------------------------------------------------------------------------------------
// vc_Guarded_Operator_Instantiation: vc_BinaryOperator_Instantiation | vc_UnaryOperator_Instantiation | vc_Select_Instantiation | vc_Branch_Instantiation | vc_Register_Instantiation
//----------------------------------------------------------------------------------------------------------------------------
vc_Guarded_Operator_Instantiation[vcSystem* sys, vcDataPath* dp]
{
  	vcWire* guard_wire = NULL;
  	bool guard_complement = false;
	string gwid;
	vcDatapathElement* dpe = NULL;
	vector<bool> wvec;
}:
  (dpe=vc_Operator_Instantiation[dp] |
            dpe=vc_Call_Instantiation[sys,dp] | 
            dpe=vc_IOPort_Instantiation[dp] |
            dpe=vc_LoadStore_Instantiation[sys,dp] )
  (gid:GUARD LPAREN ( NOT_OP {guard_complement = true;} )? guard_wire = vc_Wire_Connection [wvec,dp]
	RPAREN 
  )?
	{
		if((dpe != NULL) && (guard_wire != NULL))
		{
			dpe->Set_Guard_Wire(guard_wire);
			dpe->Set_Guard_Complement(guard_complement);
			dpe->Set_Guard_WAR_Flag(wvec[0]);
		}
	}
 (FLOWTHROUGH {dpe->Set_Flow_Through(true);} )?
 (FULLRATE {dpe->Set_Full_Rate(true);} )?

;
	
//-----------------------------------------------------------------------------------------------------------------------------
// vc_Operator_Instantiation: vc_BinaryOperator_Instantiation | vc_UnaryOperator_Instantiation | vc_Select_Instantiation | vc_Slice_Instantiation | vc_Register_Instantiation | vc_InterlockBuffer_Instantiation 
//----------------------------------------------------------------------------------------------------------------------------
vc_Operator_Instantiation[vcDataPath* dp] returns[vcDatapathElement* dpe]
:
        (dpe=vc_BinaryOperator_Instantiation[dp] |
        dpe=vc_UnaryOperator_Instantiation[dp] |
        dpe=vc_Select_Instantiation[dp] |
        dpe=vc_Slice_Instantiation[dp] |
        dpe=vc_Register_Instantiation[dp] |
        dpe=vc_Equivalence_Instantiation[dp] | 
        dpe=vc_Bitmap_Instantiation[dp] | 
        dpe=vc_InterlockBuffer_Instantiation[dp] )
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_BinaryOperator_Instantiation: vc_BinaryOp vc_Label LPAREN vc_Identifier vc_Identifier RPAREN
//                                             LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_BinaryOperator_Instantiation[vcDataPath* dp] returns[vcDatapathElement* dpe]
{
  vcBinarySplitOperator* new_op = NULL;
  string id;
  string op_id;
  string wid;
  vcWire* x = NULL;
  vcWire* y = NULL;
  vcWire* z = NULL;
  vcValue* val = NULL;

  vector<bool> war_flags;
}
:
  ((plus_id: PLUS_OP {op_id = plus_id->getText();}) |
  (minus_id: MINUS_OP {op_id = minus_id->getText();}) |
  (mul_id: MUL_OP {op_id = mul_id->getText();}) |
  (div_id:DIV_OP {op_id = div_id->getText();}) |
  (shl_id:SHL_OP  {op_id = shl_id->getText();}) |
  (shr_id:SHR_OP  {op_id = shr_id->getText();}) |
  (rol_id:ROL_OP  {op_id = rol_id->getText();}) |
  (ror_id:ROR_OP  {op_id = ror_id->getText();}) |
  (gt_id:UGT_OP  {op_id = gt_id->getText();}) |
  (ge_id:UGE_OP  {op_id = ge_id->getText();}) |
  (eq_id:EQ_OP  {op_id = eq_id->getText();}) |
  (lt_id:ULT_OP  {op_id = lt_id->getText();}) |
  (le_id:ULE_OP  {op_id = le_id->getText();}) |
  (neq_id:NEQ_OP  {op_id = neq_id->getText();}) |
  (bitsel_id:BITSEL_OP  {op_id = bitsel_id->getText();}) |
  (concat_id:CONCAT_OP  {op_id = concat_id->getText();}) |
  (unordered_id:UNORDERED_OP  {op_id = unordered_id->getText();}) |
  (or_id:OR_OP  {op_id = or_id->getText();}) |
  (and_id:AND_OP  {op_id = and_id->getText();}) |
  (xor_id:XOR_OP  {op_id = xor_id->getText();}) |
  (nor_id:NOR_OP  {op_id = nor_id->getText();}) |
  (nand_id:NAND_OP  {op_id = nand_id->getText();}) |
  (xnor_id:XNOR_OP  {op_id = xnor_id->getText();}) |
  (shra_id:SHRA_OP  {op_id = shra_id->getText();}) |
  (sgt_id:SGT_OP  {op_id = sgt_id->getText();}) |
  (sge_id:SGE_OP  {op_id = sge_id->getText();}) |
  (slt_id:SLT_OP  {op_id = slt_id->getText();}) |
  (sle_id:SLE_OP  {op_id = sle_id->getText();})) id = vc_Label 
 lpid: LPAREN 
    x = vc_Wire_Connection [war_flags, dp]
     {
        NOT_FOUND__("wire",x,wid,lpid);
     }
    y = vc_Wire_Connection[war_flags, dp]
     {
       NOT_FOUND__("wire", y,wid,lpid);
     }
 RPAREN
 lpid2: LPAREN
    wid = vc_Identifier 
     {
       z = dp->Find_Wire(wid);
       NOT_FOUND__("wire", z,wid,lpid2);
     }
 RPAREN
 { 	new_op = new vcBinarySplitOperator(id,op_id,x,y,z); 

	dp->Add_Split_Operator(new_op); 
	dpe = (vcDatapathElement*)new_op; 
	dpe->Set_Input_WAR_Flags(war_flags);
 }
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_UnaryOperator_Instantiation: vc_UnaryOp vc_Label LPAREN vc_Identifier RPAREN
//                                             LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_UnaryOperator_Instantiation[vcDataPath* dp] returns[vcDatapathElement* dpe]
{
  vcUnarySplitOperator* new_op = NULL;
  string id;
  string op_id;
  string wid;
  vcWire* x = NULL;
  vcWire* z = NULL;
  vector<bool> war_flags;
}
:

  // losts of unary assignment forms are possible!
  ((not_id: NOT_OP {op_id = not_id->getText();}) |
   (ss_assign_id: StoS_ASSIGN_OP {op_id = ss_assign_id->getText();}) |
   (su_assign_id: StoU_ASSIGN_OP {op_id = su_assign_id->getText();}) |
   (us_assign_id: UtoS_ASSIGN_OP {op_id = us_assign_id->getText();}) |
   (fs_assign_id: FtoS_ASSIGN_OP {op_id = fs_assign_id->getText();}) |
   (fu_assign_id: FtoU_ASSIGN_OP {op_id = fu_assign_id->getText();}) |
   (sf_assign_id: StoF_ASSIGN_OP {op_id = sf_assign_id->getText();}) |
   (uf_assign_id: UtoF_ASSIGN_OP {op_id = uf_assign_id->getText();}) |
   (ff_assign_id: FtoF_ASSIGN_OP {op_id = ff_assign_id->getText();}) |
   (dec_assign_id: DECODE_OP     {op_id = dec_assign_id->getText();}) |
   (enc_assign_id: ENCODE_OP     {op_id = enc_assign_id->getText();}) |
   (p_enc_assign_id: P_ENCODE_OP {op_id = p_enc_assign_id->getText();}) |
   (bitreduce_or_assign_id: BITREDUCE_OR_OP {op_id = bitreduce_or_assign_id->getText();}) |
   (bitreduce_and_assign_id: BITREDUCE_AND_OP {op_id = bitreduce_and_assign_id->getText();}) |
   (bitreduce_xor_assign_id: BITREDUCE_XOR_OP {op_id = bitreduce_xor_assign_id->getText();}) |
  )
    id = vc_Label 
 lpid: LPAREN 
    x = vc_Wire_Connection[war_flags,dp] {
      NOT_FOUND__("wire",x,wid,lpid)
     }
 RPAREN
 lpid2: LPAREN
    wid = vc_Identifier 
    {
       z = dp->Find_Wire(wid); 
       NOT_FOUND__("wire", z,wid,lpid2)
    }
 RPAREN
    { 
	new_op = new vcUnarySplitOperator(id,op_id,x,z); dp->Add_Split_Operator(new_op);
	dpe = (vcDatapathElement*) new_op;
	dpe->Set_Input_WAR_Flags (war_flags);
    }
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
  bool bypass_flag = false;
}
:
 br_id: BRANCH_OP id = vc_Label
 LPAREN 
    (wid = vc_Identifier {x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,br_id)
                          wires.push_back(x);})+
 RPAREN (FLOWTHROUGH {bypass_flag = true;})?
 { new_op = new vcBranch(id,wires,bypass_flag); dp->Add_Branch(new_op);}
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_Select_Instantiation: SELECT_OP vc_Label LPAREN vc_Identifier vc_Identifier vc_Identifier RPAREN
//                                             LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Select_Instantiation[vcDataPath* dp] returns[vcDatapathElement* dpe]
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
  vector<bool> war_flags;
}
:
 sel_id:SELECT_OP id = vc_Label
 LPAREN 
    sel = vc_Wire_Connection[war_flags,dp] {NOT_FOUND__("wire",sel,wid,sel_id) }
    x   = vc_Wire_Connection[war_flags,dp] {NOT_FOUND__("wire",x,wid,sel_id) }
    y   = vc_Wire_Connection[war_flags,dp] {NOT_FOUND__("wire",y,wid,sel_id) }
 RPAREN
 LPAREN
    wid = vc_Identifier {z = dp->Find_Wire(wid); NOT_FOUND__("wire",z,wid,sel_id) }
 RPAREN
 { 
	new_op = new vcSelect(id,sel,x,y,z); dp->Add_Select(new_op);   
	dpe = (vcDatapathElement*) new_op;
	dpe->Set_Input_WAR_Flags(war_flags);
 }
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_Slice_Instantiation: SLICE_OP vc_Label LPAREN vc_Identifier UINTEGER UINTEGER RPAREN
//                                             LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Slice_Instantiation[vcDataPath* dp] returns[vcDatapathElement* dpe]
{
  vcSlice* new_op = NULL;
  string id;
  string wid;
  int h, l;
  vcWire* din = NULL;
  vcWire* dout = NULL;

  vector<bool> war_flags;
}
:
 slice_id:SLICE_OP id = vc_Label
 LPAREN 
        din = vc_Wire_Connection[war_flags, dp]
		 {NOT_FOUND__("wire",din,wid,slice_id) }
        hid: UINTEGER { h = atoi(hid->getText().c_str()); }
        lid: UINTEGER { l = atoi(lid->getText().c_str()); }
 RPAREN
 LPAREN
    wid = vc_Identifier {dout = dp->Find_Wire(wid); NOT_FOUND__("wire",dout,wid,slice_id) }
 RPAREN
 { 
	new_op = new vcSlice(id,din,dout,h,l); dp->Add_Slice(new_op);    
	dpe = (vcDatapathElement*) new_op;
	dpe->Set_Input_WAR_Flags(war_flags);
 }
;


//-------------------------------------------------------------------------------------------------------------------------
// vc_Bitmap_Instantiation: PERMUTE_OP vc_Label LPAREN vc_Identifier (UINTEGER UINTEGER)+ RPAREN
//                                             LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Bitmap_Instantiation[vcDataPath* dp] returns[vcDatapathElement* dpe]
{
  vcPermutation* new_op = NULL;
  string id;
  string wid;
  vector<pair<int,int> > bmapv;
  vcWire* din = NULL;
  vcWire* dout = NULL;
  int s,t;
  vector<bool> war_flags;
}
:
 permute_id:PERMUTE_OP id = vc_Label
 LPAREN 
        din = vc_Wire_Connection[war_flags, dp] 
	{NOT_FOUND__("wire",din,wid,permute_id) }
        ( tid: UINTEGER { t = atoi(tid->getText().c_str()); }
        	sid: UINTEGER { s = atoi(sid->getText().c_str()); bmapv.push_back(pair<int,int>(t,s)); } )+
 RPAREN
 LPAREN
    wid = vc_Identifier {dout = dp->Find_Wire(wid); NOT_FOUND__("wire",dout,wid,permute_id) }
 RPAREN
 { 
	new_op = new vcPermutation(id,din,dout,bmapv); dp->Add_Permutation(new_op);    

	dpe = (vcDatapathElement*) new_op;
	dpe->Set_Input_WAR_Flags(war_flags);
 }
;


//-------------------------------------------------------------------------------------------------------------------------
// vc_Register_Instantiation: ASSIGN_OP vc_Label LPAREN vc_Identifier RPAREN LPAREN vc_Identifier RPAREN

//-------------------------------------------------------------------------------------------------------------------------
vc_Register_Instantiation[vcDataPath* dp] returns[vcDatapathElement* dpe]
{
  vcRegister* new_reg = NULL;
  vcWire* x;
  vcWire* y;
  string id;
  string din;
  string dout;
  vector<bool> war_flags;
}: as_id: ASSIGN_OP id = vc_Label LPAREN x = vc_Wire_Connection[war_flags,dp] 
				{NOT_FOUND__("wire",x,din,as_id) }
                          RPAREN
                          LPAREN dout = vc_Identifier { y = dp->Find_Wire(dout); 
                               NOT_FOUND__("wire",y,dout,as_id) }
                          RPAREN
   {  
      new_reg = new vcRegister(id, x, y); dp->Add_Register(new_reg);
      dpe = (vcDatapathElement*) new_reg;
      dpe->Set_Input_WAR_Flags(war_flags);
   }
;
 
//-------------------------------------------------------------------------------------------------------------------------
// vc_InterlockBuffer_Instantiation: HASH ASSIGN_OP vc_Label LPAREN vc_Identifier RPAREN LPAREN vc_Identifier RPAREN

//-------------------------------------------------------------------------------------------------------------------------
vc_InterlockBuffer_Instantiation[vcDataPath* dp] returns[vcDatapathElement* dpe]
{
  vcInterlockBuffer* new_reg = NULL;
  vcWire* x;
  vcWire* y;
  string id;
  string din;
  string dout;
  vector<bool> war_flags;
  bool cut_through = false;
}: HASH  as_id: ASSIGN_OP id = vc_Label LPAREN x = vc_Wire_Connection[war_flags,dp]
			 {NOT_FOUND__("wire",x,din,as_id) }
                          RPAREN
                          LPAREN dout = vc_Identifier { y = dp->Find_Wire(dout); 
                               NOT_FOUND__("wire",y,dout,as_id) }
                          RPAREN
			  (CUT_THROUGH {cut_through = true;})?
   {  
      new_reg = new vcInterlockBuffer(id, x, y); 

      new_reg->Set_Cut_Through(cut_through);

      dp->Add_Interlock_Buffer(new_reg);
      dpe = (vcDatapathElement*) new_reg;
      dpe->Set_Input_WAR_Flags(war_flags);
   }
;
 

//-------------------------------------------------------------------------------------------------------------------------
// vc_Equivalence_Instantiation: EQUIVALENCE_OP vc_Label LPAREN vc_Identifier+ RPAREN LPAREN vc_Identifier+ RPAREN

//-------------------------------------------------------------------------------------------------------------------------
vc_Equivalence_Instantiation[vcDataPath* dp] returns [vcDatapathElement* dpe]
{
    string id;
    vcEquivalence* nm = NULL;
    vector<vcWire*> inwires;
    vector<vcWire*> outwires;
    vcWire* w;
    string wid;
    vector<bool> war_flags;
}
    :
        eq_id: EQUIVALENCE_OP id = vc_Label LPAREN
        (w = vc_Wire_Connection [war_flags,dp]
         { 
           NOT_FOUND__("wire",w,wid,eq_id) 
           inwires.push_back(w);
         })+
        RPAREN
        LPAREN
        (wid = vc_Identifier 
         { 
            w = dp->Find_Wire(wid); 
            NOT_FOUND__("wire",w,wid,eq_id) 
            outwires.push_back(w);
         })+
        RPAREN 
        {
            nm = new vcEquivalence(id,inwires,outwires);
            dp->Add_Equivalence(nm);
	    dpe = (vcDatapathElement*) nm;
	    dpe->Set_Input_WAR_Flags(war_flags);
        }
    ;



//-------------------------------------------------------------------------------------------------------------------------
// vc_Call_Instantiation: CALL (INLINE)? vc_Label MODULE vc_Identifier 
//              LPAREN vc_Identifier* RPAREN LPAREN vc_Identifier* RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Call_Instantiation[vcSystem* sys, vcDataPath* dp] returns[vcDatapathElement* dpe]
{
  bool inline_flag;
  vcCall* nc = NULL;
  string id;
  string mid;
  vcModule* m;
  vector<vcWire*> inwires;
  vector<vcWire*> outwires;
  vcWire* w;
  vector<bool> war_flags;
}
:
  cid:CALL (INLINE {inline_flag = true;})? id = vc_Label MODULE mid=vc_Identifier 
       {m = sys->Find_Module(mid); NOT_FOUND__("module",m,mid,cid) }
       lpid1: LPAREN (w = vc_Wire_Connection[war_flags,dp] 
			{
				NOT_FOUND__("wire",w,mid,lpid1)
				inwires.push_back(w);
			})* RPAREN
       lpid2: LPAREN (mid = vc_Identifier {vcWire* ow = dp->Find_Wire(mid); 
                                    NOT_FOUND__("wire",ow,mid,lpid2)
                                    outwires.push_back(ow);})* RPAREN
       	{ 
	 nc = new vcCall(id, dp->Get_Parent(), m, inwires, outwires, inline_flag); dp->Add_Call(nc); 
	 dpe = (vcDatapathElement*) nc;
	 dpe->Set_Input_WAR_Flags(war_flags);
	}
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_IOPort_Instantiation[dp]: IOPORT  (IN | OUT) vc_LABEL LPAREN vc_Identifier RPAREN LPAREN vc_Identifier RPAREN (BARRIER?)
//-------------------------------------------------------------------------------------------------------------------------
vc_IOPort_Instantiation[vcDataPath* dp] returns[vcDatapathElement* dpe]
{
 string id, in_id, out_id, pipe_id;
 vcWire* w;
 vcPipe* p = NULL;
 bool in_flag = false;
 bool barrier_flag = false;
}
: ipid: IOPORT (( IN {in_flag = true;})  | OUT)  id = vc_Label LPAREN in_id = vc_Identifier RPAREN 
    lpid: LPAREN out_id = vc_Identifier RPAREN (BARRIER {barrier_flag = true;})?
       {
          if(in_flag)
          {
            w = dp->Find_Wire(out_id);
            NOT_FOUND__("wire",w,out_id,lpid)
            pipe_id = in_id;
            p = dp->Get_Parent()->Find_Pipe(pipe_id);
            NOT_FOUND__("pipe",p,pipe_id,lpid);
          }
          else
          {
            w = dp->Find_Wire(in_id);
            NOT_FOUND__("wire",w,in_id,lpid);
            pipe_id = out_id;
            p = dp->Get_Parent()->Find_Pipe(pipe_id);
            NOT_FOUND__("pipe",p,pipe_id,lpid);
          }


  
          if(w->Get_Type()->Size() != p->Get_Width())
             vcSystem::Error("Pipe " + pipe_id + " width does not match wire width on IOport " + id);

          if(in_flag)
          {
             vcInport* np = new vcInport(id,p,w);
             dp->Add_Inport(np);
	     dpe=(vcDatapathElement*) np;
	     np->Set_Barrier_Flag(barrier_flag);
          }
          else
          {
             vcOutport* np = new vcOutport(id,p,w);
             dp->Add_Outport(np);
	     dpe=(vcDatapathElement*) np;
          }
	
      }
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_LoadStore_Instantiation: vc_LoadInstantiation | vc_StoreInstantiation
//-------------------------------------------------------------------------------------------------------------------------
vc_LoadStore_Instantiation[vcSystem* sys, vcDataPath* dp] returns[vcDatapathElement* dpe]:
   dpe=vc_Load_Instantiation[sys,dp] | dpe=vc_Store_Instantiation[sys,dp]
;



//-------------------------------------------------------------------------------------------------------------------------
// vc_Load_Instantiation: LOAD vc_Label FROM (vc_Identifier DIV_OP)? vc_Identifier LPAREN vc_Identifier RPAREN LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Load_Instantiation[vcSystem* sys, vcDataPath* dp] returns[vcDatapathElement* dpe]
{
   string id, wid;
   string ms_id;
   string m_id = "";
   vcWire* addr;
   vcWire* data;
   vcMemorySpace* ms;
   bool is_load = false;

}
: ldid: LOAD id = vc_Label FROM (m_id = vc_Identifier DIV_OP)? ms_id = vc_Identifier 
     {
       ms = sys->Find_Memory_Space(m_id,ms_id); 
       NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),ldid)
     }
   LPAREN    wid = vc_Identifier {addr = dp->Find_Wire(wid); 
                       NOT_FOUND__("wire",addr,wid,ldid);
              } RPAREN
   LPAREN    wid = vc_Identifier {data = dp->Find_Wire(wid); 
                       NOT_FOUND__("wire",data,wid,ldid);
              } RPAREN
   {
         vcLoad* nl = new vcLoad(id, ms, addr, data);
         dp->Add_Load(nl);
	 dpe = (vcDatapathElement*) nl;
   }
;


//-------------------------------------------------------------------------------------------------------------------------
// vc_Store_Instantiation: STORE vc_Label TO (vc_Identifier DIV_OP)? vc_Identifier LPAREN vc_Identifier vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_Store_Instantiation[vcSystem* sys, vcDataPath* dp] returns[vcDatapathElement* dpe]
{
   string id, wid;
   string ms_id;
   string m_id = "";
   vcWire* addr;
   vcWire* data;
   vcMemorySpace* ms;
   bool is_load = false;
}
: st_id: STORE id = vc_Label TO (m_id = vc_Identifier DIV_OP)? ms_id = vc_Identifier 
     {
       ms = sys->Find_Memory_Space(m_id,ms_id); 
       NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),st_id)
     }
   LPAREN    wid = vc_Identifier {addr = dp->Find_Wire(wid); 
                 NOT_FOUND__("wire",addr,wid,st_id);
              } 
             wid = vc_Identifier {data = dp->Find_Wire(wid); 
                 NOT_FOUND__("data",addr,wid,st_id);              
              } RPAREN
   {
         vcStore* ns = new vcStore(id, ms, addr, data);
         dp->Add_Store(ns);
	 dpe=(vcDatapathElement*)  ns;
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
}
: p_id:PHI lbl = vc_Label LPAREN ( id = vc_Identifier { tw = dp->Find_Wire(id); 
         NOT_FOUND__("wire",tw,id,p_id);
         inwires.push_back(tw);})+ RPAREN
   LPAREN
   id = vc_Identifier 
    { 
         outwire = dp->Find_Wire(id); 
         NOT_FOUND__("wire",outwire,id,p_id);
	 phi = new vcPhi(lbl,inwires, outwire); 

         dp->Add_Phi(phi);
    }
  RPAREN
 (FULLRATE {phi->Set_Full_Rate(true);} )?
;

//-------------------------------------------------------------------------------------------------------------------------
// vc_PhiPipelined_Instantiation: HASH PHI vc_Label LPAREN ( vc_Identifier )+ RPAREN LPAREN vc_Identifier RPAREN
//-------------------------------------------------------------------------------------------------------------------------
vc_PhiPipelined_Instantiation[vcDataPath* dp]
{
  string lbl;
  string id;
  vcWire* tw;
  vcWire* outwire;
  vcPhiPipelined* phi;
  vector<vcWire*> inwires;
}
: HASH p_id:PHI lbl = vc_Label LPAREN ( id = vc_Identifier { tw = dp->Find_Wire(id); 
         NOT_FOUND__("wire",tw,id,p_id);
         inwires.push_back(tw);})+ RPAREN
   LPAREN
   id = vc_Identifier 
    { 
         outwire = dp->Find_Wire(id); 
         NOT_FOUND__("wire",outwire,id,p_id);
         phi = new vcPhiPipelined(lbl,inwires, outwire); 
         dp->Add_Phi(phi);
    }
  RPAREN
 (FULLRATE {phi->Set_Full_Rate(true);} )?
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
	vcValue* v = NULL;
	string obj_name;
}
: id: SIMPLE_IDENTIFIER {obj_name = id->getText();} COLON t = vc_Type[sys] (ASSIGN_OP v =  vc_Value[t])? 
{ 
	parent->Add_Argument(obj_name,mode,t,v);
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
              sys->Warning("Warning: wire declaration at system scope ignored: line number " + 
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

	string vstring;
	string format;

	if(t->Is("vcArrayType"))
		etypes.push_back(((vcArrayType*)t)->Get_Element_Type());
	else if(t->Is("vcRecordType"))
	{
		int i;
		for(i = 0; i < ((vcRecordType*)t)->Get_Number_Of_Elements(); i++)
			etypes.push_back(((vcRecordType*)t)->Get_Element_Type(i));
	}
}:

(
  ( (bid: BINARYSTRING { vstring = bid->getText(); format = "binary";} ) |
    (hid: HEXSTRING { vstring = hid->getText(); format = "hexadecimal";})
  )
    {
	if(t->Is("vcIntType") || t->Is("vcPointerType"))
	   v = (vcValue*) (new vcIntValue((vcIntType*)t,vstring.substr(2),format));
        else if(t->Is("vcFloatType"))
	   v = (vcValue*) (new vcFloatValue((vcFloatType*)t,vstring.substr(2),format));
    }
) | 
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
// vc_IntType : INT ULT_OP UINTEGER UGT_OP
//----------------------------------------------------------------------------------------------------------
vc_IntType[vcSystem* sys] returns [vcType* t]
{
	vcIntType* it;
	unsigned int w;
}
: INT ULT_OP i:UINTEGER {w = atoi(i->getText().c_str());} UGT_OP {it = Make_Integer_Type(w); t = (vcType*)it;}
;

//----------------------------------------------------------------------------------------------------------
// vc_FloatType: FLOAT ULT_OP UINTEGER COMMA UINTEGER UGT_OP
//----------------------------------------------------------------------------------------------------------
vc_FloatType[vcSystem* sys] returns [vcType* t]
{
	vcFloatType* ft;
	unsigned int c,m;
}
: FLOAT ULT_OP cid:UINTEGER {c = atoi(cid->getText().c_str());} COMMA mid:UINTEGER {m = atoi(mid->getText().c_str());}
UGT_OP {ft = Make_Float_Type(c,m); t = (vcType*)ft;}
;


//----------------------------------------------------------------------------------------------------------
// vc_PointerType : POINTER ULT_OP (vc_Identifier DIV_OP)? vc_Identifier UGT_OP
//----------------------------------------------------------------------------------------------------------
vc_PointerType[vcSystem* sys] returns [vcType* t]
{ 
	vcPointerType* pt;
        string scope_id, space_id;
}:
POINTER ULT_OP (sid:SIMPLE_IDENTIFIER DIV_OP {scope_id = sid->getText();})? mid:SIMPLE_IDENTIFIER
{space_id = mid->getText(); pt = Make_Pointer_Type(sys, scope_id,space_id); t = (vcType*) pt;} 
UGT_OP
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
// vc_Record_Type: Record (ULT_OP (vc_Type) UGT_OP)+
//----------------------------------------------------------------------------------------------------------
vc_RecordType[vcSystem* sys] returns [vcType* t]
{
	vcRecordType* rt;
	vcType* et;
	vector<vcType*> etypes;
}: RECORD (ULT_OP (et = vc_Type[sys] {etypes.push_back(et);}) UGT_OP)+
{ rt = Make_Record_Type(etypes); t = (vcType*) rt; etypes.clear();}
;

//----------------------------------------------------------------------------------------------------------
// vc_SysBufferingSpec: BUFFERING (IN | OUT) SIMPLE_IDENTIFIER SIMPLE_IDENTIFIER SIMPLE_IDENTIFIER UINTEGER 
//----------------------------------------------------------------------------------------------------------
vc_SysBufferingSpec[vcSystem* sys]
{
	string mod_name;
 	string dpe_name;
	string wire_name;
	int buffering;
	bool input_flag = true;
}
 :
	BUFFERING mid: SIMPLE_IDENTIFER {mod_name = mid->getText();}
		  (IN | (OUT {input_flag = false;}))
		  dpe_id: SIMPLE_IDENTIFIER{dpe_name = dpe_id->getText();}
		  wire_id: SIMPLE_IDENTIFIER {wire_name = wire_id->getText();}
		  bid : UINTEGER {buffering = atoi(bid->getText().c_str());}
		{
			vcModule* m = sys->Find_Module(mod_name);
			NOT_FOUND__("Module", m, mod_name, mid);
			if(m != NULL)
			{
				vcDatapathElement* dpe = m->Get_Data_Path()->Find_DPE(dpe_name);
				NOT_FOUND__("Datapath-element", dpe, dpe_name, dpe_id);
				if(dpe != NULL)
				{
					vcWire* w = m->Get_Data_Path()->Find_Wire(wire_name);
					NOT_FOUND__("wire", w, wire_name, wire_id);
					if(w != NULL)
					{
						if(input_flag)
							dpe->Set_Input_Buffering(w,buffering);
						else
							dpe->Set_Output_Buffering(w,buffering);

					}
				}
			}
		}
;

//----------------------------------------------------------------------------------------------------------
// vc_ModuleBufferingSpec: BUFFERING (IN | OUT) SIMPLE_IDENTIFIER SIMPLE_IDENTIFIER UINTEGER 
//----------------------------------------------------------------------------------------------------------
vc_ModuleBufferingSpec[vcModule* m]
{
 	string dpe_name;
	string wire_name;
	int buffering;
	bool input_flag = true;
}
 :
	BUFFERING (IN | (OUT {input_flag = false;}))
		  dpe_id: SIMPLE_IDENTIFIER{dpe_name = dpe_id->getText();}
		  wire_id: SIMPLE_IDENTIFIER {wire_name = wire_id->getText();}
		  bid : UINTEGER {buffering = atoi(bid->getText().c_str());}
		{
				vcDatapathElement* dpe = m->Get_Data_Path()->Find_DPE(dpe_name);
				NOT_FOUND__("Datapath-element", dpe, dpe_name, dpe_id);
				if(dpe != NULL)
				{
					vcWire* w = m->Get_Data_Path()->Find_Wire(wire_name);
					NOT_FOUND__("wire", w, wire_name, wire_id);
					if(w != NULL)
					{
						if(input_flag)
							dpe->Set_Input_Buffering(w,buffering);
						else
							dpe->Set_Output_Buffering(w,buffering);

					}
				}
		}
;

//----------------------------------------------------------------------------------------------------------
// vc_ModuleDelaySpec: DELAY SIMPLE_IDENTIFIER UINTEGER 
//----------------------------------------------------------------------------------------------------------
vc_ModuleDelaySpec[vcModule* m]
{
 	string dpe_name;
	int delay = 1;
}
 :
	DELAY dpe_id: SIMPLE_IDENTIFIER{dpe_name = dpe_id->getText();}
		  bid : UINTEGER {delay = atoi(bid->getText().c_str());}
		{
				vcDatapathElement* dpe = m->Get_Data_Path()->Find_DPE(dpe_name);
				NOT_FOUND__("Datapath-element", dpe, dpe_name, dpe_id);
				if(dpe != NULL)
				{
					dpe->Set_Delay(delay);
				}
		}
;

//----------------------------------------------------------------------------------------------------------
// vc_SysAttributeSpec: ATTRIBUTE (MEMORYSPACE | MODULE) SIMPLE_IDENTIFIER (SIMPLE_IDENTIFIER IMPLIES QUOTED_STRING) 
//----------------------------------------------------------------------------------------------------------
vc_SysAttributeSpec[vcSystem* sys]
{
	string key;
	string value;
	bool mem_space = false;
        bool module = false;
	vcRoot* child = NULL;
	string m_id;
	string ms_id;
        string child_id;
}
:
	aid:ATTRIBUTE (
			( MEMORYSPACE {mem_space = true;}
				(m_id = vc_Identifier DIV_OP)? ms_id = vc_Identifier 
				{ 
					child_id = m_id + "/" + ms_id; 
					child = sys->Find_Memory_Space(m_id,ms_id);
				} ) | 
		   	(MODULE {module = true;} 
				m_id = vc_Identifier 
				{
					child_id = m_id;
					child = sys->Find_Module(m_id);
				} )
                  )
		kid: SIMPLE_IDENTIFIER {key = kid->getText();} 
		IMPLIES vid:QUOTED_STRING { value = vid->getText();} 
		{  
			if(child != NULL) 
				child->Add_Attribute(key,value);
			else
			{
				vcSystem::Warning("could not find " + child_id + " to add attribute,"
							+ IntToStr(aid->getLine()));
						
			}
		}
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
// vc_PipelineSpec: PIPELINE SIMPLE_IDENTIFIER LPAREN (SIMPLE_IDENTIFIER+)  RPAREN
//----------------------------------------------------------------------------------------------------------
vc_PipelineSpec[vcDataPath* dp]
{
	string pname;
	string dpe_name;
}
:
PIPELINE  kid: SIMPLE_IDENTIFIER {pname = kid->getText();} 
		LPAREN (SIMPLE_IDENTIFIER { dp->Add_To_DataPipeline(pname,dpe_name); })+ RPAREN
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
UNORDERED     : "$unordered";
OBJECT        : "$object";
CAPACITY      : "$capacity";
DATAWIDTH     : "$datawidth";
ADDRWIDTH     : "$addrwidth";
MAXACCESSWIDTH : "$maxaccesswidth";
MODULE        : "$module";
FOREIGN       : "$foreign";
PIPELINE      : "$pipeline";
OPERATOR      : "$operator";
VOLATILE      : "$volatile";
USEONCE       : "$useonce";
SERIESBLOCK   : ";;";
PARALLELBLOCK : "||";
FORKBLOCK     : "::";
PIPELINEDFORKBLOCK     : ":|:";
BRANCHBLOCK   : "<>";
LOOPBLOCK     : "<o>";
OF            : "$of";
FORK          : "&->";
JOIN          : "<-&";
MARKEDJOIN    : "o<-&";
BRANCH        : "|->";
MERGE         : "<-|";
ENTRY         : "$entry";
EXIT          : "$exit";
N_ULL         : "$null";
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
LIFO          : "$lifo";
NOBLOCK       : "$noblock";
SIGNAL        : "$signal";
P2P           : "$p2p";
SHIFTREG      : "$shiftreg";
FROM          : "$from";
AT            : "$at";
CONSTANT      : "$constant";
INTERMEDIATE  : "$intermediate";
DEPTH         : "$depth";
BUFFERING     : "$buffering";
GUARD         : "$guard";
BIND          : "$bind";
TERMINATE     : "$terminate";
PHISEQUENCER  : "$phisequencer";
TRANSITIONMERGE     : "$transitionmerge";



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
ROL_OP           : "<o<";
ROR_OP           : ">o>";
SGT_OP           : "$S>$S";
SGE_OP           : "$S>=$S";
EQ_OP            : "==";
SLT_OP           : "$S<$S";
SLE_OP           : "$S<=$S";
UGT_OP           : ">";
UGE_OP           : ">=";
ULT_OP           : "<";
ULE_OP           : "<=";
NEQ_OP           : "!=";
ORDERED_OP       : ">=<";
UNORDERED_OP     : "><";
BITSEL_OP        : "[]";
CONCAT_OP        : "&&";
BRANCH_OP        : "==0?";
SELECT_OP        : "?";
SLICE_OP        : "[:]";
ASSIGN_OP        : ":="; 
NOT_OP           : "~";
OR_OP            : "|";
AND_OP           : "&";
XOR_OP           : "^";
NOR_OP           : "~|";
NAND_OP          : "~&";
XNOR_OP          : "~^";
PERMUTE_OP       : ":X=" ;


EQUIVALENCE_OP    : "&/";

OPEN             : "$open";
DELAY            : "$delay";

// signed version of SHR.
// lhs and rhs are both considered
// signed numbers.
SHRA_OP          : "$S>>";

// signed assigns ... there
// are many forms..
UtoS_ASSIGN_OP  : "$S:=$U"; 
StoS_ASSIGN_OP  : "$S:=$S"; 
StoU_ASSIGN_OP  : "$U:=$S";
// UtoU is the default..

// FP <-> int conversions.
FtoS_ASSIGN_OP : "$S:=$F";
FtoU_ASSIGN_OP : "$U:=$F";
StoF_ASSIGN_OP : "$F:=$S";
UtoF_ASSIGN_OP : "$F:=$U";

// FP <-> FP conversions.
FtoF_ASSIGN_OP : "$F:=$F";

// DECODE,ENCODE, etc.
DECODE_OP: "$decode";
ENCODE_OP: "$encode";
P_ENCODE_OP: "$priority_encode";
BITREDUCE_OR_OP:  "!|";
BITREDUCE_AND_OP: "!&";
BITREDUCE_XOR_OP: "!^";


// dead transitions..
DEAD : "$dead";
TIED_HIGH : "$tied_high";
LEFT_OPEN : "$left_open";

// input buffering indicator..
HASH: "#";

// flow-through indicator
FLOWTHROUGH : "$flowthrough";
// full-rate indicator.
FULLRATE      : "$fullrate";
BYPASS	      : "$bypass";

WAR : "$war";
DETERMINISTIC: "$deterministic";

ALIAS: "$A";
BARRIER: "$barrier";
CUT_THROUGH: "$cut_through";

GATED_CLOCK:"$gated_clock";
USE_GATED_CLOCK: "$use_gated_clock";

SCC_ARC: "$scc_arc";
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

// Identifiers
SIMPLE_IDENTIFIER options {testLiterals=true;} : ALPHA (ALPHA | DIGIT | '_' | '.')*; 

// base
protected ALPHA: 'a'..'z'|'A'..'Z';
protected DIGIT:'0'..'9';

