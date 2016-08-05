@ECHO OFF

REM [customize those variables]
SET editor=f:\programs\notepad++\notepad++.exe
SET editorargs=-x835 -y39
SET projectspath=f:\dev\projects\cpp
SET vcvarallpath=f:\dev\ide\vc2010\vc\vcvarall.bat
SET arch=x86
REM ###########################

SETLOCAL
SET new=/new
SET del=/del
SET folder=/fol
SET list=/lst
SET help=/?

IF [%1]==[%new%] GOTO CheckNewProjectName
IF [%1]==[%del%] GOTO CheckDeleteProjectName
IF [%1]==[%folder%] GOTO OpenProjectFolder
IF [%1]==[%list%] GOTO ListProjects
IF [%1]==[%help%] GOTO About
IF [%1]==[] GOTO About
GOTO LoadProject

:CheckNewProjectName
IF [%2]==[] GOTO NameNotSpecified
GOTO SetupNewProject

:CheckDeleteProjectName
IF [%2]==[] GOTO NameNotSpecified
GOTO DeleteProject

:SetupNewProject
IF EXIST "%projectspath%\%2\" GOTO ProjectExists

ECHO: Creating new project...

ENDLOCAL
CALL "%vcvarallpath%" %arch%

MKDIR "%projectspath%\%2"
MKDIR "%projectspath%\%2\code"
MKDIR "%projectspath%\%2\tools"
MKDIR "%projectspath%\%2\data"

SET project=%2
SET bin=..\bin
SET source=..\code
SET tools=..\tools

IF EXIST "%~dp0\tools\" COPY "%~dp0\tools\*" "%projectspath%\%2\tools"
IF EXIST "%projectspath%\%2\tools\build.bat" CALL %projectspath%\%2\tools\build.bat setprjname %2

IF EXIST "%~dp0\files\" COPY "%~dp0\files\*" "%projectspath%\%2\code"

SET path=%projectspath%\%2\tools;%path%
CD /D "%projectspath%\%2\data"

CLS && ECHO: --- Lets rock! ---
IF NOT EXIST "%~dp0\tools\" ECHO: NOTE: We are missing tools

START "" "%editor%" "%editorargs%" "%projectspath%\%2\code\*.c" "%projectspath%\%2\code\*.cpp"
GOTO:EOF

:LoadProject
IF NOT EXIST "%projectspath%\%1\" ECHO: ERROR: Project "%1" was NOT found! && GOTO:EOF

ECHO: Loading project...

ENDLOCAL
CALL "%vcvarallpath%" %arch%

SET project=%1
SET bin=..\bin
SET source=..\code
SET tools=..\tools

SET path=%projectspath%\%1\tools;%path%
CD /D "%projectspath%\%1\data"

CLS && ECHO: --- Lets rock! ---

START "" "%editor%" "%editorargs%" "%projectspath%\%1\code\*.c" "%projectspath%\%1\code\*.cpp"
GOTO:EOF

:DeleteProject
IF NOT EXIST "%projectspath%\%2\" ECHO: ERROR: Project "%2" was NOT found! && GOTO:EOF

SET /P confirm=Project "%2" will be deleted. Correct? [y\n]: 
IF NOT [%confirm%]==[y] ECHO: Aborted. && GOTO:EOF

ECHO: Deleting project...
RMDIR /S /Q "%projectspath%\%2"
ECHO: Done!
GOTO:EOF

:OpenProjectFolder
IF NOT EXIST "%projectspath%" ECHO: ERROR: Projects folder was NOT found! && GOTO:EOF
EXPLORER "%projectspath%"
GOTO:EOF

:About
ECHO: "%~n0" is a small batch file that aims to help manage C\C++ projects
ECHO.
ECHO: NOTE: If you are planning to use this tool, please make sure you
ECHO: have modified path variables at the beginning of batch files to
ECHO: suite your needs.
ECHO.
ECHO: USAGE:
ECHO: %~n0 [%new%] [%del%] [..] project_name
ECHO.
ECHO: %new% - create a project with "project_name"
ECHO: %del% - delete a project with "project_name"
ECHO: %folder% - open a projects folder
ECHO: %list% - show a list of existing projects
ECHO: %help% - show this information
ECHO.
ECHO: If none of a keywords are specified project with "project_name" will be loaded
GOTO:EOF

:ListProjects
ECHO:List of available projects:
ECHO.
DIR %projectspath% /B /AD /P
GOTO:EOF

:NameNotSpecified
ECHO: ERROR: Name for a project was NOT specified!
GOTO:EOF

:ProjectExists
ECHO: ERROR: Project "%2" already exists!
GOTO:EOF
