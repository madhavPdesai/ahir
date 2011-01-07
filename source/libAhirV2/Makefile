# a simple makefile which builds all the Aa related tools
vcHOME=.
SRC=$(vcHOME)/src
INCL=$(vcHOME)/include
OBJ=$(vcHOME)/obj
GRMR=$(vcHOME)/grammar
BIN=$(vcHOME)/bin
DOC=$(vcHOME)/docs
ANTLR2=../Ahir-asm/antlr2
INCLUDES=-I$(vcHOME)/include -I$(GRMR) -I$(ANTLR2)
HEADERS=$(INCL)/vcHeader.h

LIBS=-L$(ANTLR2)
OBJS=$(OBJ)/vcLexer.o $(OBJ)/vcParser.o $(OBJ)/vcRoot.o $(OBJ)/vcType.o $(OBJ)/vcValue.o $(OBJ)/vcObject.o\
$(OBJ)/vcControlPath.o $(OBJ)/vcDataPath.o $(OBJ)/vcMemorySpace.o $(OBJ)/vcModule.o $(OBJ)/vcSystem.o

DEFS=-DDebug
CXXFLAGS=-g

all : aNTLR  

aNTLR: $(GRMR)/vcLexer.cpp $(GRMR)/vcParser.html

$(GRMR)/vcLexer.cpp: $(GRMR)/vc.g
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -o $(GRMR) $(GRMR)/vc.g

$(GRMR)/vcParser.html:
	java -cp $(ANTLR2)/antlr.jar antlr.Tool -html -o $(GRMR) $(GRMR)/vc.g

clean:
	rm -f $(GRMR)/*.hpp*  $(GRMR)/*.cpp* $(GRMR)/*.html

.PHONY: clean


##------------------------
##   Directory/file names
##------------------------

SUBDIRS=

HEADER_DIR=include

SRC_DIR=src

OBJ_DIR=obj

DEPENDENCY_FILE=object.dependencies

OBJECT_MODIFIED_FILE_NAME=.objects.last_modified

OBJECT_LAST_MODIFIED_FILES=

OBJECT_LIST_FILE=object.list

TEMP
