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
%                              CLASS OPTIONS                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Equipment presets
\DeclareOption{standard}{\def\@equipmentpreset{standard}}
\DeclareOption{small}{\def\@equipmentpreset{small}}
\DeclareOption{large}{\def\@equipmentpreset{large}}

% Default options
\ExecuteOptions{standard}
\ProcessOptions\relax

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
\RequirePackage{ifthen}
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
%                              EQUIPMENT DATABASE                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Equipment boolean switches - Drums
\newboolean{bringKickDrum}
\newboolean{bringSnare}
\newboolean{bringToms}
\newboolean{bringCymbals}
\newboolean{bringKickMic}
\newboolean{bringSnareMic}
\newboolean{bringTomMics}
\newboolean{bringOverheadMics}
\newboolean{bringHiHatMic}

% Guitar equipment
\newboolean{bringGuitarAmp}
\newboolean{bringGuitarMic}

% Bass equipment
\newboolean{bringBassAmp}

% Keyboards equipment
\newboolean{bringKeyboard}
\newboolean{bringKeytar}
\newboolean{bringKeysDI}

% Vocals equipment
\newboolean{bringMainVocalMic}
\newboolean{bringBackingVocalMics}

% Monitoring equipment
\newboolean{bringIEMRack}
\newboolean{bringIEMTransmitters}
\newboolean{bringIEMReceivers}
\newboolean{bringIEMEarbuds}

% System equipment
\newboolean{bringMixingDesk}
\newboolean{bringPA}
\newboolean{bringSnake}
\newboolean{bringPowerDistro}
\newboolean{bringCables}
\newboolean{bringLights}
\newboolean{bringExtensionCables}
\newboolean{bringGafferTape}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              PRESET CONFIGURATIONS                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\setupEquipmentPreset}[1]{%
    \ifstrequal{#1}{small}{%
        % SMALL VENUE: Intimate venues, clubs, small stages
        % Drums - small venue
        \setboolean{bringKickDrum}{true}
        \setboolean{bringSnare}{true}
        \setboolean{bringToms}{true}
        \setboolean{bringCymbals}{true}
        \setboolean{bringKickMic}{true}
        \setboolean{bringSnareMic}{true}
        \setboolean{bringTomMics}{true}
        \setboolean{bringOverheadMics}{false}
        \setboolean{bringHiHatMic}{true}
        % Guitar - small venue
        \setboolean{bringGuitarAmp}{true}
        \setboolean{bringGuitarMic}{true}
        \setboolean{bringGuitarCabinet}{false}
        \setboolean{bringGuitarHead}{false}
        \setboolean{bringGuitarDI}{false}
        \setboolean{bringGuitarPedals}{true}
        % Bass - small venue
        \setboolean{bringBassAmp}{true}
        \setboolean{bringBassDI}{true}
        \setboolean{bringBassHead}{false}
        \setboolean{bringBassCabinet}{false}
        \setboolean{bringBassMic}{false}
        % Keys - small venue
        \setboolean{bringKeyboard}{true}
        \setboolean{bringKeyboard2}{false}
        \setboolean{bringKeysDI}{true}
        \setboolean{bringKeysStand}{true}
        \setboolean{bringKeysStool}{true}
        % Vocals - small venue
        \setboolean{bringMainVocalMic}{true}
        \setboolean{bringBackingVocalMics}{true}
        \setboolean{bringVocalProcessor}{false}
        \setboolean{bringHarmonicaRack}{false}
        % Monitoring - small venue
        \setboolean{bringIEMRack}{true}
        \setboolean{bringIEMTransmitters}{true}
        \setboolean{bringIEMReceivers}{true}
        \setboolean{bringIEMEarbuds}{true}
        \setboolean{bringHeadphoneAmp}{false}
        \setboolean{bringPersonalMonitor}{true}
        % System - small venue
        \setboolean{bringMixingDesk}{false}
        \setboolean{bringPA}{false}
        \setboolean{bringSnake}{false}
        \setboolean{bringPowerDistro}{true}
        \setboolean{bringCables}{true}
        \setboolean{bringLights}{false}
        \setboolean{bringExtensionCables}{true}
        \setboolean{bringGafferTape}{true}
    }
    {%
        \ifstrequal{#1}{standard}{%
            % STANDARD: Normal rock band setup
            % Drums - standard
            \setboolean{bringKickDrum}{true}
            \setboolean{bringSnare}{true}
            \setboolean{bringToms}{true}
            \setboolean{bringCymbals}{true}
            \setboolean{bringKickMic}{true}
            \setboolean{bringSnareMic}{true}
            \setboolean{bringTomMics}{true}
            \setboolean{bringOverheadMics}{true}
            \setboolean{bringHiHatMic}{true}
            % Guitar - standard
            \setboolean{bringGuitarAmp}{true}
            \setboolean{bringGuitarMic}{true}
            \setboolean{bringGuitarCabinet}{false}
            \setboolean{bringGuitarHead}{false}
            \setboolean{bringGuitarDI}{false}
            \setboolean{bringGuitarPedals}{true}
            % Bass - standard
            \setboolean{bringBassAmp}{true}
            \setboolean{bringBassDI}{true}
            \setboolean{bringBassHead}{false}
            \setboolean{bringBassCabinet}{false}
            \setboolean{bringBassMic}{false}
            % Keys - standard
            \setboolean{bringKeyboard}{true}
            \setboolean{bringKeyboard2}{false}
            \setboolean{bringKeysDI}{true}
            \setboolean{bringKeysStand}{true}
            \setboolean{bringKeysStool}{true}
            % Vocals - standard
            \setboolean{bringMainVocalMic}{true}
            \setboolean{bringBackingVocalMics}{true}
            \setboolean{bringVocalProcessor}{false}
            \setboolean{bringHarmonicaRack}{false}
            % Monitoring - standard
            \setboolean{bringIEMRack}{true}
            \setboolean{bringIEMTransmitters}{true}
            \setboolean{bringIEMReceivers}{true}
            \setboolean{bringIEMEarbuds}{true}
            \setboolean{bringHeadphoneAmp}{false}
            \setboolean{bringPersonalMonitor}{false}
            % System - standard
            \setboolean{bringMixingDesk}{false}
            \setboolean{bringPA}{false}
            \setboolean{bringSnake}{false}
            \setboolean{bringPowerDistro}{true}
            \setboolean{bringCables}{true}
            \setboolean{bringLights}{false}
            \setboolean{bringExtensionCables}{true}
            \setboolean{bringGafferTape}{true}
        }{%
            \ifstrequal{#1}{large}{%
                % LARGE VENUE: Concert halls, large venues, festivals
                % Drums - large venue
                \setboolean{bringKickDrum}{true}        % Bring own kick for consistency
                \setboolean{bringSnare}{true}
                \setboolean{bringToms}{true}
                \setboolean{bringCymbals}{true}
                \setboolean{bringKickMic}{true}
                \setboolean{bringSnareMic}{true}
                \setboolean{bringTomMics}{true}
                \setboolean{bringOverheadMics}{true}
                \setboolean{bringHiHatMic}{true}
                % Guitar - large venue
                \setboolean{bringGuitarAmp}{false}      % Use venue backline
                \setboolean{bringGuitarMic}{false}
                \setboolean{bringGuitarCabinet}{false}
                \setboolean{bringGuitarHead}{true}      % Bring head, use venue cab
                \setboolean{bringGuitarDI}{true}
                \setboolean{bringGuitarPedals}{true}
                % Bass - large venue
                \setboolean{bringBassAmp}{false}        % Use venue backline
                \setboolean{bringBassDI}{true}
                \setboolean{bringBassHead}{true}        % Bring head, use venue cab
                \setboolean{bringBassCabinet}{false}
                \setboolean{bringBassMic}{false}
                % Keys - large venue
                \setboolean{bringKeyboard}{true}
                \setboolean{bringKeyboard2}{true}       % Full keyboard rig
                \setboolean{bringKeysDI}{true}
                \setboolean{bringKeysStand}{true}
                \setboolean{bringKeysStool}{true}
                % Vocals - large venue
                \setboolean{bringMainVocalMic}{true}    % Bring own mics
                \setboolean{bringBackingVocalMics}{true}
                \setboolean{bringVocalProcessor}{true}
                \setboolean{bringHarmonicaRack}{true}
                % Monitoring - large venue
                \setboolean{bringIEMRack}{true}
                \setboolean{bringIEMTransmitters}{true}
                \setboolean{bringIEMReceivers}{true}
                \setboolean{bringIEMEarbuds}{true}
                \setboolean{bringHeadphoneAmp}{true}    % Backup monitoring
                \setboolean{bringPersonalMonitor}{false}
                % System - large venue
                \setboolean{bringMixingDesk}{false}     % Use venue FOH
                \setboolean{bringPA}{false}
                \setboolean{bringSnake}{false}
                \setboolean{bringPowerDistro}{true}
                \setboolean{bringCables}{true}
                \setboolean{bringLights}{false}         % Venue has lights
                \setboolean{bringExtensionCables}{true}
                \setboolean{bringGafferTape}{true}
            }{%
                % Default case - do nothing
            }%
        }%
    }%
}

% Apply the chosen preset
\AtBeginDocument{%
    \setupEquipmentPreset{\@equipmentpreset}%
    % Load configuration files
    \input{equipmentConfig.tex}%
    \input{channelConfig.tex}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              CHANNEL DEFINITIONS                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Channel data structure: {Number, Name, Source, Equipment, Category}
\newcommand{\defineChannel}[5]{%
    \expandafter\gdef\csname channel#1Number\endcsname{#1}%
    \expandafter\gdef\csname channel#1Name\endcsname{#2}%
    \expandafter\gdef\csname channel#1Source\endcsname{#3}%
    \expandafter\gdef\csname channel#1Equipment\endcsname{#4}%
    \expandafter\gdef\csname channel#1Category\endcsname{#5}%
}

% Get channel field
\newcommand{\getChannelField}[2]{%
    \csname channel#1#2\endcsname%
}

% Get category color (simplified approach)
\newcommand{\getCategoryColor}[1]{%
    \ifthenelse{\equal{#1}{Drums}}{drumscolor}{%
        \ifthenelse{\equal{#1}{Guitar}}{guitarcolor}{%
            \ifthenelse{\equal{#1}{Bass}}{basscolor}{%
                \ifthenelse{\equal{#1}{Keys}}{keyscolor}{%
                    \ifthenelse{\equal{#1}{Vocals}}{vocalscolor}{%
                        \ifthenelse{\equal{#1}{Tracks}}{trackscolor}{%
                            \ifthenelse{\equal{#1}{Monitoring}}{monitoringcolor}{%
                                \ifthenelse{\equal{#1}{System}}{systemcolor}{%
                                    white%
                                }}}}}}}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              PATCH PLAN HELPERS                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Channel table row
\newcommand{\channelRow}[1]{%
    \rowcolor{\getCategoryColor{\getChannelField{#1}{Category}}}
    \getChannelField{#1}{Number} & \getChannelField{#1}{Name} & \getChannelField{#1}{Equipment} \\
    \hline
}

% Input channels table - Verbesserte Typographie
\newcommand{\inputChannelsTable}{%
    \begin{center}
        \renewcommand{\arraystretch}{1.4}
        \begin{tabular}{|c|p{6cm}|}
            \hline
            \rowcolor{systemcolor}
            \subsectionstyle{Channel} & \subsectionstyle{Quelle} \\
            \hline
            \fohInputChannels
        \end{tabular}
    \end{center}
}

% Output channels table - Verbesserte Typographie
\newcommand{\outputChannelsTable}{%
    \begin{center}
        \renewcommand{\arraystretch}{1.4}
        \begin{tabular}{|c|p{6cm}|}
            \hline
            \rowcolor{systemcolor}
            \subsectionstyle{Channel} & \subsectionstyle{Quelle} \\
            \hline
            \iemOutputChannels
        \end{tabular}
    \end{center}
}

% Define input and output channel rows (to be set by user)
\def\@inputchannelsrows{}
\def\@outputchannelsrows{}

\newcommand{\setInputChannels}[1]{\def\@inputchannelsrows{#1}}
\newcommand{\setOutputChannels}[1]{\def\@outputchannelsrows{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              EQUIPMENT LIST HELPERS                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Equipment item structure
\newcommand{\equipmentItem}[5][]{%
    % #1 = optional condition (boolean)
    % #2 = category
    % #3 = name
    % #4 = details
    % #5 = power requirement
    \ifthenelse{\equal{#1}{}}{%
        % No condition, always include
        #2 & #3 & #4 & #5 \\
        \hline
    }{%
        % Check boolean condition
        \ifthenelse{\boolean{#1}}{%
            #2 & #3 & #4 & #5 \\
            \hline
        }{}%
    }%
}

% Equipment list tables - Verbesserte Typographie
\newcommand{\bandEquipmentTable}{%
    \begin{center}
        \renewcommand{\arraystretch}{1.4}
        \begin{tabular}{|l|l|p{4cm}|c|}
            \hline
            \rowcolor{systemcolor}
            \subsectionstyle{Kategorie} & \subsectionstyle{Equipment} & \subsectionstyle{Details} & \subsectionstyle{Power} \\
            \hline
            \allBandEquipment
        \end{tabular}
    \end{center}
}

\newcommand{\venueRequirementsTable}{%
    \begin{center}
        \renewcommand{\arraystretch}{1.4}
        \begin{tabular}{|l|p{4cm}|p{5cm}|}
            \hline
            \rowcolor{systemcolor}
            \subsectionstyle{Kategorie} & \subsectionstyle{Anforderung} & \subsectionstyle{Details} \\
            \hline
            % Venue requirements will be added here
        \end{tabular}
    \end{center}
}

% Define equipment rows (to be set by user)
\def\@bandequipmentrows{}
\def\@venuerequirementsrows{}

\newcommand{\setBandEquipment}[1]{\def\@bandequipmentrows{#1}}
\newcommand{\setVenueRequirements}[1]{\def\@venuerequirementsrows{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              POWER CALCULATION                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{powerCount}

\newcommand{\calculatePower}{%
    \setcounter{powerCount}{0}%
    % Always need IEM rack and keyboard
    \addtocounter{powerCount}{2}%
    % Add guitar amp if brought
    \ifbool{bringGuitarAmp}{\stepcounter{powerCount}}{}%
    % Add bass amp if brought
    \ifbool{bringBassAmp}{\stepcounter{powerCount}}{}%
}

\newcommand{\totalPowerNeeded}{%
    \calculatePower%
    \arabic{powerCount}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              STAGE PLOT HELPERS                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Stage plot dimensions
\newcommand{\stageWidth}{12}
\newcommand{\stageHeight}{8}

% Equipment positions (to be customized)
\newcommand{\drumPosition}{(6,6)}
\newcommand{\guitarAmpPosition}{(2,2)}
\newcommand{\bassAmpPosition}{(10,2)}
\newcommand{\keyboardPosition}{(6,3)}
\newcommand{\iemRackPosition}{(1,4)}

% Stage plot drawing
\newcommand{\drawStagePlot}{%
    \begin{center}
        \begin{tikzpicture}[scale=0.8]
            % Stage outline
            \draw[thick] (0,0) rectangle (\stageWidth,\stageHeight);
            \node at (\stageWidth/2,\stageHeight+0.5) {\textbf{upstage}};
            \node at (\stageWidth/2,-0.5) {\textbf{downstage}};
            \node[rotate=90] at (-0.5,\stageHeight/2) {\textbf{stage right}};
            \node[rotate=-90] at (\stageWidth+0.5,\stageHeight/2) {\textbf{stage left}};

            % Equipment positions
            \@stageplotitems

            % Drum IEM-Power, etc.
            \node[fill=black,circle,inner sep=2pt] at (\stageWidth/2,\stageHeight-0.5) {};
            \node[below] at (\stageWidth/2,\stageHeight-0.5) {\tiny 230V};
            % IEM-Rack
            \node[fill=black,circle,inner sep=2pt] at (\stageWidth-0.5,\stageHeight-0.5) {};
            \node[below] at (\stageWidth-0.5,\stageHeight-0.5) {\tiny 230V};
            % Bass Amp
            \node[fill=black,circle,inner sep=2pt] at (0.5,\stageHeight/2+0.5) {};
            \node[below] at (0.5,\stageHeight/2+0.5) {\tiny 230V};
            % Guitar Amp
            \node[fill=black,circle,inner sep=2pt] at (\stageWidth/2+0.5,\stageHeight-3) {};
            \node[below] at (\stageWidth/2+0.5,\stageHeight-3) {\tiny 230V};
            % Keytar-Rack
            \node[fill=black,circle,inner sep=2pt] at (\stageWidth-0.5,\stageHeight/2+0.5) {};
            \node[below] at (\stageWidth-0.5,\stageHeight/2+0.5) {\tiny 230V};
            % Guitar Pedal
            \node[fill=black,circle,inner sep=2pt] at (\stageWidth/2,0.5) {};
            \node[below] at (\stageWidth/2,0.5) {\tiny 230V};

        \end{tikzpicture}
    \end{center}
}

% Define stage plot items (to be set by user)
\def\@stageplotitems{}
\newcommand{\setStagePlotItems}[1]{\def\@stageplotitems{#1}}

% Helper commands to use predefined configurations
\newcommand{\useStandardEquipment}{\setBandEquipment{\allBandEquipment}}
\newcommand{\useStandardChannels}{%
    \setInputChannels{\fohInputChannels}%
    \setOutputChannels{\iemOutputChannels}%
}
\newcommand{\useStandardVenueRequirements}{%
    \setVenueRequirements{\standardVenueRequirements}%
}
\newcommand{\useSmallVenueRequirements}{%
    \setVenueRequirements{\smallVenueRequirements}%
}
\newcommand{\useLargeVenueRequirements}{%
    \setVenueRequirements{\largeVenueRequirements}%
}
\newcommand{\useStandardStagePlot}{\setStagePlotItems{\standardStagePlot}}

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
%                              UTILITY FUNCTIONS                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Checkmark symbol
\newcommand{\checkmark}{\ding{51}}

% Cross symbol  
\newcommand{\crossmark}{\ding{55}}

% Boolean display
\newcommand{\booleanDisplay}[1]{%
    \ifbool{#1}{\checkmark}{\crossmark}%
}

% Equipment override command
\newcommand{\equipmentOverride}[2]{%
    \setboolean{#1}{#2}%
}

% Custom equipment preset
\newcommand{\customPreset}[1]{%
    #1%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              END OF CLASS                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput

