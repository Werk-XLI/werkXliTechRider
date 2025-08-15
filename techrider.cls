%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                               %
%                           TECH RIDER DOCUMENT CLASS                          %
%                                                                               %
% A comprehensive LaTeX class for professional band tech riders with           %
% equipment database, automatic table generation, and patch planning.          %
%                                                                               %
% Author: Werk XLI                                                             %
% Version: 2.0                                                                 %
% Date: 2025-08-08                                                             %
%                                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{techrider}[2025/08/08 v2.0 Professional Tech Rider Class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              BASE CLASS                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass[12pt,a4paper]{scrartcl}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              REQUIRED PACKAGES                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[margin=2cm]{geometry}

% LuaLaTeX compatibility
\RequirePackage{iftex}
\ifLuaTeX
    % LuaLaTeX uses UTF-8 by default, no inputenc needed
    \RequirePackage{fontspec}  % For LuaLaTeX font handling
\else
    % For pdfLaTeX
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
\fi
\RequirePackage{lmodern}
\RequirePackage[german]{babel}
\RequirePackage{microtype}       % Verbesserte Mikrotypographie
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{svg}
\RequirePackage{transparent}
\RequirePackage[colorlinks=false,linkcolor=blue,urlcolor=blue]{hyperref}
\RequirePackage{etoolbox}        % Load early for \ifstrequal
\RequirePackage{colortbl}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{pifont}
\RequirePackage{array}
\RequirePackage{calc}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              DOCUMENT VARIABLES                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Band information
\def\@bandname{BAND NAME}
\def\@contactinfo{Contact Information}
\def\@setuptime{45 minutes}
\def\@loadintime{2 hours before show}

% Commands to set band information
\newcommand{\bandname}[1]{\long\def\@bandname{#1}}
% Contact information command - robuste Implementierung
\newcommand{\contactinfo}[1]{\long\def\@contactinfo{#1}}
\newcommand{\setuptime}[1]{\long\def\@setuptime{#1}}
\newcommand{\loadintime}[1]{\long\def\@loadintime{#1}}

% Kommando zur sicheren Ausgabe der Kontaktinfo
\newcommand{\printcontactinfo}{%
    \@contactinfo%
}
\newcommand{\printsetuptime}{%
    \@setuptime%
}
\newcommand{\printloadintime}{%
    \@loadintime%
}
\newcommand{\printbandname}{%
    \@bandname%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              TYPOGRAPHY SETTINGS                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Moderne Typographie-Einstellungen
\renewcommand{\familydefault}{\sfdefault}  % Sans-Serif als Standard
\linespread{1.15}                          % Leicht erhöhter Zeilenabstand

% Typographische Kommandos für verschiedene Hierarchie-Ebenen - ausgewogen
\newcommand{\titlestyle}[1]{\fontsize{24}{30}\selectfont\bfseries\sffamily #1}
\newcommand{\subtitlestyle}[1]{\fontsize{14}{17}\selectfont\sffamily #1}
\newcommand{\sectionstyle}[1]{\fontsize{13}{16}\selectfont\bfseries\sffamily #1}
\newcommand{\subsectionstyle}[1]{\fontsize{11}{14}\selectfont\bfseries\sffamily #1}
\newcommand{\bodystyle}[1]{\fontsize{10}{12}\selectfont\sffamily #1}
\newcommand{\captionstyle}[1]{\fontsize{9}{11}\selectfont\sffamily #1}
\newcommand{\technicalstyle}[1]{\fontsize{9}{11}\selectfont\ttfamily #1}

% Body-Text standardmäßig auf bodystyle setzen
\AtBeginDocument{%
    \fontsize{10}{12}\selectfont\sffamily% Direkt bodystyle-Einstellungen anwenden
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              COLOR DEFINITIONS                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Equipment category colors
\definecolor{drumscolor}{RGB}{255,102,102}      % Red
\definecolor{guitarcolor}{RGB}{102,255,102}     % Green
\definecolor{basscolor}{RGB}{255,255,102}       % Yellow
\definecolor{keyscolor}{RGB}{204,102,255}       % Purple
\definecolor{vocalscolor}{RGB}{255,255,255}     % White
\definecolor{trackscolor}{RGB}{102,178,255}     % Blue
\definecolor{monitoringcolor}{RGB}{229,204,255} % Light Purple (for IEM, monitors)
\definecolor{systemcolor}{RGB}{240,240,240}     % Gray
\definecolor{unusedcolor}{RGB}{248,248,248}     % Light Gray

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              DOCUMENT STRUCTURE                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Page style (using KOMA-Script features)
% Headers and footers are handled by KOMA-Script defaults

% Title page - Ausgewogene Schriftgrößen und Abstände
\renewcommand{\maketitle}{%
    \begin{titlepage}

        % Header mit Band Name und Tech Rider kombiniert
        \centering
        \titlestyle{\@bandname\space\textcolor{gray}{Tech-Rider}}

        % Logo kompakter einbinden
        \vspace{1cm}
        \@logoimage

        \vspace{0.5cm}

        % Hauptinformationen in zwei Spalten für bessere Raumnutzung
        \begin{center}
            \renewcommand{\arraystretch}{1.8}
            \begin{tabular}{@{}p{6cm}@{\hspace{1.5cm}}p{6cm}@{}}

                % Linke Spalte - Setup Information
                \colorbox{systemcolor}{
                    \begin{minipage}{6cm}
                        \vspace{0.4cm}
                        \centering
                        \subsectionstyle{Setup Information}\\[0.4cm]
                        \bodystyle{\textbf{Setup-Zeit:} \\ \@setuptime}\\[0.2cm]
                        \bodystyle{\textbf{Load-in:} \\ \@loadintime}
                        \vspace{0.4cm}
                    \end{minipage}
                }
                 &
                % Rechte Spalte - Technical Requirements  
                \colorbox{systemcolor}{
                    \begin{minipage}{6cm}
                        \vspace{0.4cm}
                        \centering
                        \subsectionstyle{Kontakt:}\\
                        \vspace{0.4cm}
                        \bodystyle{\printcontactinfo}
                        \vspace{1.09cm}
                    \end{minipage}
                }
            \end{tabular}
        \end{center}

        % Modernes Inhaltsverzeichnis
        \vspace{1.5cm}
        \begin{center}
            \subtitlestyle{Inhalt}
        \end{center}

        % Anpassung der TOC-Formatierung an das Dokument-Design
        {%
        \renewcommand{\contentsname}{}% Titel entfernen, da bereits oben gesetzt
        \hypersetup{linkcolor=black}% Schwarze Links statt blau
        \bodystyle{\@starttoc{toc}}%
        }
    \end{titlepage}
    \newpage
}

% Logo placeholder - kompakter
\def\@logoimage{\vspace{1cm}}
\newcommand{\logo}[1]{\def\@logoimage{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              SECTION FORMATTING                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TOC-Formatierung passend zum Dokumentdesign
\renewcommand{\@pnumwidth}{1.55em}
\renewcommand{\@tocrmarg}{2.55em}

% Modernisierte Section-Formatierung mit verbesserter Typographie und TOC-Einträgen
\renewcommand{\section}[1]{%
    \vspace{2\baselineskip}%
    {\sectionstyle{#1}}% Schriftänderungen in Gruppe einschließen
    \addcontentsline{toc}{section}{#1}%
    \vspace{0.8\baselineskip}%
    \fontsize{10}{12}\selectfont\sffamily% Zurück zu bodystyle
}

\renewcommand{\subsection}[1]{%
    \vspace{1.5\baselineskip}%
    {\subsectionstyle{\textcolor{darkgray}{#1}}}% Schriftänderungen in Gruppe einschließen
    \vspace{0.5\baselineskip}%
    \fontsize{10}{12}\selectfont\sffamily% Zurück zu bodystyle
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              END OF CLASS                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput

