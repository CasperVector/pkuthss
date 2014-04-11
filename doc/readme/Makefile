# vim:ts=4:sw=4
#
# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2012 Casper Ti. Vector
# Public domain.

# 被编译的主文件的文件名，不包括扩展名。
JOBNAME = pkuthss
# 这个变量的值可以为 latex、pdflatex 或 xelatex。
LATEX = latex
# 如果无法使用 biber，可以改为“bibtex”。
BIBTEX = biber -l zh__pinyin
GBK2UNI = gbk2uni
DVIPDF = dvipdfmx

# 如果用 LaTeX 编译，则使用 dvipdfmx 将 dvi 转成 pdf。
ifeq ($(LATEX), latex)
	DODVIPDF = $(DVIPDF) $(JOBNAME)
endif

# 使用 GBK 编码和 pdflatex 编译方式时，可能需要使用 gbk2uni 转换 .out
# 文件编码，以防书签乱码。
ifeq ($(LATEX), pdflatex)
	# 考虑到可能有用户未安装 gbk2uni，且有用户使用 UTF-8 编码，
	# 默认用“#”注释掉了 DOGBK2UNI 的定义。
	# 用户可以手动取消其注释（去掉下一行中的“#”）。
	#DOGBK2UNI = $(GBK2UNI) $(JOBNAME)
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

all: img_ doc

img_:
	cd img && $(MAKE)

img-clean:
	cd img && $(MAKE) clean

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

distclean: clean img-clean
	$(RM) $(JOBNAME).pdf

