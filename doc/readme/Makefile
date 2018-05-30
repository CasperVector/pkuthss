# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2012,2014-2015,2018 Casper Ti. Vector
# Public domain.

JOB = pkuthss
BIBTEX = biber -l zh__pinyin --output-safechars
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
	DODVIPDF = $(DVIPDF) $(JOB)
endif

doc:
	$(LATEX1) $(JOB)
	$(BIBTEX) $(JOB)
	$(LATEX2) $(JOB)
	$(LATEX2) $(JOB)
	$(DODVIPDF)

clean:
	$(RM) $(JOB).aux $(JOB).bbl $(JOB).bcf $(JOB).blg $(JOB).dvi \
		$(JOB).lof $(JOB).log $(JOB).lot $(JOB).run.xml $(JOB).toc \
		$(JOB).out $(JOB).out.bak missfont.log texput.log chap/*.aux

distclean: clean
	$(RM) $(JOB).pdf

# vim:ts=4:sw=4
