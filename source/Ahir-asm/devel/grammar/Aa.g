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

 TODO: why not permit declarations of $storage,$pipe and $constant
       in each statement block (instead of only in the modules and
       the program)?
 */


header "post_include_cpp" {
}

header "post_include_hpp" {
#include <AaParserClasses.h>
#include <antlr/RecognitionException.hpp>
ANTLR_USING_NAMESPACE(antlr)
}

options {
	language="Cpp";
}

class AaParser extends Parser;

options {
	// go with LL(4) grammar
	k=4;
	defaultErrorHandler=true;
} 
{
    void reportError(RecognitionException &re )
 	{
        AaRoot::Error("Parsing Exception: " + re.toString(),NULL);
 	}
}


//-----------------------------------------------------------------------------------------------
// aA_Program : (aA_Module | (aA_Object_Declaration)+ )*
//-----------------------------------------------------------------------------------------------
aA_Program
{
    AaModule* nf = NULL;
    AaObject* obj = NULL;
    AaScope* null_scope = NULL;
}
    :
        (
            (nf = aA_Module {AaProgram::Add_Module(nf);} )
            |
            (  
                    obj = aA_Object_Declaration[null_scope]  {AaProgram::Add_Object(obj);}
            )
        )*
    ;



//-----------------------------------------------------------------------------------------------
// aA_Module: (FOREIGN)? MODULE aA_Label aA_In_Args aA_Out_Args ((aA_Object_Declarations)+)? LBRACE aA_Atomic_Statement_Sequence RBRACE
//-----------------------------------------------------------------------------------------------
aA_Module returns [AaModule* new_module]
{
    string lbl = "";
    new_module = NULL;
    AaStatementSequence* stmts = NULL;
    AaObject* obj = NULL;
    bool foreign_flag = false;
    bool inline_flag = false;
}
    : (FOREIGN {foreign_flag = true;})? (INLINE {inline_flag = true;})? mt: MODULE 
        lbl = aA_Label 
        {
            new_module = new AaModule(lbl);
            new_module->Set_Foreign_Flag(foreign_flag);
            new_module->Set_Inline_Flag(inline_flag);
            new_module->Set_Line_Number(mt->getLine());
        }
        aA_In_Args[new_module] aA_Out_Args[new_module] (IS
        LBRACE
            // first the declarations in this scope
            (obj = aA_Object_Declaration[new_module] 
            { 
                if(!foreign_flag) 
                    new_module->Add_Object(obj);
                else
                    AaRoot::Error("foreign module cannot have object declarations",new_module);
            })*

            // every statement in the sequence specifies a set of
            // targets (possibly empty) which should be maintained
            // by the containing scope as implicit variable 
            // definitions
            stmts = aA_Atomic_Statement_Sequence[new_module] 
            {
                if(!foreign_flag)
                    new_module->Set_Statement_Sequence(stmts);
                else
                    AaRoot::Error("foreign module cannot have body",new_module);
            }
        RBRACE)?
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
// aA_Atomic_Statement : aA_Assignment_Statement | aA_Call_Statemet | aA_Null_Statement | aA_Block_Statement
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
        al: ASSIGNEQUAL 
        (source = aA_Expression[scope])
        {
            new_stmt = new AaAssignmentStatement(scope,target,source, al->getLine());
            new_stmt->Set_Line_Number(al->getLine());
        }
    ;

//-----------------------------------------------------------------------------------------------
// aA_Call_Statement: CALL aA_Argv_Out aA_Argv_In
//-----------------------------------------------------------------------------------------------
aA_Call_Statement[AaScope* scope] returns[AaStatement* new_stmt]
{
    vector<AaObjectReference*> input_args;
    vector<AaObjectReference*> output_args;
    string func_name = "";
}
    : 
        cl: CALL
        id:SIMPLE_IDENTIFIER { func_name = id->getText(); }
        aA_Argv_In[scope, input_args] 
        aA_Argv_Out[scope, output_args] 
        // the statement implicitly defines all variables in the output arg list
        // (except for a declared global/local/pipe)
        {
            new_stmt = new AaCallStatement(scope,func_name,input_args,output_args,cl->getLine());
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
            ( new_statement = aA_Join_Fork_Statement[scope] { slist.push_back(new_statement); }) 
            |
            ( new_statement = aA_Atomic_Statement[scope] { slist.push_back(new_statement); }) 
        )+ 
        {
            nsb = new AaStatementSequence(scope,slist);
        }
    ;

//-----------------------------------------------------------------------------------------------
// aA_Branch_Block_Statement_Sequence : (aA_Merge_Statement | aA_Switch_Statement | aA_If_Statement | aA_Atomic_Statement )+
//-----------------------------------------------------------------------------------------------
aA_Branch_Block_Statement_Sequence[AaBranchBlockStatement* scope] returns [AaStatementSequence* nsb]
{
	AaStatement* new_statement = NULL;
	vector<AaStatement*> slist;
    nsb = NULL;
} 
    :
        (
            (
                (
                    new_statement = aA_Merge_Statement[scope]
                )   
            |
                (
                    ( new_statement = aA_Switch_Statement[scope] |
                        new_statement = aA_If_Statement[scope] )
                )
            |
                (
                    new_statement = aA_Atomic_Statement[scope]
                )
            |
                (
                    new_statement = aA_Place_Statement[scope]
                )
            )
                     
            { 
                slist.push_back(new_statement); 
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
// aA_Series_Block_Statement: SERIESBLOCK LABEL LBRACE (aA_Object_Declaration)* aA_Atomic_Statement_Sequence RBRACE
//-----------------------------------------------------------------------------------------------
// a series connection of atomic statements.  control passes down the
// statement sequence
aA_Series_Block_Statement[AaScope* scope] returns [AaSeriesBlockStatement* new_sbs]
{
    string lbl = "";
    AaStatementSequence* sseq = NULL;
    AaObject* obj = NULL;
    unsigned int line_number;
} :
        sb: SERIESBLOCK 
        ( lbl = aA_Label )?
        {
                new_sbs = new AaSeriesBlockStatement(scope,lbl);
        }       
            

        LBRACE
        (obj = aA_Object_Declaration[new_sbs] { new_sbs->Add_Object(obj); })*
        sseq = aA_Atomic_Statement_Sequence[new_sbs] 
        {
            new_sbs->Set_Statement_Sequence(sseq);
            new_sbs->Set_Line_Number(sb->getLine());
        }
        RBRACE
    ;


//-----------------------------------------------------------------------------------------------
// aA_Parallel_Block_Statement: PARALLELBLOCK LABEL LBRACE aA_Object_Declaration* aA_Atomic_Statement_Sequence RBRACE
//-----------------------------------------------------------------------------------------------
// a parallel connection of atomic statements.  all statements are started in parallel
// and the block statement terminates when all statements have terminated.
aA_Parallel_Block_Statement[AaScope* scope] returns [AaParallelBlockStatement* new_pbs]
{
    string lbl = "";
    AaStatementSequence* sseq = NULL;
    AaObject* obj = NULL;
    unsigned int line_number;
} :
        pb: PARALLELBLOCK
        ( lbl = aA_Label )?
        {
            new_pbs = new AaParallelBlockStatement(scope,lbl);
            new_pbs->Set_Line_Number(pb->getLine());
        }
        LBRACE
        (obj = aA_Object_Declaration[new_pbs] { new_pbs->Add_Object(obj); })*
        sseq = aA_Atomic_Statement_Sequence[new_pbs] {new_pbs->Set_Statement_Sequence(sseq);}
        RBRACE
    ;

//-----------------------------------------------------------------------------------------------
// aA_Fork_Block_Statement: FORKBLOCK LABEL LBRACE aA_Object_Declaration* aA_Fork_Block_Statement_Sequence RBRACE
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
    AaObject* obj = NULL;
} :
        fb: FORKBLOCK 
        ( lbl = aA_Label         )?
        {
            new_fbs = new AaForkBlockStatement(scope,lbl);
            new_fbs->Set_Line_Number(fb->getLine());
        }
        LBRACE
        (obj = aA_Object_Declaration[new_fbs] { new_fbs->Add_Object(obj); })*
        sseq = aA_Fork_Block_Statement_Sequence[new_fbs] {new_fbs->Set_Statement_Sequence(sseq);}
        RBRACE
    ;


//-----------------------------------------------------------------------------------------------
// aA_Branch_Block_Statement: BRANCHBLOCK LABEL LBRACE aA_Object_Declaration* aA_Branch_Block_Statement_Sequence RBRACE
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
    AaObject* obj = NULL;
} :
        bb: BRANCHBLOCK 
        ( lbl = aA_Label )?
        {
            new_bbs = new AaBranchBlockStatement(scope,lbl);
            new_bbs->Set_Line_Number(bb->getLine());
        }
        LBRACE
        (obj = aA_Object_Declaration[new_bbs] { new_bbs->Add_Object(obj); })*
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
// 
//-----------------------------------------------------------------------------------------------
aA_Join_Fork_Statement[AaForkBlockStatement* scope] returns [AaJoinForkStatement* new_jfs]
{
    new_jfs = new AaJoinForkStatement(scope);
    AaStatementSequence* sseq = NULL;
    string lbl = "";
}
    : jl: JOIN 
        (id: SIMPLE_IDENTIFIER { lbl = id->getText(); new_jfs->Add_Join_Label(lbl); })*
        (FORK
            // new_jfs is not a scope
            sseq = aA_Atomic_Statement_Sequence[scope] 
            {
                new_jfs->Set_Statement_Sequence(sseq);
                new_jfs->Set_Line_Number(jl->getLine());
            }
        )?
      ENDJOIN
    ;

//-----------------------------------------------------------------------------------------------
// aA_Phi_Statement: PHI SIMPLE_IDENTIFIER  :=  ( aA_Object_Reference  ON  (SIMPLE_IDENTIFIER | ENTRY))+
//-----------------------------------------------------------------------------------------------
aA_Phi_Statement[AaBranchBlockStatement* scope, set<string,StringCompare>& lbl_set, AaMergeStatement* pm] returns [AaPhiStatement* new_ps]
{
    new_ps = new AaPhiStatement(scope,pm);
    string label;
    AaExpression* expr;
    AaSimpleObjectReference* target;
    set<string,StringCompare> tset;
}
    : pl: PHI tgt:SIMPLE_IDENTIFIER 
        {
            target = new AaSimpleObjectReference(scope,tgt->getText());
            target->Set_Object_Root_Name(tgt->getText());
            new_ps->Set_Target(target);
            new_ps->Set_Line_Number(pl->getLine());
        }
        ASSIGNEQUAL 
        ( 
            expr = aA_Expression[scope]
            ON
            ( 
                (sid: SIMPLE_IDENTIFIER {label = sid->getText(); }) |
                (eid: ENTRY {label = eid->getText(); })
            )
            {
                bool errflag = false;
                if(lbl_set.find(label) == lbl_set.end())
                {
                    AaRoot::Error("statement label in phi statement is  not in merge label set",new_ps);
                    errflag = true;
                }
                if(tset.find(label) != tset.end())
                {
                    AaRoot::Error("statement label repeated in phi statement",new_ps);
                    errflag = true;
                }
                else
                tset.insert(label);

                if(!errflag)
                { 
                    new_ps->Add_Source_Pair(label,expr); 
                }
            }
        )+ 
;


//-----------------------------------------------------------------------------------------------
// aA_Place_Statement : PLACE aA_Label
//          the token is not forwarded to the next statement in the sequence, but
//          is instead put in the place "label".  It will be consumed by either
//          a merge statement which is looking for the label, or by the exit
//          of the containing branch-block statement if no such merge exists
//-----------------------------------------------------------------------------------------------
aA_Place_Statement[AaBranchBlockStatement* scope] returns[AaStatement* new_stmt]
{
    string lbl = "";
}
    : pl: PLACE lbl = aA_Label 
        {
            new_stmt = new AaPlaceStatement(scope,lbl);
            new_stmt->Set_Line_Number(pl->getLine());
        }
    ;


//--------------------------------------------------------------------------------------------------
// aA_Merge_Statement: MERGE (SIMPLE_IDENTIFIER | ENTRY)+  (aA_Phi_Statement)*
//--------------------------------------------------------------------------------------------------
// This statement specifies a node in the directed graph in a branchblock. 
//
// The merge statement specifies a set of labels of branch statements 
// on which it waits. The statement is triggered by the end of any of these statements.
// (It should not be possible for the merge statement to be retriggered
// while it is in progress).
// 
// The merge executes by creating a new set of variables
// obtained by merging values from the different statements
// which are being merged (specified by the phi statements)
//
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
    : ml: MERGE { new_mgs->Set_Line_Number(ml->getLine()); }
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
            ( ns = aA_Phi_Statement[scope,lbl_set,new_mgs] {  slist.push_back(ns); } )+
        {
            AaStatementSequence* sseq = new AaStatementSequence(scope,slist);
            sseq->Increment_Tab_Depth();
            new_mgs->Set_Statement_Sequence(sseq);

        }
        )?
    ENDMERGE
    ;
            

//----------------------------------------------------------------------------------------------------------
// aA_Switch_Statement : SWITCH Aa_Expression (WHEN aA_Constant_Literal_Reference THEN  aA_Branch_Block_Statement_Sequence )+ (DEFAULT aA_Branch_Block_Statement_Sequence)? ENDSWITCH
//----------------------------------------------------------------------------------------------------------
// Incoming control flow is passed on to one of the sequences depending on the conditions.
// A switch can occur only inside a branch statement.  
//
// A switch statement does not define a new scope.  All implicit variables
// declared in statements in a switch belong to the parent scope of the switch
//----------------------------------------------------------------------------------------------------------
aA_Switch_Statement[AaBranchBlockStatement* scope] returns [AaSwitchStatement* new_ss]
{
    new_ss = new AaSwitchStatement(scope);
    AaStatementSequence* sseq = NULL;
    AaStatementSequence* defseq = NULL;
    AaExpression* select_expression = NULL;
    AaConstantLiteralReference* choice_value = NULL;
}
    : sl:SWITCH 
        select_expression=aA_Expression[scope] 
        (
            WHEN 
            choice_value = aA_Constant_Literal_Reference[scope]
            THEN 
            sseq = aA_Branch_Block_Statement_Sequence[scope]
            {
                sseq->Increment_Tab_Depth();
                new_ss->Add_Choice(choice_value,sseq);
            }
        )*
        (DEFAULT
            defseq = aA_Branch_Block_Statement_Sequence[scope]
        )?
        {
            if(defseq)
                defseq->Increment_Tab_Depth();
            new_ss->Set_Select_Expression(select_expression);
            new_ss->Set_Default_Sequence(defseq);
            new_ss->Set_Line_Number(sl->getLine());
        }
        ENDSWITCH
    ;


//----------------------------------------------------------------------------------------------------------
//  aA_If_Statement:  IF aA_Expression THEN aA_Branch_Block_Statement_Sequence (ELSE aA_Branch_Block_Statement_Sequence)? ENDIF
//----------------------------------------------------------------------------------------------------------
// Incoming control flow is passed on to one of the sequences depending on the conditions.
// An IF can occur only inside a branch statement.  
//
// An IF statement does not define a new scope.  All implicit variables
// declared in statements in an IF belong to the parent scope of the IF
//----------------------------------------------------------------------------------------------------------
aA_If_Statement[AaBranchBlockStatement* scope] returns [AaIfStatement* new_is]
{
    AaExpression* if_expression = NULL;
    new_is = new AaIfStatement(scope);
    AaStatementSequence *ifseq = NULL;
    AaStatementSequence *elseseq = NULL;
    AaExpression* select_expression = NULL;
}: 
     il:IF
        (if_expression=aA_Expression[scope]) { new_is->Set_Test_Expression(if_expression);}
     THEN 
        ifseq = aA_Branch_Block_Statement_Sequence[scope] 
        {
            new_is->Set_If_Sequence(ifseq);
            ifseq->Increment_Tab_Depth();
        }
        (
            ELSE 
            elseseq = aA_Branch_Block_Statement_Sequence[scope] 
            {
                elseseq->Increment_Tab_Depth();
                new_is->Set_Else_Sequence(elseseq);
                new_is->Set_Line_Number(il->getLine());
            }
        )?
     ENDIF
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
                    obj->Set_Object_Root_Name(id->getText());
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
            (expr = aA_Constant_Literal_Reference[scope]) |
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
    AaOperation op;
    AaExpression* rest = NULL;
    AaType* to_type = NULL;
    expr = NULL;
}   
    :   
        lpid: LPAREN 
        (
            (
                (NOT {op = __NOT;})
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
        {
            if(expr) expr->Set_Line_Number(lpid->getLine());
        }
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
    AaOperation opid;
}
    :   
        lp: LPAREN         
        first = aA_Expression[scope]  
        opid = aA_Binary_Op 
        second = aA_Expression[scope] 
        RPAREN 
        {
            expr = new AaBinaryExpression(scope,opid,first,second);
            expr->Set_Line_Number(lp->getLine());
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
: lp: LPAREN 
        MUX testexpr = aA_Expression[scope] 
        (iftrue = aA_Expression[scope])  
        (iffalse = aA_Expression[scope])
  RPAREN
        {
            expr = new AaTernaryExpression(scope,testexpr,iftrue,iffalse);
            expr->Set_Line_Number(lp->getLine());
        }
;   

//----------------------------------------------------------------------------------------------------------
// aA_Binary_Op : OR | AND | NOR | NAND | XOR | XNOR | SHL | SHR | PLUS | MINUS | DIV | MUL | EQUAL | NOTEQUAL | LESS | LESSEQUAL | GREATER | GREATEREQUAL 
//----------------------------------------------------------------------------------------------------------
aA_Binary_Op returns [AaOperation op] : 
        ( id_or:OR {op = __OR;}) |
        ( id_and:AND {op = __AND;}) | 
        ( id_nor:NOR { op = __NOR;}) | 
        ( id_nand:NAND { op = __NAND;}) | 
        ( id_xor:XOR { op = __XOR;}) | 
        ( id_xnor:XNOR { op = __XNOR;}) | 
        ( id_shl:SHL { op = __SHL;}) |
        ( id_shr:SHR { op = __SHR;}) | 
        ( id_plus:PLUS { op = __PLUS;}) | 
        ( id_minus:MINUS { op = __MINUS;}) | 
        ( id_div:DIV { op = __DIV;}) | 
        ( id_mul:MUL { op = __MUL;}) | 
        ( id_EQUAL:EQUAL { op = __EQUAL;}) | 
        ( id_notequal:NOTEQUAL { op = __NOTEQUAL;}) | 
        ( id_less:LESS { op = __LESS;}) | 
        ( id_lessequal:LESSEQUAL { op = __LESSEQUAL;}) | 
        ( id_greater:GREATER { op = __GREATER;}) | 
        ( id_greaterequal:GREATEREQUAL { op = __GREATEREQUAL;}) |
        ( id_bitsel:BITSEL { op = __BITSEL;}) | 
        ( id_concat:CONCAT { op = __CONCAT;})  
    ;


//----------------------------------------------------------------------------------------------------------
// aA_Object_Declaration : (aA_Storage_Object_Declaration | aA_Constant_Object_Declaration | aA_Pipe_Object_Declaration)
//----------------------------------------------------------------------------------------------------------
aA_Object_Declaration[AaScope* scope] returns [AaObject* obj]
        : (obj = aA_Storage_Object_Declaration[scope]) |
        (obj = aA_Constant_Object_Declaration[scope]) |
        (obj = aA_Pipe_Object_Declaration[scope])
        ;

//----------------------------------------------------------------------------------------------------------
// aA_Storage_Object_Declaration:  STORAGE SIMPLE_IDENTIFIER COLON aA_Type_Reference (ASSIGNEQUAL aA_Constant_Literal_Reference)?
//----------------------------------------------------------------------------------------------------------
aA_Storage_Object_Declaration[AaScope* scope] returns [AaObject* obj]
        {
            string oname;
            AaType* otype = NULL;
            AaConstantLiteralReference* initial_value = NULL;
        }
        : (st:STORAGE aA_Object_Declaration_Base[scope,oname,otype,initial_value])
        {

            obj = new AaStorageObject(scope,oname,otype,NULL);
            obj->Set_Line_Number(st->getLine());
            if(initial_value != NULL)
            {
              AaRoot::Warning("initial value not allowed on storage objects, will be ignored.",obj);
              delete initial_value;
            }
        }
        ;

//----------------------------------------------------------------------------------------------------------
// aA_Object_Declaration_Base: SIMPLE_IDENTIFIER COLON aA_Type_Reference (ASSIGNEQUAL aA_Constant_Literal_Reference)?
//----------------------------------------------------------------------------------------------------------
aA_Object_Declaration_Base[AaScope* scope, string& oname, AaType*& otype, AaConstantLiteralReference*& initial_value]
        : (id:SIMPLE_IDENTIFIER { oname = id->getText(); }) COLON
            (otype = aA_Type_Reference[scope])
            (ASSIGNEQUAL initial_value = aA_Constant_Literal_Reference[scope])?
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
        : (st: CONSTANT aA_Object_Declaration_Base[scope,oname,otype,initial_value])
        {
            if(otype->Is("AaArrayType"))
            {
                AaRoot::Error("Currently, Aa constants must have scalar types!", otype);
            }
            else
            {
               obj = new AaConstantObject(scope,oname,otype,initial_value);
               obj->Set_Line_Number(st->getLine());
            }
        }
        ;

//----------------------------------------------------------------------------------------------------------
// aA_Pipe_Object_Declaration: PIPE aA_Object_Declaration_Base
//----------------------------------------------------------------------------------------------------------
aA_Pipe_Object_Declaration[AaScope* scope] returns [AaObject* obj]
        {
            string oname;
            AaType* otype = NULL;
            AaConstantLiteralReference* initial_value = NULL;
        }
        : (st:PIPE aA_Object_Declaration_Base[scope,oname,otype,initial_value])
        {
            if(initial_value != NULL)
                cerr << "Warning: ignoring initial value for pipe " << oname << endl;
            obj = new AaPipeObject(scope,oname,otype);
            obj->Set_Line_Number(st->getLine());
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

            // this is not exact.. but better something than nothing.
            if(scope != NULL)
                obj->Set_Line_Number(scope->Get_Line_Number());
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
        (LBRACKET ds:UINTEGER { dims.push_back(atoi(ds->getText().c_str())); } RBRACKET)
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
    vector<string> hier_ids;
    unsigned int search_ancestor_level = 0;
    string root_name;
}
    : 
        (
            (
                    (
                        PERCENT {full_name += '%';} id:SIMPLE_IDENTIFIER 
                        {
                            full_name += id->getText();
                            hier_ids.push_back(id->getText());
                        }
                    )* 
            |
                    (
                        cid: HASH
                        {
                            full_name += cid->getText();
                            search_ancestor_level++;
                        } 
                    )+ 
            )
            COLON  
                    {
                        full_name += ':';
                    }
        )?
        (sid:SIMPLE_IDENTIFIER {full_name += sid->getText(); root_name = sid->getText(); })
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

            for(unsigned int i=0; i < hier_ids.size(); i++)
                obj_ref->Add_Hier_Id(hier_ids[i]);

            obj_ref->Set_Object_Root_Name(root_name);
            obj_ref->Set_Line_Number(sid->getLine());
        }
    ;

         
//----------------------------------------------------------------------------------------------------------
// aA_Constant_Literal_Reference: aA_Constant_Scalar_Reference | LESS aA_Constant_Scalar_Reference+ GREATER
//----------------------------------------------------------------------------------------------------------
aA_Constant_Literal_Reference[AaScope* scope] returns [AaConstantLiteralReference* obj_ref]
    {
        string full_name;
        vector<string> literals;
        unsigned int line_number;
        unsigned int dlno;
    }
    : 
          (           
           (aA_Integer_Literal_Reference[full_name,literals,dlno]) 
           |
            (lid:LESS  {full_name += lid->getText(); line_number = lid->getLine();}
            (aA_Integer_Literal_Reference[full_name,literals,dlno])+
              gid:GREATER {full_name += gid->getText();} )
           | 
           (aA_Float_Literal_Reference[full_name,literals,dlno])
           |
           (llid:LESS { full_name += llid->getText(); line_number = llid->getLine();}
              (aA_Float_Literal_Reference[full_name,literals,dlno])+ ggid:GREATER 
                      {full_name += ggid->getText();})
         )

        {
                obj_ref = new AaConstantLiteralReference(scope,full_name,literals);
                obj_ref->Set_Line_Number(line_number);
                full_name.clear();
        }
;


//----------------------------------------------------------------------------------------------------------
// aA_Integer_Literal_Reference : (MINUS)? UINTEGER
//----------------------------------------------------------------------------------------------------------
aA_Integer_Literal_Reference[string& full_name, vector<string>& literals, unsigned int& line_number]
{ 
  string sign_char;
}
:
   (( (MINUS {sign_char = "-";})?  iid: UINTEGER 
                 {
                       line_number = iid->getLine();
                       full_name += sign_char +  iid->getText() + " "; 
                       literals.push_back(sign_char + iid->getText());
                 }) |
   (bidv:BINARY
                 { 
                       line_number = bidv->getLine();
                       literals.push_back(bidv->getText()); 
                       full_name += bidv->getText() + " ";
                 }))
;
               

//----------------------------------------------------------------------------------------------------------
// aA_Float_Literal_Reference : (MINUS)? UFLOAT
//----------------------------------------------------------------------------------------------------------
aA_Float_Literal_Reference[string& full_name, vector<string>& literals, unsigned int& line_number]
:
   ( "_f" MINUS {full_name += '-';})?  iid: UFLOAT 
           { 
               full_name += iid->getText(); 
               line_number = iid->getLine(); 
               literals.push_back(full_name); 
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

// language keywords (all start with $)
FOREIGN       : "$foreign";
INLINE        : "$inline";
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
UFLOAT : DIGIT '.' (DIGIT)+ 'e' ('+' | '-') UINTEGER;
BINARY : "_b"  ('0' | '1')+ ;

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

