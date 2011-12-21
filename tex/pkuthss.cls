% vim:ft=tex:ts=2:sw=2
%
% Peking University dissertation document class
%
% Copyright (c) 2008-2009 solvethis
% Copyright (c) 2010-2011 Casper Ti. Vector
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

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{pkuthss}
	[2011/12/21 v1.3 Peking University dissertation document class]

% Process the encoding options.
\newif\ifpkuthss@opt@gbk \pkuthss@opt@gbktrue
\DeclareOption{GBK}{\pkuthss@opt@gbktrue\PassOptionsToClass{GBK}{ctexbook}}
\DeclareOption{UTF8}%
	{\pkuthss@opt@gbkfalse\PassOptionsToClass{UTF8}{ctexbook}}
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
\pkuthss@int@extraopt{tocbibind}
\pkuthss@int@extraopt{uppermark}
\pkuthss@int@extraopt{spechap}
\pkuthss@int@extraopt{upcite}
\pkuthss@int@extraopt{pdfmeta}
\pkuthss@int@extraopt{linkcolor}
% Pass all other options to `ctexbook' document class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% Process all class options now.
\ProcessOptions\relax

% pkuthss is based on ctexbook; We use A4 paper, and `xiao 4' as default font size.
% CJKfntef provides \CJKunderline used in \maketitle.
% fancyhdr provides utilities for setting headers and footers.
\LoadClass[fntef,a4paper,fancyhdr,cs4size]{ctexbook}[2009/10/20]
% Provide support for key=val grammar.
\RequirePackage{keyval}
% Graphics support.
\RequirePackage{graphicx}[1999/02/16]
% Provide utilities for setting page layout.
\RequirePackage{geometry}
% Provide utilities for setting format of citation labels.
% Use the numerical scheme as default.
\RequirePackage[numbers]{natbib}
% Provide \AtEndPreamble used later.
% To be removed by summer in 2013, see the fix of `\hypersetup' below.
\RequirePackage{etoolbox}
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

	% Automatically generate hyperlinks and bookmarks for table of contents,
	% citations and index.
	% Code copied with minor modifications from ctex-common.def in `ctex' package.
	% Not directly using the `hyperref' option of `ctex' package in order to avoid
	% the conflicts caused by loading of `hyperref' before `setspace' in `ctex'
	% package older than 1.02c.
	% This piece of code will be removed by summer in 2013, and we will use the
	% `hyperref' option of `ctex' package instead, considering most people
	% will be using newer versions of `ctex' package at that time.
	\providecommand\hypersetup[1]{\PassOptionsToPackage{#1}{hyperref}}
	\AtEndPreamble{\@ifpackageloaded{hyperref}{}{\RequirePackage{hyperref}}}
	\ifxetex
		\hypersetup{xetex,unicode}
	\else
		\ifpdf
			\hypersetup{pdftex}
		\else
			\hypersetup{dvipdfmx}
			\ifpkuthss@opt@gbk
				\AtBeginDvi{\special{pdf:tounicode GBK-EUC-UCS2}}
			\fi
		\fi
		\ifpkuthss@opt@gbk
			\hypersetup{CJKbookmarks}
		\else
			\hypersetup{unicode}
		\fi
	\fi
}

% Set page layout.
\geometry{height=240mm,width=150mm,includeheadfoot,headheight=1.2em}
% Set headers and footers.
\pagestyle{fancy}\fancyhf{}
\fancyhead[LE]{\small\normalfont\leftmark}
\fancyhead[RO]{\small\normalfont\rightmark}
\fancyhead[LO,RE]{\small\normalfont\cuniversity\cthesisname}
\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
% Set the headers and footers on the first page in every chapter.
\fancypagestyle{plain}{
	\fancyhf{}\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
}

% eg. `\pkuthss@int@infoitema{ctitle}' will expand to:
%   \def\ctitle#1{\def\@ctitle{#1}}
%   \define@key{pkuthss@info}{ctitle}{\ctitle{#1}}
\def\pkuthss@int@infoitema#1{
	\expandafter\def\csname #1\endcsname##1%
		{\expandafter\def\csname @#1\endcsname{##1}}
	\expandafter\define@key{pkuthss@info}{#1}{\csname #1\endcsname{##1}}
}
% eg. `\pkuthss@int@infoitemb{cuniversity}' will expand to:
%   \define@key{pkuthss@info}{cuniversity}{\def\cuniversity{#1}}
\def\pkuthss@int@infoitemb#1{
	\expandafter\define@key{pkuthss@info}{#1}%
		{\expandafter\def\csname #1\endcsname{##1}}
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
% Set document information using the key=value grammar.
\newcommand{\pkuthssinfo}[1]{\setkeys{pkuthss@info}{#1}}

% Set format of the title page (cover).
\renewcommand{\maketitle}{
	\cleardoublepage
	% Add PDF bookmark for the title page.
	\pdfbookmark[1]{\titlepagename}{titlepage}
	\begin{titlepage}
		% It will be more nice to use this line skip level in the title page.
		\linespread{1.6}\selectfont
		% Fill specified space with underline on the bottom line. `\underline'
		% draws line on the baseline (not the bottom line), and this is why
		% `\CJKunderline' is used here instead.
		\def\pkuthss@int@fillinblank##1##2%
			{\CJKunderline{\makebox[##1]{##2}}}
		% Make the title page centered.
		\begin{center}
			% Emblem and inscription of the university, and type of thesis.
			{
				\includegraphics[height=0.07\textheight]{img/pkulogo}\hspace{1em}
				\includegraphics[height=0.07\textheight]{img/pkuword}\\[2.25em]
				{\zihao{1}\bfseries\cthesisname}
			}
			\vfill
			% Title of the thesis.
			{
				\zihao{2}
				{\label@ctitle}\makebox[0pt][l]{
					\parbox[t]{12em}{\centering\textbf{\@ctitle}}
				}
				\parbox[t]{12em}{
					\pkuthss@int@fillinblank{12em}{}\\
					\pkuthss@int@fillinblank{12em}{}
				}
			}
			\vfill
			% Information about the author.
			{
				% Slightly adjust the line skip when using new font size.
				\zihao{-2}\linespread{1.75}\selectfont
				\begin{tabular}{l@{\extracolsep{0.2em}}c}
					{\label@cauthor}		&
					\pkuthss@int@fillinblank{12em}{\kaishu\@cauthor}		\\
					{\label@studentid}	&
					\pkuthss@int@fillinblank{12em}{\kaishu\@studentid}	\\
					{\label@school}			&
					\pkuthss@int@fillinblank{12em}{\kaishu\@school}			\\
					{\label@cmajor}			&
					\pkuthss@int@fillinblank{12em}{\kaishu\@cmajor}			\\
					{\label@direction}	&
					\pkuthss@int@fillinblank{12em}{\kaishu\@direction}	\\
					{\label@cmentor}		&
					\pkuthss@int@fillinblank{12em}{\kaishu\@cmentor}		\\
				\end{tabular}
			}
			\vfill
			% Date.
			{\kaishu\zihao{2}\@date}
		\end{center}
	\end{titlepage}
}

% Internal environment for typesetting abstracts.
\newenvironment{pkuthss@int@abstract}{
	\cleardoublepage
	\pdfbookmark[1]{\pkuthss@tmp@abstractname}{\pkuthss@tmp@abstlabel}
	\chapter*{\zihao{-2}\pkuthss@tmp@title}
	\markboth{\pkuthss@tmp@abstractname}{}
	\vspace{-2em}\par
	\begin{center}
 		\zihao{-3}
 		{\pkuthss@tmp@author}\quad{\pkuthss@tmp@major}\\
 		{\pkuthss@tmp@label@mentor}{\pkuthss@tmp@mentor}
	\end{center}
	\vspace{1em}\par
	\section*{\zihao{4}\pkuthss@tmp@abstractname}
	\vskip 0.5em
}{% Keywords at the bottom of the page.
	\vfill\noindent\textbf{\pkuthss@tmp@label@keywords}{\pkuthss@tmp@keywords}
}

% Typesetting the Chinese abstract.
\newenvironment{cabstract}{
	\def\pkuthss@tmp@abstlabel{cabstract}
	\let\pkuthss@tmp@title\@ctitle
 	\let\pkuthss@tmp@author\@cauthor
	\let\pkuthss@tmp@major\@cmajor
 	\let\pkuthss@tmp@mentor\@cmentor
 	\let\pkuthss@tmp@keywords\@ckeywords
 	\let\pkuthss@tmp@label@mentor\label@cmentor
 	\let\pkuthss@tmp@label@keywords\label@ckeywords
	\let\pkuthss@tmp@abstractname\cabstractname
	\begin{pkuthss@int@abstract}
}{\end{pkuthss@int@abstract}}

% Typesetting the English abstract.
\newenvironment{eabstract}{
	\def\pkuthss@tmp@abstlabel{eabstract}
	\let\pkuthss@tmp@title\@etitle
 	\let\pkuthss@tmp@author\@eauthor
	\let\pkuthss@tmp@major\@emajor
 	\let\pkuthss@tmp@mentor\@ementor
 	\let\pkuthss@tmp@keywords\@ekeywords
 	\let\pkuthss@tmp@label@mentor\label@ementor
 	\let\pkuthss@tmp@label@keywords\label@ekeywords
	\let\pkuthss@tmp@abstractname\eabstractname
	\begin{pkuthss@int@abstract}
}{\end{pkuthss@int@abstract}}

\endinput
