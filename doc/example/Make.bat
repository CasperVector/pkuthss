@echo off

@rem Copyright (c) 2008-2009 solvethis
@rem Copyright (c) 2010-2012,2019 Casper Ti. Vector
@rem Public domain.

if "%1"=="" goto doc
if "%1"=="doc" goto doc
if "%1"=="clean" (goto clean) else (goto usage)

:doc
latexmk
goto end

:clean
latexmk -c
goto end

:usage
echo %0 [doc] [clean]
goto end

:end
pause

@rem vim:ts=4:sw=4
