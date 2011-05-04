# a simple makefile which builds all the Aa related tools
AAHOME=.
AHIRHOME=../../../
SRC=$(AAHOME)/src
INCL=$(AAHOME)/include
OBJ=$(AAHOME)/obj
GRMR=$(AAHOME)/grammar
BIN=$(AAHOME)/bin
DOC=$(AAHOME)/docs
ANTLR2=$(AHIRHOME)antlr2
VALUEINCLUDE=../../Value/include
VALUELIB=../../Value/lib
BOOSTINCLUDE=/usr/local/boost_1_46_1/
INCLUDES=-I$(AAHOME)/include -I$(GRMR) -I$(ANTLR2) -I$(VALUEINCLUDE) -I$(BOOSTINCLUDE)
AHIRINCLUDES=-I$(AHIRHOME) 
HEADERS=$(INCL)/AaRoot.h\
		$(INCL)/AaScope.h\
		$(INCL)/AaType.h\
		$(INCL)/AaValue.h\
		$(INCL)/AaObject.h\
		$(INCL)/AaExpression.h\
		$(INCL)/AaStatement.h\
		$(INCL)/AaModule.h\
		$(INCL)/AaProgram.h\
		$(INCL)/AaUtil.h\
		$(INCL)/AaParse.h\
		$(INCL)/Aa2VC.h

LIBS=-L$(ANTLR2) -L$(VALUELIB)
OBJS=$(OBJ)/AaLexer.o $(OBJ)/AaParser.o\
		$(OBJ)/AaRoot.o\
		$(OBJ)/AaScope.o\
		$(OBJ)/AaType.o\
		$(OBJ)/AaValue.o\
		$(OBJ)/AaObject.o\
		$(OBJ)/AaExpression.o\
		$(OBJ)/AaExpressionWriteVCLoadStore.o\
		$(OBJ)/AaExpressionWriteVCOptimized.o\
		$(OBJ)/AaStatement.o\
		$(OBJ)/AaStatementWriteVCOptimized.o\
		$(OBJ)/AaModule.o\
		$(OBJ)/AaProgram.o\
		$(OBJ)/AaUtil.o\
		$(OBJ)/AaParse.o\
		$(OBJ)/Aa2VCWrite.o

DEFS=-DDebug
CXXFLAGS=-g
GCC=g++


all : aNTLR $(BIN)/AaAnalyze $(BIN)/AaLinkExtMem $(INCL)/Aa2C.h $(BIN)/Aa2C $(GRMR)/AaParser.html  $(BIN)/Aa2VC


$(BIN)/AaAnalyze : $(OBJS) $(OBJ)/TestAaParser.o
	$(GCC) $(CXXFLAGS) $(LIBS) $(OBJ)/TestAaParser.o  $(OBJS) -lantlr-4.0.3 -lValue -o $(BIN)/AaAnalyze 

$(BIN)/AaLinkExtMem : $(OBJS) $(OBJ)/AaLinkExtMem.o
	$(GCC) $(CXXFLAGS) $(LIBS) $(OBJ)/AaLinkExtMem.o  $(OBJS) -lantlr-4.0.3 -lValue -o $(BIN)/AaLinkExtMem 

$(INCL)/Aa2C.h: $(BIN)/AaWriteCHeader
	$(BIN)/AaWriteCHeader > $(INCL)/Aa2C.h

$(BIN)/AaWriteCHeader : $(OBJS) $(OBJ)/AaWriteCHeader.o
	$(GCC) $(CXXFLAGS) $(LIBS) $(OBJ)/AaWriteCHeader.o  $(OBJS) -lantlr-4.0.3 -lValue -o $(BIN)/AaWriteCHeader

$(BIN)/Aa2C : $(OBJS) $(OBJ)/Aa2C.o 
	$(GCC) $(CXXFLAGS) $(LIBS) $(OBJ)/Aa2C.o  $(OBJS) -lantlr-4.0.3 -lValue -o $(BIN)/Aa2C

$(BIN)/Aa2VC : $(OBJS) $(OBJ)/Aa2VC.o 
	$(GCC) $(CXXFLAGS) $(LIBS) $(OBJ)/Aa2VC.o  $(OBJS) -lantlr-4.0.3 -lValue -o $(BIN)/Aa2VC


$(OBJ)/Aa2C.o : $(SRC)/Aa2C.cpp  $(INCL)/Aa2C.h $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/Aa2C.cpp -o $(OBJ)/Aa2C.o

$(OBJ)/Aa2VC.o : $(SRC)/Aa2VC.cpp  $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/Aa2VC.cpp -o $(OBJ)/Aa2VC.o

$(OBJ)/Aa2VCWrite.o : $(SRC)/Aa2VCWrite.cpp  $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/Aa2VCWrite.cpp -o $(OBJ)/Aa2VCWrite.o

$(OBJ)/AaWriteCHeader.o : $(SRC)/AaWriteCHeader.cpp  $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaWriteCHeader.cpp -o $(OBJ)/AaWriteCHeader.o


$(OBJ)/AaProgram.o: $(SRC)/AaProgram.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaProgram.cpp -o $(OBJ)/AaProgram.o

$(OBJ)/AaStatement.o: $(SRC)/AaStatement.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaStatement.cpp -o $(OBJ)/AaStatement.o

$(OBJ)/AaStatementWriteVCOptimized.o: $(SRC)/AaStatementWriteVCOptimized.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaStatementWriteVCOptimized.cpp -o $(OBJ)/AaStatementWriteVCOptimized.o

$(OBJ)/AaModule.o: $(SRC)/AaModule.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaModule.cpp -o $(OBJ)/AaModule.o

$(OBJ)/AaParse.o: $(SRC)/AaParse.cpp $(GRMR)/Aa.g  $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaParse.cpp -o $(OBJ)/AaParse.o

$(OBJ)/AaUtil.o: $(SRC)/AaUtil.cpp $(GRMR)/Aa.g  $(INCL)/AaUtil.h $(INCL)/AaEnums.h
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaUtil.cpp -o $(OBJ)/AaUtil.o

$(OBJ)/AaRoot.o: $(SRC)/AaRoot.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaRoot.cpp -o $(OBJ)/AaRoot.o

$(OBJ)/AaScope.o: $(SRC)/AaScope.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaScope.cpp -o $(OBJ)/AaScope.o

$(OBJ)/AaType.o: $(SRC)/AaType.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaType.cpp -o $(OBJ)/AaType.o

$(OBJ)/AaValue.o: $(SRC)/AaValue.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaValue.cpp -o $(OBJ)/AaValue.o

$(OBJ)/AaObject.o: $(SRC)/AaObject.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaObject.cpp -o $(OBJ)/AaObject.o

$(OBJ)/AaExpression.o: $(SRC)/AaExpression.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaExpression.cpp -o $(OBJ)/AaExpression.o


$(OBJ)/AaExpressionWriteVCLoadStore.o: $(SRC)/AaExpressionWriteVCLoadStore.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaExpressionWriteVCLoadStore.cpp -o $(OBJ)/AaExpressionWriteVCLoadStore.o

$(OBJ)/AaExpressionWriteVCOptimized.o: $(SRC)/AaExpressionWriteVCOptimized.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaExpressionWriteVCOptimized.cpp -o $(OBJ)/AaExpressionWriteVCOptimized.o

$(OBJ)/TestAaParser.o: $(SRC)/TestAaParser.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/TestAaParser.cpp  -o $(OBJ)/TestAaParser.o

$(OBJ)/AaLinkExtMem.o: $(SRC)/AaLinkExtMem.cpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaLinkExtMem.cpp  -o $(OBJ)/AaLinkExtMem.o

$(OBJ)/AaLexer.o: $(GRMR)/AaLexer.cpp $(GRMR)/AaLexer.hpp 
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(GRMR)/AaLexer.cpp -o $(OBJ)/AaLexer.o

$(OBJ)/AaParser.o: $(GRMR)/AaParser.cpp $(GRMR)/AaParser.hpp $(HEADERS)
	$(GCC) $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(GRMR)/AaParser.cpp -o $(OBJ)/AaParser.o

aNTLR: $(GRMR)/AaLexer.cpp $(GRMR)/AaParser.html 

$(GRMR)/AaLexer.cpp: $(GRMR)/Aa.g
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -o $(GRMR) $(GRMR)/Aa.g

$(GRMR)/AaParser.html:
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -html -o $(GRMR) $(GRMR)/Aa.g

clean:
	rm -f $(OBJ)/*.o $(BIN)/TestAaParser $(GRMR)/*.hpp*  $(GRMR)/*.cpp* $(GRMR)/*.html

.PHONY: clean

