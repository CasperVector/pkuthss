# vim:ft=make:ts=4:sw=4

TITLE = pkuthss
README = README
MAJORVER = 1.4
MINORVER = alpha2

dist:
	utils/dist TITLE=$(TITLE) README=$(README)

dist-clean:
	utils/dist TITLE=$(TITLE) README=$(README) dist-clean

qa:
	utils/qa

revbump:
	utils/revbump MAJORVER=$(MAJORVER) MINORVER=$(MINORVER)

