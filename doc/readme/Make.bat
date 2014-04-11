@echo off

@rem vim:ts=4:sw=4
@rem
@rem Copyright (c) 2008-2009 solvethis
@rem Copyright (c) 2010-2012 Casper Ti. Vector
@rem Public domain.

set JOBNAME=pkuthss
@rem 这个变量的值可以为 latex 或 pdflatex。
set LATEX=latex
@rem 如果无法使用 biber，可以改为“bibtex”。
set BIBTEX=biber -l zh__pinyin
set GBK2UNI=gbk2uni
set DVIPDF=dvipdfmx

if "%LATEX%"=="latex" (set DODVIPDF=%DVIPDF% %JOBNAME%
) else (set DODVIPDF=echo No need to run %DVIPDF%.)
@rem 用 pdflatex 时可能需要使用 gbk2uni 转换 .out 文件编码以防书签乱码。
if "%LATEX%"=="pdflatex" (@rem set DOGBK2UNI=%GBK2UNI% %JOBNAME%
) else (set DOGBK2UNI=echo No need to run %GBK2UNI%.)
if "%1"=="" goto doc
if "%1"=="doc" goto doc
if "%1"=="clear" (goto clear) else (goto usage)

:doc
cd img
call Make.bat
cd ..
%LATEX% %JOBNAME%
%BIBTEX% %JOBNAME%
%DOGBK2UNI%
%LATEX% %JOBNAME%
%LATEX% %JOBNAME%
%DODVIPDF%
goto end

:clear
del *.aux *.bbl *.bcf *.blg *.dvi *.lof *.log *.lot *.run.xml *.toc *.out
del missfont.log chap\*.aux
goto end

:usage
echo %0 [doc] [clear]
goto end

:end

