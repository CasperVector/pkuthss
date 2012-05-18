# vim:ts=4:sw=4
#
# Copyright (c) 2011-2012 Casper Ti. Vector
# Public domain.

TITLE = pkuthss
README = README
MAJORVER = 1.4
MINORVER = alpha2

dist:
	utils/dist TITLE=$(TITLE) README=$(README) \
		MAJORVER=$(MAJORVER) MINORVER=$(MINORVER)

dist-clean:
	utils/dist TITLE=$(TITLE) README=$(README) \
		MAJORVER=$(MAJORVER) MINORVER=$(MINORVER) dist-clean

qa:
	utils/qa

bump:
	utils/bump MAJORVER=$(MAJORVER) MINORVER=$(MINORVER)

