% vim:filetype=tex:tabstop=2
%
% Peking University dissertation document class
%
% Copyright (c) 2008-2009 solvethis.
% Copyright (c) 2010 Casper Ti. Vector.
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
% This work consists of the files pkuthss.cls, pkuthss-gbk.def
% and pkuthss-utf8.def.
%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{pkuthss}
	[2010/07/24 v1.2beta2 Peking University dissertation document class]

% 处理编码选项。
\newif\ifPKUTHSS@GBK \PKUTHSS@GBKtrue
\DeclareOption{UTF8}{\PKUTHSS@GBKfalse\PassOptionsToClass{UTF8}{ctexbook}}
% 将文档类参数全部传递给 ctexbook 文档类。
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
% 此文档类以 ctexbook 为基础，设定页面尺寸为 A4，默认字号为小四号。
% CJKfntef 宏包提供了 \maketitle 中用到的 \CJKunderline 命令。
% fancyhdr 宏包提供了方便使用的命令用于设置页眉、页脚。
\LoadClass[fntef,a4paper,fancyhdr,cs4size]{ctexbook}[2010/01/22]
% 此宏包提供图形支持。
\RequirePackage{graphicx}[1999/02/16]
% 此宏包提供了方便使用的命令用于设置页面布局。
\RequirePackage{geometry}
\ifxetex
	% 不支持非用 XeLaTeX 编译非 UTF-8 的文档。
	\ifPKUTHSS@GBK
		\ClassError{pkuthss}
			{XeLaTeX compilation is not supported without UTF-8}
			{%
				XeLaTeX compilation without UTF-8 is very problematic.\MessageBreak
				Therefore please use UTF-8 encoding for the LaTeX code.%
			}
	\fi
\else
	% 忽略 CJK 文字之间的空白而保留（CJK 文字与英文之间等的）其它空白。
  \RequirePackage{CJKspace}
\fi

% 设定页面布局。
\geometry{height=240mm,width=150mm,includeheadfoot,headheight=1.2em}
% 设定页眉、页脚样式。
\pagestyle{fancy}\fancyhf{}
\fancyhead[LE]{\small\songti\rightmark}
\fancyhead[RO]{\small\songti\leftmark}
\fancyhead[LO,RE]{\small\songti\label@university\thesisname}
\fancyfoot[RO,LE]{\small --~\thepage~--}
% 设定每个章一级部分的第一页的页眉、页脚样式。
\fancypagestyle{plain}{%
	\fancyhf{}\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[RO,LE]{\small --~\thepage~--}%
}

% 这些命令用于设定各项文档信息的具体内容。
\newcommand\etitle[1]{\def\@etitle{#1}}
\newcommand\eauthor[1]{\def\@eauthor{#1}}
\newcommand\studentid[1]{\def\@studentid{#1}}
\newcommand\school[1]{\def\@school{#1}}
\newcommand\major[1]{\def\@major{#1}}
\newcommand\emajor[1]{\def\@emajor{#1}}
\newcommand\direction[1]{\def\@direction{#1}}
\newcommand\mentor[1]{\def\@mentor{#1}}
\newcommand\ementor[1]{\def\@ementor{#1}}
\newcommand\keywords[1]{\def\@keywords{#1}}
\newcommand\ekeywords[1]{\def\@ekeywords{#1}}

% 此命令用下划线填充指定的空间。
\newcommand{\fillinblank}[2]{\CJKunderline{\makebox[#1]{#2}}}
% 此命令将对象放到页面底部。
\newcommand{\putonbottom}[1]{\begin{figure}[b!]%
	\begin{minipage}{\textwidth}{#1}\end{minipage}\end{figure}}

% 设定标题页格式。
\renewcommand\maketitle{%
	\cleardoublepage
	\begin{titlepage}
		% 居中。
		\begin{center}
			% 第一部分：校徽、“北京大学”字样和论文类别名。
			{
				\includegraphics[height=0.07\textheight]{img/pkulogo}\hspace{1em}
				\includegraphics[height=0.07\textheight]{img/pkuword}\\[2.25em]
				{\zihao{1}\bfseries\thesisname}
			}
			\vfill
			% 第二部分：论文标题。
			{
				\zihao{2}{\label@title}
				\makebox[0pt][t]{%
					\begin{minipage}[t]{12em}
						\centering\textbf{\@title}
					\end{minipage}%
				}
				\parbox[t]{12em}{\fillinblank{12em}{}\\ \fillinblank{12em}{}}\par
			}
			\vfill
			% 第三部分：作者信息。
			{
				\zihao{-2}
				\begin{tabular}{l@{\extracolsep{0.2em}}c}
					{\label@author}    & \fillinblank{12em}{\kaishu\@author}
						\\[2pt]
					{\label@studentid} & \fillinblank{12em}{\kaishu\@studentid}
						\\[2pt]
					{\label@school}    & \fillinblank{12em}{\kaishu\@school}
						\\[2pt]
					{\label@major}     & \fillinblank{12em}{\kaishu\@major}
						\\[2pt]
					{\label@direction} & \fillinblank{12em}{\kaishu\@direction}
						\\[2pt]
					{\label@mentor}& \fillinblank{12em}{\kaishu\@mentor}
				\end{tabular}
			}
			\vfill
			% 第四部分：日期。
			{\kaishu\zihao{2}\@date}
		\end{center}
	\end{titlepage}
}

% 此命令用于开始不标号的一章。
% 通过 \matkboth 命令设置相应的页眉内容（尽管可能不显示）。
\newcommand{\specialchap}[1]{%
	\chapter*{#1}\addcontentsline{toc}{chapter}{#1}
	\markboth{#1}{}\phantomsection%
}

% 此环境用于排版中文摘要。
\newenvironment{cabstract}{%
	\chapter*{\zihao{-2}\@title}
	\markboth{\@title}{}
	\vspace{-2em}\par
	\begin{center}
 		\zihao{-3}
 		{\@author}\quad{\@major}\\
 		{\label@mentor}{\@mentor}
	\end{center}
	\vspace{1em}\par
	\section*{\zihao{4}\cabstractname}
	\vskip 0.5em%
}{% 在页面底部排版关键词。
\putonbottom{\textbf{\label@keywords}\@keywords}}

% 此环境用于排版英文摘要。代码的解释详见 cabstract 环境的定义部分。
\newenvironment{eabstract}{%
	\chapter*{\zihao{-2}\@etitle}
	\markboth{\@etitle}{}
	\vspace{-2em}\par
	\begin{center}
 		\zihao{-3}
 		{\@eauthor}\quad({\@emajor})\\
 		Directed by {\@ementor}
	\end{center}
	\vspace{1em}\par
	\section*{\zihao{4}\eabstractname}
	\vskip 0.5em%
}{\putonbottom{\textbf{Keywords:} \@ekeywords}}

% 设定各处标题的内容。
\AtEndOfClass{%
	\ifPKUTHSS@GBK
		\input{pkuthss-gbk.def}
	\else
		\input{pkuthss-utf8.def}
	\fi
}
\endinput

