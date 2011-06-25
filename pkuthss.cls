\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{pkuthss}
  [2008/03/13 v1.1 Peking University
   dissertation document class]
   
\LoadClass[a4paper,fntef,fancyhdr,cs4size]{ctexbook}[2004/08/14]
\RequirePackage{ifpdf}
\RequirePackage{graphicx}[1999/02/16]
\RequirePackage{geometry}

\geometry{a4paper,centering,height=240mm,width=150mm,%
          includeheadfoot,headheight=12.65pt}

\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
\renewcommand{\baselinestretch}{1.5}
\renewcommand{\floatpagefraction}{0.80}

\CTEXsetup[format={\bf\zihao{-3}\centering},
           beforeskip={5mm},
           afterskip={1ex plus .2ex}]{chapter}
\CTEXsetup[format={\bf\zihao{4}\centering},
           beforeskip={-3ex plus -1ex minus -.2ex},
           afterskip={1ex plus .2ex}]{section}
\CTEXsetup[format={\bf\zihao{-4}},
           indent={2\ccwd},
           beforeskip={-2.5ex plus -1ex minus -.2ex},
           afterskip={1ex plus .2ex}]{subsection}

\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}}
\pagestyle{fancy}
  \fancyhf{}
  \fancyhead[LE]{\small\songti\rightmark}
  \fancyhead[RO]{\small\songti\leftmark}
  \fancyhead[LO,RE]{\small\songti\university\thesisname}
  \fancyfoot[RO,LE]{\small --~\thepage~--}

\newcommand{\fillinblank}[2]{\CJKunderline{\makebox[#1]{#2}}}
\newcommand{\thesisclearpage}{\clearpage%
  \if@twoside\thispagestyle{empty}\cleardoublepage\fi}
\newcommand\school[1]{\def\@school{#1}}
\newcommand\supervisor[1]{\def\@supervisor{#1}}
\newcommand\major[1]{\def\@major{#1}}
\newcommand\studentid[1]{\def\@studentid{#1}}
\newcommand\direction[1]{\def\@direction{#1}}
\renewcommand\maketitle{%
  \begin{titlepage}\enlargethispage{30pt}
  \vskip10pt\hskip10pt
  \includegraphics[height=0.09\textheight]{imgs/pkulogo}\hskip13mm
  \includegraphics[height=0.08\textheight]{imgs/pkuword}
  \vskip 32pt
  \begin{center}
    {\zihao{-0}\bf\songti\thesisname}
    \vskip 102pt\zihao{2}{\songti\label@title}
    \makebox[0pt][t]{%
      \begin{minipage}[t]{13em}\centering\bf\songti\@title\end{minipage}}
    \parbox[t]{13em}{\fillinblank{13em}{}\\ \fillinblank{13em}{}}\par
    \vskip 70pt\zihao{3}\songti
    \begin{tabular}{l@{\extracolsep{2pt}}c}
      \label@author     & \fillinblank{200pt}{\kaishu\@author}   \\[2pt]
      \label@studentid  & \fillinblank{200pt}{\kaishu\@studentid}\\[2pt]
      \label@school     & \fillinblank{200pt}{\kaishu\@school}   \\[2pt]
      \label@major      & \fillinblank{200pt}{\kaishu\@major}    \\[2pt]
      \label@direction  & \fillinblank{200pt}{\kaishu\@direction}\\[2pt]
      \label@supervisor & \fillinblank{200pt}{\kaishu\@supervisor}
    \end{tabular}
    \vfill {\zihao{-2}\kaishu\@date}
  \end{center}
  \end{titlepage}
  \thesisclearpage\thispagestyle{empty}
  \begin{center}
    \zihao{2}{\bf\label@copyright}\vskip 15pt
  \end{center}
  \zihao{3}\label@copycontent\vskip 15pt
  \zihao{-4}\normalfont
  \thesisclearpage}

\newcommand\keywords[1]{\def\@keywords{#1}}
\newcommand\ekeywords[1]{\def\@ekeywords{#1}}
\newcommand\etitle[1]{\def\@etitle{#1}}
\newcommand\eauthor[1]{\def\@eauthor{#1}}
\newcommand\esupervisor[1]{\def\@esupervisor{#1}}
\newcommand\emajor[1]{\def\@emajor{#1}}
\newcommand{\putonbottom}[1]{\begin{figure}[b!]%
  \begin{minipage}{\textwidth}#1\end{minipage}\end{figure}}
\newenvironment{abstract}
  {\cleardoublepage
   \thispagestyle{empty}
   \begin{center}
     \vspace*{20pt}\zihao{3}\bf\@title \\[20pt]
     \zihao{-4}\rm\@author\quad\@major\\
     \label@supervisor\quad\@supervisor\\[30pt]
     \zihao{4}\bf\abstractname\vskip 30pt
   \end{center}}
  {\putonbottom{\textbf{\label@keywords}\@keywords}\thesisclearpage}
\newenvironment{eabstract}
  {\cleardoublepage
   \thispagestyle{empty}
   \begin{center}
     \vspace*{20pt}\zihao{-2}\sf\@etitle \\[20pt]
     \zihao{4}\bf\@eauthor\quad(\@emajor)\\
     \rm Supervised by \textbf{\@esupervisor}\\[25pt]
     \zihao{4}\bf Abstract\vskip 25pt
   \end{center}}
  {\putonbottom{\textbf{Keywords:} \@ekeywords}\thesisclearpage}

\newenvironment{introduction}%
  {\chapter*{\introductionname}
   \markboth{\introductionname}{}
   \addcontentsline{toc}{chapter}{\introductionname}}{}

\newenvironment{conclusion}%
  {\chapter*{\conclusionname}
   \markboth{\conclusionname}{}
   \addcontentsline{toc}{chapter}{\conclusionname}}{}

\renewenvironment{appendix}%
  {\chapter*{\appendixname}
   \markboth{\appendixname}{}
   \renewcommand{\thesection}{\Alph{section}}
   \addcontentsline{toc}{chapter}{\appendixname}}{}

\newenvironment{acknowledgement}%
  {\chapter*{\acknowledgename}
   \markboth{\acknowledgename}{}
   \addcontentsline{toc}{chapter}{\acknowledgename}}{}

\newcommand\finaldeclares{%
  \cleardoublepage
  \thispagestyle{empty}\vfill
  \begin{center}
    \zihao{3}\bf\songti\label@origandauth \vskip 32pt
    \zihao{4}\bf\songti\label@original
  \end{center}
  \zihao{-4}\label@origcontent \vskip 20pt
  \hfill\label@authorsign\hspace{6em}\label@origdate
  \vskip 38pt
  \begin{center}
    \zihao{4}{\bf\songti\label@authorization}\\
    \zihao{-5}{\songti\label@authaddition}\vskip 5pt
  \end{center}
  \zihao{-4}\label@authcontent \vskip 40pt
  \hfill\label@authorsign\hspace{6em}
  \label@supervisorsign\hbox{\hspace{8em}} \vskip 3pt  %%check
  \hfill\label@origdate\hbox{\hspace{12em}}
  \thesisclearpage}

\bibliographystyle{chinesebst}
\setcounter{secnumdepth}{3}

\AtBeginDocument{\begin{CJK*}{GBK}{song}%                                     
  \sloppy\CJKindent\CJKtilde}
\AtEndDocument{\finaldeclares\clearpage\end{CJK*}}

\def\pku@makeActive{
  % Activate all >128 characters.
  \count@=127
  \@whilenum\count@<255 \do{%
    \advance\count@ by 1
    \lccode`\~=\count@
    \catcode\count@=\active
    \lowercase{\def~{\kern1ex}}}}
\AtEndOfClass{\pku@makeActive\input{pkuthss.def}}

\endinput
