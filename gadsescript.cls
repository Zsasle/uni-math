\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gadsescript}[2023/10/22 1.0 gadse script]
\RequirePackage{kvoptions}

\SetupKeyvalOptions{%
	family=gadse,%
	prefix=gadse@%
}%

\DeclareStringOption[0]{consecutivenumbering}[1]%
\DeclareBoolOption{printtitle}
\DeclareBoolOption{printsubtitle}
\DeclareBoolOption{printtitlelh}
\DeclareBoolOption{printtitlerh}
\DeclareBoolOption{transparentEnvironments}

\DeclareStringOption{presectionnum}[{Section}]%
\DeclareStringOption[.]{aftersectionnum}[:]%
\DeclareStringOption[bfseries]{sectionnumseries}[mdseries]%
\DeclareStringOption[bfseries]{sectionseries}[mdseries]%
\DeclareBoolOption{presectionnumspace}%
\DeclareBoolOption{aftersectionnumspace}%

\DeclareStringOption[default]{presubsectionnum}[{Subsection}]%
\DeclareStringOption[default]{aftersubsectionnum}[:]%
\DeclareStringOption[default]{subsectionnumseries}[mdseries]%
\DeclareStringOption[default]{subsectionseries}[mdseries]%
\DeclareBoolOption{presubsectionnumspace}%
\DeclareBoolOption{aftersubsectionnumspace}%

\DeclareStringOption[default]{sectionformat}[missing_argument]
\DeclareStringOption[default]{subsectionformat}[missing_argument]

\ProcessKeyvalOptions*%

\if\gadse@presubsectionnum default%
	\xdef\gadse@presubsectionnum{\gadse@presectionnum}%
\fi%

\if\gadse@aftersubsectionnum default%
	\xdef\gadse@aftersubsectionnum{\gadse@aftersectionnum}%
\fi%

\if\gadse@subsectionnumseries default%
	\xdef\gadse@subsectionnumseries{\gadse@sectionnumseries}%
\fi%

\if\gadse@subsectionseries default%
	\xdef\gadse@subsectionsection{\gadse@sectionseries}%
\fi%

\LoadClass[a4paper, parskip = true]{scrartcl}%


%%%%%%%%%%%%%%
%%% layout %%%
%%%%%%%%%%%%%%

\RequirePackage[headsepline]{scrlayer-scrpage}
\clearpairofpagestyles
%\pagestyle{scrheadings}
\automark[section]{section}
\ihead{\normalfont\scshape\headmark}
\ohead*{\pagemark}
\chead{}
\cfoot{}
\RequirePackage[top=3cm, left=2cm, right=2cm, bottom=2cm]{geometry}

%\RequirePackage{graphicx}
%\counterwithin{figure}{section}
\RequirePackage[plainpages=false, pdfpagelabels]{hyperref}
\RequirePackage{caption}
%\renewcommand\theHfigure{\thesection.\arabic{figure}}
%\newsubfloat{figure}

%%%%%%%%%%%%%
%%% title %%%
%%%%%%%%%%%%%

\edef\temp@default{default}%
\edef\temp@missingargument{missing_argument}%
\edef\temp@exercise{exercise}%
\edef\temp@aufgabe{aufgabe}%

\ifx\gadse@sectionformat\temp@default%
\else%
\ifx\tempmacrosectionformat\temp@missingargument%
	\typeout{##########################################################}%
	\typeout{### There's a missing argument for gadse@sectionformat ###}%
	\typeout{##########################################################}%
\else%
\ifx\gadse@sectionformat\temp@exercise%
	\gdef\gadse@presectionnum{Exercise}%
	\gdef\gadse@aftersectionnum{:}%
	\gdef\gadse@sectionnumseries{bfseries}%
	\gdef\gadse@sectionseries{mdseries}%
	\gadse@presectionnumspacetrue%
	\gadse@aftersectionnumspacetrue%

	\gdef\gadse@presubsectionnum{Exercise}%
	\gdef\gadse@aftersubsectionnum{:}%
	\gdef\gadse@subsectionnumseries{bfseries}%
	\gdef\gadse@subsectionseries{mdseries}%
	\gadse@presubsectionnumspacetrue%
	\gadse@aftersubsectionnumspacetrue%
\else%
\ifx\gadse@sectionformat\temp@aufgabe%
	\gdef\gadse@presectionnum{Aufgabe}%
	\gdef\gadse@aftersectionnum{:}%
	\gdef\gadse@sectionnumseries{bfseries}%
	\gdef\gadse@sectionseries{mdseries}%
	\gadse@presectionnumspacetrue%
	\gadse@aftersectionnumspacetrue%

	\gdef\gadse@presubsectionnum{Aufgabe}%
	\gdef\gadse@aftersubsectionnum{:}%
	\gdef\gadse@subsectionnumseries{bfseries}%
	\gdef\gadse@subsectionseries{mdseries}%
	\gadse@presubsectionnumspacetrue%
	\gadse@aftersubsectionnumspacetrue%
\else%
	\typeout{}%
	\typeout{---}%
	\typeout{!!! \gadse@sectionformat\space is no valid sectionformat !!!}%
	\typeout{using \gadse@sectionformat\space as presectionnum}
	\typeout{---}%
	\typeout{}%

	\xdef\gadse@presectionnum{\gadse@sectionformat}%
	\gdef\gadse@aftersectionnum{:}%
	\gdef\gadse@sectionnumseries{bfseries}%
	\gdef\gadse@sectionseries{mdseries}%
	\gadse@presectionnumspacetrue%
	\gadse@aftersectionnumspacetrue%

	\gdef\gadse@presubsectionnum{\gadse@sectionformat}%
	\gdef\gadse@aftersubsectionnum{:}%
	\gdef\gadse@subsectionnumseries{bfseries}%
	\gdef\gadse@subsectionseries{mdseries}%
	\gadse@presubsectionnumspacetrue%
	\gadse@aftersubsectionnumspacetrue%
\fi%
\fi%
\fi%
\fi%

\newcommand*{\setsomething}[2]{%
	\expandafter\ifx\csname ifgadse@#1#2sectionnumspace\endcsname\iftrue%
		\expandafter\edef\csname#1#2sectionnum\endcsname{\csname gadse@#1#2sectionnum\endcsname\ }%
	\else%
		\expandafter\edef\csname#1#2sectionnum\endcsname{\csname gadse@#1#2sectionnum\endcsname}%
	\fi%
}%

\expandafter\renewcommand\csname sectionformat\endcsname{}

\newcommand{\notsubsub}[1]{

	\setsomething{pre}{#1}%
	\setsomething{after}{#1}%

	\ifx\gadse@sectionformat\temp@default
		\expandafter\renewcommand\expandafter*\csname #1sectionformat\endcsname{\setnumbers{0}{#1}%
			\expandafter\csname the#1section\endcsname\ %
		}%
	\else
		\expandafter\renewcommand\expandafter*\csname #1sectionformat\endcsname{\setnumbers{0}{#1}%
			{%
				\expandafter\csname\csname gadse@#1sectionnumseries\endcsname\endcsname%
				\csname pre#1sectionnum\endcsname%
				\expandafter\csname the#1section\endcsname%
				\csname aftersectionnum\endcsname%
			}%
				\expandafter\csname\csname gadse@#1sectionseries\endcsname\endcsname%
		}%
	\fi
}

\notsubsub{}
\notsubsub{sub}

\setkomafont{disposition}{\raggedright\large\csname\gadse@sectionseries\endcsname}%

%\unsettoc{toc}{noindent}
\DeclareTOCStyleEntry[entryformat=\normalfont\bfseries, pagenumberformat=\normalfont\bfseries]{tocline}{section}
\DeclareTOCStyleEntries[dynindent, indent = 0.5cm, indentfollows = {section, subsection, subsubsection}]{tocline}{section, subsection, subsubsection}
\DeclareTOCStyleEntry[entryformat=\normalfont\bfseries, pagenumberformat=\normalfont\bfseries]{tocline}{part}

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
\sisetup{%
	display-per-mode = fraction,%
	inline-per-mode = symbol,%
	exponent-mode = scientific,%
	exponent-product = \cdot,%
	product-symbol = \ensuremath{\cdot}%
	}%
\newcommand{\binnum}[2][0]{%
	\num[digit-group-size = 4, minimum-integer-digits = #1]{#2}_{2}%
}
\newcommand{\decnum}[1]{%
	\num{#1}_{10}%
}
\newcommand{\hexnum}[1]{%
	\text{#1}_{16}%
}
\RequirePackage{tikz}
\newcommand{\mynode}[2]{\tikz[remember picture]{\node[inner sep = 0pt](#1){#2};}}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}
%\makeatletter
\def\pgfplotsforeachtodomain@@.#1\relax{%
	\pgf@xa=0.#1pt %   
		\ifdim\pgf@xa>0.01pt  % % <----corrected \ifdim instead of ifnum
			\def\pgfplotsretval{}%
			\def\pgfplotsretvalb{}%
		\else
			\edef\pgfplotsretvalb{\the\c@pgf@counta}%
		\fi
}%
%\makeatletter

\DeclareMathOperator{\diam}{diam}
\DeclareMathOperator{\sech}{sech}
\DeclareMathOperator{\csch}{csch}
\DeclareMathOperator{\arcsec}{arcsec}
\DeclareMathOperator{\arccot}{arccot}
\DeclareMathOperator{\arccsc}{arccsc}
\DeclareMathOperator{\arccosh}{arccosh}
\DeclareMathOperator{\arcsinh}{arcsinh}
\DeclareMathOperator{\arctanh}{arctanh}
\DeclareMathOperator{\arcsech}{arcsech}
\DeclareMathOperator{\arccsch}{arccsch}
\DeclareMathOperator{\arccoth}{arccoth}
\DeclareMathOperator{\Real}{Re}
\DeclareMathOperator{\Imaginary}{Im}

%not math
\RequirePackage[ngerman, english]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage[babel]{csquotes}
\RequirePackage{enumitem}
\RequirePackage{tabularx, booktabs}
\RequirePackage{multicol}
\RequirePackage{marvosym}
\RequirePackage{arydshln}
\RequirePackage{float}
\usepackage[style=iso]{datetime2}


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

\newcommand{\myboxenvironment}[5]{ % tcolorbox-environment %
	\ifgadse@transparentEnvironments
		\newtcolorbox{cache#1#2box}[2]{
			standard jigsaw,%
			opacityback	= 0,%
			title		= ##1,
			fonttitle	= \bfseries,
			colback		= #3,
			colframe	= #4,
			sharp corners,
			rounded corners	= northeast,
			rounded corners	= southeast,
			arc		= 2pt,
			outer arc	= 2pt,
			boxrule		= 0pt,
			leftrule	= 4pt,
			breakable,
			##2
		}
	\else
		\ifstrequal{#5}{true}{%
			\newtcolorbox{cache#1#2box}[2]{
				standard jigsaw,%
				opacityback	= 0,%
				title = ##1,%
				fonttitle	= \bfseries,
				colback		= #3,
				colframe	= #4,
				sharp corners,
				rounded corners	= northeast,
				rounded corners	= southeast,
				arc		= 2pt,
				outer arc	= 2pt,
				boxrule		= 0pt,
				leftrule	= 4pt,
				breakable,
				##2
			}
		}{
			\newtcolorbox{cache#1#2box}[2]{
				title		= ##1,
				fonttitle	= \bfseries,
				colback		= #3,
				colframe	= #4,
				sharp corners,
				rounded corners	= northeast,
				rounded corners	= southeast,
				arc		= 2pt,
				outer arc	= 2pt,
				boxrule		= 0pt,
				leftrule	= 4pt,
				breakable,
				##2
			}
		}
	\fi
}

\if \gadse@consecutivenumbering 0
	\newcommand{\cachemyenvironment}[5]{ % command to define \#1#2number, #1#2 tcolorbox, #1#2box %
		%\setlength\parindent{1em}
		\ifstrequal{#1}{nosection}{
			\newcounter{#1#2number}%
			\expandafter\renewcommand\csname the#1#2number\endcsname{\arabic{#1#2number}}%
		}{
			\newcounter{#1#2number}[#1section]%
			\expandafter\renewcommand\csname the#1#2number\endcsname{\csname the#1section\endcsname.\arabic{#1#2number}}%
		}
		\myboxenvironment{#1}{#2}{#3}{#4}{#5}%
		\newenvironment{#1#2}[1][]{%
			\refstepcounter{#1#2number}%
			\begin{cache#1#2box}{\MakeUppercase#2 \csname the#1#2number\endcsname\quad{##1}}{}%
				\setlength\parindent{1em}%
			}{%
			\end{cache#1#2box}%
		}
		\newenvironment{#1#2*}[1][]{%
			\begin{cache#1#2box}{\MakeUppercase#2 \quad{##1}}{}%
				\setlength\parindent{1em}%
			}{%
			\end{cache#1#2box}%
		}
		\newenvironment{#1#2-headless}{%
			\begin{cache#1#2box}{}{title = }%
				\setlength\parindent{1em}%
			}{%
			\end{cache#1#2box}%
		}
	}
\else
	\newcommand{\cachemyenvironment}[5]{ % command to define \#1#2number, #1#2 tcolorbox, #1#2box %
		%\setlength\parindent{1em}
		\myboxenvironment{#1}{#2}{#3}{#4}{#5}%
		\newenvironment{#1#2}[1][]{%
			\refstepcounter{#1environmentnumber}%
			\label{\csname the#1environmentnumber\endcsname}
			\begin{cache#1#2box}{\MakeUppercase#2 \csname the#1environmentnumber\endcsname\quad{##1}}{}%
				\setlength\parindent{1em}%
			}{%
			\end{cache#1#2box}%
		}
		\newenvironment{#1#2*}[1][]{%
			\begin{cache#1#2box}{\MakeUppercase#2 \quad{##1}}{}%
				\setlength\parindent{1em}%
			}{%
			\end{cache#1#2box}%
		}
		\newenvironment{#1#2-headless}{%
			\begin{cache#1#2box}{}{title = }%
				\setlength\parindent{1em}%
			}{%
			\end{cache#1#2box}%
		}
	}
\fi

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

\if \gadse@consecutivenumbering0%
\else%
	\newcounter{environmentnumber}[section]%
	\newcounter{subenvironmentnumber}[subsection]%
	\newcounter{subsubenvironmentnumber}[subsubsection]%
	\expandafter\renewcommand\csname theenvironmentnumber\endcsname{\csname thesection\endcsname.\arabic{environmentnumber}}%
		\expandafter\renewcommand\csname thesubenvironmentnumber\endcsname{\csname thesubsection\endcsname.\arabic{subenvironmentnumber}}%
		\expandafter\renewcommand\csname thesubsubenvironmentnumber\endcsname{\csname thesubsection\endcsname.\arabic{subsubenvironmentnumber}}%
\fi

\newcommand{\myenvironment}[4]{%
	\cachemyenvironment{}{#1}{#2}{#3}{#4}%
	\cachemyenvironment{sub}{#1}{#2}{#3}{#4}%
	\cachemyenvironment{subsub}{#1}{#2}{#3}{#4}%
	\cachemyenvironment{nosection}{#1}{#2}{#3}{#4}%
}

\myenvironment{example}		{gadse-orange}%
				{gadse-red}%
				{0}%
\myenvironment{task}		{gadse-orange!50!gadse-yellow}%
				{gadse-red!50!gadse-orange}%
				{0}%
\myenvironment{problem}		{gadse-yellow}%
				{gadse-orange}%
				{0}%
%
\myenvironment{definition}	{gadse-pink!50!gadse-white}%
				{gadse-pink}%
				{0}%
\myenvironment{axiom}		{gadse-dark-green!50!gadse-light-green}%
				{gadse-dark-green!100!gadse-black}%
				{0}%
%
\myenvironment{theorem}		{gadse-dark-green!50!gadse-light-green}%
				{gadse-dark-green!100!gadse-ligth-green}%
				{0}%
\myenvironment{proposition}	{gadse-dark-green!25!gadse-light-green}%
				{gadse-dark-green!75!gadse-light-green}%
				{0}%
\myenvironment{lemma}		{gadse-light-green}%
				{gadse-dark-green!25!gadse-light-green}%
				{0}%
\myenvironment{conjecture}	{gadse-dark-green!75!gadse-light-green}%
				{gadse-dark-green!75!gadse-black}%
				{0}%
\myenvironment{corollary}	{gadse-light-green!50!gadse-white}%
				{gadse-light-green!100!gadse-white}%
				{0}%
%
\myenvironment{proof}		{gadse-orange!50!gadse-light-blue!100!gadse-white}%
				{gadse-red!50!gadse-dark-blue}%
				{true}%
\myenvironment{algorithm}	{gadse-light-blue}%
				{gadse-dark-blue}%
				{0}%


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
	\if \gadse@consecutivenumbering0%
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
	\else%
		\setcounter{#2environmentnumber}{#1}%
	\fi%
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

\newcommand{\qed}{\@ifstar\@qedwhite\@qedblack}
\DeclareRobustCommand{\@qedblack}{%
	\ifmmode \tag*{$\blacksquare$}%
	\else \leavevmode\unskip\penalty9999 \hbox{}\nobreak\hfill\quad\hbox{$\blacksquare$}%
	\fi%
}
\DeclareRobustCommand{\qedwhite}{%
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
\newcommand{\F}{\mathbb{F}}
\newcommand{\OO}{\emptyset}
\newcommand{\mathsec}[2]{\texorpdfstring{$#1$}{#2}}

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
		\csname gadse@print#1true\endcsname%
	}%
	\expandafter\gdef\csname #1\endcsname{#1}%
}

\definetitles{title}
\definetitles{subtitle}
\definetitles{titlelh}
\definetitles{titlerh}
\definetitles{university}
\definetitles{faculty}
\definetitles{semester}

\newcommand*{\defaultmathtitle}{%
	\setsemester{Winter Semester 2023/2024}%
	\setuniversity{University of Konstanz}%
	\setfaculty{Faculty of Science (Mathematics and Statistics)}%
}
\newcommand*{\defaultphysicstitle}{%
	\setsemester{Winter Semester 2023/2024}%
	\setuniversity{University of Konstanz}%
	\setfaculty{Faculty of Science (Physics)}%
}
\newcommand*{\defaultcomputersciencetitle}{%
	\setsemester{Winter Semester 2023/2024}%
	\setuniversity{University of Konstanz}%
	\setfaculty{Faculty of Science\\(Computer and Information Science)}%
}

% sets title headers
\settitlelh{\today\\\semester}
\settitlerh{\university\\\faculty}

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
	\ifgadse@printtitle
	\begin{center}%
		\unskip%
		\ifgadse@printsubtitle%
		{\LARGE \title}\\[2pt]%
		{\large \subtitle}\\%
		\else%
		{\LARGE \title}\\%
		\fi%
	\end{center}%
	\endgroup%
	\hrule%
	\fi
	\vskip 1cm
	\thispagestyle{empty}%
}
