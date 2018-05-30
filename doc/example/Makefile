# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2012,2014-2015,2018 Casper Ti. Vector
# Public domain.

# 被编译的主文件的文件名，不包括扩展名。
JOB = thesis
# 这个变量的值可以为 latex、pdflatex 或 xelatex。
LATEX = latex
BIBTEX = biber -l zh__pinyin --output-safechars
DVIPDF = dvipdfmx

# 如果用 LaTeX 编译，则使用 dvipdfmx 将 dvi 转成 pdf。
ifeq ($(LATEX), latex)
	DODVIPDF = $(DVIPDF) $(JOB)
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

doc:
	$(LATEX) $(JOB)
	$(BIBTEX) $(JOB)
	$(LATEX) $(JOB)
	$(LATEX) $(JOB)
	$(DODVIPDF)

clean:
	$(RM) $(JOB).aux $(JOB).bbl $(JOB).bcf $(JOB).blg $(JOB).dvi \
		$(JOB).lof $(JOB).log $(JOB).lot $(JOB).run.xml $(JOB).toc \
		$(JOB).out $(JOB).out.bak missfont.log texput.log chap/*.aux

distclean: clean
	$(RM) $(JOB).pdf

# vim:ts=4:sw=4
