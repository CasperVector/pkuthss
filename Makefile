# vim:ts=4:sw=4
#
# Copyright (c) 2011-2012 Casper Ti. Vector
# Public domain.

TITLE = pkuthss
MAJORVER = 1.4
MINORVER = beta1
DIST_FLAGS = TITLE=$(TITLE) MAJORVER=$(MAJORVER) MINORVER=$(MINORVER)

dist:
	utils/dist $(DIST_FLAGS)

doc-dist:
	utils/dist $(DIST_FLAGS) doc-dist

doc-pdf:
	utils/dist $(DIST_FLAGS) doc-pdf

dist-ctan:
	utils/dist $(DIST_FLAGS) dist-ctan

dist-tds:
	utils/dist $(DIST_FLAGS) dist-tds

clean:
	utils/dist $(DIST_FLAGS) clean

distclean:
	utils/dist $(DIST_FLAGS) distclean

toutf8lf:
	utils/enclt toutf8lf

togbkcrlf:
	utils/enclt togbkcrlf

qa:
	utils/qa

bump:
	utils/bump MAJORVER=$(MAJORVER) MINORVER=$(MINORVER)

