/*
 * AhiVC.g: the Ahir Virtual Circuit grammar
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
// vc_Program :  (vc_Library | vc_Module | vc_Memory_Space)+
//-----------------------------------------------------------------------------------------------
vc_Program
{ 
    vcDPLibrary* lib = NULL;
    vcModule* nf = NULL;
    vcMemorySpace* ms = NULL;
}
    :
        (
            (nf = vc_Module {vcProgram::Add_Module(nf);} )
            |
            (ms = vc_Memory_Space {vcProgram::Add_Memory_Space(ms))
            |
            (lib = vc_Library {vcProgram::Add_Library(lib))
        )*
    ;


//-----------------------------------------------------------------------------------------------
// vc_Library : LIBRARY vc_Label (vc_DatapathElementDefinition)* ENDLIBRARY
//-----------------------------------------------------------------------------------------------
vc_Library returns [vcLibrary* new_lib]
{
  string lbl = "";
  new_lib = NULL;
}
: LIBRARY lbl = vc_Label { new_lib = new vcDatapathElementLibrary(lbl); }
              

//----------------------------------------------------------------------------------------------------------
// vc_DatapathElementTemplate: DPE vc_Label vc_DpeParamSpec? vc_InPorts vc_OutPorts vc_DpeReqs vc_DpeAcks ENDDPE
//----------------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------------------------------------------
// vc_Module :  MODULE vc_Label  vc_Inargs vc_Outargs vc_Controlpath vc_Datapath vc_Link vc_Storage? vc_Attribute_Spec? ENDMODULE
//--------------------------------------------------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// vc_Controlpath: CONTROLPATH (vc_PlaceDef)+ (vc_TransitionDef)+ ENDCONTROLPATH
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// vc_Datapath: DATAPATH (vc_WireDeclaration | vc_DatapathElementInstantiation)+  ENDDATAPATH
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// vc_Storage: STORAGE vc_Label (vc_StorageLocation)+ ENDSTORAGE
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// vc_StorageLocation: LOCATION vc_Label vc_TypeSpec vc_InitialValue  ENDLOCATION
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// vc_Label : LBRACKET SIMPLE_IDENTIFIER RBRACKET
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// vc_Inargs : IN LPAREN (vc_Interface_Object_Declaration)* RPAREN
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// vc_Outargs : OUT LPAREN (vc_Interface_Object_Declaration)* RPAREN
//-----------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Interface_Object_Declaration : vc_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Object_Declaration_Base: SIMPLE_IDENTIFIER COLON aA_Type_Reference (ASSIGNEQUAL aA_Constant_Literal_Reference)?
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Constant_Object_Declaration: CONSTANT aA_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Wire_Object_Declaration: WIRE aA_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Type : vc_Scalar_Type | vc_Array_Type | vc_Record_Type 
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Scalar_Type : vc_Int_Type | vc_Float_Type | vc_Pointer_Type 
//----------------------------------------------------------------------------------------------------------
    
//----------------------------------------------------------------------------------------------------------
// vc_Int_Type : INT LESS UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Float_Type: FLOAT LESS UINTEGER COMMA UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Pointer_Type : POINTER LESS HIERARCHICAL_IDENTIFIER GREATER
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Array_Type: ARRAY (LBRACKET UINTEGER RBRACKET) OF aA_Scalar_Type
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Record_Type: Record (LBRACKET (vc_Type) (COMMA vc_Type)*  RBRACKET)
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Object_Reference: SIMPLE_IDENTIFIER 
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------
// vc_Attribute_Spec: ATTRIBUTE (SIMPLE_IDENTIFIER IMPLIES STRING)+ ENDATTRIBUTE 
//----------------------------------------------------------------------------------------------------------



// lexer rules
class AaLexer extends Lexer;

options {
	k = 6;
	testLiterals = true;
	charVocabulary = '\3'..'\377';
	defaultErrorHandler=true;
}

// language keywords (all start with $)
FOREIGN       : "$foreign";
MODULE        : "$module";
DECLARE       : "$declare";
DEFAULT       : "$default";
STORAGE       : "$storage";
PIPE          : "$pipe";
CONSTANT      : "$constant";
SERIESBLOCK   : "$seriesblock";
PARALLELBLOCK : "$parallelblock";
FORKBLOCK     : "$forkblock";
BRANCHBLOCK   : "$branchblock";
PLACE         : "$place";
SWITCH        : "$switch";
ENDSWITCH     : "$endswitch";
IF            : "$if";
ENDIF         : "$endif";
OF            : "$of";
ON            : "$on";
THEN          : "$then";
ELSE          : "$else";
FORK          : "$fork";
JOIN          : "$join";
MERGE         : "$merge";
ENDMERGE      : "$endmerge";
ENDJOIN       : "$endjoin";
WHEN          : "$when";
ENTRY         : "$entry";
EXIT          : "$exit";
FIN           : "$fin";
IN            : "$in";
OUT           : "$out";
IS            : "$is";
ASSIGN        : "$assign";
CALL          : "$call";
PHI           : "$phi";


// Special symbols
COLON		 : ':' ; // label separator
SEMICOLON	 : ';' ; // sequence
COMMA        : ',' ; // argument-separator, index-separator etc.
QUOTE           : '"'; // string marker
HASH            : '#';
ASSIGNEQUAL      : ":=" ; // assignment
EQUAL            : "=="; // equality 
NOTEQUAL         : "!="; // not equal
LESS             : '<' ; // less-than
LESSEQUAL        : "<="; // less-than-or-equal
QUESTION         : '?' ; // test in ternary statement
GREATER          : ">" ; // greater-than
GREATEREQUAL     : ">="; // greater-than-or-equal
IMPLIES          : "=>"; 
SHL              : "<<"; // shift-left
SHR              : ">>"; // shift-right
LBRACE           : '{' ; // scope open
RBRACE           : '}' ; // scope close
LBRACKET         : '[' ; // array index marker
RBRACKET         : ']' ; // array index marker
LPAREN           : '(' ; // argument-list
RPAREN           : ')' ; // argument-list
PERCENT          : '%' ; 
CONCAT           : '_' ; // concatenation
BITSEL           : '@' ; // bit-select


// arithmetic operators
PLUS             : '+' ; // plus
MINUS            : '-' ; // minus
MUL              : '*' ; // multiply
DIV              : '/' ; // divide

// logical operators
NOT              : '~'     ;
OR               : '|'     ;
AND              : '&'     ;
XOR              : '^'     ;
NOR              : "~|"    ;
NAND             : "~&"    ;
XNOR             : "~^"    ;

// Mux
MUX : "$mux";



// types
UINT           : "$uint"    ;
INT            : "$int"     ;
FLOAT          : "$float"   ;
POINTER        : "$pointer" ;
NuLL           : "$null";
ARRAY          : "$array";

// type cast
CAST : "$cast";


// data format
UINTEGER          : DIGIT (DIGIT)*;
UFLOAT : '.' UINTEGER 'E' ('+' | '-') UINTEGER;

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


// Scope-id
SCOPE_IDENTIFIER : '.' (SIMPLE_IDENTIFIER '.')* ;

// Identifiers
SIMPLE_IDENTIFIER options {testLiterals=true;} : ALPHA (ALPHA | DIGIT | '_')*; 



// base
protected ALPHA: 'a'..'z'|'A'..'Z';
protected DIGIT:'0'..'9';

