# 直接使用 pkulogo.ps 作为论文封面图片也是可行的，
# 因为它使用的 Times-Bold 字体一般操作系统都有。
# 这样用 LaTeX + dvipdfm 方式是可以编译成功的，
# 但LATEX + dvips + ps2pdf 方式则不行。
# 为了兼容后面这种编译方式，
# 可以使用ghostscript 将 ps 文件转换为 eps 和 pdf 格式。

GS=gs
OPTS=-q -dSAFER -dNOPAUSE -dBATCH
LOGOG=-dDEVICEWIDTHPOINTS=400 -dDEVICEHEIGHTPOINTS=400
WORDG=-dDEVICEWIDTHPOINTS=525 -dDEVICEHEIGHTPOINTS=150

# 区分是 Windows 环境还是类 UNIX 环境。
ifdef COMSPEC
	RM=del
else
	RM=rm -f
endif

all: eps pdf

eps: pkulogo.ps pkuword.ps
	$(GS) $(OPTS) -sDEVICE=epswrite $(LOGOG) \
		-sOutputFile=pkulogo.eps -f pkulogo.ps
	$(GS) $(OPTS) -sDEVICE=epswrite $(WORDG) \
		-sOutputFile=pkuword.eps -f pkuword.ps

pdf: pkulogo.ps pkuword.ps
	$(GS) $(OPTS) -sDEVICE=pdfwrite $(LOGOG) \
		-sOutputFile=pkulogo.pdf -f pkulogo.ps
	$(GS) $(OPTS) -sDEVICE=pdfwrite $(WORDG) \
		-sOutputFile=pkuword.pdf -f pkuword.ps

.PHONY: clean

clean:
	$(RM) pkulogo.eps pkulogo.pdf pkuword.eps pkuword.pdf

