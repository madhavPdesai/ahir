
FIG_IMAGES := $(wildcard *.fig)
EPS_IMAGES := $(FIG_IMAGES:.fig=.eps)

dsd2010.pdf : dsd2010.tex $(EPS_IMAGES)
	latex dsd2010.tex
	dvipdf dsd2010.dvi

$(EPS_IMAGES): %.eps: %.fig
	fig2dev -L eps $< $@