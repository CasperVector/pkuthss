# Makefile
# $Id: Makefile 2007-09-03 09:08:43 GMT$

GS=gs
OPTS=-q -dSAFER -dNOPAUSE -dBATCH
LOGOG=-dDEVICEWIDTHPOINTS=400 -dDEVICEHEIGHTPOINTS=400
WORDG=-dDEVICEWIDTHPOINTS=525 -dDEVICEHEIGHTPOINTS=150

.PHONY: eps pdf all clean

all: eps pdf

eps:
	$(GS) $(OPTS) -sDEVICE=epswrite $(LOGOG) \
		-sOutputFile=pkulogo.eps -f pkulogo.ps
	$(GS) $(OPTS) -sDEVICE=epswrite $(WORDG) \
		-sOutputFile=pkuword.eps -f pkuword.ps

pdf:
	$(GS) $(OPTS) -sDEVICE=pdfwrite $(LOGOG) \
		-sOutputFile=pkulogo.pdf -f pkulogo.ps
	$(GS) $(OPTS) -sDEVICE=pdfwrite $(WORDG) \
		-sOutputFile=pkuword.pdf -f pkuword.ps

clean:
	-@rm -f pku{logo,word}.{eps,pdf}
