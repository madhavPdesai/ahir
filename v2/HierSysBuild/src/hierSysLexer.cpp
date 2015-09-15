/* $ANTLR 2.7.7 (2006-11-01): "hierSys.g" -> "hierSysLexer.cpp"$ */
#include "hierSysLexer.hpp"
#include <antlr/CharBuffer.hpp>
#include <antlr/TokenStreamException.hpp>
#include <antlr/TokenStreamIOException.hpp>
#include <antlr/TokenStreamRecognitionException.hpp>
#include <antlr/CharStreamException.hpp>
#include <antlr/CharStreamIOException.hpp>
#include <antlr/NoViableAltForCharException.hpp>

#line 11 "hierSys.g"


#line 15 "hierSysLexer.cpp"
#line 1 "hierSys.g"
#line 17 "hierSysLexer.cpp"
hierSysLexer::hierSysLexer(ANTLR_USE_NAMESPACE(std)istream& in)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(new ANTLR_USE_NAMESPACE(antlr)CharBuffer(in),true)
{
	initLiterals();
}

hierSysLexer::hierSysLexer(ANTLR_USE_NAMESPACE(antlr)InputBuffer& ib)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(ib,true)
{
	initLiterals();
}

hierSysLexer::hierSysLexer(const ANTLR_USE_NAMESPACE(antlr)LexerSharedInputState& state)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(state,true)
{
	initLiterals();
}

void hierSysLexer::initLiterals()
{
}

ANTLR_USE_NAMESPACE(antlr)RefToken hierSysLexer::nextToken()
{
	ANTLR_USE_NAMESPACE(antlr)RefToken theRetToken;
	for (;;) {
		ANTLR_USE_NAMESPACE(antlr)RefToken theRetToken;
		int _ttype = ANTLR_USE_NAMESPACE(antlr)Token::INVALID_TYPE;
		resetText();
		try {   // for lexical and char stream error handling
			switch ( LA(1)) {
			case 0x7b /* '{' */ :
			{
				mLBRACE(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x7d /* '}' */ :
			{
				mRBRACE(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x28 /* '(' */ :
			{
				mLPAREN(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x29 /* ')' */ :
			{
				mRPAREN(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5b /* '[' */ :
			{
				mLBRACKET(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5d /* ']' */ :
			{
				mRBRACKET(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x21 /* '!' */ :
			{
				mNOTEQUAL(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2b /* '+' */ :
			{
				mPLUS(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2d /* '-' */ :
			{
				mMINUS(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2a /* '*' */ :
			{
				mMUL(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x7c /* '|' */ :
			{
				mOR(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5e /* '^' */ :
			{
				mXOR(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x30 /* '0' */ :
			case 0x31 /* '1' */ :
			case 0x32 /* '2' */ :
			case 0x33 /* '3' */ :
			case 0x34 /* '4' */ :
			case 0x35 /* '5' */ :
			case 0x36 /* '6' */ :
			case 0x37 /* '7' */ :
			case 0x38 /* '8' */ :
			case 0x39 /* '9' */ :
			{
				mUINTEGER(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x9 /* '\t' */ :
			case 0xa /* '\n' */ :
			case 0xc /* '\14' */ :
			case 0xd /* '\r' */ :
			case 0x20 /* ' ' */ :
			{
				mWHITESPACE(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2f /* '/' */ :
			{
				mSINGLELINECOMMENT(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x41 /* 'A' */ :
			case 0x42 /* 'B' */ :
			case 0x43 /* 'C' */ :
			case 0x44 /* 'D' */ :
			case 0x45 /* 'E' */ :
			case 0x46 /* 'F' */ :
			case 0x47 /* 'G' */ :
			case 0x48 /* 'H' */ :
			case 0x49 /* 'I' */ :
			case 0x4a /* 'J' */ :
			case 0x4b /* 'K' */ :
			case 0x4c /* 'L' */ :
			case 0x4d /* 'M' */ :
			case 0x4e /* 'N' */ :
			case 0x4f /* 'O' */ :
			case 0x50 /* 'P' */ :
			case 0x51 /* 'Q' */ :
			case 0x52 /* 'R' */ :
			case 0x53 /* 'S' */ :
			case 0x54 /* 'T' */ :
			case 0x55 /* 'U' */ :
			case 0x56 /* 'V' */ :
			case 0x57 /* 'W' */ :
			case 0x58 /* 'X' */ :
			case 0x59 /* 'Y' */ :
			case 0x5a /* 'Z' */ :
			case 0x61 /* 'a' */ :
			case 0x62 /* 'b' */ :
			case 0x63 /* 'c' */ :
			case 0x64 /* 'd' */ :
			case 0x65 /* 'e' */ :
			case 0x66 /* 'f' */ :
			case 0x67 /* 'g' */ :
			case 0x68 /* 'h' */ :
			case 0x69 /* 'i' */ :
			case 0x6a /* 'j' */ :
			case 0x6b /* 'k' */ :
			case 0x6c /* 'l' */ :
			case 0x6d /* 'm' */ :
			case 0x6e /* 'n' */ :
			case 0x6f /* 'o' */ :
			case 0x70 /* 'p' */ :
			case 0x71 /* 'q' */ :
			case 0x72 /* 'r' */ :
			case 0x73 /* 's' */ :
			case 0x74 /* 't' */ :
			case 0x75 /* 'u' */ :
			case 0x76 /* 'v' */ :
			case 0x77 /* 'w' */ :
			case 0x78 /* 'x' */ :
			case 0x79 /* 'y' */ :
			case 0x7a /* 'z' */ :
			{
				mSIMPLE_IDENTIFIER(true);
				theRetToken=_returnToken;
				break;
			}
			default:
				if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x73 /* 's' */ ) && (LA(3) == 0x69 /* 'i' */ ) && (LA(4) == 0x67 /* 'g' */ ) && (LA(5) == 0x6e /* 'n' */ ) && (LA(6) == 0x61 /* 'a' */ )) {
					mSIGNAL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x73 /* 's' */ ) && (LA(3) == 0x69 /* 'i' */ ) && (LA(4) == 0x67 /* 'g' */ ) && (LA(5) == 0x6e /* 'n' */ ) && (LA(6) == 0x65 /* 'e' */ )) {
					mSIGNED(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6c /* 'l' */ ) && (LA(3) == 0x69 /* 'i' */ ) && (LA(4) == 0x66 /* 'f' */ )) {
					mLIFO(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x69 /* 'i' */ ) && (LA(3) == 0x6e /* 'n' */ ) && (LA(4) == 0x73 /* 's' */ )) {
					mINSTANCE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6c /* 'l' */ ) && (LA(3) == 0x69 /* 'i' */ ) && (LA(4) == 0x62 /* 'b' */ )) {
					mLIBRARY(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x69 /* 'i' */ ) && (LA(3) == 0x6e /* 'n' */ ) && (LA(4) == 0x74 /* 't' */ )) {
					mINTEGER(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x75 /* 'u' */ ) && (LA(3) == 0x69 /* 'i' */ )) {
					mUINT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x73 /* 's' */ ) && (LA(3) == 0x79 /* 'y' */ )) {
					mSYSTEM(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x69 /* 'i' */ ) && (LA(3) == 0x6e /* 'n' */ ) && (true)) {
					mIN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6f /* 'o' */ ) && (LA(3) == 0x75 /* 'u' */ )) {
					mOUT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x73 /* 's' */ ) && (LA(3) == 0x74 /* 't' */ )) {
					mSTRING(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x75 /* 'u' */ ) && (LA(3) == 0x6e /* 'n' */ )) {
					mUNSIGNED(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6f /* 'o' */ ) && (LA(3) == 0x66 /* 'f' */ )) {
					mOF(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (LA(2) == 0x3e /* '>' */ )) {
					mIMPLIES(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6d /* 'm' */ )) {
					mMUX(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x76 /* 'v' */ )) {
					mVARIABLE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x63 /* 'c' */ )) {
					mCONSTANT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3a /* ':' */ ) && (LA(2) == 0x3d /* '=' */ )) {
					mASSIGNEQUAL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (LA(2) == 0x3d /* '=' */ )) {
					mEQUAL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3d /* '=' */ )) {
					mLESSEQUAL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (LA(2) == 0x3d /* '=' */ )) {
					mGREATEREQUAL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3c /* '<' */ )) {
					mSHL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (LA(2) == 0x3e /* '>' */ )) {
					mSHR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x6f /* 'o' */ )) {
					mROL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (LA(2) == 0x6f /* 'o' */ )) {
					mROR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (LA(2) == 0x26 /* '&' */ )) {
					mCONCAT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x7c /* '|' */ )) {
					mNOR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x26 /* '&' */ )) {
					mNAND(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x5e /* '^' */ )) {
					mXNOR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x70 /* 'p' */ )) {
					mPIPE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x64 /* 'd' */ )) {
					mDEPTH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x74 /* 't' */ )) {
					mTHREAD(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6e /* 'n' */ )) {
					mNuLL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x65 /* 'e' */ )) {
					mEMIT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x67 /* 'g' */ )) {
					mGOTO(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x61 /* 'a' */ )) {
					mARRAY(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x5f /* '_' */ ) && (LA(2) == 0x62 /* 'b' */ )) {
					mBINARY(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x5f /* '_' */ ) && (LA(2) == 0x68 /* 'h' */ )) {
					mHEXADECIMAL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3a /* ':' */ ) && (true)) {
					mCOLON(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (true)) {
					mLESS(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (true)) {
					mGREATER(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (true)) {
					mNOT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (true)) {
					mAND(true);
					theRetToken=_returnToken;
				}
			else {
				if (LA(1)==EOF_CHAR)
				{
					uponEOF();
					_returnToken = makeToken(ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE);
				}
				else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
			}
			}
			if ( !_returnToken )
				goto tryAgain; // found SKIP token

			_ttype = _returnToken->getType();
			_ttype = testLiteralsTable(_ttype);
			_returnToken->setType(_ttype);
			return _returnToken;
		}
		catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& e) {
			{
				reportError(e);
				consume();
			}
		}
		catch (ANTLR_USE_NAMESPACE(antlr)CharStreamIOException& csie) {
			throw ANTLR_USE_NAMESPACE(antlr)TokenStreamIOException(csie.io);
		}
		catch (ANTLR_USE_NAMESPACE(antlr)CharStreamException& cse) {
			throw ANTLR_USE_NAMESPACE(antlr)TokenStreamException(cse.getMessage());
		}
tryAgain:;
	}
}

void hierSysLexer::mLBRACE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LBRACE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('{' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mRBRACE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RBRACE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('}' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mLPAREN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LPAREN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('(' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mRPAREN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RPAREN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(')' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mIMPLIES(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = IMPLIES;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("=>");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mCOLON(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = COLON;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(":");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mUINT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UINT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$uint");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mLBRACKET(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LBRACKET;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("[");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mRBRACKET(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RBRACKET;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("]");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mMUX(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MUX;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$mux");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mVARIABLE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = VARIABLE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$variable");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mCONSTANT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = CONSTANT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$constant");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mASSIGNEQUAL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ASSIGNEQUAL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(":=");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mEQUAL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EQUAL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("==");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mNOTEQUAL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOTEQUAL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("!=");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mLESS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LESS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('<' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mLESSEQUAL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LESSEQUAL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("<=");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mGREATER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = GREATER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(">");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mGREATEREQUAL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = GREATEREQUAL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(">=");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mSHL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SHL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("<<");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mSHR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SHR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(">>");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mROL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ROL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("<o<");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mROR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ROR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(">o>");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mCONCAT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = CONCAT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("&&");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mPLUS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PLUS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('+' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mMINUS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MINUS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('-' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mMUL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MUL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('*' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mNOT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('~' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('|' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mAND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = AND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('&' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mXOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XOR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('^' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mNOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("~|");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mNAND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NAND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("~&");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mXNOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XNOR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("~^");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mSYSTEM(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SYSTEM;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$system");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mIN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = IN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$in");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mOUT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OUT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$out");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mPIPE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PIPE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$pipe");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mLIFO(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LIFO;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$lifo");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mSIGNAL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SIGNAL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$signal");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mINSTANCE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = INSTANCE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$instance");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mLIBRARY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LIBRARY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$library");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mDEPTH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DEPTH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$depth");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mTHREAD(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = THREAD;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$thread");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mSTRING(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = STRING;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$string");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mNuLL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NuLL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$null");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mEMIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EMIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$emit");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mGOTO(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = GOTO;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$goto");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mINTEGER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = INTEGER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$integer");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mUNSIGNED(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UNSIGNED;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$unsigned");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mSIGNED(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SIGNED;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$signed");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mARRAY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ARRAY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$array");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mOF(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OF;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$of");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mBINARY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BINARY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("_b");
		{ // ( ... )+
		int _cnt208=0;
		for (;;) {
			switch ( LA(1)) {
			case 0x30 /* '0' */ :
			{
				match('0' /* charlit */ );
				break;
			}
			case 0x31 /* '1' */ :
			{
				match('1' /* charlit */ );
				break;
			}
			default:
			{
				if ( _cnt208>=1 ) { goto _loop208; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
			}
			}
			_cnt208++;
		}
		_loop208:;
		}  // ( ... )+
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mHEXADECIMAL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = HEXADECIMAL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("_h");
		{ // ( ... )+
		int _cnt212=0;
		for (;;) {
			switch ( LA(1)) {
			case 0x30 /* '0' */ :
			case 0x31 /* '1' */ :
			case 0x32 /* '2' */ :
			case 0x33 /* '3' */ :
			case 0x34 /* '4' */ :
			case 0x35 /* '5' */ :
			case 0x36 /* '6' */ :
			case 0x37 /* '7' */ :
			case 0x38 /* '8' */ :
			case 0x39 /* '9' */ :
			{
				mDIGIT(false);
				break;
			}
			case 0x41 /* 'A' */ :
			case 0x42 /* 'B' */ :
			case 0x43 /* 'C' */ :
			case 0x44 /* 'D' */ :
			case 0x45 /* 'E' */ :
			case 0x46 /* 'F' */ :
			case 0x61 /* 'a' */ :
			case 0x62 /* 'b' */ :
			case 0x63 /* 'c' */ :
			case 0x64 /* 'd' */ :
			case 0x65 /* 'e' */ :
			case 0x66 /* 'f' */ :
			{
				{
				switch ( LA(1)) {
				case 0x61 /* 'a' */ :
				{
					match('a' /* charlit */ );
					break;
				}
				case 0x62 /* 'b' */ :
				{
					match('b' /* charlit */ );
					break;
				}
				case 0x63 /* 'c' */ :
				{
					match('c' /* charlit */ );
					break;
				}
				case 0x64 /* 'd' */ :
				{
					match('d' /* charlit */ );
					break;
				}
				case 0x65 /* 'e' */ :
				{
					match('e' /* charlit */ );
					break;
				}
				case 0x66 /* 'f' */ :
				{
					match('f' /* charlit */ );
					break;
				}
				case 0x41 /* 'A' */ :
				{
					match('A' /* charlit */ );
					break;
				}
				case 0x42 /* 'B' */ :
				{
					match('B' /* charlit */ );
					break;
				}
				case 0x43 /* 'C' */ :
				{
					match('C' /* charlit */ );
					break;
				}
				case 0x44 /* 'D' */ :
				{
					match('D' /* charlit */ );
					break;
				}
				case 0x45 /* 'E' */ :
				{
					match('E' /* charlit */ );
					break;
				}
				case 0x46 /* 'F' */ :
				{
					match('F' /* charlit */ );
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
				}
				}
				}
				break;
			}
			default:
			{
				if ( _cnt212>=1 ) { goto _loop212; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
			}
			}
			_cnt212++;
		}
		_loop212:;
		}  // ( ... )+
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mDIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		matchRange('0','9');
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mUINTEGER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UINTEGER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		mDIGIT(false);
		{ // ( ... )*
		for (;;) {
			if (((LA(1) >= 0x30 /* '0' */  && LA(1) <= 0x39 /* '9' */ ))) {
				mDIGIT(false);
			}
			else {
				goto _loop215;
			}
			
		}
		_loop215:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mWHITESPACE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = WHITESPACE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case 0x20 /* ' ' */ :
		{
			match(' ' /* charlit */ );
			break;
		}
		case 0x9 /* '\t' */ :
		{
			match('\t' /* charlit */ );
			break;
		}
		case 0xc /* '\14' */ :
		{
			match('\14' /* charlit */ );
			break;
		}
		case 0xd /* '\r' */ :
		{
			match('\r' /* charlit */ );
			break;
		}
		case 0xa /* '\n' */ :
		{
			match('\n' /* charlit */ );
#line 832 "hierSys.g"
			newline();
#line 1733 "hierSysLexer.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
		}
#line 833 "hierSys.g"
		
			_ttype = ANTLR_USE_NAMESPACE(antlr)Token::SKIP; 
		
#line 1746 "hierSysLexer.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mSINGLELINECOMMENT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SINGLELINECOMMENT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		{
		match("//");
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_2.member(LA(1)))) {
				matchNot('\n' /* charlit */ );
			}
			else {
				goto _loop221;
			}
			
		}
		_loop221:;
		} // ( ... )*
		match('\n' /* charlit */ );
#line 841 "hierSys.g"
		newline();
#line 1783 "hierSysLexer.cpp"
		}
#line 843 "hierSys.g"
		
			_ttype = ANTLR_USE_NAMESPACE(antlr)Token::SKIP; 
		
#line 1789 "hierSysLexer.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mSIMPLE_IDENTIFIER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SIMPLE_IDENTIFIER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		mALPHA(false);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case 0x41 /* 'A' */ :
			case 0x42 /* 'B' */ :
			case 0x43 /* 'C' */ :
			case 0x44 /* 'D' */ :
			case 0x45 /* 'E' */ :
			case 0x46 /* 'F' */ :
			case 0x47 /* 'G' */ :
			case 0x48 /* 'H' */ :
			case 0x49 /* 'I' */ :
			case 0x4a /* 'J' */ :
			case 0x4b /* 'K' */ :
			case 0x4c /* 'L' */ :
			case 0x4d /* 'M' */ :
			case 0x4e /* 'N' */ :
			case 0x4f /* 'O' */ :
			case 0x50 /* 'P' */ :
			case 0x51 /* 'Q' */ :
			case 0x52 /* 'R' */ :
			case 0x53 /* 'S' */ :
			case 0x54 /* 'T' */ :
			case 0x55 /* 'U' */ :
			case 0x56 /* 'V' */ :
			case 0x57 /* 'W' */ :
			case 0x58 /* 'X' */ :
			case 0x59 /* 'Y' */ :
			case 0x5a /* 'Z' */ :
			case 0x61 /* 'a' */ :
			case 0x62 /* 'b' */ :
			case 0x63 /* 'c' */ :
			case 0x64 /* 'd' */ :
			case 0x65 /* 'e' */ :
			case 0x66 /* 'f' */ :
			case 0x67 /* 'g' */ :
			case 0x68 /* 'h' */ :
			case 0x69 /* 'i' */ :
			case 0x6a /* 'j' */ :
			case 0x6b /* 'k' */ :
			case 0x6c /* 'l' */ :
			case 0x6d /* 'm' */ :
			case 0x6e /* 'n' */ :
			case 0x6f /* 'o' */ :
			case 0x70 /* 'p' */ :
			case 0x71 /* 'q' */ :
			case 0x72 /* 'r' */ :
			case 0x73 /* 's' */ :
			case 0x74 /* 't' */ :
			case 0x75 /* 'u' */ :
			case 0x76 /* 'v' */ :
			case 0x77 /* 'w' */ :
			case 0x78 /* 'x' */ :
			case 0x79 /* 'y' */ :
			case 0x7a /* 'z' */ :
			{
				mALPHA(false);
				break;
			}
			case 0x30 /* '0' */ :
			case 0x31 /* '1' */ :
			case 0x32 /* '2' */ :
			case 0x33 /* '3' */ :
			case 0x34 /* '4' */ :
			case 0x35 /* '5' */ :
			case 0x36 /* '6' */ :
			case 0x37 /* '7' */ :
			case 0x38 /* '8' */ :
			case 0x39 /* '9' */ :
			{
				mDIGIT(false);
				break;
			}
			case 0x5f /* '_' */ :
			{
				match('_' /* charlit */ );
				break;
			}
			default:
			{
				goto _loop224;
			}
			}
		}
		_loop224:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
	_ttype = testLiteralsTable(_ttype);
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void hierSysLexer::mALPHA(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ALPHA;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		switch ( LA(1)) {
		case 0x61 /* 'a' */ :
		case 0x62 /* 'b' */ :
		case 0x63 /* 'c' */ :
		case 0x64 /* 'd' */ :
		case 0x65 /* 'e' */ :
		case 0x66 /* 'f' */ :
		case 0x67 /* 'g' */ :
		case 0x68 /* 'h' */ :
		case 0x69 /* 'i' */ :
		case 0x6a /* 'j' */ :
		case 0x6b /* 'k' */ :
		case 0x6c /* 'l' */ :
		case 0x6d /* 'm' */ :
		case 0x6e /* 'n' */ :
		case 0x6f /* 'o' */ :
		case 0x70 /* 'p' */ :
		case 0x71 /* 'q' */ :
		case 0x72 /* 'r' */ :
		case 0x73 /* 's' */ :
		case 0x74 /* 't' */ :
		case 0x75 /* 'u' */ :
		case 0x76 /* 'v' */ :
		case 0x77 /* 'w' */ :
		case 0x78 /* 'x' */ :
		case 0x79 /* 'y' */ :
		case 0x7a /* 'z' */ :
		{
			matchRange('a','z');
			break;
		}
		case 0x41 /* 'A' */ :
		case 0x42 /* 'B' */ :
		case 0x43 /* 'C' */ :
		case 0x44 /* 'D' */ :
		case 0x45 /* 'E' */ :
		case 0x46 /* 'F' */ :
		case 0x47 /* 'G' */ :
		case 0x48 /* 'H' */ :
		case 0x49 /* 'I' */ :
		case 0x4a /* 'J' */ :
		case 0x4b /* 'K' */ :
		case 0x4c /* 'L' */ :
		case 0x4d /* 'M' */ :
		case 0x4e /* 'N' */ :
		case 0x4f /* 'O' */ :
		case 0x50 /* 'P' */ :
		case 0x51 /* 'Q' */ :
		case 0x52 /* 'R' */ :
		case 0x53 /* 'S' */ :
		case 0x54 /* 'T' */ :
		case 0x55 /* 'U' */ :
		case 0x56 /* 'V' */ :
		case 0x57 /* 'W' */ :
		case 0x58 /* 'X' */ :
		case 0x59 /* 'Y' */ :
		case 0x5a /* 'Z' */ :
		{
			matchRange('A','Z');
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}


const unsigned long hierSysLexer::_tokenSet_0_data_[] = { 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysLexer::_tokenSet_0(_tokenSet_0_data_,10);
const unsigned long hierSysLexer::_tokenSet_1_data_[] = { 0UL, 67043328UL, 2281701374UL, 134217726UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0 1 2 3 4 5 6 7 8 9 A B C D E 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysLexer::_tokenSet_1(_tokenSet_1_data_,10);
const unsigned long hierSysLexer::_tokenSet_2_data_[] = { 4294966264UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xb 0xc 0xd 0xe 0xf 0x10 0x11 0x12 0x13 
// 0x14 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f   ! \" # 
// $ % & \' ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysLexer::_tokenSet_2(_tokenSet_2_data_,16);

