AAHOME=.
SRC=$(AAHOME)/src
INCL=$(AAHOME)/include
OBJ=$(AAHOME)/obj
GRMR=$(AAHOME)/grammar
BIN=$(AAHOME)/bin
DOC=$(AAHOME)/docs
ANTLR2=/home/madhav/antlr2
INCLUDES=-I$(AAHOME)/include -I$(GRMR) -I$(ANTLR2)
HEADERS=$(INCL)/*.h
LIBS=-L$(ANTLR2)
OBJS=$(OBJ)/AaLexer.o $(OBJ)/AaParser.o $(OBJ)/AaParserClasses.o $(OBJ)/AaProgram.o $(OBJ)/AaParse.o $(OBJ)/AaStatement.o $(OBJ)/AaModule.o
DEFS=-DDebug
CXXFLAGS=-g
all : $(BIN)/TestAaParser $(BIN)/Aa2C $(GRMR)/AaParser.html $(BIN)/AaWriteCHeader

$(GRMR)/AaParser.html: $(GRMR)/Aa.g
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -html -o $(GRMR) $(GRMR)/Aa.g

$(BIN)/TestAaParser : $(OBJS) $(OBJ)/TestAaParser.o
	g++ $(CXXFLAGS) $(LIBS) $(OBJ)/TestAaParser.o  $(OBJS) -lantlr-4.0.3 -o $(BIN)/TestAaParser 

$(BIN)/AaWriteCHeader : $(OBJS) $(OBJ)/AaWriteCHeader.o
	g++ $(CXXFLAGS) $(LIBS) $(OBJ)/AaWriteCHeader.o  $(OBJS) -lantlr-4.0.3 -o $(BIN)/AaWriteCHeader
	$(BIN)/AaWriteCHeader > $(INCL)/Aa2C.h

$(BIN)/Aa2C : $(OBJS) $(OBJ)/Aa2C.o 
	g++ $(CXXFLAGS) $(LIBS) $(OBJ)/Aa2C.o  $(OBJS) -lantlr-4.0.3 -o $(BIN)/Aa2C

$(OBJ)/Aa2C.o : $(SRC)/Aa2C.cpp  $(INCL)/Aa2C.h $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/Aa2C.cpp -o $(OBJ)/Aa2C.o

$(OBJ)/AaWriteCHeader.o : $(SRC)/AaWriteCHeader.cpp  $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaWriteCHeader.cpp -o $(OBJ)/AaWriteCHeader.o

$(OBJ)/AaParserClasses.o: $(SRC)/AaParserClasses.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaParserClasses.cpp -o $(OBJ)/AaParserClasses.o

$(OBJ)/AaProgram.o: $(SRC)/AaProgram.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaProgram.cpp -o $(OBJ)/AaProgram.o

$(OBJ)/AaStatement.o: $(SRC)/AaStatement.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaStatement.cpp -o $(OBJ)/AaStatement.o

$(OBJ)/AaModule.o: $(SRC)/AaModule.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaModule.cpp -o $(OBJ)/AaModule.o

$(OBJ)/AaParse.o: $(SRC)/AaParse.cpp $(GRMR)/Aa.g  $(INCL)/AaUtil.h
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/AaParse.cpp -o $(OBJ)/AaParse.o

$(OBJ)/TestAaParser.o: $(SRC)/TestAaParser.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(SRC)/TestAaParser.cpp  -o $(OBJ)/TestAaParser.o

$(OBJ)/AaLexer.o: $(GRMR)/AaLexer.cpp $(GRMR)/AaLexer.hpp $(GRMR)/Aa.g
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(GRMR)/AaLexer.cpp -o $(OBJ)/AaLexer.o

$(OBJ)/AaParser.o: $(GRMR)/AaParser.cpp $(GRMR)/AaParser.hpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) $(CXXFLAGS) -c $(GRMR)/AaParser.cpp -o $(OBJ)/AaParser.o

$(GRMR)/AaLexer.cpp: $(GRMR)/Aa.g $(HEADERS) 
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -o $(GRMR) $(GRMR)/Aa.g

$(GRMR)/AaParser.cpp: $(GRMR)/AaLexer.cpp

clean:
	rm -f $(OBJ)/*.o $(BIN)/TestAaParser $(GRMR)/*.hpp*  $(GRMR)/*.cpp* $(GRMR)/*.html

.PHONY: clean

