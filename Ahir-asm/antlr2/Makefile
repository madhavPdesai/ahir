AAHOME=.
SRC=$(AAHOME)/src
INCL=$(AAHOME)/include
OBJ=$(AAHOME)/obj
GRMR=$(AAHOME)/grammar
BIN=$(AAHOME)/bin
DOC=$(AAHOME)/docs
ANTLR2=/home/madhav/antlr2
INCLUDES=-I$(AAHOME)/include -I$(GRMR) -I$(ANTLR2)
LIBS=-L$(ANTLR2)
OBJS=$(OBJ)/AaLexer.o $(OBJ)/AaParser.o $(OBJ)/TestAaParser.o $(OBJ)/AaParserClasses.o
DEFS=-DDebug
all : $(BIN)/TestAaParser $(GRMR)/AaParser.html

$(GRMR)/AaParser.html: $(GRMR)/Aa.g
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -html -o $(GRMR) $(GRMR)/Aa.g

$(BIN)/TestAaParser :$(OBJS)
	g++ -g $(LIBS) $(OBJS) -lantlr-4.0.3 -o $(BIN)/TestAaParser 

$(OBJ)/AaParserClasses.o: $(SRC)/AaParserClasses.cpp $(INCL)/AaParserClasses.h
	g++ $(DEFS) $(INCLUDES) -g -c $(SRC)/AaParserClasses.cpp -o $(OBJ)/AaParserClasses.o

$(OBJ)/TestAaParser.o: $(SRC)/TestAaParser.cpp
	g++ $(DEFS) $(INCLUDES) -g -c $(SRC)/TestAaParser.cpp  -o $(OBJ)/TestAaParser.o

$(OBJ)/AaLexer.o: $(GRMR)/AaLexer.cpp $(GRMR)/AaLexer.hpp
	g++ $(DEFS) $(INCLUDES) -g -c $(GRMR)/AaLexer.cpp -o $(OBJ)/AaLexer.o

$(OBJ)/AaParser.o: $(GRMR)/AaParser.cpp $(GRMR)/AaParser.hpp
	g++ $(DEFS) $(INCLUDES) -g -c $(GRMR)/AaParser.cpp -o $(OBJ)/AaParser.o

$(GRMR)/AaLexer.cpp: $(GRMR)/Aa.g $(INCL)/AaParserClasses.h $(SRC)/AaParserClasses.cpp
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -o $(GRMR) $(GRMR)/Aa.g

clean:
	rm -f $(OBJ)/*.o $(BIN)/TestAaParser $(GRMR)/*.hpp*  $(GRMR)/*.cpp* $(GRMR)/*.html

.PHONY: clean

