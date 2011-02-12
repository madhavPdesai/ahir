# a simple makefile which builds all the Aa related tools
AAHOME=.
AHIRHOME=../../toolset/lib
SRC=$(AAHOME)/src
INCL=$(AAHOME)/include
OBJ=$(AAHOME)/obj
GRMR=$(AAHOME)/grammar
BIN=$(AAHOME)/bin
DOC=$(AAHOME)/docs
ANTLR2=../antlr2
VALUEINCLUDE=../../Value/include
VALUELIB=../../Value/lib
INCLUDES=-I$(AAHOME)/include -I$(GRMR) -I$(ANTLR2) -I$(VALUEINCLUDE)
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
		$(INCL)/AaParse.h

LIBS=-L$(ANTLR2) -L$(VALUELIB)
OBJS=$(OBJ)/AaLexer.o $(OBJ)/AaParser.o\
		$(OBJ)/AaRoot.o\
		$(OBJ)/AaScope.o\
		$(OBJ)/AaType.o\
		$(OBJ)/AaValue.o\
		$(OBJ)/AaObject.o\
		$(OBJ)/AaExpression.o\
		$(OBJ)/AaStatement.o\
		$(OBJ)/AaModule.o\
		$(OBJ)/AaProgram.o\
		$(OBJ)/AaUtil.o\
		$(OBJ)/AaParse.o

DEFS=-DDebug
CXXFLAGS=-g


all : aNTLR $(BIN)/TestAaParser $(INCL)/Aa2C.h $(BIN)/Aa2C $(GRMR)/AaParser.html  $(BIN)/Aa2VC


$(BIN)/TestAaParser : $(OBJS) $(OBJ)/TestAaParser.o
	g++ $(CXXFLAGS) $(LIBS) $(OBJ)/TestAaParser.o  $(OBJS) -lantlr-4.0.3 -lValue -o $(BIN)/TestAaParser 

$(INCL)/Aa2C.h: $(BIN)/AaWriteCHeader
	$(BIN)/AaWriteCHeader > $(INCL)/Aa2C.h

$(BIN)/AaWriteCHeader : $(OBJS) $(OBJ)/AaWriteCHeader.o
	g++ $(CXXFLAGS) $(LIBS) $(OBJ)/AaWriteCHeader.o  $(OBJS) -lantlr-4.0.3 -lValue -o $(BIN)/AaWriteCHeader

$(BIN)/Aa2C : $(OBJS) $(OBJ)/Aa2C.o 
	g++ $(CXXFLAGS) $(LIBS) $(OBJ)/Aa2C.o  $(OBJS) -lantlr-4.0.3 -lValue -o $(BIN)/Aa2C

$(BIN)/Aa2VC : $(OBJS) $(OBJ)/Aa2VC.o 
	g++ $(CXXFLAGS) $(LIBS) $(OBJ)/Aa2VC.o  $(OBJS) -lantlr-4.0.3 -lValue -o $(BIN)/Aa2VC

$(BIN)/Aa2Ahir : $(OBJS) $(OBJ)/Aa2Ahir.o 
	g++ $(CXXFLAGS) $(LIBS) $(OBJ)/Aa2Ahir.o  $(OBJS) -lantlr-4.0.3 -lValue -o $(BIN)/Aa2Ahir

$(OBJ)/Aa2C.o : $(SRC)/Aa2C.cpp  $(INCL)/Aa2C.h $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/Aa2C.cpp -o $(OBJ)/Aa2C.o

$(OBJ)/Aa2VC.o : $(SRC)/Aa2VC.cpp  $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/Aa2VC.cpp -o $(OBJ)/Aa2VC.o

$(OBJ)/Aa2Ahir.o : $(SRC)/Aa2Ahir.cpp  $(INCL)/Aa2Ahir.h $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(AHIRINCLUDES) $(CXXFLAGS) -c $(SRC)/Aa2Ahir.cpp -o $(OBJ)/Aa2Ahir.o

$(OBJ)/AaWriteCHeader.o : $(SRC)/AaWriteCHeader.cpp  $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaWriteCHeader.cpp -o $(OBJ)/AaWriteCHeader.o


$(OBJ)/AaProgram.o: $(SRC)/AaProgram.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaProgram.cpp -o $(OBJ)/AaProgram.o

$(OBJ)/AaStatement.o: $(SRC)/AaStatement.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaStatement.cpp -o $(OBJ)/AaStatement.o

$(OBJ)/AaModule.o: $(SRC)/AaModule.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaModule.cpp -o $(OBJ)/AaModule.o

$(OBJ)/AaParse.o: $(SRC)/AaParse.cpp $(GRMR)/Aa.g  $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaParse.cpp -o $(OBJ)/AaParse.o

$(OBJ)/AaUtil.o: $(SRC)/AaUtil.cpp $(GRMR)/Aa.g  $(INCL)/AaUtil.h $(INCL)/AaEnums.h
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaUtil.cpp -o $(OBJ)/AaUtil.o

$(OBJ)/AaRoot.o: $(SRC)/AaRoot.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaRoot.cpp -o $(OBJ)/AaRoot.o

$(OBJ)/AaScope.o: $(SRC)/AaScope.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaScope.cpp -o $(OBJ)/AaScope.o

$(OBJ)/AaType.o: $(SRC)/AaType.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaType.cpp -o $(OBJ)/AaType.o

$(OBJ)/AaValue.o: $(SRC)/AaValue.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaValue.cpp -o $(OBJ)/AaValue.o

$(OBJ)/AaObject.o: $(SRC)/AaObject.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaObject.cpp -o $(OBJ)/AaObject.o

$(OBJ)/AaExpression.o: $(SRC)/AaExpression.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaExpression.cpp -o $(OBJ)/AaExpression.o


$(OBJ)/TestAaParser.o: $(SRC)/TestAaParser.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/TestAaParser.cpp  -o $(OBJ)/TestAaParser.o

$(OBJ)/AaLexer.o: $(GRMR)/AaLexer.cpp $(GRMR)/AaLexer.hpp 
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(GRMR)/AaLexer.cpp -o $(OBJ)/AaLexer.o

$(OBJ)/AaParser.o: $(GRMR)/AaParser.cpp $(GRMR)/AaParser.hpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(GRMR)/AaParser.cpp -o $(OBJ)/AaParser.o

aNTLR: $(GRMR)/AaLexer.cpp $(GRMR)/AaParser.html 

$(GRMR)/AaLexer.cpp: $(GRMR)/Aa.g
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -o $(GRMR) $(GRMR)/Aa.g

$(GRMR)/AaParser.html:
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -html -o $(GRMR) $(GRMR)/Aa.g

clean:
	rm -f $(OBJ)/*.o $(BIN)/TestAaParser $(GRMR)/*.hpp*  $(GRMR)/*.cpp* $(GRMR)/*.html

.PHONY: clean

