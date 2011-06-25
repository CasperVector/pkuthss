# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2011 Casper Ti. Vector
# Public domain.

# 被编译的主文件的文件名，不包括扩展名。
JOBNAME = pkuthss
# 这个变量的值可以为 latex、pdflatex 或 xelatex。
LATEX = latex
BIBTEX = bibtex
DVIPDF = dvipdfmx

# 如果用 LaTeX 编译，则使用 dvipdfmx 将 dvi 转成 pdf。
ifeq ($(LATEX), latex)
	DODVIPDF = $(DVIPDF) $(JOBNAME)
endif

# 区分是 Windows 环境还是类 UNIX 环境。
# 如果是后者，则 GNU make 将可以检测到已经定义 PATH 环境变量。
ifdef PATH
	MAKE = make
	RM = rm -f
else
	MAKE = mingw32-make
	RM = del
endif

all: img doc

img:
	cd img && $(MAKE)

img-clean:
	cd img && $(MAKE) clean

doc:
	$(LATEX) $(JOBNAME)
	$(BIBTEX) $(JOBNAME)
	$(LATEX) $(JOBNAME)
	$(LATEX) $(JOBNAME)
	$(DODVIPDF)

clear:
	$(RM) $(JOBNAME).log $(JOBNAME).aux $(JOBNAME).out $(JOBNAME).thm\
		$(JOBNAME).toc $(JOBNAME).lof $(JOBNAME).lot $(JOBNAME).blg\
		$(JOBNAME).bbl $(JOBNAME).dvi missfont.log
	$(RM) chap/*.aux

clean: clear img-clean
	$(RM) $(JOBNAME).pdf

.PHONY: img img-clean clear clean

