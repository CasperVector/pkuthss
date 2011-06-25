@echo off
@rem $Id: make.bat 2007-09-03 10:41:23 GMT$

set GS=gswin32c
set OPTS=-q -dSAFER -dNOPAUSE -dBATCH
set LOGOG=-dDEVICEWIDTHPOINTS#400 -dDEVICEHEIGHTPOINTS#400
set WORDG=-dDEVICEWIDTHPOINTS#525 -dDEVICEHEIGHTPOINTS#150

if (%1)==() goto all

if (%1)==(clean) (
  goto clean
) else ( goto usage )

:all
%GS% %OPTS% -sDEVICE#epswrite %LOGOG% -sOutputFile#pkulogo.eps -f pkulogo.ps
%GS% %OPTS% -sDEVICE#epswrite %WORDG% -sOutputFile#pkuword.eps -f pkuword.ps
%GS% %OPTS% -sDEVICE#pdfwrite %LOGOG% -sOutputFile#pkulogo.pdf -f pkulogo.ps
%GS% %OPTS% -sDEVICE#pdfwrite %WORDG% -sOutputFile#pkuword.pdf -f pkuword.ps
goto end

:clean
del pkulogo.eps pkuword.eps pkulogo.pdf pkuword.pdf
goto end

:usage
echo make [,all,help,clean]

:end
