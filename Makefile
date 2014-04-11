# vim:ts=4:sw=4
#
# Copyright (c) 2011-2014 Casper Ti. Vector
# Public domain.

TITLE = pkuthss
VERSION = 1.4.9

default: dist

qa:
	utils/qa

toutf8 togbk:
	utils/enc $@

bump:
	utils/bump VERSION=$(VERSION)

dist clean distclean:
	utils/dist TITLE=$(TITLE) VERSION=$(VERSION) $@

