
FIG_IMAGES := $(wildcard *.fig)
EPS_IMAGES := $(FIG_IMAGES:.fig=.eps)

Talk.pdf : Talk.tex $(EPS_IMAGES)
	latex Talk.tex
	dvipdf Talk.dvi

$(EPS_IMAGES): %.eps: %.fig
	fig2dev -L eps $< $@
