% vim:ft=tex:ts=2:sw=2
%
% Peking University dissertation document class
%
% Copyright (c) 2008-2009 solvethis
% Copyright (c) 2010-2014 Casper Ti. Vector
%
% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License, either version 1.3 of this license or (at
% your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% The current maintainer of this work is Casper Ti. Vector.
%
% This work consists of the following files:
%   pkuthss.cls
%   pkuthss-gbk.def
%   pkuthss-utf8.def
%   pkuthss-extra.sty
%   pkulogo.eps
%   pkuword.eps

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{pkuthss}
	[2014/04/17 v1.5.2 Peking University dissertation document class]

% Process the encoding options.
\newif\ifpkuthss@opt@gbk \pkuthss@opt@gbktrue
\DeclareOption{GBK}{\pkuthss@opt@gbktrue\PassOptionsToClass{GBK}{ctexbook}}
\DeclareOption{UTF8}%
	{\pkuthss@opt@gbkfalse\PassOptionsToClass{UTF8}{ctexbook}}
% Whether to enable `\Uppercase' (works problematically) in heading marks.
\newif\ifpkuthss@opt@uppermark \pkuthss@opt@uppermarkfalse
\DeclareOption{uppermark}{\pkuthss@opt@uppermarktrue}
\DeclareOption{nouppermark}{\pkuthss@opt@uppermarkfalse}
% Whether to enable the default extra settings.
\newif\ifpkuthss@opt@extra \pkuthss@opt@extratrue
\DeclareOption{extra}{\pkuthss@opt@extratrue}
\DeclareOption{noextra}{\pkuthss@opt@extrafalse}
% eg. `\pkuthss@int@extraopt{spacing}' will expand to:
%   \DeclareOption{spacing}{\PassOptionsToClass{spacing}{pkuthss-extra}}
%   \DeclareOption{nospacing}{\PassOptionsToClass{nospacing}{pkuthss-extra}}
\def\pkuthss@int@extraopt#1{
	\DeclareOption{#1}{\PassOptionsToClass{#1}{pkuthss-extra}}
	\DeclareOption{no#1}{\PassOptionsToClass{no#1}{pkuthss-extra}}
}
% Pass options to `pkuthss-extra'.
% See pkuthss-extra.sty for an explanation of the options.
\pkuthss@int@extraopt{spacing}
\pkuthss@int@extraopt{tightlist}
\pkuthss@int@extraopt{pdftoc}
\pkuthss@int@extraopt{spechap}
\pkuthss@int@extraopt{pdfprop}
\pkuthss@int@extraopt{colorlinks}
% Pass all other options to `ctexbook' document class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% Process all class options now.
\ProcessOptions\relax

% pkuthss is based on ctexbook; We use `xiao 4' as default font size.
% CJKfntef provides \CJKunderline used in \maketitle.
% fancyhdr provides utilities for setting headers and footers.
\LoadClass[hyperref, cs4size, fntef, fancyhdr]{ctexbook}[2011/03/11]
% Provide support for `key = val' grammar.
\RequirePackage{keyval}
% Graphics support.
\RequirePackage{graphicx}[1999/02/16]
% Provide utilities for setting page layout.
\RequirePackage{geometry}
% Whether to enable the default extra settings.
\ifpkuthss@opt@extra\RequirePackage{pkuthss-extra}\fi

\ifxetex\ifpkuthss@opt@gbk
	% No support for XeLaTeX compilation in non-unicode encoding, i.e. GBK.
	\ClassError{pkuthss}%
		{XeLaTeX compilation is not supported without UTF-8}%
		{%
			XeLaTeX compilation without UTF-8 is very problematic.\MessageBreak
			Therefore please use UTF-8 encoding for the LaTeX code.%
		}
\fi\fi

\AtEndOfClass{
	% Setting chinese captions and labels.
	\ifpkuthss@opt@gbk\input{pkuthss-gbk.def}
	\else\input{pkuthss-utf8.def}
	\fi
}

% Set page layout.
\geometry{
	a4paper, height = 240mm, width = 150mm, includeheadfoot, headheight = 1.2em
}
% Internal command to set headers and footers.
\def\pkuthss@int@setpagestyle{
	% Set the headers and footers on the first page in every chapter.
	\fancypagestyle{plain}{
		\fancyhf{}\renewcommand{\headrulewidth}{0pt}
		\if@twoside
			\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
		\else
			\fancyfoot[C]{\small\normalfont --~\thepage~--}
		\fi
	}
	% Set the headers and footers on other pages.
	\fancypagestyle{pkuthss}{
		\fancyhf{}
		\if@twoside
			\fancyhead[LE]{\small\normalfont\pkuthss@int@setcase{\leftmark}}
			\fancyhead[RO]{\small\normalfont\pkuthss@int@setcase{\rightmark}}
			\fancyhead[LO,RE]{\small\normalfont\cuniversity\cthesisname}
			\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
		\else
			\fancyhead[L]{\small\normalfont\pkuthss@int@setcase{\leftmark}}
			\fancyhead[R]{\small\normalfont\pkuthss@int@setcase{\rightmark}}
			\fancyfoot[C]{\small\normalfont --~\thepage~--}
		\fi
	}
	\pagestyle{pkuthss}
}
% `\MakeUppercase' works problematically.
% eg. it converts `\cite{ctex}' into `\cite{CTEX}'.
% This option can disable `\MakeUppercase' in left/right heading marks.
\ifpkuthss@opt@uppermark
	\def\pkuthss@int@setcase#1{#1}
	\pkuthss@int@setpagestyle
\else
	% Code copied from fancyhdr's `\nouppercase', with the redefinition of
	% `\uppercase' dropped to avoid disrupting CJKutf8.
	% cf. <https://code.google.com/p/ctex-kit/issues/detail?id=147>.
	\def\pkuthss@int@setcase#1{%
		\let\MakeUppercase\relax%
		\expandafter\let\csname MakeUppercase \endcsname\relax%
		#1%
	}
	\pkuthss@int@setpagestyle
\fi

% eg. `\pkuthss@int@infoitema{ctitle}' will expand to:
%   \def\ctitle#1{\def\@ctitle{#1}}
%   \define@key{pkuthss@info}{ctitle}{\ctitle{#1}}
\def\pkuthss@int@infoitema#1{
	\@namedef{#1}##1{\@namedef{@#1}{##1}}
	\define@key{pkuthss@info}{#1}{\@nameuse{#1}{##1}}
}
% eg. `\pkuthss@int@infoitemb{cuniversity}' will expand to:
%   \define@key{pkuthss@info}{cuniversity}{\def\cuniversity{#1}}
\def\pkuthss@int@infoitemb#1{
	\define@key{pkuthss@info}{#1}{\@namedef{#1}{##1}}
}
% Setting document information entries.
\pkuthss@int@infoitema{ctitle}
\pkuthss@int@infoitema{etitle}
\pkuthss@int@infoitema{cauthor}
\pkuthss@int@infoitema{eauthor}
\pkuthss@int@infoitema{studentid}
\pkuthss@int@infoitema{date}
\pkuthss@int@infoitema{school}
\pkuthss@int@infoitema{cmajor}
\pkuthss@int@infoitema{emajor}
\pkuthss@int@infoitema{direction}
\pkuthss@int@infoitema{cmentor}
\pkuthss@int@infoitema{ementor}
\pkuthss@int@infoitema{ckeywords}
\pkuthss@int@infoitema{ekeywords}
\pkuthss@int@infoitemb{cuniversity}
\pkuthss@int@infoitemb{euniversity}
\pkuthss@int@infoitemb{cthesisname}
\pkuthss@int@infoitemb{ethesisname}
\pkuthss@int@infoitemb{cabstractname}
\pkuthss@int@infoitemb{eabstractname}
% Set document information using the `key = value' grammar.
\newcommand{\pkuthssinfo}[1]{\setkeys{pkuthss@info}{#1}}

% Usage: \pkuthss@int@fillinblank{(number of lines)}{(line width)}{(contents)}
\def\pkuthss@int@fillinblank#1#2#3{
	\makebox[0pt][l]{\parbox[t]{#2}{\centering{#3}}}\mbox{}%
	\parbox[t]{#2}{%
		\newcount\pkuthss@tmp@linecount
		\pkuthss@tmp@linecount=#1
		\loop\ifnum\pkuthss@tmp@linecount>0
			% Fill specified space with underline on the bottom line. `\underline'
			% draws line on the baseline (not the bottom line), and this is why
			% `\CJKunderline' is used here instead.
			\ifnum\pkuthss@tmp@linecount=1
				\CJKunderline{\makebox[#2]{}}
			\else
				\CJKunderline{\makebox[#2]{}}\\
			\fi
		\advance\pkuthss@tmp@linecount by -1\relax
		\repeat%
	}%
}
% Set format of the title page (cover).
\renewcommand{\maketitle}{
	\cleardoublepage
	% Add PDF bookmark for the title page.
	\pdfbookmark[1]{\titlepagename}{titlepage}
	\begin{titlepage}
		% It will be more nice to use this line skip level in the title page.
		\linespread{1.6}\selectfont
		% Make the title page centered.
		\begin{center}
			% Emblem and inscription of the university, and type of thesis.
			{
				\zihao{1}%
				\includegraphics[height = 2.4em]{pkulogo}\hspace{0.4em}%
				\raisebox{0.4em}{\includegraphics[height = 1.6em]{pkuword}}\\[0.8em]
				{\bfseries{\cthesisname}}
			}
			\vfill
			% Title of the thesis.
			{
				\zihao{2}{\label@ctitle}%
				\pkuthss@int@fillinblank{2}{0.64\textwidth}{\textbf{\@ctitle}}
			}
			\vfill
			% Information about the author.
			{
				% Slightly adjust the line skip when using new font size.
				\zihao{-2}\linespread{1.75}\selectfont
				\def\pkuthss@tmp@len{0.56\textwidth}
				\begin{tabular}{l@{\extracolsep{0.2em}}c}
					{\label@cauthor}		&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\kaishu\@cauthor}		\\
					{\label@studentid}	&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\kaishu\@studentid}	\\
					{\label@school}			&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\kaishu\@school}		\\
					{\label@cmajor}			&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\kaishu\@cmajor}		\\
					{\label@direction}	&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\kaishu\@direction}	\\
					{\label@cmentor}		&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\kaishu\@cmentor}		\\
				\end{tabular}
			}
			\vfill
			% Date.
			{\kaishu\zihao{2}\@date}
		\end{center}
	\end{titlepage}
}

% Typesetting the Chinese abstract.
\newenvironment{cabstract}{
	\cleardoublepage
	\pdfbookmark[1]{\cabstractname}{cabstract}
	\chapter*{\zihao{-2}\cabstractname}
	\markboth{\cabstractname}{}
}{% Keywords at the bottom of the page.
	\vfill\noindent\textbf{\label@ckeywords}{\@ckeywords}
}

% Typesetting the English abstract.
\newenvironment{eabstract}{
	\cleardoublepage
	\pdfbookmark[1]{\eabstractname}{eabstract}
	\chapter*{\zihao{-2}\@etitle}
	\markboth{\eabstractname}{}
	\vspace{-2em}\par
	\begin{center}
		\zihao{-3}
		{\@eauthor} ({\@emajor})\\
		{\label@ementor}{\@ementor}
	\end{center}
	\vspace{1em}\par
	\section*{\zihao{4}\eabstractname}
	\vskip 0.5em
}{% Keywords at the bottom of the page.
	\vfill\noindent\textbf{\label@ekeywords}{\@ekeywords}
}

\endinput
