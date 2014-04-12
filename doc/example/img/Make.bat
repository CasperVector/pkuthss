@echo off

@rem vim:ts=4:sw=4
@rem
@rem Copyright (c) 2008-2009 solvethis
@rem Copyright (c) 2010-2012 Casper Ti. Vector
@rem Public domain.

set PS2PDF=ps2pdf
set WIDTHOPT=-dDEVICEWIDTHPOINTS=
set HEIGHTOPT=-dDEVICEHEIGHTPOINTS=

if "%1"=="" goto pdf
if "%1"=="clean" (goto clean) else (goto usage)

:pdf
%PS2PDF% %WIDTHOPT%400 %HEIGHTOPT%400 pkulogo.eps pkulogo.pdf
%PS2PDF% %WIDTHOPT%525 %HEIGHTOPT%150 pkuword.eps pkuword.pdf
goto end

:clean
del pkulogo.pdf pkuword.pdf
goto end

:usage
echo %0 [pdf] [clean]

:end

