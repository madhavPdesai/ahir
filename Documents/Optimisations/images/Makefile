
DOTFILES := $(wildcard *.dot)
DIAFILES := $(wildcard *.dia)

EPSFILES := $(DOTFILES:.dot=.eps) $(DIAFILES:.dia=.eps)

PDFFILES := $(EPSFILES:.eps=.pdf)

.PHONY : pdf

pdf : $(PDFFILES)

%.pdf : %.eps
	epstopdf $< --outfile $@

%.eps : %.dot
	dot -Teps -o $@ $<

%.eps : %.dia
	dia -e $@ $<