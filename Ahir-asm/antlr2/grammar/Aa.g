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
	defaultErrorHandler=true;
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
    : MODULE 
        lbl = aA_Label 
        {
            new_module = new AaModule(aa_pgm,lbl);
        }
        aA_In_Args[new_module] aA_Out_Args[new_module] IS
        (DECLARE  aA_Object_Declarations[new_module])?
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
    :  (LBRACKET) 
        (id:SIMPLE_IDENTIFIER  { lbl = id->getText(); })  
        (RBRACKET)
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
    : stmt = aA_Assignment_Statement[scope] |
        stmt = aA_Call_Statement[scope] |
        stmt = aA_Null_Statement[scope] |
        stmt = aA_Block_Statement[scope]
    ;

//-----------------------------------------------------------------------------------------------
// aA_Null_Statement : NuLL
//-----------------------------------------------------------------------------------------------
aA_Null_Statement[AaScope* scope] returns[AaStatement* new_stmt]
    : NuLL 
        {
            // NuLL statements have no labels.
            new_stmt = new AaNullStatement(scope);
        }
    ;

//-----------------------------------------------------------------------------------------------
// aA_Assignment: ASSIGN aA_Object_Reference  aA_Expression
//-----------------------------------------------------------------------------------------------
aA_Assignment_Statement[AaScope* scope] returns[AaStatement* new_stmt]
{
    AaObjectReference* target = NULL;
    AaExpression* source = NULL;
}
    : 

        (target = aA_Object_Reference[scope]) 
        ASSIGNEQUAL
        (source = aA_Expression[scope])
        {
            new_stmt = new AaAssignmentStatement(scope,target,source);
        }
    ;

//-----------------------------------------------------------------------------------------------
// aA_Call_Statement: CALL aA_Argv_Out  SIMPLE_IDENTIFIER aA_Argv_In
//-----------------------------------------------------------------------------------------------
aA_Call_Statement[AaScope* scope] returns[AaStatement* new_stmt]
{
    vector<AaObjectReference*> input_args;
    vector<AaObjectReference*> output_args;
    string func_name = "";
}
    : 
        CALL
        id:SIMPLE_IDENTIFIER { func_name = id->getText(); }
        aA_Argv_In[scope, input_args] 
        aA_Argv_Out[scope, output_args] 
        // the statement implicitly defines all variables in the output arg list
        // (except for a declared global/local/pipe)
        {
            new_stmt = new AaCallStatement(scope,func_name,input_args,output_args);
        }
    ;


//-----------------------------------------------------------------------------------------------
// aA_Block_Statement : aA_Series_Block_Statement | aA_Parallel_Block_Statement | aA_Fork_Block_Statement | aA_Branch_Block_Statement
//-----------------------------------------------------------------------------------------------
aA_Block_Statement[AaScope* scope] returns [AaBlockStatement* stmt]
    // all block statements are labeled and define a new namespace
    : stmt = aA_Series_Block_Statement[scope] |
        stmt = aA_Parallel_Block_Statement[scope] |
        stmt = aA_Fork_Block_Statement[scope] |
        stmt = aA_Branch_Block_Statement[scope]
    ;


//-----------------------------------------------------------------------------------------------
// aA_Fork_Block_Statement_Sequence : (aA_Atomic_Statement | aA_Join_Fork_Statement)+
//-----------------------------------------------------------------------------------------------
aA_Fork_Block_Statement_Sequence[AaForkBlockStatement* scope] returns [AaStatementSequence* nsb]
{
	AaStatement* new_statement = NULL;
	vector<AaStatement*> slist;
    nsb = NULL;
} 
    :
        ( 
            new_statement = aA_Join_Fork_Statement[scope] { slist.push_back(new_statement); }
        )+ 
        {
            nsb = new AaStatementSequence(scope,slist);
        }
    ;

//-----------------------------------------------------------------------------------------------
// aA_Branch_Block_Statement_Sequence : (aA_Merge_Statement (aA_Switch_Statement | aA_If_Statement | aA_Exit_Statement)?)+
//-----------------------------------------------------------------------------------------------
aA_Branch_Block_Statement_Sequence[AaBranchBlockStatement* scope] returns [AaStatementSequence* nsb]
{
	AaStatement* new_statement = NULL;
	vector<AaStatement*> slist;
    nsb = NULL;
} 
    :
        (
            // Note: the merge statement is always paired with a switch/if/exit
            //
            ( new_statement = aA_Merge_Statement[scope]) 
            { 
                slist.push_back(new_statement); 
            }
        (
            ( new_statement = aA_Switch_Statement[scope] |
                new_statement = aA_If_Statement[scope] |
                new_statement = aA_Exit_Statement[scope])
            { 
                slist.push_back(new_statement); 
            }
        )?
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
// aA_Block_Statement_Sequence : (aA_Block_Statement)+ 
//-----------------------------------------------------------------------------------------------
aA_Block_Statement_Sequence[AaScope* scope] returns [AaStatementSequence* nsb]
{
	AaStatement* new_statement = NULL;
	vector<AaStatement*> slist;
    nsb = NULL;
} 
    :
        ( new_statement = aA_Block_Statement[scope] { slist.push_back(new_statement); })+ 
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
// aA_Join_Fork_Statement: JOIN (SIMPLE_IDENTIFIER)+ (FORK LBRACE aA_Block_Statement_Sequence RBRACE)?
//--------------------------------------------------------------------------------------------------
// These statements are not atomic and can occur only inside forkblocks
// each statement is to be interpreted as a node in a directed graph
// with incoming labels describing joined statements and the
// subsequent sequence defining the forked statements.
//
//-----------------------------------------------------------------------------------------------
aA_Join_Fork_Statement[AaForkBlockStatement* scope] returns [AaJoinForkStatement* new_jfs]
{
    new_jfs = new AaJoinForkStatement(scope);
    AaStatementSequence* sseq = NULL;
    string lbl = "";
}
    : JOIN 
        (id: SIMPLE_IDENTIFIER { lbl = id->getText(); new_jfs->Add_Join_Label(lbl); })+  
        (   FORK
            sseq = aA_Block_Statement_Sequence[new_jfs] {new_jfs->Set_Statement_Sequence(sseq);}
        )?
    ;

//-----------------------------------------------------------------------------------------------
// aA_Phi_Statement: PHI SIMPLE_IDENTIFIER  :=  ( aA_Object_Reference  ON  (SIMPLE_IDENTIFIER | ENTRY))+
//-----------------------------------------------------------------------------------------------
aA_Phi_Statement[AaMergeStatement* scope, set<string,StringCompare>& lbl_set] returns [AaPhiStatement* new_ps]
{
    new_ps = new AaPhiStatement(scope);
    string label;
    AaObjectReference* obj_ref;
    set<string,StringCompare> tset;
}
    : PHI tgt:SIMPLE_IDENTIFIER 
        {
            new_ps->Set_Target(new AaSimpleObjectReference(scope,tgt->getText()));
        }
        ASSIGNEQUAL
        ( 
            obj_ref = aA_Object_Reference[scope]
            ON
            ( 
                (sid: SIMPLE_IDENTIFIER {label = sid->getText(); }) |
                (eid: ENTRY {label = eid->getText(); })
            )
            {
                bool errflag = false;
                if(lbl_set.find(label) == lbl_set.end())
                {
                    cerr << "Error: statement label in phi not in merge label set" << endl;
                    AaRoot::Error();
                    errflag = true;
                }
                if(tset.find(label) != tset.end())
                {
                    cerr << "Error: statement label repeated in phi " << endl;
                    AaRoot::Error();
                    errflag = true;
                }
                else
                tset.insert(label);

                if(!errflag)
                { 
                    new_ps->Add_Source_Pair(label,obj_ref); 
                }
            }
        )+ 
;


//-----------------------------------------------------------------------------------------------
// aA_Exit_Statement : EXIT
//-----------------------------------------------------------------------------------------------
aA_Exit_Statement[AaScope* scope] returns[AaStatement* new_stmt]
    : EXIT 
        {
            // NuLL statements have no labels.
            new_stmt = new AaExitStatement(scope);
        }
    ;


//--------------------------------------------------------------------------------------------------
// aA_Merge_Statement: MERGE (SIMPLE_IDENTIFIER | ENTRY)+  (aA_Phi_Statement)*
//--------------------------------------------------------------------------------------------------
// This statement specifies a node in the directed graph in a branchblock. 
//
// The in-arcs are specified by the MERGE section and the out-arcs by 
// the SWITCH/IF section
//
// The merge statement specifies a set of labels on which it waits.
// The statement is triggered by the end of any of these statements.
// (It should not be possible for the merge statement to be retriggered
// while it is in progress).
// 
// The merge executes by creating a new set of variables
// obtained by merging values from the different statements
// which are being merged (specified by the phi statements)
//
// The merge is then followed by a (required) branch statement
// (either a switch or an if).  
//
// The merge statement can occur only inside branchblocks
//--------------------------------------------------------------------------------------------------
aA_Merge_Statement[AaBranchBlockStatement* scope] returns [AaMergeStatement* new_mgs]
{
    new_mgs = new AaMergeStatement(scope);
    AaStatement* ns = NULL;
    vector<AaStatement*> slist;
    set<string,StringCompare> lbl_set;
    string lbl;
}
    : MERGE
        ( (id: SIMPLE_IDENTIFIER
            { 
                lbl = id->getText();
                if(lbl_set.find(lbl) == lbl_set.end())
                {
                    new_mgs->Add_Merge_Label(lbl);
                    lbl_set.insert(lbl);
                }
                else
                    cerr << "Warning: ignoring duplicate label in merge " << endl;

            } ) | 
            (eid:ENTRY {lbl = eid->getText(); lbl_set.insert(lbl); new_mgs->Add_Merge_Label(lbl);}))+
        (
            ( ns = aA_Phi_Statement[new_mgs,lbl_set] {  slist.push_back(ns); } )+
        {
            new_mgs->Set_Statement_Sequence(new AaStatementSequence(new_mgs,slist));
        }
        )?
    ;
            

//----------------------------------------------------------------------------------------------------------
// aA_Switch_Statement : SWITCH Aa_Expression (WHEN aA_Constant_Literal_Reference THEN  aA_Block_Statement )+ DEFAULT aA_Block_Statement 
//----------------------------------------------------------------------------------------------------------
// Incoming control flow is passed on to one of the sequences depending on the conditions.
// A switch can occur only inside a branch statement.  
//
// The default is necessary
//----------------------------------------------------------------------------------------------------------
aA_Switch_Statement[AaBranchBlockStatement* scope] returns [AaSwitchStatement* new_ss]
{
    new_ss = new AaSwitchStatement(scope);
    AaBlockStatement* sseq = NULL;
    AaBlockStatement* defseq = NULL;
    AaExpression* select_expression = NULL;
    AaConstantLiteralReference* choice_value = NULL;
}
    : SWITCH 
        select_expression=aA_Expression[new_ss] 
        (
            WHEN 
            choice_value = aA_Constant_Literal_Reference[new_ss]
            THEN 
            sseq = aA_Block_Statement[new_ss]
            {
                new_ss->Add_Choice(choice_value,sseq);
            }
        )+
        (DEFAULT
            defseq = aA_Block_Statement[new_ss]
        )?
        {
            new_ss->Set_Select_Expression(select_expression);
            new_ss->Set_Default_Statement(defseq);
        }
    ;


//----------------------------------------------------------------------------------------------------------
//  aA_If_Statement:  IFSPEC aA_Expression THEN aA_Block_Statement ELSE aA_Block_Statement
//----------------------------------------------------------------------------------------------------------
// Incoming control flow is passed on to one of the sequences depending on the conditions.
// An IF can occur only inside a branch statement.  
//----------------------------------------------------------------------------------------------------------
aA_If_Statement[AaBranchBlockStatement* scope] returns [AaIfStatement* new_is]
{
    AaExpression* if_expression = NULL;
    new_is = new AaIfStatement(scope);
    AaBlockStatement *ifseq = NULL;
    AaBlockStatement *elseseq = NULL;
    AaExpression* select_expression = NULL;
}: 
     IF
        (if_expression=aA_Expression[new_is]) { new_is->Set_Test_Expression(if_expression);}
     THEN 
        ifseq = aA_Block_Statement[new_is] 
        {
            new_is->Set_If_Statement(ifseq);
        }
        (
            ELSE 
            elseseq = aA_Block_Statement[new_is] 
        )
        {
            new_is->Set_Else_Statement(elseseq);
        }
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
    AaType* to_type = NULL;
}   
    :   
        LPAREN 
        (
            (
                (NOT {op = new AaStringValue(scope,"$not");})
                (rest = aA_Expression[scope])
                {
                    expr = new AaUnaryExpression(scope,op,rest); 
                } 
             )   
                |
            (
                CAST

                LPAREN (to_type = aA_Type_Reference[scope]) RPAREN
                (rest = aA_Expression[scope] )
                {   
                    expr = new AaTypeCastExpression(scope,to_type,rest);
                }
            )
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
    string opid;
}
    :   
        LPAREN         
        first = aA_Expression[scope]  
        opid = aA_Binary_Op 
        { op = new AaStringValue(scope,opid); }
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
    AaExpression* testexpr;
    AaExpression* iftrue;
    AaExpression* iffalse;
}
: LPAREN 
        MUX testexpr = aA_Expression[scope] 
        (iftrue = aA_Expression[scope])  
        (iffalse = aA_Expression[scope])
  RPAREN
        {
            expr = new AaTernaryExpression(scope,testexpr,iftrue,iffalse);
        }
;   

//----------------------------------------------------------------------------------------------------------
// aA_Binary_Op : OR | AND | NOR | NAND | XOR | XNOR | SHL | SHR | PLUS | MINUS | DIV | MUL | EQUAL | NOTEQUAL | LESS | LESSEQUAL | GREATER | GREATEREQUAL 
//----------------------------------------------------------------------------------------------------------
aA_Binary_Op returns [string op] : 
        ( id_or:OR {op = id_or->getText();} )  | 
        ( id_and:AND {op = id_and->getText();}) | 
        ( id_nor:NOR { op = id_nor->getText();}) | 
        ( id_nand:NAND { op = id_nand->getText();}) | 
        ( id_xor:XOR { op = id_xor->getText();}) | 
        ( id_xnor:XNOR { op = id_xnor->getText();}) | 
        ( id_shl:SHL { op = id_shl->getText();}) |
        ( id_shr:SHR { op = id_shr->getText();}) | 
        ( id_plus:PLUS { op = id_plus->getText();}) | 
        ( id_minus:MINUS { op = id_minus->getText();}) | 
        ( id_div:DIV { op = id_div->getText();}) | 
        ( id_mul:MUL { op = id_mul->getText();}) | 
        ( id_EQUAL:EQUAL { op = id_EQUAL->getText();}) | 
        ( id_notequal:NOTEQUAL { op = id_notequal->getText();}) | 
        ( id_less:LESS { op = id_less->getText();}) | 
        ( id_lessequal:LESSEQUAL { op = id_lessequal->getText();}) | 
        ( id_greater:GREATER { op = id_greater->getText();}) | 
        ( id_greaterequal:GREATEREQUAL { op = id_greaterequal->getText();});

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
// aA_Global_Object_Declaration:  GLOBAL SIMPLE_IDENTIFIER COLON aA_Type_Reference (ASSIGNEQUAL aA_Constant_Literal_Reference)?
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
// aA_Object_Declaration_Base: SIMPLE_IDENTIFIER COLON aA_Type_Reference (ASSIGNEQUAL aA_Constant_Literal_Reference)?
//----------------------------------------------------------------------------------------------------------
aA_Object_Declaration_Base[AaScope* scope, string& oname, AaType*& otype, AaConstantLiteralReference*& initial_value]
        : (id:SIMPLE_IDENTIFIER { oname = id->getText(); })
            (otype = aA_Type_Reference[scope])
            (ASSIGNEQUAL initial_value = aA_Constant_Literal_Reference[scope])?
        ;

//----------------------------------------------------------------------------------------------------------
// aA_Local_Object_Declaration: LOCAL aA_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------
aA_Local_Object_Declaration[AaScope* scope] returns [AaObject* obj]
        {
            string oname;
            AaType* otype = NULL;
            AaConstantLiteralReference* initial_value = NULL;
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
            AaConstantLiteralReference* initial_value = NULL;
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
            AaConstantLiteralReference* initial_value = NULL;
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
aA_Interface_Object_Declaration[AaModule* scope, string mode] returns [AaInterfaceObject* obj]
    {       
            string oname;
            AaType* otype = NULL;
            AaConstantLiteralReference* initial_value = NULL;
    }
    : ( aA_Object_Declaration_Base[scope,oname,otype,initial_value] )
        {
            if(initial_value != NULL)
                cerr << "Warning: ignoring initial value for interface object " << oname << endl;
            obj = new AaInterfaceObject(scope,oname, otype, mode);
        }
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Scalar_Type_Reference : aA_Uint_Reference | aA_Int_Reference | aA_Float_Reference | aA_Pointer_Reference 
//----------------------------------------------------------------------------------------------------------
aA_Scalar_Type_Reference[AaScope* scope] returns [AaScalarType* ref_type]
     :  (ref_type = aA_Uint_Type_Reference[scope]) |
      (ref_type = aA_Int_Type_Reference[scope]) |
      (ref_type = aA_Float_Type_Reference[scope]) |
      (ref_type = aA_Pointer_Type_Reference[scope]) 
    ;
    
//----------------------------------------------------------------------------------------------------------
// aA_Type_Reference : aA_Uint_Reference | aA_Int_Reference | aA_Float_Reference | aA_Pointer_Reference | aA_Array_Reference
//----------------------------------------------------------------------------------------------------------
aA_Type_Reference[AaScope* scope] returns [AaType* ref_type]
    :  (ref_type = aA_Scalar_Type_Reference[scope]) |
        (ref_type = aA_Array_Type_Reference[scope])
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Uint_Type_Reference : UINT LESS UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------
aA_Uint_Type_Reference[AaScope* scope] returns [AaScalarType* ref_type]
{
    unsigned int width;
}
    : UINT LESS w:UINTEGER {width = atoi(w->getText().c_str());} GREATER 
        { 
            ref_type = AaProgram::Make_Uinteger_Type(width);
        }
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Int_Type_Reference: INT LESS UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------
aA_Int_Type_Reference[AaScope* scope] returns [AaScalarType* ref_type]
{
    unsigned int width;
}
    : INT LESS w:UINTEGER {width = atoi(w->getText().c_str());} GREATER 
        { 
            ref_type = AaProgram::Make_Integer_Type(width);
        }
    ;


//----------------------------------------------------------------------------------------------------------
// aA_Float_Type_Reference: FLOAT LESS UINTEGER COMMA UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------
aA_Float_Type_Reference[AaScope* scope] returns [AaScalarType* ref_type]
{
    unsigned int c,m;
}
    : FLOAT LESS cs:UINTEGER {c = atoi(cs->getText().c_str());} 
        COMMA
        ms:UINTEGER {m = atoi(ms->getText().c_str()); }
        GREATER 
        { 
            ref_type = AaProgram::Make_Float_Type(c,m);
        }
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Pointer_Type_Reference: POINTER LESS UINTEGER GREATER
//----------------------------------------------------------------------------------------------------------
aA_Pointer_Type_Reference[AaScope* scope] returns [AaScalarType* ref_type]
{
    unsigned int width;
}
    : POINTER LESS w:UINTEGER {width = atoi(w->getText().c_str());} GREATER 
        { 
            ref_type = AaProgram::Make_Pointer_Type(width);
        }
    ;

//----------------------------------------------------------------------------------------------------------
// aA_Array_Type_Reference: ARRAY (LBRACKET UINTEGER RBRACKET)+ OF aA_Scalar_Type_Reference
//----------------------------------------------------------------------------------------------------------
aA_Array_Type_Reference[AaScope* scope] returns [AaType* ref_type]
{
    vector<unsigned int> dims;
    AaScalarType* element_type;
}
    : ARRAY 
        (LESS ds:UINTEGER { dims.push_back(atoi(ds->getText().c_str())); } GREATER)+ 
        OF 
        (element_type = aA_Scalar_Type_Reference[scope])
        {
            ref_type = AaProgram::Make_Array_Type(element_type,dims);
        }
    ;           


//----------------------------------------------------------------------------------------------------------
// aA_Object_Reference : HIEARCHICAL_IDENTIFIER (LBRACKET Aa_Object_Reference RBRACKET)*
//----------------------------------------------------------------------------------------------------------
aA_Object_Reference[AaScope* scope] returns [AaObjectReference* obj_ref]
{
    string full_name;
    bool array_flag = false;
    vector<AaExpression*> indices;
    AaExpression* index_expr;
}
    : 

        (((PERCENT {full_name += '%';} id:SIMPLE_IDENTIFIER {full_name += id->getText();})* 
        |
            (cid: CARET {full_name += cid->getText();} )+ )
            COLON {full_name += ':';})?
        (sid:SIMPLE_IDENTIFIER {full_name += sid->getText();})
        (LBRACKET index_expr = aA_Expression[scope]  RBRACKET
            {
                array_flag = true; 
                indices.push_back(index_expr); 
            }
        )*
        {
            if(array_flag)
                obj_ref = new AaArrayObjectReference(scope,full_name,indices);
            else
                obj_ref = new AaSimpleObjectReference(scope,full_name);
        }
    ;

         
//----------------------------------------------------------------------------------------------------------
// aA_Constant_Literal_Reference: (PLUS | MINUS)? ((INTEGER)+ | (FLOAT)+)
//----------------------------------------------------------------------------------------------------------
aA_Constant_Literal_Reference[AaScope* scope] returns [AaConstantLiteralReference* obj_ref]
    {
        string full_name;
    }
    : 

        (PLUS | MINUS {full_name += '-';})? 
        ( 
            ( 
                (iid: UINTEGER { full_name += iid->getText();} ) 
                |
                (fid: UFLOAT { full_name += fid->getText();} ) 
            )
            |
            ( lp: LPAREN { full_name += lp->getText(); }
                ( 
                    (iidv: UINTEGER { full_name += iidv->getText() + " ";} )+
                    |
                    (fidv: UFLOAT { full_name += fidv->getText() + " ";} )+
                )
              rp: RPAREN { full_name += rp->getText(); }
            )
        )

        {
                obj_ref = new AaConstantLiteralReference(scope,full_name);
        }
    ;



//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------


// lexer rules
class AaLexer extends Lexer;

options {
	k = 6;
	testLiterals = true;
	charVocabulary = '\3'..'\377';
	defaultErrorHandler=true;
}


MODULE : "$module";
DECLARE : "$declare";
DEFAULT : "$default";
GLOBAL : "$global";
LOCAL  : "$local";
PIPE : "$pipe";
SERIESBLOCK   : "$seriesblock";
PARALLELBLOCK : "$parallelblock";
FORKBLOCK     : "$forkblock";
BRANCHBLOCK   : "$branchblock";
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
CARET            : '^';

// arithmetic operators
PLUS             : '+' ; // plus
MINUS            : '-' ; // minus
MULTIPLY         : '*' ; // multiply
DIV           : '/' ; // divide

// logical operators
NOT              : "$not"  ;
OR               : "$or"   ;
AND              : "$and"  ;
XOR              : "$xor"  ;
NOR              : "$nor"  ;
NAND             : "$nand" ;
XNOR             : "$xnor" ;

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

