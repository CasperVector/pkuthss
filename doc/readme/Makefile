# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2012,2014 Casper Ti. Vector
# Public domain.

JOBNAME = pkuthss
BIBTEX = biber -l zh__pinyin
DVIPDF = dvipdfmx
MAKE = make
RM = rm -f

ifndef LATEX
	LATEX1 = latex
	LATEX2 = xelatex
else
	LATEX1 = $(LATEX)
	LATEX2 = $(LATEX)
endif

ifeq ($(LATEX), latex)
	DODVIPDF = $(DVIPDF) $(JOBNAME)
endif

doc:
	$(LATEX1) $(JOBNAME)
	$(BIBTEX) $(JOBNAME)
	$(LATEX2) $(JOBNAME)
	$(LATEX2) $(JOBNAME)
	$(DODVIPDF)

clean:
	$(RM) $(JOBNAME).{aux,bbl,bcf,blg,dvi,lof,log,lot,run.xml,toc,out{,.bak}} \
		{missfont,texput}.log chap/*.aux

distclean: clean
	$(RM) $(JOBNAME).pdf

# vim:ts=4:sw=4
