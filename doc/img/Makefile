# 直接使用 pkulogo.ps 作为论文封面图片也是可行的，
# 因为它使用的 Times-Bold 字体一般操作系统都有。
# 这样用 LaTeX + dvipdfm 或 xeLaTeX 方式是可以编译成功的。
# 可以使用 ghostscript 将 ps 文件转换为 和 pdf 格式，
# 则 pdfLaTeX 方式也可以编译成功。

OPTS = -q -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite
WIDTHOPT = -dDEVICEWIDTHPOINTS=
HEIGHTOPT = -dDEVICEHEIGHTPOINTS=
OUTPUTOPT = -sOutputFile=

# 区分是 Windows 环境还是类 UNIX 环境。
ifdef PATH
	GS=gs
	RM=rm -f
else
	GS=gswin32c
	RM=del
endif

all: pkulogo.pdf pkuword.pdf

pkulogo.pdf: pkulogo.ps
	$(GS) $(OPTS) $(WIDTHOPT)400 $(HEIGHTOPT)400 $(OUTPUTOPT)$@ -f $<

pkuword.pdf: pkuword.ps
	$(GS) $(OPTS) $(WIDTHOPT)525 $(HEIGHTOPT)150 $(OUTPUTOPT)$@ -f $<

.PHONY: clean
clean:
	$(RM) pkulogo.pdf pkuword.pdf

