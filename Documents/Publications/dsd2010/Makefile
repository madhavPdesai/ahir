
LATEX := latex 
LATEX_OPTS := -halt-on-error

BIBTEX := bibtex

.PHONY : images

paper : paper.dvi

paper.dvi : paper.tex images
	$(LATEX) $(LATEX_OPTS) paper.tex
	if grep -q "referenced but does not exist" paper.log; \
	then \
		$(LATEX) $(LATEX_OPTS) paper.tex; \
	fi
	while grep -q "Rerun to get cross-references right." paper.log; \
        do \
                $(LATEX) $(LATEX_OPTS) paper.tex; \
        done

paper.pdf : paper.dvi
	dvipdf paper.dvi

energy.pdf : energy.eps
	epstopdf energy.eps

energy-delay.pdf : energy-delay.eps
	epstopdf energy-delay.eps

energy.eps energy-delay.eps : ppw.plot ppw.dat
	gnuplot ppw.plot

images:
	$(MAKE) -C images

