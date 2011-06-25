# Makefile
# $Id: Makefile 2007-08-11 09:48:29 CST$

JOBNAME=sample

.PHONY: all imgs doc clean

all: imgs doc

imgs:
	cd imgs && make

doc: imgs
	pdflatex $(JOBNAME)
	bibtex $(JOBNAME)
	gbk2uni $(JOBNAME)
	pdflatex $(JOBNAME)
	pdflatex $(JOBNAME)

clean:
	-@rm -f $(JOBNAME).{aux,log,out,out.bak,thm,toc,blg,bbl,ps,dvi} chaps/*.aux
	cd imgs && make clean
