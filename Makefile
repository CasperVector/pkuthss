# vim:ts=4:sw=4
#
# Copyright (c) 2011-2014 Casper Ti. Vector
# Public domain.

TITLE = pkuthss
MAJORVER = 1.4
MINORVER =

default: dist

qa:
	utils/qa

toutf8 togbk:
	utils/enc $@

bump:
	utils/bump MAJORVER=$(MAJORVER) MINORVER=$(MINORVER)

dist clean distclean:
	utils/dist TITLE=$(TITLE) MAJORVER=$(MAJORVER) MINORVER=$(MINORVER) $@

