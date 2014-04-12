# vim:ts=4:sw=4
#
# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2012,2014 Casper Ti. Vector
# Public domain.

# 直接使用 pkulogo.eps 作为论文封面图片也是可行的，
# 因为它使用的 Times-Bold 字体一般操作系统都有。
# 这样用 LaTeX + dvipdfm 或 XeLaTeX 方式是可以编译成功的。
# 可以使用 ghostscript 将 eps 文件转换为 和 pdf 格式，
# 则 pdfLaTeX 方式也可以编译成功。

PDFS = pkulogo.pdf pkuword.pdf
PS2PDF = ps2pdf -dEPSCrop

# 区分是 Windows 环境还是类 UNIX 环境。
ifdef PATH
	RM = rm -f
else
	RM = del
endif

all: $(PDFS)

%.pdf: %.eps
	$(PS2PDF) $< $@

clean:
	$(RM) $(PDFS)

