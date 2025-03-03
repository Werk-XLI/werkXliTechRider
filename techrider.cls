% techrider.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{techrider}[2024/11/28 Band Tech Rider Class]

% Load necessary packages
\LoadClass[12pt]{scrartcl} % Base on scrartcl
\RequirePackage{geometry}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{svg}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[german]{babel}
\RequirePackage[table]{xcolor}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{ifthen}

%Font setup
\renewcommand*\familydefault{\sfdefault}

% Geometry setup
\geometry{a4paper, margin=1in}

% Custom section formatting
\titleformat{\section}{\large\bfseries\sffamily\color{darkgray}}{}{0em}{}
\titleformat{\subsection}{\normalsize\bfseries\sffamily\color{gray}}{}{0em}{}

% Custom header/footer
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\includesvg[width=0.075\textwidth]{Images/logo}}
\fancyhead[R]{\sffamily\color{gray}\thepage}

% Commands for rider-specific formatting
\newcommand{\bandname}[1]{\def\@bandname{#1}}
\newcommand{\contactinfo}[1]{\def\@contactinfo{#1}}

% Title block
\newcommand{\maketitleblock}{
    \begin{center}
        \vspace*{2em}
        {\Huge\bfseries\sffamily Tech Rider}\\[1em]
        {\Large\bfseries\sffamily \@bandname}\\[1em]
        {\color{gray}\@contactinfo}
        \vspace*{2em}
    \end{center}
    \hrule
    \vspace{2em}
}

% Start document
\renewcommand{\maketitle}{\maketitleblock}

\endinput

