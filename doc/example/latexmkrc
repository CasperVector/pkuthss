# Copyright (c) 2019 Casper Ti. Vector
# Public domain.

@default_files = ('thesis');
# 5：xelatex；3：latex（+ dvipdfmx）；1：pdflatex。
$pdf_mode = 5;
# 用 latex 模式编译时，使用 dvipdfmx 而非默认的 dvipdf。
$dvipdf = "dvipdfmx %O -o %D %S";
# 此选项相关说明见 texdoc latexmk。
$bibtex_use = 1.5;
$biber = "biber -l zh__pinyin --output-safechars %O %S";
# latexmk -c 时自动删除 .run.xml 文件。
$clean_ext = "run.xml";

