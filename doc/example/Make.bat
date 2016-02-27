@echo off

@rem Copyright (c) 2008-2009 solvethis
@rem Copyright (c) 2010-2012 Casper Ti. Vector
@rem Public domain.

set JOBNAME=thesis
@rem 这个变量的值可以为 latex 或 pdflatex。
set LATEX=latex
set BIBTEX=biber -l zh__pinyin
set DVIPDF=dvipdfmx

if "%LATEX%"=="latex" (set DODVIPDF=%DVIPDF% %JOBNAME%
) else (set DODVIPDF=echo No need to run %DVIPDF%.)
if "%1"=="" goto doc
if "%1"=="doc" goto doc
if "%1"=="clean" (goto clean) else (goto usage)

:doc
%LATEX% %JOBNAME%
%BIBTEX% %JOBNAME%
%LATEX% %JOBNAME%
%LATEX% %JOBNAME%
%DODVIPDF%
goto end

:clean
del *.aux *.bbl *.bcf *.blg *.dvi *.lof *.log *.lot *.run.xml *.toc *.out
del missfont.log chap\*.aux
goto end

:usage
echo %0 [doc] [clean]
goto end

:end
pause

@rem vim:ts=4:sw=4
