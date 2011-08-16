all: docs

docs: CtestBench.tex
	latex CtestBench.tex
	dvipdf CtestBench.dvi
	rm -f *.aux *.dvi *.log
clean: 
	rm -f *.aux *.dvi *.pdf *.log
