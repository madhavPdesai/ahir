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
		vcRoot::Error("Parsing Exception: " + re.toString(),NULL);
	}
}

//-----------------------------------------------------------------------------------------------
// vc_System :  (vc_Library | vc_Module | vc_MemorySpace)+
//-----------------------------------------------------------------------------------------------
vc_System
{ 
	vcDPLibrary* lib = NULL;
	vcModule* nf = NULL;
	vcMemorySpace* ms = NULL;
}
:
(
 (nf = vc_Module {vcProgram::Add_Module(*nf);} )
 |
 (ms = vc_MemorySpace {vcProgram::Add_Memory_Space(*ms)})
 |
 (lib = vc_Library {vcProgram::Add_Library(*lib)})
 )*
	;


//-----------------------------------------------------------------------------------------------
// vc_Library : LIBRARY vc_Label LBRACE (vc_DatapathElementTemplate)* RBRACE
//-----------------------------------------------------------------------------------------------
vc_Library returns [vcDatapathElementLibrary* new_lib]
{
	string lbl = "";
	vcDatapathElementTemplate* e;
	new_lib = NULL;
}
: LIBRARY lbl = vc_Label { new_lib = new vcDatapathElementLibrary(lbl); } LBRACE
( e = vc_DatapathElementTemplate { new_lib->Add_Template(e); } )* RBRACE
;

//----------------------------------------------------------------------------------------------------------
// vc_DatapathElementTemplate: DPE vc_Label LBRACE  vc_DpeParamSpec? vc_InDpePorts? vc_OutDpePorts? vc_DpeReqs vc_DpeAcks RBRACE
//----------------------------------------------------------------------------------------------------------
vc_DatapathElementTemplate returns [vcDatapathElementTemplate* t]
{
	string lbl = "";
}
:  DPE lbl = vc_Label { t = new vcDatapathElementTemplate(lbl);}
LBRACE (vc_DpeParamSpec[t])?  (vc_InDpePorts[t])?  (vc_OutDpePorts[t])?  (vc_DpeReqs[t]) (vc_DpeAcks[t]) RBRACE 
;


//--------------------------------------------------------------------------------------------------------------------------------------
// vc_DpeParamSpec: PARAMETER LPAREN (vc_Identifier MIN UINTEGER MAX UINTEGER)+ RPAREN
//--------------------------------------------------------------------------------------------------------------------------------------
vc_DpeParamSpec[vc_DatapathElementTemplate* p] 
{
	string pname;
	unsigned int min_val, max_val;
}
:  PARAMETER LPAREN 
(nlbl:vc_Identifier { pname = nlbl->getText();}  
  minval:UINTEGER { min_val = atoi(minval->getText().c_str());} 
  maxval:UINTEGER { max_val = atoi(maxval->getText().c_str()); p->Add_Parameter(pname,min_val,max_val); } 
)+ 
RPAREN
;


//----------------------------------------------------------------------------------------------------------
// vc_InDpePorts: IN vc_DpePorts 
//----------------------------------------------------------------------------------------------------------
vc_InDpePorts[vc_DatapathElementTemplate* t]
:
IN vc_DpePorts[t,"in"]
;

//----------------------------------------------------------------------------------------------------------
// vc_OutDpePorts: IN vc_DpePorts 
//----------------------------------------------------------------------------------------------------------
vc_OutDpePorts[vc_DatapathElementTemplate* t]
:
OUT vc_DpePorts[t,"out"]
;

//----------------------------------------------------------------------------------------------------------
// vc_DpePorts: ( vc_Identifier COLON vc_ScalarTypeTemplate )+
//----------------------------------------------------------------------------------------------------------
vc_DpePorts[vc_DatapathElementTemplate* t, string mode]
{
	vcScalarTypeTemplate* tt;
}
:
(lbl:vc_Identifier COLON tt = vc_ScalarTypeTemplate 
 { 
 if(mode == "in") 
 t->Add_Input_Port(lbl->getText(), *tt);
 else
 t->Add_Output_Port(lbl->getText(), *tt);
 }
 )+
;

//----------------------------------------------------------------------------------------------------------
// vc_ScalarTypeTemplate: TEMPLATE ((FLOAT LESS SIMPLE_IDENTIFIER SIMPLE_IDENTIFIER GREATER) |
//                                  (INT   LESS SIMPLE_IDENTIFIER GREATER)
//----------------------------------------------------------------------------------------------------------
vc_ScalarTypeTemplate returns[vcScalarTypeTemplate* t]
: TEMPLATE ((FLOAT LESS c: SIMPLE_IDENTIFIER m:SIMPLE_IDENTIFIER GREATER 
  {
    t = new vcScalarTypeTemplate(c->getText(),m->getText());
  }) |
  (INT LESS w:SIMPLE_IDENTIFIER GREATER
  {
    t = new vcScalarTypeTemplate(w->getText());
  })
);


//----------------------------------------------------------------------------------------------------------
// vc_DpeReqs: REQS (vc_Identifier)+
//----------------------------------------------------------------------------------------------------------
vc_DpeReqs[vc_DatapathElementTemplate* t]
:
REQS (id: vc_Identifier { t->Add_Req(id->getText());})+
;

//----------------------------------------------------------------------------------------------------------
// vc_DpeAcks: ACKS (vc_Identifier)+
//----------------------------------------------------------------------------------------------------------
vc_DpeAcks[vc_DatapathElementTemplate* t]
:
ACKS (id: vc_Identifier { t->Add_Ack(id->getText());})+
;

//--------------------------------------------------------------------------------------------------------------------------------------
// vc_MemorySpace:  MEMORYSPACE vc_Label  LBRACE vc_MemorySpaceParams (vc_MemoryLocation)* RBRACE
//--------------------------------------------------------------------------------------------------------------------------------------
vc_MemorySpace returns[vcMemorySpace* ms]
{
	string lbl;
	ms = NULL;
}
: MEMORYSPACE lbl = vc_Label { ms = new vcMemorySpace(lbl);} LBRACE vc_MemorySpaceParams[ms] (vc_MemoryLocation[ms])* RBRACE
;

//--------------------------------------------------------------------------------------------------------------------------------------
// vc_MemorySpaceParams:  CAPACITY UINTEGER DATAWIDTH UINTEGER ADDRWIDTH UINTEGER 
//--------------------------------------------------------------------------------------------------------------------------------------
vc_MemorySpaceParams[vcMemorySpace* ms]
: CAPACITY cap:UINTEGER {ms->Set_Capacity(atoi(cap->getText().c_str()));}
DATAWIDTH lau:UINTEGER {ms->Set_Word_Size(atoi(lau->getText().c_str()));}
ADDRWIDTH aw:UINTEGER {ms->Set_Word_Size(atoi(aw->getText().c_str()));}
;

//--------------------------------------------------------------------------------------------------------------------------------------
// vc_MemoryLocation:  OBJECT vc_Label COLON vc_Type (ASSIGNEQUAL ? vc_Value)
//--------------------------------------------------------------------------------------------------------------------------------------
vc_MemoryLocation[vcMemorySpace* ms]
{
	vcStorageObject* nl = NULL;
	string lbl;
	vcType* t;
	vcValue* v = NULL;
}
: OBJECT lbl = vc_Label COLON t = vc_Type (ASSIGNEQUAL v = vc_Value[t])? 
{
	nl = new vcStorageObject(lbl,t);
	if(v != NULL)
		nl->Set_Value(v);
}
;

//--------------------------------------------------------------------------------------------------------------------------------------
// vc_Module :  MODULE vc_Label  LBRACE vc_Inargs vc_Outargs vc_Controlpath vc_Datapath vc_Link vc_MemorySpace* vc_AttributeSpec* RBRACE
//--------------------------------------------------------------------------------------------------------------------------------------
vc_Module returns[vcModule* m]
{
	string lbl;
	m = NULL;
        vcMemorySpace* ms;
}
: MODULE lbl = vc_Label { m = new vcModule(lbl);} 
LBRACE vc_Inargs[m] vc_Outargs[m] vc_Controlpath[m] vc_Datapath[m] vc_Link[m] (ms = vc_MemorySpace {m->Add_Memory_Space(ms);})* (vc_AttributeSpec[m])* RBRACE
;


//--------------------------------------------------------------------------------------------------------------------------------------
// vc_Link : LINK vc_Identifier vc_Identifier COLON vc_Identifier 
//--------------------------------------------------------------------------------------------------------------------------------------
vc_Link[vcModule* m]
:  LINK LPAREN tid:vc_Identifier IMPLIES dpeid:vc_Identifier COLON reqackid:vc_Identifier RPAREN
   { m->Add_Link(tid->getText(), dpeid->getText(), reqackid->getText());}
;
   
//-----------------------------------------------------------------------------------------------
// vc_Controlpath: CONTROLPATH LBRACE (vc_CPRegion)+  vc_AttributeSpec* RBRACE
//-----------------------------------------------------------------------------------------------
vc_Controlpath[vcModule* m]
{
	vcControPath* cp = new vcControlPath(m->Get_Id() + "_CP");
}
: CONTROLPATH  LBRACE (vc_CPRegion[cp])* (vc_AttributeSpec[cp])* RBRACE
;

//-----------------------------------------------------------------------------------------------
// vc_CPElement: vc_CPPlace | vc_CPTransition
//-----------------------------------------------------------------------------------------------
vc_CPElement returns [vcCPElement* cpe]
: (cpe = vc_CPPlace) | (cpe = vc_CPTransition);


//-----------------------------------------------------------------------------------------------
// vc_CPPlace: PLACE vc_Identifier
//-----------------------------------------------------------------------------------------------
vc_CPPlace returns[vcCPElement* cpe]
: PLACE id:vc_Identifier {cpe = (vcCPElement*) new vcPlace(id->getText());};


//-----------------------------------------------------------------------------------------------
// vc_CPTransition: TRANSITION vc_Identifier (IN | OUT | HIDDEN)
//-----------------------------------------------------------------------------------------------
vc_CPTransition returns[vcCPElement* cpe]
{ 
   vcTransitionType t;
}
: TRANSITION id:vc_Identifier ((IN {t = _IN_TRANSITION;}) | (OUT {t = _OUT_TRANSITION;}) | (HIDDEN {t = _HIDDEN_TRANSITION;}));

//-----------------------------------------------------------------------------------------------
// vc_CPRegion: (vc_CPSeriesBlock | vc_CPParallelBlock | vc_CPBranchBlock | vc_CPForkBlock )
//-----------------------------------------------------------------------------------------------
vc_CPRegion[vcControlPath* cp]
:
vc_CPSeriesBlock[cp] |
vc_CPParallelBlock[cp] |
vc_CPBranchBlock[cp] |
vc_CPForkBlock[cp] 
;

//-----------------------------------------------------------------------------------------------
// vc_CPSeriesBlock: SERIESBLOCK vc_Label LBRACE (vc_CPElement | vc_CPRegion)+ RBRACE
//-----------------------------------------------------------------------------------------------
vc_CPSeriesBlock[vcControlPath* cp] 
{
	string lbl;
	vcCPSeriesBlock* sb;
	vcCPElement* cpe;
}
: SERIESBLOCK lbl = vc_Label { sb = new vcSeriesBlock(lbl);} LBRACE 
(( cpe =  vc_CPElement { sb->Add_CPElement(cpe); }) | 
 ( vc_CPRegion[sb] ))+ RBRACE
{ cp->Add_CPElement(sb); }
;

//-----------------------------------------------------------------------------------------------
// vc_CPParallelBlock: PARALLELBLOCK vcLabel LBRACE (vc_CPRegion)+ RBRACE
//-----------------------------------------------------------------------------------------------
vc_CPParallelBlock[vcControlPath* cp] 
{
	string lbl;
	vcCPParallelBlock* sb;
	vcCPElement* cpe;
}
: PARALLELBLOCK lbl = vc_Label { sb = new vcParallelBlock(lbl);} LBRACE 
 ( vc_CPRegion[sb] )+ RBRACE
{ cp->Add_CPElement(sb); }
;

//-----------------------------------------------------------------------------------------------
// vc_CPBranchBlock: BRANCHBLOCK vc_Label LBRACE (vc_CPRegion | vc_CPBranch | vc_CPMerge | vc_CPPlace)+ RBRACE
//-----------------------------------------------------------------------------------------------
vc_CPBranchBlock[vcControlPath* cp] 
{
	string lbl;
	vcCPBranchBlock* sb;
	vcCPElement* cpe;
}
: BRANCHBLOCK lbl = vc_Label { sb = new vcBranchBlock(lbl);} LBRACE 
(( vc_CPRegion[sb] ) | 
 ( vc_CPBranch[sb] ) |
 ( vc_CPMerge[sb] ))+ RBRACE
{ cp->Add_CPElement(sb); }
;

//-----------------------------------------------------------------------------------------------
// vc_CPMerge: MERGE vc_Label  LPAREN ENTRY? (vc_Identifier)* RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPMerge[vcCPBranchBlock* bb]
{ 
	string lbl;
	string merge_region;
}
:
MERGE lbl = vc_Label LPAREN (e:ENTRY {bb->Add_Merge_Point(lbl,e->getText());})?
      (mid:vc_Identifier {bb->Add_Merge_Point(lbl,mid->getText());})* RPAREN
;



//-----------------------------------------------------------------------------------------------
// vc_CPBranch: BRANCH vc_Label LPAREN EXIT? (vc_Identifier)* RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPBranch[vcCPBranchBlock* bb]
{
	string lbl;
	vector<string> branch_ids;
}
:
BRANCH lbl = vc_Label 
LPAREN (e:EXIT {branch_ids.push_back(e->getText());})?
(b: vc_Identifier {branch_ids.push_back(b->getText());})*
RPAREN {bb->Add_Branch_Point(lbl,branch_ids);}
;

//-----------------------------------------------------------------------------------------------
// vc_CPForkBlock: FORKBLOCK vc_Label LBRACE (vc_CPFork | vc_CPRegion | vc_CPJoin | vc_CPTransition )+ RBRACE
//-----------------------------------------------------------------------------------------------
vc_CPForkBlock[vcControlPath* cp] 
{
	string lbl;
	vcCPForkBlock* fb;
	vcCPElement* cpe;
}
: FORKBLOCK lbl = vc_Label { fb = new vcCPForkBlock(lbl);} LBRACE 
 ((vc_CPRegion[fb]) | 
 ( vc_CPFork[fb] ) |
 ( vc_CPJoin[fb] ))+ RBRACE
{ cp->Add_CPElement(fb); }
;

//-----------------------------------------------------------------------------------------------
// vc_CPJoin: JOIN vc_Label LPAREN ENTRY? (vc_Idenitfier)+ RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPJoin[vcCPForkBlock* fb]
{
	string lbl;
	vector<string> join_ids;
}
:
JOIN lbl = vc_Label LPAREN (e:ENTRY {join_ids.push_back(e->getText());})?
(b: vc_Identifier {join_ids.push_back(b->getText());})*
RPAREN {bb->Add_Join_Point(lbl,join_ids);}
;

//-----------------------------------------------------------------------------------------------
// vc_CPFork: FORK vc_Label LPAREN EXIT? (vc_Identifier)+ RPAREN
//-----------------------------------------------------------------------------------------------
vc_CPFork[vcCPForkBlock* fb]
{
	string lbl;
	vector<string> fork_ids;
}
:
FORK lbl = vc_Label LPAREN (e:ENTRY {fork_ids.push_back(e->getText());})?
(b: vc_Identifier {fork_ids.push_back(b->getText());})*
RPAREN {bb->Add_Fork_Point(lbl,fork_ids);}
;

//-----------------------------------------------------------------------------------------------
// vc_Datapath: DATAPATH LBRACE (vc_WireDeclaration | vc_DatapathElementInstantiation)*  RBRACE
//-----------------------------------------------------------------------------------------------
vc_Datapath[vcModule* m]
{
	vcDataPath* dp = new vcDataPath(m->Get_Id() + "_DP");
}
: DATAPATH LBRACE ( vc_WireDeclaration[dp] | vc_DatapathElementInstantiation[dp] | vc_AttributeSpec[dp])* RBRACE
;


//-------------------------------------------------------------------------------------------------------------------------
// vc_DatapathElementInstantiation: DPEINSTANCE [vc_Label] OF [vc_Label] LBRACE 
//                   (PARAMETER MAP (vc_Identifier IMPLIES vc_Identifier)+)?  
//                   (PORT MAP (vc_Identifier IMPLIES vc_Identifier)+)?
//                    vc_AttributeSpec* RBRACE
//-------------------------------------------------------------------------------------------------------------------------
vc_DatapathElementInstantiation[vcDataPath* dp]
{
	string id;
	string template_id;
	vcDatapathElement* dpe;
}: DPEINSTANCE id = vc_Label OF template_id = vc_Label {dpe = new vcDatapathElement(id,template_id);} 
LBRACE
(PARAMETER MAP
 (paramid: vc_Identifier IMPLIES vid:vc_Identifier {dpe->Set_Parameter(paramid->getText(), atoi(vid->getText().c_str()));})+)?
(PORT MAP
 (portid: vc_Identifier IMPLIES wid: vc_Identifier{dpe->Connect_Wire(portid->getText(),dp->Get_Wire(wid->getText()));})+)? 
(vc_AttributeSpec[dpe])* 
RBRACE

;


//-----------------------------------------------------------------------------------------------
// vc_Label : LBRACKET SIMPLE_IDENTIFIER RBRACKET
//-----------------------------------------------------------------------------------------------
	vc_Label returns [string lbl]
:  (LBRACKET) 
	(id:SIMPLE_IDENTIFIER  { lbl = id->getText(); })  
(RBRACKET)
	;

	//-----------------------------------------------------------------------------------------------
	// vc_Inargs : IN LPAREN (vc_Interface_Object_Declaration)* RPAREN
	vc_Inargs[vcModule* parent] 
{
	string mode = "out";
}
: IN LPAREN (vc_Interface_Object_Declaration[parent,mode])* RPAREN
;
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// vc_Outargs : OUT LPAREN (vc_Interface_Object_Declaration)* RPAREN
//-----------------------------------------------------------------------------------------------
vc_Outargs[vcModule* parent] 
{
	string mode = "out";
}
: OUT LPAREN (vc_Interface_Object_Declaration[parent,mode])* RPAREN
;

//----------------------------------------------------------------------------------------------------------
// vc_Interface_Object_Declaration : vc_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------
vc_Interface_Object_Declaration[vcModule* parent, string mode]
{
	vcType* t;
	vcValue* v;
	string obj_name;
}
: vc_Object_Declaration_Base[&t,obj_name,&v] 
{ 
	if(mode == "in") parent->Add_Input_Argument(obj_name,t,v);
	else parent->Add_Output_Argument(obj_name,t,v);
}
;

//----------------------------------------------------------------------------------------------------------
// vc_Object_Declaration_Base: SIMPLE_IDENTIFIER COLON vc_Type (ASSIGNEQUAL vc_Value)?
//----------------------------------------------------------------------------------------------------------
vc_Object_Declaration_Base[vcType** t, string& obj_name, vcValue** v]
{
	vcType* tt = NULL;
	vcValue* vv = NULL;
}
: id:SIMPLE_IDENTIFIER {obj_name = id->getText();} COLON tt = vc_Type
(ASSIGNEQUAL vv =  vc_Value[*t])? {*t = tt; *v = vv;}
;



//----------------------------------------------------------------------------------------------------------
// vc_WireDeclaration: WIRE vc_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------
vc_WireDeclaration[vcDataPath* dp]
{
	vcType* t;
	string obj_name;
}
:
WIRE vc_Object_Declaration_Base[&t, obj_name, NULL] {dp->Add_Wire(obj_name, t);}
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
		etype.push_back(((vcArrayType*)t)->Get_Element_Type());
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
 v = (vcValue*) (new vcRecordValue(t,evalues));
 else 
 if(t->Is("vcArrayType")) v = (vcValue*) (new vcArrayValue(t,evalues));
 else 
 vcRoot::Error("composite value specified for scalar type: line %d\n", sig->getLine());
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
	assert(t->Is("vcIntType"));
}: (bid: BINARYSTRING { vstring = bid->getText(); format = "binary";} ) |
(hid: HEXSTRING { vstring = hid->getText(); format = "hexadecimal";})
{
	v = (vcValue*) (new vcIntValue(t,vstring,format));
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
	vcIntValue* cv;
	vcIntValue* mv;
}:  (MINUS {sign_value = 1;})? "C" cv = vc_IntValue[t->Get_Characteristic_Type()] "M" mv = vc_IntValue[t->Get_Mantissa_Type()]
{
	v = (vcValue*) (new vcFloatValue(t,sign_value, cv, mv));
}
;

//----------------------------------------------------------------------------------------------------------
// vc_Type : vc_ScalarType | vc_ArrayType | vc_RecordType 
//----------------------------------------------------------------------------------------------------------
vc_Type returns[vcType* t]
: ((t =  vc_ScalarType ) | (t =  vc_ArrayType ) | (t =  vc_RecordType )) ;

//----------------------------------------------------------------------------------------------------------
// vc_ScalarType : vc_IntType | vc_FloatType | vc_PointerType 
//----------------------------------------------------------------------------------------------------------
vc_ScalarType returns[vcType* t]
: (t =  vc_IntType ) | (t = vc_FloatType) | (t =  vc_PointerType ) ;

//----------------------------------------------------------------------------------------------------------
// vc_IntType : INT LESS UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------
vc_IntType returns [vcType* t]
{
	vcIntType* it;
	unsigned int w;
}
: INT LESS i:UINTEGER {w = atoi(i->getText().c_str());} GREATER {it = vcProgram::Make_Integer_Type(w); t = (vcType*)it;}
;

//----------------------------------------------------------------------------------------------------------
// vc_FloatType: FLOAT LESS UINTEGER COMMA UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------
vc_FloatType returns [vcType* t]
{
	vcFloatType* ft;
	unsigned int c,m;
}
: FLOAT LESS cid:UINTEGER {c = atoi(cid->getText().c_str());} COMMA mid:UINTEGER {m = atoi(mid->getText().c_str());}
GREATER {ft = vcProgram::Make_Float_Type(c,m); t = (vcType*)ft;}
;


//----------------------------------------------------------------------------------------------------------
// vc_PointerType : POINTER LESS HIERARCHICAL_IDENTIFIER GREATER
//----------------------------------------------------------------------------------------------------------
vc_PointerType returns [vcType* t]
{ 
	vcPointerType* pt;
	string space_id; 
}:
POINTER LESS id:HIERARCHICAL_IDENTIFIER 
{space_id = id->getText(); pt = new vcPointer(space_id); t = (vcType*) pt;} 
GREATER
;
//----------------------------------------------------------------------------------------------------------
// vc_Array_Type: ARRAY (LBRACKET UINTEGER RBRACKET) OF vc_ScalarType
//----------------------------------------------------------------------------------------------------------
vc_ArrayType returns [vcType* t]
{
	vcArrayType* at;
	vcType* et;
	unsigned int dimension;
}: ARRAY LBRACKET dim: UINTEGER {dimension = atoi(dim->getText().c_str());} RBRACKET OF et = vc_Type
{ at = new vcArrayType(et,dimension); t = (vcType*) at;}
;

//----------------------------------------------------------------------------------------------------------
// vc_Record_Type: Record (LPAREN (vc_Type) (COMMA vc_Type)*  RPAREN)
//----------------------------------------------------------------------------------------------------------
vc_RecordType returns [vcType* t]
{
	vcRecordType* rt;
	vcElementType* et;
	vector<vcType*> etypes;
}: RECORD LBRACKET (et = vc_Type {etypes.push_back(et);}) (COMMA t = vc_Type {etypes.push_back(et);})* RBRACKET
{ rt = new vcRecordType(etypes); t = (vcType*) rt; etypes.clear();}
;

//----------------------------------------------------------------------------------------------------------
// vc_AttributeSpec: ATTRIBUTE LPAREN (SIMPLE_IDENTIFIER IMPLIES QUOTED_STRING) RPAREN
//----------------------------------------------------------------------------------------------------------
vc_AttributeSpec[vcRoot* m]
{
	string key;
	string value;
}
:
ATTRIBUTE LPAREN kid: SIMPLE_IDENTIFIER {key = kid->getText();} IMPLIES vid:QUOTED_STRING { value = vid->getText();} RPAREN
{  m->Add_Attribute(key,value);}

;


//----------------------------------------------------------------------------------------------------------
// vc_Identifier: SIMPLE_IDENTIFIER
//----------------------------------------------------------------------------------------------------------
vc_Identifier : SIMPLE_IDENTIFIER;

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
SERIESBLOCK   : "$seriesblock";
PARALLELBLOCK : "$parallelblock";
FORKBLOCK     : "$forkblock";
BRANCHBLOCK   : "$branchblock";
OF            : "$of";
FORK          : "$fork";
JOIN          : "$join";
BRANCH        : "$branch";
MERGE         : "$merge";
ENTRY         : "$entry";
EXIT          : "$exit";
IN            : "$in";
OUT           : "$out";
REQS          : "$reqs";
ACKS          : "$acks";
TRANSITION    : "$transition";
PLACE         : "$place";
HIDDEN        : "$hidden";
PARAMETER     : "$parameter";
PORT          : "$port";
MAP           : "$map";
DATAPATH      : "$datapath";
CONTROLPATH   : "$controlpath";


// Special symbols
COLON		 : ':' ; // label separator
COMMA        : ',' ; // argument-separator, index-separator etc.
ASSIGNEQUAL      : ":=" ; // assignment
LESS             : '<' ; // less-than
GREATER          : ">" ; // greater-than
IMPLIES          : "=>"; 
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


QUOTED_STRING : '"' (ALPHA | DIGIT | '_' | ' ' | '\t' )* '"';

// Scope-id
HIERARCHICAL_IDENTIFIER : ':' (SIMPLE_IDENTIFIER)? ':' SIMPLE_IDENTIFIER ;

// Identifiers
SIMPLE_IDENTIFIER options {testLiterals=true;} : ALPHA (ALPHA | DIGIT | '_')*; 

// base
protected ALPHA: 'a'..'z'|'A'..'Z';
protected DIGIT:'0'..'9';

