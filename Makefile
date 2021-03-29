# Copyright (c) 2011-2014,2019 Casper Ti. Vector
# Public domain.

TITLE = pkuthss
EXAMPLE = thesis
VERSION = 1.9.0

default: dist

qa:
	utils/qa

bump:
	utils/bump VERSION=$(VERSION)

dist clean distclean:
	utils/dist TITLE=$(TITLE) EXAMPLE=$(EXAMPLE) VERSION=$(VERSION) $@

# vim:ts=4:sw=4
