#ifndef __MY_AST_H__
# define __MY_AST_H__

#include <antlr/CommonAST.hpp>

class MyAST;

typedef ANTLR_USE_NAMESPACE(antlr)ASTRefCount<MyAST> RefMyAST;

/** Custom AST class that adds line numbers to the AST nodes.
 * easily extended with columns. Filenames will take more work since
 * you'll need a custom token class as well (one that contains the
 * filename)
 */
class MyAST : public ANTLR_USE_NAMESPACE(antlr)CommonAST {
public:
   // copy constructor
   MyAST( const MyAST& other )
	: CommonAST(other)
	, line(other.line)
	{
	}
   // Default constructor
   MyAST( void ) : CommonAST(), line(0) {}
   virtual ~MyAST( void ) {}
   // get the line number of the node (or try to derive it from the child node
   virtual int getLine( void ) const
   {
      // most of the time the line number is not set if the node is a
      // imaginary one. Usually this means it has a child. Refer to the
      // child line number. Of course this could be extended a bit.
      // based on an example by Peter Morling.
      if ( line != 0 )
         return line;
      if( getFirstChild() )
         return ( RefMyAST(getFirstChild())->getLine() );
      return 0;
   }
   virtual void setLine( int l )
   {
      line = l;
   }
	/** the initialize methods are called by the tree building constructs
    * depending on which version is called the line number is filled in.
    * e.g. a bit depending on how the node is constructed it will have the
    * line number filled in or not (imaginary nodes!).
    */
   virtual void initialize(int t, const ANTLR_USE_NAMESPACE(std)string& txt)
   {
      CommonAST::initialize(t,txt);
      line = 0;
   }
   virtual void initialize( ANTLR_USE_NAMESPACE(antlr)RefToken t )
   {
      CommonAST::initialize(t);
      line = t->getLine();
   }
   virtual void initialize( RefMyAST ast )
   {
      CommonAST::initialize(ANTLR_USE_NAMESPACE(antlr)RefAST(ast));
      line = ast->getLine();
   }
   // for convenience will also work without
   void addChild( RefMyAST c )
   {
      BaseAST::addChild( ANTLR_USE_NAMESPACE(antlr)RefAST(c) );
   }
   // for convenience will also work without
   void setNextSibling( RefMyAST c )
   {
      BaseAST::setNextSibling( ANTLR_USE_NAMESPACE(antlr)RefAST(c) );
   }
   // provide a clone of the node (no sibling/child pointers are copied)
   virtual ANTLR_USE_NAMESPACE(antlr)RefAST clone( void )
   {
      return ANTLR_USE_NAMESPACE(antlr)RefAST(new MyAST(*this));
   }
   static ANTLR_USE_NAMESPACE(antlr)RefAST factory( void )
   {
      return ANTLR_USE_NAMESPACE(antlr)RefAST(RefMyAST(new MyAST()));
   }
private:
   int line;
};
#endif
