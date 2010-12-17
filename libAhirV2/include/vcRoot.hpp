#ifndef _VC_ROOT_H_
#define _VC_ROOT_H_

#include <vcIncludes.hpp>
// language keywords (all start with $)

enum vcLexerKeytags
  {
    __ATTRIBUTE = 0    	,
    __DPE           ,
    __LIBRARY       ,
    __MEMORYSPACE   	,
    __OBJECT        ,
    __CAPACITY      	,
    __DATAWIDTH     	,
    __ADDRWIDTH     	,
    __MODULE        ,
    __SERIESBLOCK   	,
    __PARALLELBLOCK 	,
    __FORKBLOCK     	,
    __BRANCHBLOCK   	,
    __OF            	,
    __FORK          	,
    __JOIN          	,
    __BRANCH          	,
    __MERGE         	,
    __ENTRY         	,
    __EXIT          	,
    __IN            	,
    __OUT           	,
    __REQS          	,
    __ACKS          	,
    __TRANSITION    		,
    __PLACE         	,
    __HIDDEN        	,
    __COLON	    	, // label separator
    __COMMA        	, // argument-separator, index-separator etc.
    __ASSIGNEQUAL   	, // assignment
    __LESS          	, // less-than
    __GREATER       	, // greater-than
    __IMPLIES       	, 
    __LBRACE        	, // scope open
    __RBRACE        	, // scope close
    __LBRACKET      	, // array index marker
    __RBRACKET      	, // array index marker
    __LPAREN        	, // argument-list
    __RPAREN        	, // argument-list
    __INT           		,
    __FLOAT         		,
    __POINTER       		,
    __ARRAY         	,
    __RECORD        ,
    __PARAMETER    ,
    __PORT ,
    __MAP,
    __DATAPATH,
    __CONTROLPATH,
    __WIRE,
    __MIN,
    __MAX,
    __DPEINSTANCE,
    __LINK,
    __FROM,
    __AT
  };

static char *vcLexerKeywords[] = 
  {   "$attribute"		,
      "$dpe"		,
      "$lib"		,
      "$memoryspace"		,
      "$object"		,
      "$capacity"		,
      "$datawidth"		,
      "$addrwidth"		,
      "$module"		,
      "$seriesblock"		,
      "$parallelblock"		,
      "$forkblock"		,
      "$branchblock"		,
      "$of"		,
      "$fork"		,
      "$join"		,
      "$choose"		,
      "$merge"		,
      "$entry"		,
      "$exit"		,
      "$in"		,
      "$out"		,
      "$reqs"		,
      "$acks"		,
      "$transition"		,
      "$place"		,
      "$hidden"		,
      ":" 		, // label separator
      "," 		, // argument-separator, index-separator etc.
      "=" 		, // assignment
      "<" 		, // less-than
      ">" 		, // greater-than
      "=>"		, // implies
      "{" 		, // scope open
      "}" 		, // scope close
      "[" 		, // array index marker
      "]" 		, // array index marker
      "(" 		, // argument-list
      ")" 		, // argument-list
      "$int"     		,
      "$float"   		,
      "$pointer" 		,
      "$array"		,
      "$record",
      "$parameter",
      "$port",
      "$map",
      "$datapath",
      "$controlpath",
      "$wire",
      "$min",
      "$max",
      "$dpeinstance",
      "$link",
      "$from",
      "$at"
  };

string IntToStr(unsigned int x);

class vcRoot
{
  string _id;
  map<string,string> _attribute_map;

  

 public:
  vcRoot();
  vcRoot(string id);

  

  void Add_Attribute(string tag, string value);
  string Get_Id();
  string Get_Label();

  virtual void Print(ostream& ofile);

  void Print(ofstream& ofile);
  void Print(string& ostring);

  virtual string Kind()
  {
    return("vcRoot");
  }

  bool Is(string class_name)
  {
    return(class_name == this->Kind());
  }

  void Print_Attributes(ostream& ofile);
};

//  compare functor
struct vcRoot_Compare:public binary_function
  <vcRoot*, vcRoot*, bool >
{
  bool operator() (vcRoot*, vcRoot*) const;
};

#endif // vcRoot
