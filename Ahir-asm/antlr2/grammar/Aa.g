/*
 * Aa.g: the Ahir ASM Language Grammar
 *
 * Author: Madhav Desai
 *
 *
 
 Inspired by: type-2 petri-nets
                  grammar allows the user to specify arbitrary
                  type-2 conformant algorithms.
                  allows for reuse (write-once-use-often)
              latex
                  easy to parse, no redundancies.
              esterel
                  concept of module and series/parallel blocks

 
 The top_level program consists of a collection of
 modules

 Each module has the following constituents
    input-output arguments
    declarations
    body

 A module is described as follows
    $module label ($in{in-args}) returns ($out{out-args}) is 
    (declarations)? { statement-sequence }

 The module body consists of a sequence of statements. A statement can
 be
    a simple statement
        assignment, call, null
    a block statement
        series, parallel, fork, branch

 A block statement can be one of the following
    seriesblock
        $seriesblock label { statement-sequence } 
    parallelblock
    forkblock 
    branchblock


 Each module describes a namespace.  A labeled 
 statement introduces a new namespace which
 is hierarchically identified.

 */

header "post_include_cpp" {
    static const char RCS_ID[] = "$Id:$";
}

header "post_include_hpp" {
#include <AaParserClasses.h>
}

options {
	language="Cpp";
}

class AaParser extends Parser;

options {
	// go with LL(2) grammar
	k=2;
	// no error handler for now
	defaultErrorHandler=false;
} 

tokens
{

// delimitation keywords
MODULE = "$module";
SERIESBLOCK   = "$series";
PARALLELBLOCK = "$parallel";
FORKBLOCK     = "$forkblock";
BRANCHBLOCK   = "$branchblock";
SWITCH        = "$switch";
IF            = "$if";
THEN          = "$then";
ELSE          = "$else";
FORK          = "$fork";
JOIN          = "$join";
MERGESPEC     = "$merge";
WHEN          = "$when";
ENTRY         = "$entry";
EXIT          = "$exit";
IN            = "$in";
OUT           = "$out";
IS            = "$is";

// Special symbols
COLON		 = ":" ; // label separator
SEMICOLON	 = ";" ; // sequence
COMMA        = "," ; // argument-separator, index-separator etc.
DQOUTE           = "\""; // string marker
ASSIGN           = ":=" ; // assignment
EQUAL            = "=="; // equality 
NOTEQUAL         = "!="; // not equal
LESS             = "<" ; // less-than
LESSEQUAL        = "<="; // less-than-or-equal
QUESTION         = "?" ; // test in ternary statement
GREATER          = ">" ; // greater-than
GREATEREQUAL     = ">="; // greater-than-or-equal
SHL              = "<<"; // shift-left
SHR              = ">>"; // shift-right
LBRACE           = "{" ; // scope open
RBRACE           = "}" ; // scope close
LBRACKET         = "[" ; // array index marker
RBRACKET         = "]" ; // array index marker
LPAREN           = "(" ; // argument-list
RPAREN           = ")" ; // argument-list

// arithmetic operators
PLUS             = "+" ; // plus
MINUS            = "-" ; // minus
MULTIPLY         = "*" ; // multiply
DIVIDE           = "/" ; // divide

// logical operators
NOT              = "not"  ;
OR               = "or"   ;
AND              = "and"  ;
XOR              = "xor"  ;
NOR              = "nor"  ;
NAND             = "nand" ;
XNOR             = "xnor" ;

// phi symbol
PHI            = "phi"     ;

// types
UINT           = "uint"    ;
INT            = "int"     ;
FLOAT          = "float"   ;
POINTER        = "pointer" ;
NuLL           = "null";
}


//-----------------------------------------------------------------------------------------------
// aA_Program : (aA_Module)*
//-----------------------------------------------------------------------------------------------
aA_Program[AaProgram* aa_pgm]
{
    AaModule* nf = NULL;
}
    :
        (
            nf = aA_Module[aa_pgm]
            { 
                aa_pgm->Add_Module(nf);
            }
        )*

    ;



//-----------------------------------------------------------------------------------------------
// aA_Module: MODULE aA_Label aA_In_Args aA_Out_Args (aA_Object_Declarations)? LBRACE aA_Atomic_Statement_Sequence RBRACE
//-----------------------------------------------------------------------------------------------
aA_Module[AaProgram* aa_pgm] returns [AaModule* new_module]
{
    string lbl = "";
    new_module = NULL;
    AaStatementSequence* stmts = NULL;
}
    : MODULE lbl = aA_Label 
        {
            new_module = new AaModule(aa_pgm,lbl);
        }
        aA_In_Args[new_module] aA_Out_Args[new_module]
        ( DECLARE aA_Object_Declarations[new_module])?
        LBRACE
            // every statement in the sequence specifies a set of
            // targets (possibly empty) which should be maintained
            // by the containing scope as implicit variable 
            // definitions
            stmts = aA_Atomic_Statement_Sequence[new_module] 
            {new_module->Set_Statement_Sequence(stmts);}
        RBRACE
    ;


//-----------------------------------------------------------------------------------------------
// aA_Label : LBRACKET SIMPLE_IDENTIFIER RBRACKET
//-----------------------------------------------------------------------------------------------
aA_Label returns [string lbl]
    : LBRACKET id:SIMPLE_IDENTIFIER  { lbl = id->getText(); } RBRACKET
    ;

//-----------------------------------------------------------------------------------------------
// aA_In_Args : IN LPAREN (Aa_Interface_Object_Declaration)* RPAREN
//-----------------------------------------------------------------------------------------------
aA_In_Args[AaModule* parent] 
{
    AaInterfaceObject* obj;
    string mode = "in";
}
    : IN LPAREN (obj = aA_Interface_Object_Declaration[parent,mode] {parent->Add_Argument(obj);})* RPAREN
    ;

//-----------------------------------------------------------------------------------------------
// aA_Out_Args : OUT LPAREN (Aa_Interface_Object_Declaration)* RPAREN
//-----------------------------------------------------------------------------------------------
aA_Out_Args[AaModule* parent] 
{
    AaInterfaceObject* obj;
    string mode = "out";
}
    : OUT LPAREN (obj = aA_Interface_Object_Declaration[parent,"out"] {parent->Add_Argument(obj);})* RPAREN
    ;

//-----------------------------------------------------------------------------------------------
// aA_Atomic_Statement : aA_Assignment | aA_Call | aA_Block_Statement
//-----------------------------------------------------------------------------------------------
aA_Atomic_Statement[AaScope* scope] returns [AaStatement* stmt]
    : stmt = aA_Assignment[scope] |
        stmt = aA_Call[scope] |
        stmt = aA_Null[scope] |
        stmt = aA_Block_Statement[scope]
    ;

//-----------------------------------------------------------------------------------------------
// aA_Null : NuLL
//-----------------------------------------------------------------------------------------------
aA_Null[AaScope* scope] returns[AaStatement* new_stmt]
    : NuLL 
        {
            // NuLL statements have no labels.
            new_stmt = new AaNullStatement(scope);
        }
    ;

//-----------------------------------------------------------------------------------------------
// aA_Assignment: aA_Object_Reference ASSIGN aA_Expression
//-----------------------------------------------------------------------------------------------
aA_Assignment[AaScope* scope] returns[AaStatement* new_stmt]
{
    AaObjectReference* target = NULL;
    AaExpression* source = NULL;
}
    :   
        // The target defines the label only if it is not
        // a declared global/local/pipe
        (target = aA_Object_Reference[scope]) 
        ASSIGN
        (source = aA_Expression[scope])
        {
            new_stmt = new AaAssignmentStatement(scope,target,source);
        }
    ;

//-----------------------------------------------------------------------------------------------
// aA_Call: aA_Argv_Out := SIMPLE_IDENTIFIER aA_Argv_In
//-----------------------------------------------------------------------------------------------
aA_Call[AaScope* scope] returns[AaStatement* new_stmt]
{
    vector<AaObjectReference*> input_args;
    vector<AaObjectReference*> output_args;
    string func_name = "";
}
    : 
        aA_Argv_Out[scope, output_args] 
        ASSIGN
        id:SIMPLE_IDENTIFIER { func_name = id->getText(); }
        aA_Argv_In[scope, input_args] 
        // the statement implicitly defines all variables in the output arg list
        // (except for a declared global/local/pipe)
        {
            new_stmt = new AaCallStatement(scope,func_name,input_args,output_args);
        }
    ;


//-----------------------------------------------------------------------------------------------
// aA_Block_Statement : aA_Series_Block_Statement | aA_Parallel_Block_Statement | aA_Fork_Block_Statement | aA_Branch_Block_Statement
//-----------------------------------------------------------------------------------------------
aA_Block_Statement[AaScope* scope] returns [AaStatement* stmt]
    // all block statements are labeled and define a new namespace
    : stmt = aA_Series_Block_Statement[scope] |
        stmt = aA_Parallel_Block_Statement[scope] |
        stmt = aA_Fork_Block_Statement[scope] |
        stmt = aA_Branch_Block_Statement[scope]
    ;


//-----------------------------------------------------------------------------------------------
// aA_Subatomic_Branch_Statement : aA_Merge_Statement | aA_Switch_Statement | aA_If_Statement
//-----------------------------------------------------------------------------------------------
// these are special statements which can occur only inside branchblocks
// they are all unlabeled
aA_Subatomic_Branch_Statement[AaScope* scope] returns [AaStatement* stmt]
    : stmt = aA_Merge_Statement[scope] |
        stmt = aA_Switch_Statement[scope] |
        stmt = aA_If_Statement[scope]
    ;

//-----------------------------------------------------------------------------------------------
// aA_Fork_Block_Statement_Sequence : (aA_Atomic_Statement | aA_Join_Fork_Statement)+
//-----------------------------------------------------------------------------------------------
aA_Fork_Block_Statement_Sequence[AaScope* scope] returns [AaStatementSequence* nsb]
{
	AaStatement* new_statement = NULL;
	vector<AaStatement*> slist;
    nsb = NULL;
} 
    :
        ( 
            new_statement = aA_Atomic_Statement[scope] { slist.push_back(new_statement); }
            |
            new_statement = aA_Join_Fork_Statement[scope] { slist.push_back(new_statement); }
        )+ 
        {
            nsb = new AaStatementSequence(scope,slist);
        }
    ;

//-----------------------------------------------------------------------------------------------
// aA_Branch_Block_Statement_Sequence : (aA_Atomic_Statement | aA_Subatomic_Branch_Statement)+
//-----------------------------------------------------------------------------------------------
aA_Branch_Block_Statement_Sequence[AaScope* scope] returns [AaStatementSequence* nsb]
{
	AaStatement* new_statement = NULL;
	vector<AaStatement*> slist;
    nsb = NULL;
} 
    :
        (
            ( new_statement = aA_Atomic_Statement[scope] | new_statement = aA_Subatomic_Branch_Statement[scope]) 
                { slist.push_back(new_statement); 
                }
        )+ 
        {
            nsb = new AaStatementSequence(scope,slist);
        }
    ;

//-----------------------------------------------------------------------------------------------
// aA_Atomic_Statement_Sequence : (aA_Atomic_Statement)+ 
//-----------------------------------------------------------------------------------------------
aA_Atomic_Statement_Sequence[AaScope* scope] returns [AaStatementSequence* nsb]
{
	AaStatement* new_statement = NULL;
	vector<AaStatement*> slist;
    nsb = NULL;
} 
    :
        ( new_statement = aA_Atomic_Statement[scope] { slist.push_back(new_statement); })+ 
        {
            nsb = new AaStatementSequence(scope,slist);
        }
    ;

//-----------------------------------------------------------------------------------------------
// aA_Series_Block_Statement: SERIESBLOCK LABEL LBRACE aA_Atomic_Statement_Sequence RBRACE
//-----------------------------------------------------------------------------------------------
// a series connection of atomic statements.  control passes down the
// statement sequence
aA_Series_Block_Statement[AaScope* scope] returns [AaSeriesBlockStatement* new_sbs]
{

    string lbl = "";
    AaStatementSequence* sseq = NULL;
} :
        SERIESBLOCK
            (
                lbl = aA_Label 
                {
                    new_sbs = new AaSeriesBlockStatement(scope,lbl);
                }       

        )
        LBRACE
        sseq = aA_Atomic_Statement_Sequence[new_sbs] 
            {
                new_sbs->Set_Statement_Sequence(sseq);
            }
        RBRACE
    ;


//-----------------------------------------------------------------------------------------------
// aA_Parallel_Block_Statement: PARALLELBLOCK LABEL LBRACE aA_Atomic_Statement_Sequence RBRACE
//-----------------------------------------------------------------------------------------------
// a parallel connection of atomic statements.  all statements are started in parallel
// and the block statement terminates when all statements have terminated.
aA_Parallel_Block_Statement[AaScope* scope] returns [AaParallelBlockStatement* new_pbs]
{
    string lbl = "";
    AaStatementSequence* sseq = NULL;

} :
        PARALLELBLOCK 
        (
            lbl = aA_Label 
            {
                new_pbs = new AaParallelBlockStatement(scope,lbl);
            }
        )
        LBRACE
        sseq = aA_Atomic_Statement_Sequence[new_pbs] {new_pbs->Set_Statement_Sequence(sseq);}
        RBRACE
    ;

//-----------------------------------------------------------------------------------------------
// aA_Fork_Block_Statement: FORKBLOCK LABEL LBRACE aA_Fork_Block_Statement_Sequence RBRACE
//-----------------------------------------------------------------------------------------------
// for non series-parallel fork-join structures.  basically describes a directed
// graph with each node being represented by a statement.  In-arcs describe a join
// and out-arcs a fork.  The graph must be acyclic, with a single source node
// and a single sink node.  This is not checked in the grammar and must be done
// by the application.
// 
// All statements inside the forkblock are executed concurrently!  Thus,
// there is an implicit entry point which forks out all the statements in
// the block and an implicit exit point which joins all the statements in
// the block
//-----------------------------------------------------------------------------------------------
aA_Fork_Block_Statement[AaScope* scope] returns [AaForkBlockStatement* new_fbs]
{
    string lbl = "";
    AaStatementSequence* sseq = NULL;
} :
        FORKBLOCK 
        (
            lbl = aA_Label 
            {
                new_fbs = new AaForkBlockStatement(scope,lbl);
            }
        )
        LBRACE
        sseq = aA_Fork_Block_Statement_Sequence[new_fbs] {new_fbs->Set_Statement_Sequence(sseq);}
        RBRACE
    ;


//-----------------------------------------------------------------------------------------------
// aA_Branch_Block_Statement: BRANCHBLOCK LABEL LBRACE aA_Branch_Block_Statement_Sequence RBRACE
//-----------------------------------------------------------------------------------------------
// for specifying arbitrary branching structures with a single token in flight.
// the structure is described by two constructs: a switch/if and a merge.
// These describe a directed graph, with the first statement being the
// entry point and the last statement being the exit point.  
//
// The graph can have directed cycles.  There must be a path from 
// every node inside the graph to the exit point and from the source to 
// every node in the graph.  
//
// The control-flow in this block is sequential
//-----------------------------------------------------------------------------------------------
aA_Branch_Block_Statement[AaScope* scope] returns [AaBranchBlockStatement* new_bbs]
{
    string lbl = "";
    AaStatementSequence* sseq = NULL;
} :
        BRANCHBLOCK 
        (
            lbl = aA_Label 
            {
                new_bbs = new AaBranchBlockStatement(scope,lbl);
            }
        )
        LBRACE
        sseq = aA_Branch_Block_Statement_Sequence[new_bbs] {new_bbs->Set_Statement_Sequence(sseq);}
        RBRACE
    ;


//--------------------------------------------------------------------------------------------------
// aA_Join_Fork_Statement: JOIN LBRACE (aA_Label)* RBRACE (FORK LBRACE aA_Atomic_Statement_Sequence RBRACE)?
//--------------------------------------------------------------------------------------------------
// These statements are not atomic and can occur only inside forkblocks
// each statement is to be interpreted as a node in a directed graph
// with incoming labels describing joined statements and the
// subsequent sequence defining the forked statements.
//
//-----------------------------------------------------------------------------------------------
aA_Join_Fork_Statement[AaScope* scope] returns [AaJoinForkStatement* new_jfs]
{
    new_jfs = new AaJoinForkStatement(scope);
    AaStatementSequence* sseq = NULL;
    string lbl = "";
}
    : JOIN
        LBRACE (lbl = aA_Label {new_jfs->Add_Join_Label(lbl); })+ RBRACE
        (   FORK
            LBRACE
            sseq = aA_Atomic_Statement_Sequence[new_jfs] {new_jfs->Set_Statement_Sequence(sseq);}
            RBRACE
        )?
    ;


//--------------------------------------------------------------------------------------------------
// aA_Merge_Statement: MERGE LPAREN (SIMPLE_IDENTIFIER)* RPAREN ASSIGN LPAREN (aA_Label COLON LPAREN (aA_Simple_Object_Reference)* RPAREN)+ RPAREN
//--------------------------------------------------------------------------------------------------
// The merge statement specifies a set of statements on which it waits.
// exactly one of the statements is expected to be executed, and the merge
// also specifies merging of values by creating a new set of variables
// which is obtained by merging values from the different statements
// which are being merged
//
// The merge statement can occur only inside branchblocks
//--------------------------------------------------------------------------------------------------
aA_Merge_Statement[AaScope* scope] returns [AaMergeStatement* new_mgs]
{

    set<string,StringCompare> target_id_set;
    vector<AaObjectReference*> target_object_vector;

    new_mgs = new AaMergeStatement(scope);

    set<string,StringCompare> source_label_set;
    vector<AaObjectReference*>* object_vector= NULL;

    AaObjectReference* oref;
    string merged_stmt_label;
}
    : MERGE LBRACE
        LPAREN 
        (
            // first get the vector of targets
            id:SIMPLE_IDENTIFIER 
            {
                
                if(target_id_set.find(id->getText()) != target_id_set.end())
                {
                    cerr << "Error: repeated targets in merge spec " << endl;
                    AaRoot::Set_Error(true);
                }
                else
                {
                    target_id_set.insert(id->getText());
                    new_mgs->Add_Target(new AaSimpleObjectReference(new_mgs,id->getText()));
                }
            }
         )+
         RPAREN

        // now get the sources.
        ASSIGN LPAREN 

        (merged_stmt_label = aA_Label 
            {
                if(source_label_set.find(merged_stmt_label) != source_label_set.end())
                {
                    cerr << "Error: repeated statement labels in merge spec " << endl;
                    AaRoot::Set_Error(true);
                }
                else
                {
                    source_label_set.insert(merged_stmt_label);
                    object_vector = new vector<AaObjectReference*>;
                }
            }
            COLON 
            LPAREN
            (oref = aA_Simple_Object_Reference {object_vector->push_back(oref);})* 
            RPAREN
            { 
                if(object_vector->size() != target_id_set.size()) 
                    {
                        cerr << "Error: merge-sources from label " << merged_stmt_label << " do not match targets" << endl;
                        AaRoot::Set_Error(true);
                    }
                else
                    {
                        new_mgs->Add_Source(merged_stmt_label,object_vector);
                        object_vector.clear();
                    }
            }
        
        )+ RPAREN
    ;
            

//----------------------------------------------------------------------------------------------------------
// aA_Switch_Statement : SWITCHSPEC (WHEN aA_Expression THEN LBRACE aA_Atomic_Statement_Sequence RBRACE )+
//----------------------------------------------------------------------------------------------------------
// Incoming control flow is passed on to one of the sequences depending on the conditions.
// A switch can occur only inside a branch statement.  
//
// EXACTLY ONE OF THE ALTERNATIVES MUST BE TAKEN in the control-flow (this is the programmer's problem!)
// If more than one alternative is taken this will result in a run-time error!
// If no alternative is taken, the switch statement will never complete execution!!
//----------------------------------------------------------------------------------------------------------
aA_Switch_Statement[AaScope* scope] returns [AaSwitchStatement* new_ss]
{
    new_ss = new AaSwitchStatement(scope);
    AaStatementSequence* sseq = NULL;
    AaExpression* select_expression = NULL;
}
    : SWITCHSPEC 

        (
            WHEN 
            select_expression=aA_Expression[new_ss]
            THEN 
            LBRACE 
            sseq = aA_Atomic_Statement_Sequence[new_ss]
            {
                new_ss->Add_Choice(select_expression,sseq);
            }
            RBRACE
        )+

    ;


//----------------------------------------------------------------------------------------------------------
//  aA_If_Statement:  IFSPEC aA_Expression THEN LBRACE aA_Atomic_Statement_Sequence RBRACE  ELSE LBRACE aA_Atomic_Statement_Sequence RBRACE
//----------------------------------------------------------------------------------------------------------
// Incoming control flow is passed on to one of the sequences depending on the conditions.
// An IF can occur only inside a branch statement.  
//----------------------------------------------------------------------------------------------------------
aA_If_Statement[AaScope* scope] returns [AaIfStatement* new_is]
{
    AaExpression* if_expression = NULL;
    new_mgs = new AaIfStatement(scope);
    AaStatementSequence* sseq = NULL;
    AaExpression* select_expression = NULL;
}: 
     IFSPEC 
        (if_expression=aA_Expression[new_mgs]) { new_mgs->Set_Test_Expression(if_expression);}
     THEN 
     LBRACE
        sseq = aA_Atomic_Statement_Sequence[new_mgs] 
        {
            new_mgs->Set_If_Sequence(sseq);
        }
     RBRACE 
     ELSE 
     LBRACE
        sseq = aA_Atomic_Statement_Sequence[new_mgs] 
        {
            new_mgs->Set_Else_Sequence(sseq);
        }
      RBRACE
    ;   





//----------------------------------------------------------------------------------------------------------
// aA_Argv_In : (LPAREN (aA_Object_Reference)* RPAREN)
//----------------------------------------------------------------------------------------------------------
// Input args to a function call can be arbitrary (ie global-local-pipe and array refs are permitted)
//----------------------------------------------------------------------------------------------------------

aA_Argv_In[AaScope* scope, vector<AaObjectReference*>& args]
{       
    AaObjectReference* obj = NULL;
}       
    : LPAREN 
            (
                obj = aA_Object_Reference[scope] 
                { 
                    args.push_back(obj); 
                }
            )*
        RPAREN
;


//----------------------------------------------------------------------------------------------------------
// aA_Argv_Out : (LPAREN (SIMPLE_IDENTIFIER)* RPAREN)
//----------------------------------------------------------------------------------------------------------
// Output args to a function must be in the same scope.
//----------------------------------------------------------------------------------------------------------
aA_Argv_Out[AaScope* scope, vector<AaObjectReference*>& args]
{       
    AaObjectReference* obj = NULL;
}       
    :LPAREN 
            (id:SIMPLE_IDENTIFIER 
                {
                    obj = new AaSimpleObjectReference(scope,id->getText());
                    args.push_back(obj); 
                }
        )* 
        RPAREN
;


//----------------------------------------------------------------------------------------------------------
// aA_Expression : aA_Object_Reference | aA_Unary_Expression | aA_Binary_Expression | aA_Ternary_Expression 
//----------------------------------------------------------------------------------------------------------
// Expressions will be fully parenthisized to describe order of evaluation
// e.g. (a and (b or c))
//
// Makes them easy to parse and the parallelism in the evaluation 
// is explicitly described.
//----------------------------------------------------------------------------------------------------------
aA_Expression[AaScope* scope] returns [AaExpression* expr]
:       
    ( 
            (expr = aA_Object_Reference[scope]) |
      (expr = aA_Unary_Expression[scope]) |
      (expr = aA_Binary_Expression[scope]) |
      (expr = aA_Ternary_Expression[scope]) 
    )
;


//----------------------------------------------------------------------------------------------------------
// aA_Unary_Expression : LPAREN ( NOT aA_Expression | LPAREN aA_Type_Reference RPAREN aA_Expression) RPAREN
//----------------------------------------------------------------------------------------------------------
// complement and type-cast expressions.
//----------------------------------------------------------------------------------------------------------
aA_Unary_Expression[AaScope* scope] returns [AaExpression* expr]
{       
    AaStringValue* op = NULL;
    AaExpression* rest = NULL;
    AaExpression* to_type = NULL;
}   
    :   
        LPAREN 
            (
                (NOT {op = new AaStringValue(scope,"not");})
                (rest = aA_Expression[scope])
                {
                    expr = new AaUnaryExpression(scope,op,rest); 
                } 
             )   
                |
            ( 
                LPAREN (to_type = aA_Type_Reference[scope]) RPAREN
                (rest = aA_Expression[scope] )
                {   
                    expr = new AaTypeCastExpression(scope,to_type,rest);
                }
            )
        RPAREN
;

//----------------------------------------------------------------------------------------------------------
// aA_Binary_Expression : LPAREN aA_Expression aA_Binary_Op aA_Expression RPAREN
//----------------------------------------------------------------------------------------------------------
// binary expressions: both operands must be of the same type in all cases
//----------------------------------------------------------------------------------------------------------
aA_Binary_Expression[AaScope* scope] returns [AaExpression* expr]
{
    AaExpression* first;
    AaExpression* second;
    AaStringValue* op;
}
    :   
        LPAREN         
        first = aA_Expression[scope]  
        opid:aA_Binary_Op { op = new AaStringValue(scope,opid->getText()); }
        second = aA_Expression[scope] 
        RPAREN 
        {
            expr = new AaBinaryExpression(scope,op,first,second);
        }
    ;   


//----------------------------------------------------------------------------------------------------------
// aA_Ternary_Expression: LPAREN QUESTION aA_Expression aA_Expression COLON aA_Expression RPAREN
//----------------------------------------------------------------------------------------------------------
// put the ? in the beginning to make it easy to parse
//----------------------------------------------------------------------------------------------------------
aA_Ternary_Expression[AaScope* scope] returns [AaExpression* expr]
{
    AaExpression* testexpr, iftrue, iffalse;
}
: LPAREN 
        QUESTION testexpr = aA_Expression[scope] 
        (iftrue = aA_Expression[scope])  COLON
        (iffalse = aA_Expression[scope])
  RPAREN
        {
            expr = new AaTernaryExpression(scope,testexpr,iftrue,iffalse);
        }
;   

//----------------------------------------------------------------------------------------------------------
// aA_Binary_Op : OR | AND | NOR | NAND | XOR | XNOR | SHL | SHR | PLUS | MINUS | DIV | MUL | EQUAL | NOTEQUAL | LESS | LESSEQUAL | GREATER | GREATEREQUAL 
//----------------------------------------------------------------------------------------------------------
aA_Binary_Op : OR | AND | NOR | NAND | XOR | XNOR | SHL | SHR | PLUS | MINUS | DIV | MUL | EQUAL | NOTEQUAL | LESS | LESSEQUAL | GREATER | GREATEREQUAL ;

//----------------------------------------------------------------------------------------------------------
// aA_Object_Declarations : (aA_Object_Declaration)* 
//----------------------------------------------------------------------------------------------------------
// object declarations allowed only inside modules
//----------------------------------------------------------------------------------------------------------
aA_Object_Declarations[AaModule* scope]
        {
            AaObject* obj;
        }
    :
        (obj = aA_Object_Declaration[scope] { scope->Add_Object(obj); })*
    ;


//----------------------------------------------------------------------------------------------------------
// aA_Object_Declaration : (aA_Global_Object_Declaration | aA_Local_Object_Declaration | aA_Constant_Object_Declaration | aA_Pipe_Object_Declaration)
//----------------------------------------------------------------------------------------------------------
aA_Object_Declaration[AaScope* scope] returns [AaObject* obj]
        : (obj = aA_Global_Object_Declaration[scope]) |
            (obj = aA_Local_Object_Declaration[scope]) |
                (obj = aA_Constant_Object_Declaration[scope]) |
                    (obj = aA_Pipe_Object_Declaration[scope])
        ;

//----------------------------------------------------------------------------------------------------------
// aA_Global_Object_Declaration:  GLOBAL SIMPLE_IDENTIFIER COLON aA_Type_Reference (COLONEQUAL aA_Constant_Literal_Reference)?
//----------------------------------------------------------------------------------------------------------
aA_Global_Object_Declaration[AaScope* scope] returns [AaObject* obj]
        {
            string oname;
            AaType* otype = NULL;
            AaConstantLiteralReference* initial_value = NULL;
        }
        : (GLOBAL aA_Object_Declaration_Base[scope,oname,otype,initial_value])
        {
            obj = new AaGlobal(scope,oname,otype,initial_value);
        }
        ;

//----------------------------------------------------------------------------------------------------------
// aA_Object_Declaration_Base: SIMPLE_IDENTIFIER COLON aA_Type_Reference (COLONEQUAL aA_Constant_Literal_Reference)?
//----------------------------------------------------------------------------------------------------------
aA_Object_Declaration_Base[AaScope* scope, string& oname, AaType*& otype, AaExpression*& initial_value]
        : (id:SIMPLE_IDENTIFIER { oname = id->getText(); })
            (otype = aA_Type_Reference[scope])
            (COLONEQUAL initial_value = aA_Constant_Literal_Reference[scope])?
        ;

//----------------------------------------------------------------------------------------------------------
// aA_Local_Object_Declaration: LOCAL aA_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------
aA_Local_Object_Declaration[AaScope* scope] returns [AaObject* obj]
        {
            string oname;
            AaType* otype = NULL;
            AaExpression* initial_value = NULL;
        }
        : (LOCAL aA_Object_Declaration_Base[scope,oname,otype,initial_value])
        {
            obj = new AaGlobal(scope,oname,otype,initial_value);
        }
        ;


//----------------------------------------------------------------------------------------------------------
// aA_Constant_Object_Declaration: CONSTANT aA_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------
aA_Constant_Object_Declaration[AaScope* scope] returns [AaObject* obj]
        {
            string oname;
            AaType* otype = NULL;
            AaExpression* initial_value = NULL;
        }
        : (CONSTANT aA_Object_Declaration_Base[scope,oname,otype,initial_value])
        {
            obj = new AaConstant(scope,oname,otype,initial_value);
        }
        ;

//----------------------------------------------------------------------------------------------------------
// aA_Pipe_Declaration: PIPE aA_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------
aA_Pipe_Object_Declaration[AaScope* scope] returns [AaObject* obj]
        {
            string oname;
            AaType* otype = NULL;
            AaExpression* initial_value = NULL;
        }
        : (PIPE aA_Object_Declaration_Base[scope,oname,otype,initial_value])
        {
            if(initial_value != NULL)
                cerr << "Warning: ignoring initial value for pipe " << oname << endl;
            obj = new AaPipe(scope,oname,otype);
        }
        ;

//----------------------------------------------------------------------------------------------------------
// aA_Interface_Object_Declaration : aA_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------
aA_Interface_Object_Declaration[AaModule* scope, string mode] returns [AaObject* obj]
    {       
            string oname;
            AaType* otype = NULL;
            AaExpression* initial_value = NULL;
    }
    : ( aA_Object_Declaration_Base[scope,oname,otype,initial_value] )
        {
            if(initial_value != NULL)
                cerr << "Warning: ignoring initial value for interface object " << oname << endl;
            obj = new AaInterfaceObject(scope,oname, otype, mode);
        }
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Type_Reference : aA_Uint_Reference | aA_Int_Reference | aA_Float_Reference | aA_Pointer_Reference | aA_Array_Reference
//----------------------------------------------------------------------------------------------------------
aA_Type_Reference[AaScope* scope] returns [AaType* ref_type]
     :  (ref_type = aA_Uint_Reference[scope]) |
      (ref_type = aA_Int_Reference[scope]) |
      (ref_type = aA_Float_Reference[scope]) |
      (ref_type = aA_Pointer_Reference[scope]) |
      (ref_type = aA_Array_Reference[scope])
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Uint_Reference : UINT LESS UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------
aA_Uint_Reference[AaScope* scope] returns [AaType* ref_type]
{
    unsigned int width;
}
    : UINT LESS w:UINTEGER {width = atoi(w->getText().c_str());} GREATER 
        { 
            ref_type = scope->Make_UInteger_Type(width);
        }
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Int_Reference: INT LESS UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------
aA_Int_Reference[AaScope* scope] returns [AaType* ref_type]
{
    unsigned int width;
}
    : INT LESS w:UINTEGER {width = atoi(w->getText().c_str());} GREATER 
        { 
            ref_type = scope->Make_Integer_Type(width);
        }
    ;


//----------------------------------------------------------------------------------------------------------
// aA_Float_Reference: FLOAT LESS UINTEGER COMMA UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------
aA_Float_Reference[AaScope* scope] returns [AaType* ref_type]
{
    unsigned int c,m;
}
    : FLOAT LESS cs:UINTEGER {c = atoi(cs->getText().c_str());} 
        COMMA
        ms:UINTEGER {m = atoi(ms->getText().c_str()); }
        GREATER 
        { 
            ref_type = scope->Make_Float_Type(c,m);
        }
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Pointer_Reference: POINTER LESS UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------
aA_Pointer_Reference[AaScope* scope] returns [AaType* ref_type]
{
    unsigned int width;
}
    : POINTER LESS w:UINTEGER {width = atoi(w->getText().c_str());} GREATER 
        { 
            ref_type = scope->Make_Pointer_Type(width);
        }
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Array_Reference: ARRAY (LBRACKET UINTEGER RBRACKET)+ OF aA_Type_Reference
//----------------------------------------------------------------------------------------------------------
aA_Array_Reference[AaScope* scope] returns [AaType* ref_type]
{
    vector<int> dims;
    AaType* element_type;
}
    : ARRAY 
        (LESS ds:UINTEGER { dims.push_back(ds->getText().c_str()); } GREATER)+ 
        OF 
        (element_type = aA_Type_Reference[scope])
        {
            ref_type = scope->Make_Array_Type(element_type,dims);
        }
    ;           


//----------------------------------------------------------------------------------------------------------
// aA_Object_Reference : aA_Simple_Object_Reference | aA_Array_Object_Reference 
//----------------------------------------------------------------------------------------------------------
aA_Object_Reference[AaScope* scope] returns [AaObjectReference* obj_ref]
    :
            (obj_ref = aA_Simple_Object_Reference[scope]) |
            (obj_ref = aA_Array_Object_Reference[scope])
    ;

         
//----------------------------------------------------------------------------------------------------------
// aA_Constant_Literal_Reference: (PLUS | MINUS)? ((INTEGER)+ | (FLOAT)+)
//----------------------------------------------------------------------------------------------------------
aA_Constant_Literal_Reference[AaScope* scope] returns [AaObjectReference* obj_ref]
    {
        string full_name;
    }
    : 
        (PLUS | MINUS {full_name += '-';})? 
        ( 
            ( 
                (iid: INTEGER { full_name += iid->getText();} ) 
                |
                (fid: FLOAT { full_name += fid->getText();} ) 
            )
            |
            ( LPAREN 
                ( 
                    (iidv: INTEGER { full_name += iidv->getText() + " ";} )+
                    |
                    (fidv: FLOAT { full_name += fidv->getText() + " ";} )+
                )
              RPAREN
            )
        )
        {
                obj_ref = new AaConstantLiteralReference(scope,full_name);
        }
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Simple_Object_Reference : HIERARCHICAL_IDENTIFIER
//----------------------------------------------------------------------------------------------------------
aA_Simple_Object_Reference[AaScope* scope] returns [AaObjectReference* obj_ref]
{
    string full_name;
}
    : 
        (hid:HIERARCHICAL_IDENTIFIER {full_name = hid->getText();})
        {
            obj_ref = AaSimpleObjectReference(scope,full_name);
        }
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Array_Object_Reference : HIERARCHICAL_IDENTIFIER (DOT aA_Expression)+ 
//----------------------------------------------------------------------------------------------------------
aA_Array_Object_Reference[AaScope* scope] returns [AaObjectReference* obj_ref]
{
    string full_name;
    vector<AaExpression*> indices;
    AaExpression* index_expr;
}
    :
        (hid:HIERARCHICAL_IDENTIFIER {full_name = hid->getText();})
        ("#" index_expr = aA_Expression[scope] {indices.push_back(index_expr); })+

        {
            obj_ref = new AaArrayObjectReference(scope,full_name,indices);
        }
    ;

//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------


// lexer rules
class AaLexer extends Lexer;

options {
	k = 1;
	testLiterals = false;
	charVocabulary = '\3'..'\377';
	defaultErrorHandler=true;
}

// data format
UINTEGER          : (DIGIT)+;
UFLOAT : "." UINTEGER 'E' ('+' | '-') UINTEGER;

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

// Hierarchy
HIERARCHICAL_IDENTIFIER : (("../")+ | (SIMPLE_IDENTIFIER '/')*) '(' SIMPLE_IDENTIFIER ')';

// Identifiers
SIMPLE_IDENTIFIER options {testLiterals=true;} : ALPHA (ALPHA | DIGIT | '_')*; 

// base
protected ALPHA: 'a'..'z'|'A'..'Z';
protected DIGIT:'0'..'9';

