# vim:ts=4:sw=4
#
# Copyright (c) 2011-2012 Casper Ti. Vector
# Public domain.

TITLE = pkuthss
MAJORVER = 1.4
MINORVER = beta1

dist:
	utils/dist TITLE=$(TITLE) MAJORVER=$(MAJORVER) MINORVER=$(MINORVER)

distclean:
	utils/dist TITLE=$(TITLE) MAJORVER=$(MAJORVER) MINORVER=$(MINORVER) distclean

toutf8lf:
	utils/enclt toutf8lf

togbkcrlf:
	utils/enclt togbkcrlf

qa:
	utils/qa

bump:
	utils/bump MAJORVER=$(MAJORVER) MINORVER=$(MINORVER)

