@echo off

if .%1.==.. goto NoSolutionFile


set _@slnfile=%1

if /i "%~x1"==".sln" goto SlnSet
set _@slnfile=%1.sln

:SlnSet
if not exist %_@slnfile% goto FileNotFound

:Platform
if /I .%3. EQU ..          set _@platform=&goto BuildType
if /I .%3. EQU .x86.       set _@platform=x86&goto BuildType
if /I .%3. EQU ."x86".     set _@platform=x86&goto BuildType
if /I .%3. EQU .x64.       set _@platform=x64&goto BuildType
if /I .%3. EQU ."x64".     set _@platform=x64&goto BuildType
if /I .%3. EQU ."any cpu". set _@platform="Any CPU"&goto BuildType
goto Invalid_Platform

:BuildType
if /I .%2. EQU .clean.    goto clean
if /I .%2. EQU .debug.    goto debug
if /I .%2. EQU .release.  goto release

goto InvalidSyntax

:clean
set _@target1=Clean
set _@config1=Debug
set _@target2=Clean
set _@config2=Release
goto builditcore

:debug
set _@target1=Clean
set _@config1=Debug
set _@target2=Rebuild
set _@config2=Debug
goto builditcore

:release
set _@target1=Clean
set _@config1=Release
set _@target2=Rebuild
set _@config2=Release
goto builditcore

:builditcore
call builditcore.cmd %_@slnfile% %_@target1% %_@config1% %_@platform%
if errorlevel 1 goto builditcoreerror
call builditcore.cmd %_@slnfile% %_@target2% %_@config2% %_@platform%
if errorlevel 1 goto builditcoreerror
goto end


:NoSolutionFile
echo.
echo Invalid solution filename.
echo.
goto syntax

:FileNotFound
echo.
echo File not found, %_@slnfile%
echo.
goto syntax

:InvalidSyntax
echo.
echo Invalid command line arguments
echo.
goto syntax

:Invalid_Platform
echo.
echo Invalid Platform
echo.
goto syntax

:syntax
echo.
echo.******************
echo    Sample usage
echo.******************
echo.
echo buildit.bat [SolutionFile] [target] [Platform]
echo.
echo SolutionFile
echo.
echo    solution filename. eg: dotnet.sln
echo.
echo Targets
echo.
echo    clean    - clean in debug and release configurations
echo    debug    - clean and rebuild in debug configuration
echo    release  - clean and rebuild in release configuration
echo    platform - not req., either x86, x64, "Any CPU"
echo               if not entered, it will used the project default
echo.
goto setexiterror

:builditcoreerror
echo *************************************************
echo    Error occurred during builditcore, see above.
echo *************************************************
echo.
goto setexiterror

:setexiterror
exit /b 1
goto end

:end
