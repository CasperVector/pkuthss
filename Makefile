# vim:ft=make:ts=4:sw=4

TITLE = pkuthss
VERSION = 1.4alpha1
PROJECT = $(TITLE)-$(VERSION)
DIST_DOC = $(PROJECT)/doc
DOC_UTF8LF = $(DIST_DOC)/utf8lf
DOC_GBKCRLF = $(DIST_DOC)/gbkcrlf
README = README
TOLF = dos2unix -q
TOCRLF = unix2dos -q
# VCS directories are unwanted in packaged releases.
FIND_VCSDIR = -type d -name '.git' -prune
FIND_FILENOVCS = -not \( $(FIND_VCSDIR) \) -type f

dist: dist-clean
	make dist-dir
	make doc-utf8lf
	make doc-gbkcrlf
	make dist-zip

dist-dir: tex/ doc/
	mkdir -p $(DIST_DOC)/
	cp -r tex/ $(PROJECT)/
	cp -r doc/ $(DOC_UTF8LF)/
	mv -f $(DOC_UTF8LF)/license/ $(DIST_DOC)/
	cp -r $(DOC_UTF8LF)/ $(DOC_GBKCRLF)/
	find $(PROJECT)/ $(FIND_VCSDIR) -exec rm -rf '{}' ';'

doc-utf8lf:
	cd $(DOC_UTF8LF)/ && make
	mv $(DOC_UTF8LF)/$(TITLE).pdf $(PROJECT)/$(README).pdf
	cd $(DOC_UTF8LF)/ && make dist-clean

doc-gbkcrlf:
	find $(DOC_GBKCRLF) $(FIND_FILENOVCS) -exec $(TOCRLF) '{}' ';'
	find $(DOC_GBKCRLF) $(FIND_FILENOVCS) -not -iname '*utf8*' \
		-exec enca -L zh -x GBK '{}' ';'
	sed -i 's;\(\\documentclass\[[^][]*\)UTF8\([^][]*\]{pkuthss}\);\1GBK\2;g' \
		$(DOC_GBKCRLF)/pkuthss.tex
	sed -i 's;\(\.\./tex/pkuthss-\)utf8\(.def\);\1gbk\2;g' \
		$(DOC_GBKCRLF)/chap/encl1.tex

dist-zip: $(PROJECT)
	zip -rmT $(PROJECT).zip $(PROJECT)/

dist-clean:
	cd doc && make dist-clean && cd -
	rm -rf $(PROJECT)/ $(PROJECT).zip

.PHONY: dist-clean

