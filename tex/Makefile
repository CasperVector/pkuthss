# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2012,2014 Casper Ti. Vector
# Public domain.

PDFS = pkulogo.pdf pkuword.pdf
PS2PDF = ps2pdf -dEPSCrop

all: $(PDFS)

%.pdf: %.eps
	$(PS2PDF) $< $@

clean:
	$(RM) $(PDFS)

# vim:ts=4:sw=4
