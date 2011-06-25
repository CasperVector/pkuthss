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
	[2011/04/08 v1.3 beta1 Peking University dissertation document class]

% 处理编码选项。
\newif\ifpkuthss@opt@gbk \pkuthss@opt@gbktrue
\DeclareOption{GBK}{\pkuthss@opt@gbktrue\PassOptionsToClass{GBK}{ctexbook}}
\DeclareOption{UTF8}%
	{\pkuthss@opt@gbkfalse\PassOptionsToClass{UTF8}{ctexbook}}
% 是否采用默认的额外设置。
\newif\ifpkuthss@opt@extra \pkuthss@opt@extratrue
\DeclareOption{extra}{\pkuthss@opt@extratrue}
\DeclareOption{noextra}{\pkuthss@opt@extrafalse}
% 将其余的文档类参数全部传递给 ctexbook 文档类。
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% 立刻处理所有宏包选项。
\ProcessOptions\relax

% 此文档类以 ctexbook 为基础，设定页面尺寸为 A4，默认字号为小四号。
% CJKfntef 宏包提供了 \maketitle 中用到的 \CJKunderline 命令。
% fancyhdr 宏包提供了方便使用的命令用于设置页眉、页脚。
\LoadClass[fntef,a4paper,fancyhdr,cs4size]{ctexbook}[2009/10/20]
% 此宏包提供对 key=val 格式设置的支持。
\RequirePackage{keyval}
% 此宏包提供图形支持。
\RequirePackage{graphicx}[1999/02/16]
% 此宏包提供了方便使用的命令用于设置页面布局。
\RequirePackage{geometry}
% 是否采用默认的额外设置。
\ifpkuthss@opt@extra\RequirePackage{pkuthss-extra}\fi

\ifxetex\ifpkuthss@opt@gbk
	% 不支持非用 XeLaTeX 编译非 UTF-8 的文档。
	\ClassError{pkuthss}%
		{XeLaTeX compilation is not supported without UTF-8}%
		{%
			XeLaTeX compilation without UTF-8 is very problematic.\MessageBreak
			Therefore please use UTF-8 encoding for the LaTeX code.%
		}
\fi\fi

\AtEndOfClass{%
	% 设定各处标题的内容。
	\ifpkuthss@opt@gbk\input{pkuthss-gbk.def}
	\else\input{pkuthss-utf8.def}
	\fi

	% 为文章中的目录、交叉和索引等自动产生链接，并自动生成书签。
	% 代码复制自 ctex 宏包的 ctex-common.def，有改动。
	% 不直接使用 ctex 宏包的 hyperref 选项的原因是避免和 setspace 的冲突。
	% XXX: 实现方式不够优雅，或许有更加合适的处理方式。
	\ifxetex
		\RequirePackage{hyperref}
	\else
		\ifpdf
			\RequirePackage[pdftex]{hyperref}
		\else
			\ifCTEX@GBK
				\AtBeginDvi{\special{pdf:tounicode GBK-EUC-UCS2}}
			\fi
			\RequirePackage[dvipdfmx]{hyperref}
		\fi
		\ifCTEX@GBK
			\hypersetup{CJKbookmarks=true}
		\else
			\hypersetup{unicode=true}
		\fi
	\fi
}

% 设定页面布局。
\geometry{height=240mm,width=150mm,includeheadfoot,headheight=1.2em}
% 设定页眉、页脚样式。
\pagestyle{fancy}\fancyhf{}
\fancyhead[LE]{\small\normalfont\leftmark}
\fancyhead[RO]{\small\normalfont\rightmark}
\fancyhead[LO,RE]{\small\normalfont\cuniversity\cthesisname}
\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
% 设定每个章一级部分的第一页的页眉、页脚样式。
\fancypagestyle{plain}{
	\fancyhf{}\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
}

% 例如：
% \pkuthss@int@infoitema{ctitle} 最终被扩展为：
%   \def\ctitle#1{\def\@ctitle{#1}}
%   \define@key{pkuthss@info}{ctitle}{\ctitle{#1}}
\def\pkuthss@int@infoitema#1{
	\expandafter\def\csname #1\endcsname##1%
		{\expandafter\def\csname @#1\endcsname{##1}}
	\expandafter\define@key{pkuthss@info}{#1}{\csname #1\endcsname{##1}}
}
% 例如：
% \pkuthss@int@infoitemb{cuniversity} 最终被扩展为：
%   \define@key{pkuthss@info}{cuniversity}{\def\cuniversity{#1}}
\def\pkuthss@int@infoitemb#1{
	\expandafter\define@key{pkuthss@info}{#1}%
		{\expandafter\def\csname #1\endcsname{##1}}
}
% 设定各项文档信息的具体内容。
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
% 此命令用于以 key=val 格式设置文档信息。
\newcommand{\pkuthssinfo}[1]{\setkeys{pkuthss@info}{#1}}

% 设定封面格式，并在生成封面时设定文档信息。
\renewcommand{\maketitle}{
	\cleardoublepage
	\pdfbookmark[1]{\titlepagename}{titlepage}
	\begin{titlepage}
		% 封面使用这个行距较为美观。
		\linespread{1.6}\selectfont
		% 此命令用下划线填充指定的空间。
		\def\pkuthss@int@fillinblank##1##2%
			{\CJKunderline{\makebox[##1]{##2}}}
		% 居中。
		\begin{center}
			% 第一部分：校徽、“北京大学”字样和论文类别。
			{
				\includegraphics[height=0.07\textheight]{img/pkulogo}\hspace{1em}
				\includegraphics[height=0.07\textheight]{img/pkuword}\\[2.25em]
				{\zihao{1}\bfseries\cthesisname}
			}
			\vfill
			% 第二部分：论文标题。
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
			% 第三部分：作者信息。
			{
				% 字号有改变，行距设定须稍作调整。
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
			% 第四部分：日期。
			{\kaishu\zihao{2}\@date}
		\end{center}
	\end{titlepage}
}

% 用于排版摘要的内部环境。
\newenvironment{pkuthss@int@abstract}{
	\cleardoublepage
	\pdfbookmark[1]{\tmp@abstractname}{\tmp@abstlabel}
	\chapter*{\zihao{-2}\tmp@title}
	\markboth{\tmp@abstractname}{}
	\vspace{-2em}\par
	\begin{center}
 		\zihao{-3}
 		{\tmp@author}\quad{\tmp@major}\\
 		{\tmp@label@mentor}{\tmp@mentor}
	\end{center}
	\vspace{1em}\par
	\section*{\zihao{4}\tmp@abstractname}
	\vskip 0.5em
}{% 在页面底部排版关键词。
	\vfill\noindent\textbf{\tmp@label@keywords}{\tmp@keywords}
}

% 此环境用于排版中文摘要。
\newenvironment{cabstract}{
	\def\tmp@abstlabel{cabstract}
	\let\tmp@title\@ctitle
 	\let\tmp@author\@cauthor
	\let\tmp@major\@cmajor
 	\let\tmp@mentor\@cmentor
 	\let\tmp@keywords\@ckeywords
 	\let\tmp@label@mentor\label@cmentor
 	\let\tmp@label@keywords\label@ckeywords
	\let\tmp@abstractname\cabstractname
	\begin{pkuthss@int@abstract}
}{\end{pkuthss@int@abstract}}

% 此环境用于排版英文摘要。
\newenvironment{eabstract}{
	\def\tmp@abstlabel{eabstract}
	\let\tmp@title\@etitle
 	\let\tmp@author\@eauthor
	\let\tmp@major\@emajor
 	\let\tmp@mentor\@ementor
 	\let\tmp@keywords\@ekeywords
 	\let\tmp@label@mentor\label@ementor
 	\let\tmp@label@keywords\label@ekeywords
	\let\tmp@abstractname\eabstractname
	\begin{pkuthss@int@abstract}
}{\end{pkuthss@int@abstract}}

\endinput
