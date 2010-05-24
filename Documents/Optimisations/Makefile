
LATEX := pdflatex -halt-on-error

.PHONY : IMAGES

register-elimination.pdf : register-elimination.tex IMAGES
	$(LATEX) register-elimination.tex


IMAGES :
	$(MAKE) -C images