@echo off

@rem vim:ts=4:sw=4
@rem
@rem Copyright (c) 2008-2009 solvethis
@rem Copyright (c) 2010-2012 Casper Ti. Vector
@rem Public domain.

set GS=gswin32c
set GSOPTS=-q -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite
set WIDTHOPT=-dDEVICEWIDTHPOINTS=
set HEIGHTOPT=-dDEVICEHEIGHTPOINTS=
set OUTPUTOPT=-sOutputFile=

if "%1"=="" goto pdf
if "%1"=="clean" (goto clean) else (goto usage)

:pdf
%GS% %GSOPTS% %WIDTHOPT%400 %HEIGHTOPT%400 %OUTPUTOPT%pkulogo.pdf -f pkulogo.eps
%GS% %GSOPTS% %WIDTHOPT%525 %HEIGHTOPT%150 %OUTPUTOPT%pkuword.pdf -f pkuword.eps
goto end

:clean
del pkulogo.pdf pkuword.pdf
goto end

:usage
echo %0 [pdf] [clean]

:end

