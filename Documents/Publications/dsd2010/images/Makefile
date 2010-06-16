
SOURCES := $(wildcard *.dia)
EPS := $(SOURCES:.dia=.eps) $(wildcard *.eps)
PDF := $(SOURCES:.dia=.pdf)

all : $(EPS)

%.pdf : %.eps
	epstopdf $<

%.eps : %.dia
	dia -e $@ $<

