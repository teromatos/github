@echo off

for %%a in (.) do set currentfolder=%%~na
set _d=%currentfolder%
echo %_d%.sln

::clean, debug, release
set _t=debug
set _p=
call buildit.cmd %_d%.sln %_t%  %_p%
if errorlevel 1 goto end

choice /T 5 /N /M "Run app?" /D N
if errorlevel 2 goto End
%_d%\bin\debug\%_d%.exe

:end
