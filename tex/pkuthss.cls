% Peking University dissertation document class
%
% Copyright (c) 2008-2009 solvethis
% Copyright (c) 2010-2017 Casper Ti. Vector
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
%   pkulogo.eps
%   pkuword.eps

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{pkuthss}
	[2017/03/01 v1.7.4 Peking University dissertation document class]

% eg. `\pkuthss@int@boolopt{spacing}{true}' will expand to:
%   \newif\ifpkuthss@opt@spacing \pkuthss@opt@spacingtrue
%   \DeclareOption{spacing}{\pkuthss@opt@spacingtrue}
%   \DeclareOption{nospacing}{\pkuthss@opt@spacingfalse}
\def\pkuthss@int@boolopt#1#2{
	\expandafter\newif\csname ifpkuthss@opt@#1\endcsname
	\@nameuse{pkuthss@opt@#1#2}
	\DeclareOption{#1}{\@nameuse{pkuthss@opt@#1true}}
	\DeclareOption{no#1}{\@nameuse{pkuthss@opt@#1false}}
}
% Process the encoding options.
\newif\ifpkuthss@opt@gbk \pkuthss@opt@gbktrue
\DeclareOption{GBK}{\pkuthss@opt@gbktrue\PassOptionsToClass{GBK}{ctexbook}}
\DeclareOption{UTF8}{\pkuthss@opt@gbkfalse\PassOptionsToClass{UTF8}{ctexbook}}
% Whether to enable `\Uppercase' (works problematically) in heading marks.
\pkuthss@int@boolopt{uppermark}{false}
% Whether to modify fonts according to school regulation.
\pkuthss@int@boolopt{pkufont}{true}
% Whether to modify footnote format according to school regulation.
\pkuthss@int@boolopt{pkufoot}{true}
% Whether to modify spacing according to school regulation.
\pkuthss@int@boolopt{pkuspace}{true}
% Whether to use some common settings for adjusting spacing.
\pkuthss@int@boolopt{spacing}{true}
% Add PDF bookmark for table of contents.
\pkuthss@int@boolopt{pdftoc}{true}
% Whether to enable the `\spacialchap' command.
\pkuthss@int@boolopt{spechap}{true}
% Whether to automatically set up properties for generated PDF from user
% defined document information (author, title, etc.).
\pkuthss@int@boolopt{pdfprop}{true}
% Whether to disable some infractions intended to make the style less ugly.
\pkuthss@int@boolopt{ugly}{false}
% Pass all other options to `ctexbook' document class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% Process all class options now.
\ProcessOptions\relax

% Prevent fontspec (loaded by xeCJK) from interfering with newtxmath.
\ifpkuthss@opt@pkufont\PassOptionsToPackage{no-math}{fontspec}\fi
% pkuthss is based on ctexbook; we use `xiao 4' as default font size.
\LoadClass[zihao = -4]{ctexbook}[2014/03/06]
% ctex 2.x no longer loads ifpdf and ifxetex by itself.
\RequirePackage{ifpdf, ifxetex}
% Provides support for `key = val' grammar.
\RequirePackage{keyval}
% Graphics support.
\RequirePackage{graphicx}[1999/02/16]
% Provides utilities for setting up page layout.
\RequirePackage{geometry}
% fancyhdr provides utilities for setting up headers and footers.
\RequirePackage{fancyhdr}
% Provides `\uline' used in `\maketitle'.
\RequirePackage{ulem}
% `\AtEndOfClass' used to avoid `PDF destination not defined' with setspace.
\AtEndOfClass{\RequirePackage{hyperref}}

\ifpkuthss@opt@gbk
	\input{pkuthss-gbk.def}
	\ifxetex
		% No support for XeLaTeX compilation in non-unicode encoding, i.e. GBK.
		\ClassError{pkuthss}%
			{XeLaTeX compilation is not supported without UTF-8}%
			{%
				XeLaTeX compilation without UTF-8 is very problematic.\MessageBreak
				Therefore please use UTF-8 encoding for the LaTeX code.%
			}
	\fi
\else
	\input{pkuthss-utf8.def}
\fi

\ifpkuthss@opt@pkufont
	% Use Times New Roman / Arial according to school regulation.
	% Option used to prevent newtxtext from manipulating footnote marks.
	\RequirePackage[defaultsups]{newtxtext}
	\RequirePackage[cmintegrals, varg]{newtxmath}
\else
	% Provides `\Box' for originauth.tex if newtx is absent.
	\RequirePackage{latexsym}
\fi

\ifpkuthss@opt@pkufoot
	% Handle the `Unparsed material' issue with latex/dvipdfmx compilation.
	\unless\ifxetex\unless\ifpdf
		\newcommand*\pgfsysdriver{pgfsys-dvipdfm.def}
	\fi\fi
	% Circled text, cf. <https://tex.stackexchange.com/questions/7032/>.
	\RequirePackage{tikz}
	\newcommand*\pkuthss@int@circled[1]{%
		\scalebox{0.8}{\tikz[baseline = (char.base)]{
			\node[
				shape = circle, draw = black, minimum size = 1.25em, inner sep = 0pt
			] (char) {#1};
		}}%
	}
	% Use circled numbers as footnote symbols. Does not affect title page, but
	% footnote is rarely used in dissertation covers ;)
	\renewcommand\thefootnote%
		{\protect\pkuthss@int@circled{\arabic{footnote}}}
	% Provides utility to modify footnote spacing.
	% Option used to make sure it does not render interleaf pages totally blank.
	\RequirePackage[cleardoublepage = current]{scrextend}
	% Set up footnote spacing: symbol indent 2 ccwd, paragraph indent 3.5 ccwd,
	% 0.75 ccwd between symbol and paragraph.
	\deffootnote{2\ccwd}{3.5\ccwd}{\thefootnotemark\hspace{0.75\ccwd}}
\fi

\ifpkuthss@opt@pkuspace
	% lineskip / baselineskip = 20 bp / (12 bp * (6 / 5)).
	\linespread{1.39}\selectfont
	% Provides utilities for setting TOC format; `titles' applied to avoid
	% interfering with LaTeX's own title mechanism.
	\RequirePackage[titles]{tocloft}
	\setlength{\cftbeforechapskip}{6bp plus 1bp}
	\setlength{\cftsecindent}{\ccwd}
	\setlength{\cftsubsecindent}{2\ccwd}
	% `caption' modifies font size and separator of captions.  `subcaption'
	% provides functions similar to `subfigure'/`subfig' but does not clash with
	% `tocloft'; it clashes with `subfigure'/`subfig', but the error message will
	% say they cannot be used simultaneously.
	\RequirePackage{caption, subcaption}
	\DeclareCaptionFont{cfive}{\zihao{5}}
	\DeclareCaptionLabelSeparator{quad}{\quad}
	\captionsetup{font = cfive, labelsep = quad}
\fi

\ifpkuthss@opt@spacing
	% Make spacing nicer in some situations (eg. footnotes and verbatims).
	\RequirePackage{setspace}
	% Lists often appear to be too sparse when items are just one or two lines
	% long. Here we cancel the extra vertical spacing between list items.
	\RequirePackage{enumitem}
	\setlist{nolistsep}
\fi

\ifpkuthss@opt@spechap
	% This command is used to start a chapter without numbering, and correctly set
	% up the headers and footers in the chapter.
	\newcommand\specialchap[1]{%
		\chapter*{#1}\addcontentsline{toc}{chapter}{#1}
		\markboth{#1}{}\phantomsection%
	}
\fi

\AtBeginDocument{
	\ifpkuthss@opt@pkuspace
		% Kludge for `tocloft' used with `ctex'.
		% <http://bbs.ctex.org/forum.php?mod=redirect&goto=findpost&ptid=43535&pid=310238>.
		\renewcommand{\numberline}[1]{%
			\settowidth\@tempdimb{#1\hspace{0.5em}}%
			\ifdim\@tempdima<\@tempdimb%
				\@tempdima=\@tempdimb%
			\fi%
			\hb@xt@\@tempdima{\@cftbsnum #1\@cftasnum\hfil}\@cftasnumb%
		}%
	\fi

	\ifpkuthss@opt@pdftoc
		% Add PDF bookmark for table of contents.
		\let\pkuthss@tmp@tableofcontents\tableofcontents
		\renewcommand{\tableofcontents}{%
			\pkuthss@int@pdfmark{\contentsname}{contents}
			\pkuthss@tmp@tableofcontents%
		}
	\fi

	\ifpkuthss@opt@pdfprop
		% Automatically generate properties for generated PDF.
		% Use English properties to avoid problems with character encodings.
		\newcommand*{\setpdfproperties}{%
			\hypersetup{
				pdfauthor = {\@eauthor}, pdftitle = {\@etitle},
				pdfsubject = {\euniversity\ \ethesisname}, pdfkeywords = {\@ekeywords}
			}%
		}
		% Set up the properties when generating the title page because the document
		% information should have been all defined before this.
		\let\pkuthss@tmp@maketitle\maketitle
		% NOTE: `\hypersetup' must appear before `\maketitle', otherwise it might not
		% act as wished.
		\renewcommand\maketitle{\setpdfproperties\pkuthss@tmp@maketitle}
	\fi
}

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
% Set up document information entries.
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
% Set up document information using the `key = value' grammar.
\newcommand*{\pkuthssinfo}[1]{\setkeys{pkuthss@info}{#1}}

% Set up page layout.
\geometry{
	a4paper, includefoot, hmargin = 2.6cm, top = 3cm, bottom = 2.5cm,
	headheight = 1.5cm, headsep = 0.5cm, footskip = 0.75cm
}

% Set up spacing for displayed formulae.
\setlength{\abovedisplayskip}{6bp plus 1.5bp minus 3.5bp}
\setlength{\abovedisplayshortskip}{3bp plus 0.75bp minus 1.75bp}
\setlength{\belowdisplayshortskip}{3bp plus 0.75bp minus 1.75bp}
\setlength{\belowdisplayskip}{6bp plus 1.5bp minus 3.5bp}

% Set up chapter/section/... captions.
% The `*skip' values are not supposed to be modified by the `ugly' option:
% the actual style of the school's guide and Word template seem to be different
% from the written specification (when applied verbatim in LaTeX), and here the
% actual style is used.
\ctexset{
	chapter = {beforeskip = {0bp}, afterskip = {18bp}},
	section =
		{beforeskip = {20bp plus 1ex minus 0.2ex}, afterskip = {6bp plus 0.2ex}},
	subsection =
		{beforeskip = {12bp plus 1ex minus 0.2ex}, afterskip = {6bp plus 0.2ex}},
	subsubsection =
		{beforeskip = {12bp plus 1ex minus 0.2ex}, afterskip = {6bp plus 0.2ex}}
}
\ifpkuthss@opt@ugly
	\ctexset{
		chapter =
			{nameformat = {\zihao{3}\bfseries}, titleformat = {\zihao{3}\bfseries}},
		section = {format = {\zihao{4}\bfseries}},
		subsection =
			{format = {\fontsize{13bp}{15.6bp}\selectfont\bfseries}},
		subsubsection = {format = {\zihao{-4}\bfseries}}
	}
\else
	\ctexset{
		chapter =
			{nameformat = {\zihao{-2}\bfseries}, titleformat = {\zihao{-2}\bfseries}},
		section = {format = {\zihao{-3}\bfseries}},
		subsection = {format = {\zihao{4}\bfseries}},
		subsubsection = {format = {\bfseries}}
	}
\fi

% Internal command to set up headers and footers.
\def\pkuthss@int@setpagestyle{
	% The actual setup commands.
	\fancypagestyle{plain}{
		\fancyhf{}\renewcommand*{\headrulewidth}{0.75bp}
		\fancyfoot[C]{\zihao{5}\normalfont{\thepage}}
		\if@twoside
			\fancyhead[CE]{\zihao{5}\normalfont{\cuniversity\cthesisname}}
			\fancyhead[CO]{\zihao{5}\normalfont\pkuthss@int@setcase{\leftmark}}
		\else
			\fancyhead[C]{\zihao{5}\normalfont\pkuthss@int@setcase{\leftmark}}
		\fi
	}
	\pagestyle{plain}
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

% This places a bookmark pointing to somewhere near the page header;
% Result of simple `\chapter{...} \pdfbookmark{...}' does not look nice,
% because the bookmark will point to somewhere below the chapter mark.
\def\pkuthss@int@pdfmark#1#2{%
	\if@openright\cleardoublepage\else\clearpage\fi
	\pdfbookmark[0]{#1}{#2}%
}

% Usage: \pkuthss@int@fillinblank{(number of lines)}{(line width)}{(contents)}
\def\pkuthss@int@fillinblank#1#2#3{%
	\makebox[0pt][l]{\parbox[t]{#2}{\centering{#3}}}\mbox{}%
	\parbox[t]{#2}{%
		\newcount\pkuthss@tmp@linecount
		\pkuthss@tmp@linecount=#1
		\loop\ifnum\pkuthss@tmp@linecount>0
			% Fill specified space with underline on the bottom line. `\underline'
			% draws line on the baseline (not the bottom line), and this is why
			% `\uline' is used here instead.
			\ifnum\pkuthss@tmp@linecount=1
				\uline{\makebox[#2]{}}
			\else
				\uline{\makebox[#2]{}}\\
			\fi
		\advance\pkuthss@tmp@linecount by -1\relax
		\repeat%
	}%
}

% Set up format of the title page (cover).
\renewcommand{\maketitle}{%
	\pkuthss@int@pdfmark{\titlepagename}{titlepage}
	\begin{titlepage}
		% It will be nicer to use this line skip level in the title page.
		\linespread{1.6}\selectfont
		% Make the title page centered.
		\begin{center}
			% Emblem and inscription of the university, and type of thesis.
			{%
				\zihao{1}%
				\includegraphics[height = 2.4em]{pkulogo}\hspace{0.4em}%
				\raisebox{0.4em}{\includegraphics[height = 1.6em]{pkuword}}\\[0.8em]
				{\bfseries{\cthesisname}}%
			}
			\vfill
			% Title of the thesis.
			{%
				\zihao{2}{\label@ctitle}%
				\pkuthss@int@fillinblank{2}{0.64\textwidth}{\textbf{\@ctitle}}%
			}
			\vfill
			% Information about the author.
			{%
				% Slightly adjust the line skip when using new font size.
				\zihao{3}\linespread{1.75}\selectfont
				\def\pkuthss@tmp@len{0.56\textwidth}
				\begin{tabular}{l@{\extracolsep{0.2em}}c}
					{\bfseries\label@cauthor}		&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\fangsong\@cauthor}		\\
					{\bfseries\label@studentid}	&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\fangsong\@studentid}	\\
					{\bfseries\label@school}		&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\fangsong\@school}		\\
					{\bfseries\label@cmajor}		&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\fangsong\@cmajor}		\\
					{\bfseries\label@direction}	&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\fangsong\@direction}	\\
					{\bfseries\label@cmentor}		&
					\pkuthss@int@fillinblank{1}{\pkuthss@tmp@len}{\fangsong\@cmentor}		\\
				\end{tabular}%
			}
			\vfill
			% Date.
			{\zihao{-2}\@date}
		\end{center}
	\end{titlepage}%
}

% Typeset the Chinese abstract.
\newenvironment{cabstract}{%
	\pkuthss@int@pdfmark{\cabstractname}{cabstract}
	\chapter*{\cabstractname}
	\markboth{\cabstractname}{}%
}{% Keywords at the bottom of the page.
	\vfill\noindent\textbf{\label@ckeywords}{\@ckeywords}%
}

% Typeset the English abstract.
\newenvironment{eabstract}{%
	\pkuthss@int@pdfmark{\eabstractname}{eabstract}
	\chapter*{\sffamily\@etitle}
	\markboth{\eabstractname}{}
	\begin{center}
		{\@eauthor} ({\@emajor})\\
		{\label@ementor}{\@ementor}\\[2em]
		\textbf{\sffamily\eabstractname}
	\end{center}
	\par%
}{% Keywords at the bottom of the page.
	\vfill\noindent\textbf{\label@ekeywords}{\@ekeywords}%
}

\endinput
% vim:ft=tex:ts=2:sw=2
