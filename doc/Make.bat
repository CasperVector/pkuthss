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
if "%1"=="" goto pdf
if "%1"=="pdf" goto pdf
if "%1"=="clean" (goto clean) else (goto usage)

:pdf
%LATEX% %JOBNAME%
%BIBTEX% %JOBNAME%
%LATEX% %JOBNAME%
%LATEX% %JOBNAME%
%DODVIPDF%
goto end

:clean
del *.log *.aux *.out *.thm *.toc *.lof *.lot *.blg *.bbl *.dvi chap\*.aux
goto end

:usage
echo %0 [pdf] [clean]
goto end

:end

