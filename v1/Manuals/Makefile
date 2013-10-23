
LATEX := pdflatex 
LATEX_OPTS := -halt-on-error

BIBTEX := bibtex

.PHONY : images

all : getting-started.pdf

getting-started.pdf : getting-started.tex

%.pdf : %.tex images
	$(LATEX) $(LATEX_OPTS) $<
	if grep -q "LaTeX Warning: Citation" $(<:.tex=.log); \
	then \
		$(BIBTEX) $(BIBTEX_OPTS) $(<:.tex=); \
	fi
	if grep -q "referenced but does not exist" $(<:.tex=.log); \
	then \
		$(LATEX) $(LATEX_OPTS) $<; \
	fi
	while grep -q "Rerun to get cross-references right." $(<:.tex=.log); \
        do \
                $(LATEX) $(LATEX_OPTS) $<; \
        done

images:
	$(MAKE) -C images
