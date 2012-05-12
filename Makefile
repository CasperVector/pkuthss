# vim:ft=make:ts=4:sw=4

TITLE = pkuthss
MAJORVER = 1.4
MINORVER = alpha2
README = README
TOLF = dos2unix -q
TOCRLF = unix2dos -q
# VCS directories are unwanted in packaged releases.
FIND_VCSDIR = -type d -name '.git' -prune

NUMDATE = $(shell date +%Y/%m/%d)
CNDATE = $(shell python3 -c 'print("$(shell date +%Y年%-m月)".translate(str.maketrans("0123456789", "〇一二三四五六七八九")))')

VER_GEN = $(if $(MINORVER),$(MAJORVER)$(1)$(MINORVER),$(MAJORVER))
PROJECT = $(TITLE)-$(call VER_GEN,)
DIST_DOC = $(PROJECT)/doc
DOC_UTF8LF = $(DIST_DOC)/utf8lf
DOC_GBKCRLF = $(DIST_DOC)/gbkcrlf
FIND_FILENOVCS = -not '(' $(FIND_VCSDIR) ')' -type f

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

maintcheck:
	@echo '========================================================================'
	@echo '$@: keep GBK and UTF-8 files synchronised'
	@echo '========================================================================'
	iconv -f GBK tex/pkuthss-gbk.def | diff - tex/pkuthss-utf8.def || true
	@echo '========================================================================'
	@echo '$@: use "模版" instead of "模板"'
	@echo '========================================================================'
	grep -r '模板' . || true
	@echo '========================================================================'
	@echo '$@: remember to update documentation after modifications'
	@echo '========================================================================'

revbump:
	sed -i '/\\Provides/,+1 s;\[[^ ]* [^ ]*;[$(NUMDATE) v$(call VER_GEN,-);g' tex/*
	sed -i '/\\newcommand{\\docversion}/ s;{[^{}]\+}$$;{v$(call VER_GEN, )};g' doc/pkuthss.tex
	sed -i '/date = / s;{[^{}]\+},$$;{$(CNDATE)},;g' doc/pkuthss.tex
	@echo '$@: remember to update the ChangeLog'
	@echo '$@: remember to tag the commit'
	@echo '$@: remember to use `git push --tags'\'
	@echo '$@: remember to add new download on Google Code'

