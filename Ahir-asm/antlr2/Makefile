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
OBJS=$(OBJ)/AaLexer.o $(OBJ)/AaParser.o $(OBJ)/TestAaParser.o $(OBJ)/AaParserClasses.o $(OBJ)/AaProgram.o $(OBJ)/AaParse.o
DEFS=-DDebug
all : $(BIN)/TestAaParser $(GRMR)/AaParser.html

$(GRMR)/AaParser.html: $(GRMR)/Aa.g
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -html -o $(GRMR) $(GRMR)/Aa.g

$(BIN)/TestAaParser :$(OBJS)
	g++ -g $(LIBS) $(OBJS) -lantlr-4.0.3 -o $(BIN)/TestAaParser 

$(OBJ)/AaParserClasses.o: $(SRC)/AaParserClasses.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) -g -c $(SRC)/AaParserClasses.cpp -o $(OBJ)/AaParserClasses.o

$(OBJ)/AaProgram.o: $(SRC)/AaProgram.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) -g -c $(SRC)/AaProgram.cpp -o $(OBJ)/AaProgram.o

$(OBJ)/AaParse.o: $(SRC)/AaParse.cpp $(GRMR)/Aa.g  $(INCL)/AaUtil.h
	g++ $(DEFS) $(INCLUDES) -g -c $(SRC)/AaParse.cpp -o $(OBJ)/AaParse.o

$(OBJ)/TestAaParser.o: $(SRC)/TestAaParser.cpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) -g -c $(SRC)/TestAaParser.cpp  -o $(OBJ)/TestAaParser.o

$(OBJ)/AaLexer.o: $(GRMR)/AaLexer.cpp $(GRMR)/AaLexer.hpp $(GRMR)/Aa.g
	g++ $(DEFS) $(INCLUDES) -g -c $(GRMR)/AaLexer.cpp -o $(OBJ)/AaLexer.o

$(OBJ)/AaParser.o: $(GRMR)/AaParser.cpp $(GRMR)/AaParser.hpp $(HEADERS)
	g++ $(DEFS) $(INCLUDES) -g -c $(GRMR)/AaParser.cpp -o $(OBJ)/AaParser.o

$(GRMR)/AaLexer.cpp: $(GRMR)/Aa.g $(HEADERS) 
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -o $(GRMR) $(GRMR)/Aa.g

$(GRMR)/AaParser.cpp: $(GRMR)/AaLexer.cpp

clean:
	rm -f $(OBJ)/*.o $(BIN)/TestAaParser $(GRMR)/*.hpp*  $(GRMR)/*.cpp* $(GRMR)/*.html

.PHONY: clean

