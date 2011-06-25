@rem Copyright (c) 2008-2009 solvethis
@rem Copyright (c) 2010-2011 Casper Ti. Vector
@rem Public domain.

@echo off

set JOBNAME=pkuthss
set LATEX=latex
set BIBTEX=bibtex
set DVIPDF=dvipdfmx

if "%LATEX%"=="latex" (set DODVIPDF=%DVIPDF% %JOBNAME%
) else (set DODVIPDF=echo No need to run %DVIPDF%.)
if "%1"=="" goto doc
if "%1"=="doc" goto doc
if "%1"=="clear" (goto clear) else (goto usage)

:doc
%LATEX% %JOBNAME%
%BIBTEX% %JOBNAME%
%LATEX% %JOBNAME%
%LATEX% %JOBNAME%
%DODVIPDF%
goto end

:clear
del *.log *.aux *.out *.thm *.toc *.lof *.lot *.blg *.bbl *.dvi chap\*.aux
goto end

:usage
echo %0 [doc] [clear]
goto end

:end

