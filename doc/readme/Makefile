# vim:ts=4:sw=4
#
# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2012,2014 Casper Ti. Vector
# Public domain.

JOBNAME = pkuthss
LATEX = latex
BIBTEX = biber -l zh__pinyin
GBK2UNI = gbk2uni
DVIPDF = dvipdfmx
MAKE = make
RM = rm -f

ifeq ($(LATEX), latex)
	DODVIPDF = $(DVIPDF) $(JOBNAME)
endif
ifeq ($(LATEX), pdflatex)
	DOGBK2UNI = $(GBK2UNI) $(JOBNAME)
endif

doc:
	$(LATEX) $(JOBNAME)
	$(BIBTEX) $(JOBNAME)
	$(DOGBK2UNI)
	$(LATEX) $(JOBNAME)
	$(LATEX) $(JOBNAME)
	$(DODVIPDF)

clean:
	$(RM) $(JOBNAME).{aux,bbl,bcf,blg,dvi,lof,log,lot,run.xml,toc,out{,.bak}} \
		{missfont,texput}.log chap/*.aux

distclean: clean
	$(RM) $(JOBNAME).pdf

