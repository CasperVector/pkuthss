# Copyright (c) 2011-2014,2019 Casper Ti. Vector
# Public domain.

TITLE = pkuthss
README = $(TITLE)
EXAMPLE = thesis
VERSION = 1.8.0

default: dist

qa:
	utils/qa

bump:
	utils/bump VERSION=$(VERSION)

dist clean distclean:
	utils/dist TITLE=$(TITLE) README=$(README) EXAMPLE=$(EXAMPLE) VERSION=$(VERSION) $@

# vim:ts=4:sw=4
