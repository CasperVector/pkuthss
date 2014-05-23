# vim:ts=4:sw=4
#
# Copyright (c) 2011-2014 Casper Ti. Vector
# Public domain.

TITLE = pkuthss
EXAMPLE = thesis
VERSION = 1.5.3

default: dist

qa:
	utils/qa

toutf8 togbk:
	utils/enc $@

bump:
	utils/bump VERSION=$(VERSION)

dist clean distclean:
	utils/dist TITLE=$(TITLE) EXAMPLE=$(EXAMPLE) VERSION=$(VERSION) $@

