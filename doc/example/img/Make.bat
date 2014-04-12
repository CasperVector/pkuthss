@echo off

@rem vim:ts=4:sw=4
@rem
@rem Copyright (c) 2008-2009 solvethis
@rem Copyright (c) 2010-2012 Casper Ti. Vector
@rem Public domain.

set PS2PDF=ps2pdf -dEPSCrop

if "%1"=="" goto pdf
if "%1"=="clean" (goto clean) else (goto usage)

:pdf
%PS2PDF% pkulogo.eps pkulogo.pdf
%PS2PDF% pkuword.eps pkuword.pdf
goto end

:clean
del pkulogo.pdf pkuword.pdf
goto end

:usage
echo %0 [pdf] [clean]

:end

