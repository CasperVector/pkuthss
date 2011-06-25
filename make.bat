@echo off
@rem $id: make.bat  2007/08/30 08:44$

set JOBNAME=sample

if "%1"=="" goto pdf

if %1==pdf goto pdf

if %1==clean (
  goto clean
) else ( goto usage )

:pdf
latex %JOBNAME%
bibtex %JOBNAME%
latex %JOBNAME%
latex %JOBNAME%
dvipdfmx %JOBNAME%
goto end

:clean
del *.aux chaps\*.aux *.bbl *.blg *.lof *.log *.lot *.out *.out.bak *.thm *.toc
goto end

:usage
echo %0 [ ,pdf,clean]
goto end

:end
