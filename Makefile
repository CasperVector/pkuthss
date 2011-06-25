# vim:ft=make:ts=4:sw=4

PROJECT = pkuthss-1.3alpha2
SOURCES = tex/ doc/
DEST_UTF8LF = $(PROJECT)-utf8lf
DEST_GBKCRLF = $(PROJECT)-gbkcrlf
TOLF = dos2unix -q
TOCRLF = unix2dos -q
# 让 find(1) 忽略 svn/git 目录，并只搜索文件。
FINDDEFAULT = -not \( -type d -name '.svn' -o -name '.git' -prune \) -type f

doc: $(SOURCES)
	cd "doc" && make && cd -

pdf: doc
	cd "doc" && make clear img-clean && cd -

clean: $(SOURCES)
	cd "doc" && make clean && cd -

# 将整个目录恢复原状，但保留 $(DEST_GBK)/、$(DEST_UTF8)/ 和生成的压缩包。
reset: clean toutf8lf

# 产生用于发布的压缩包。
dist: 
	make dist-utf8lf
	make dist-gbkcrlf
	make reset

dist-utf8lf: toutf8lf pdf $(DEST_UTF8LF).zip
dist-gbkcrlf: togbkcrlf pdf $(DEST_GBKCRLF).zip

togbkcrlf: clean
	find $(SOURCES) $(FINDDEFAULT) -exec $(TOCRLF) '{}' ';'
# 转换到 GBK 编码时忽略所有文件名中含有“UTF8”（不区分大小写）的文件。
	find $(SOURCES) $(FINDDEFAULT) -not -iname '*utf8*' \
		-exec enca -L zh -x GBK '{}' ';'
	sed -i 's;\(\\documentclass\[.*\)UTF8\(.*\]{pkuthss}\);\1GBK\2;g' \
		doc/pkuthss.tex
	sed -i 's;\(\.\./tex/pkuthss-\)utf8\(.def\);\1gbk\2;g' \
		doc/chap/encl1.tex

toutf8lf: clean
	find $(SOURCES) $(FINDDEFAULT) -exec $(TOLF) '{}' ';'
# 转换到 UTF-8 编码时忽略所有文件名中含有“GBK”（不区分大小写）的文件。
	find $(SOURCES) $(FINDDEFAULT) -not -name '*gbk*' \
		-exec enca -L zh -x UTF8 '{}' ';'
	sed -i 's;\(\\documentclass\[.*\)GBK\(.*\]{pkuthss}\);\1UTF8\2;g' \
		doc/pkuthss.tex
	sed -i 's;\(\.\./tex/pkuthss-\)gbk\(.def\);\1utf8\2;g' \
		doc/chap/encl1.tex

%.zip: $(SOURCES)
	mkdir -p $*/
	cp -r $^ $*/
# 发布压缩包时用户不需要 svn/git 目录。
	find $* -name '.svn' -o -name '.git' -prune -exec rm -rf '{}' ';'
	zip -rmT $@ $*/

# 将整个目录完全恢复原状。
dist-clean: reset
	rm -rf $(DEST_UTF8LF)/ $(DEST_GBKCRLF)/
	rm -f $(DEST_UTF8LF).zip $(DEST_GBKCRLF).zip

.PHONY: doc pdf clean reset togbkcrlf toutf8lf \
		dist dist-utf8lf dist-gbkcrlf dist-clean

