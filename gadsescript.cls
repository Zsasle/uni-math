\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gadsescript}[2023/10/22 1.0 gadse script]

\LoadClass[a4paper, parskip = true]{scrartcl}

\newcommand{\consecutivenumbering}{0}
\DeclareOption{consecutive numbering}{\renewcommand{\consecutivenumbering}{1}}

%%%%%%%%%%%%%%
%%% layout %%%
%%%%%%%%%%%%%%

\RequirePackage{layout}
\RequirePackage[top=3cm, left=2cm, right=2cm, bottom=2cm]{geometry}
\RequirePackage[headsepline]{scrlayer-scrpage}
\pagestyle{scrheadings}
\automark[section]{section}
\ihead{\normalfont\scshape\headmark}
\ohead*{\pagemark}
\chead{}
\cfoot{}

%%%%%%%%%%%%%
%%% title %%%
%%%%%%%%%%%%%

\if\consecutivenumbering 0
	\renewcommand*{\sectionformat}{\setnumbers{0}{}\thesection.\enskip}
	\renewcommand*{\subsectionformat}{\setnumbers{0}{sub}\thesubsection.\enskip}
\else 
	\renewcommand*{\sectionformat}{\setnumbers{0}{}\thesection.\enskip}
	\renewcommand*{\subsectionformat}{\setnumbers{0}{sub}\thesubsection.\enskip}
\fi
\setkomafont{disposition}{\raggedright\large\bfseries}

\setlength\parindent{1em}
\newcommand{\saveparinfos}{%
	\edef\myindent{\the\parindent}%
	\edef\myparskip{\the\parskip}%
}
\saveparinfos
\newcommand{\pardefs}{%
	\setlength{\parindent}{\myindent}%
	\setlength{\parskip}{\myparskip}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% necessary packages %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

%math and physics
\RequirePackage[fleqn]{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{siunitx}
\RequirePackage{tikz}
\newcommand{\mynode}[2]{\tikz[remember picture]{\node[inner sep = 0pt](#1){#2};}}

%not math
\RequirePackage[ngerman, english]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage[babel]{csquotes}
\RequirePackage{enumitem}
\RequirePackage{tabularx, booktabs}
\RequirePackage{multicol}


%%%%%%%%%%%%%%
%%% colors %%%
%%%%%%%%%%%%%%

\RequirePackage[many]{tcolorbox}	%for COLORED BOXES
\definecolor{gadse-black}	{RGB}{000, 000, 000}
\definecolor{gadse-white}	{RGB}{255, 255, 255}
\definecolor{gadse-background}	{RGB}{208, 197, 112}
\definecolor{gadse-light-green}	{RGB}{113, 212, 083}
\definecolor{gadse-dark-green}	{RGB}{048, 109, 000}
\definecolor{gadse-red}		{RGB}{255, 016, 000}
\definecolor{gadse-pink}	{RGB}{255, 031, 206}
\definecolor{gadse-orange}	{RGB}{255, 139, 000}
\definecolor{gadse-yellow}	{RGB}{255, 197, 017}
\definecolor{gadse-light-blue}	{RGB}{079, 160, 183}
\definecolor{gadse-another-blue}{RGB}{051, 110, 217}
\definecolor{gadse-dark-blue}	{RGB}{051, 030, 181}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    commands to create    %%%
%%%  the commands for these  %%%
%%% environements I am using %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\myboxenvironment}[4]{ % tcolorbox-environment %
	\newtcolorbox{cache#1#2box}[1]{
		title		= ##1,
		fonttitle	= \bfseries,
		colback		= #3,
		colframe	= #4,
		sharp corners,
		rounded corners	= northeast,
		rounded corners	= southeast,
		arc		= 2pt,
		outer arc	= 2pt,
		boxrule = 0pt,
		leftrule = 4pt,
		breakable
	}
}

\newcommand{\cachemyenvironment}[4]{ % command to define \#1#2number, #1#2 tcolorbox, #1#2box %
	%\setlength\parindent{1em}
	\newcounter{#1#2number}[#1section]%
	\expandafter\renewcommand\csname the#1#2number\endcsname{\csname the#1section\endcsname.\arabic{#1#2number}}%
	\myboxenvironment{#1}{#2}{#3}{#4}%
	\newenvironment{#1#2}[1][]{%
		\refstepcounter{#1#2number}%
		\begin{cache#1#2box}{\MakeUppercase#2 \csname the#1#2number\endcsname\quad{##1}}%
			\setlength\parindent{1em}%
		}{%
		\end{cache#1#2box}%
	}
}

\newtcolorbox{important}[1][]{
	title		= Important: #1,
	fonttitle	= \bfseries,
	colback		= gadse-red,
	colframe	= gadse-red!75!gadse-black,
	sharp corners,
	rounded corners	= northeast,
	rounded corners	= southeast,
	arc		= 2pt,
	outer arc	= 2pt,
	boxrule = 0pt,
	leftrule = 4pt,
	breakable
}
\newtcolorbox{blackbox}[1][]{
	title = #1,
	standard jigsaw,
	opacityback = 0,
	colframe = gadse-black,
	sharp corners,
	rounded corners	= northeast,
	rounded corners	= southeast,
	arc		= 2pt,
	outer arc	= 2pt,
	boxrule = 0pt,
	leftrule = 4pt
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    command to create     %%%
%%% these environments I use %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\myenvironment}[3]{%
	\cachemyenvironment{}{#1}{#2}{#3}%
	\cachemyenvironment{sub}{#1}{#2}{#3}%
}

\myenvironment{example}		{gadse-orange}%
				{gadse-red}%
\myenvironment{task}		{gadse-orange!50!gadse-yellow}%
				{gadse-red!50!gadse-orange}%
\myenvironment{problem}		{gadse-yellow}%
				{gadse-orange}%
\myenvironment{definition}	{gadse-pink!50!gadse-white}%
				{gadse-pink}%
\myenvironment{theorem}		{gadse-dark-green!50!gadse-light-green}%
				{gadse-dark-green!100!gadse-ligth-green}%
\myenvironment{lemma}		{gadse-dark-green!25!gadse-light-green}%
				{gadse-dark-green!75!gadse-light-green}%
\myenvironment{conjecture}	{gadse-light-green}%
				{gadse-dark-green!25!gadse-light-green}%
\myenvironment{proof}		{gadse-light-green!50!gadse-white}%
				{gadse-light-green!100!gadse-white}%
\myenvironment{corollary}	{gadse-dark-green!75!gadse-light-green}%
				{gadse-dark-green!75!gadse-black}%
\myenvironment{axiom}		{gadse-dark-green!50!gadse-light-green}%
				{gadse-dark-green!100!gadse-black}%


\newenvironment{indentpar}{%
	\hfill\begin{minipage}{\dimexpr\linewidth-2em}%
		\pardefs%
	}{%
	\end{minipage}%
}
\setlist[description]{%
	font = \normalfont\bfseries,%
	}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% sets #2numbers to #1 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\setnumbers}[2]{%
	\setcounter{#2examplenumber}	{#1}%
	\setcounter{#2tasknumber}	{#1}%
	\setcounter{#2problemnumber}	{#1}%
	\setcounter{#2definitionnumber}	{#1}%
	\setcounter{#2theoremnumber}	{#1}%
	\setcounter{#2lemmanumber}	{#1}%
	\setcounter{#2conjecturenumber}	{#1}%
	\setcounter{#2proofnumber}	{#1}%
	\setcounter{#2corollarynumber}	{#1}%
	\setcounter{#2axiomnumber}	{#1}%
}


%%%%%%%%%%%%
%%% tikz %%%
%%%%%%%%%%%%

\newcommand{\circled}[1]{%
	\tikz[baseline=(char.base)]{%
		\node[shape=circle, draw, inner sep = 2pt] (char) {#1};%
	}%
}


%%%%%%%%%%%%%%%%%%%%%
%%% math commands %%%
%%%%%%%%%%%%%%%%%%%%%

\DeclareRobustCommand{\qed}{%
	\ifmmode \tag*{$\Box$}%
	\else \leavevmode\unskip\penalty9999 \hbox{}\nobreak\hfill\quad\hbox{$\Box$}%
	\fi%
}
\newcommand{\contradiction}{\bot}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\C}{\mathbb{C}}

%%%%%%%%%%%%%
%%% specs %%%
%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% makes my titlepage %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

% defines command to change title, subtitle and titleheaders
\newcommand{\definetitles}[1]{%
	\expandafter\gdef\csname set#1\endcsname##1{%
		\expandafter\gdef\csname #1\endcsname{##1}%
	}%
}

\definetitles{title}
\definetitles{subtitle}
\definetitles{titlelh}
\definetitles{titlerh}

% sets title headers
\settitlelh{\today\\Wintersemester 2023/2024}

\settitlerh{Universität Konstanz\\Fachbereich Mathematik und Statistik}

% sets maketitle
\renewcommand{\maketitle}{%
	\begingroup%
	\setlength\multicolsep{\baselineskip}%
	\begin{multicols}{2}%
		\raggedright%
		\titlelh\\
		\columnbreak%
		\raggedleft%
		\titlerh
	\end{multicols}%
	\hrule height 0.8pt%
	%\setlength\topsep{0pt}%
	\begin{center}%
		\unskip%
		\ifx\mysubtitle\undefined%
		{\LARGE \title}\\%
		\else%
		{\LARGE \title}\\[2pt]%
		{\large \subtitle}\\%
		\fi%
	\end{center}%
	\endgroup%
	\hrule%
	\vskip 1cm
	\thispagestyle{empty}%
}
