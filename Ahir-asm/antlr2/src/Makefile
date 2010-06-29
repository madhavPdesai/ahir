AAHOME=/home/madhav/ahir/gitrepo/AhirGit/Documents/Ahir-asm/antlr2
SRC=$(AAHOME)/src
INCL=$(AAHOME)/include
OBJ=$(AAHOME)/obj
GRMR=$(AAHOME)/grammar
BIN=$(AAHOME)/BIN
ANTLR2=/home/madhav/antlr2/
INCLUDES=-I$(HOME)/include -I$(GRMR) -I$(ANTLR2)/include
OBJS=$(OBJ)/TestAaParser.o $(OBJ)/AaParserClasses.o $(OBJ)/AaParser.o $(OBJ)/AaLexer.o
DEFS=-DDebug
all = $(BIN)/TestAaParser

$(BIN)/TestAaParser :$(OBJS)
	g++ -g -o $(BIN)/TestAaParser $(TESTOBJS) $(LIBOBJS)

$(OBJ)/AaParserClasses.o: $(SRC)/AaParserClasses.cpp $(INCL)/AaParserClasses.h
	g++ $(DEFS) $(INCLUDES) -g -c AaParserClasses.cpp -o $(OBJ)/AaParserClasses.o
	mv AaParserClasses.obj ../obj/

$(OBJ)/TestAaParser.o: $(SRC)/TestAaParser.cpp
	g++ $(DEFS) $(INCLUDES) -g -c $(SRC)/TestAaParser.cpp  -o $(OBJS)/TestAaParser.o
	mv TestAaParser.obj ../obj/

$(OBJ)/AaLexer.o: $(GRMR)/AaLexer.cpp $(GRMR)/AaLexer.hpp
	g++ $(DEFS) $(INCLUDES) -g -c $(GRMR)/AaLexer.cpp -o $(OBJ)/AaLexer.o

$(OBJ)/AaLexer.o: $(GRMR)/AaLexer.cpp $(GRMR)/AaLexer.hpp
	g++ $(DEFS) $(INCLUDES) -g -c $(GRMR)/AaLexer.cpp -o $(OBJ)/AaLexer.o

$(OBJ)/AaParser.o: $(GRMR)/AaParser.cpp $(GRMR)/AaParser.hpp
	g++ $(DEFS) $(INCLUDES) -g -c $(GRMR)/AaParser.cpp -o $(OBJ)/AaParser.o

$(GRMR)/AaLexer.cpp: $(GRMR)/Aa.g
	java -cp $(ANTLR2)/antlr.jar -o $(GRMR) $(GRMR)/Aa.g

clean:
	rm -f $(OBJ)/*.o $(BIN)/TestAaParser $(GRMR)/*.hpp  $(GRMR)/*.cpp

.PHONY: clean

