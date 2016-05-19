@echo off

set _@v2="C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\MsBuild.exe"
set _@v3="C:\WINDOWS\Microsoft.NET\Framework\v3.5\MsBuild.exe"
set _@v4="C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319\MsBuild.exe"
set _@v12="C:\Program Files (x86)\MSBuild\12.0\Bin\MSBuild.exe"
set _@v14="C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe"

set _@v=%_@v14%

if not exist %_@v% echo Unable to locate %_@v%
if not exist %_@v% goto end

if .%1==./? goto syntax
if .%1==.?  goto syntax
if .%1==.   goto syntax

echo.
echo Solution:      %1
echo Target:        %2
echo Configuration: %3
echo Platform:      %4
echo.

if /I .%4. EQU ..   goto execute
goto execute_platform

:syntax
echo.
echo.******************
echo    Sample usage
echo.******************
echo.
echo builditcore.bat [solutionname] [target] [configuration] [platform]
echo.
echo SolutionFile
echo.
echo    solution filename. eg: dotnet.sln x86
echo.
echo Targets
echo.
echo    Clean   (do not include /t:, just use Clean, Build or Rebuild)
echo    Build   (do not include /t:, just use Clean, Build or Rebuild)
echo    Rebuild (do not include /t:, just use Clean, Build or Rebuild)
echo.
echo Configurations
echo.
echo    Debug    (do not include /p:Configuration, just use Debug or Release)
echo    Release  (do not include /p:Configuration, just use Debug or Release)
echo.
pause
echo.
echo Platform
echo.
echo.   x86      - compiles your assembly to be run by the 32-bit, x86-compatible
echo.              common language runtime.
echo.   x64      - compiles your assembly to be run by the 64-bit common language
echo.              runtime on a computer that supports the AMD64 or EM64T
echo.              instruction set.
echo.   "any cpu" -(default) compiles your assembly to run on any platform.
echo.
echo.   On a 64-bit Windows operating system:
echo.
echo.     Assemblies compiled with /platform:x86 will execute on the 32 bit CLR
echo      running under WOW64.
echo.
echo.     Executables compiled with the /platform:anycpu will execute on the
echo.     64 bit CLR.
echo.
echo.     DLLs compiled with the /platform:anycpu will execute on the same CLR
echo.     as the process into which it is being loaded.
echo.
goto end

:execute
%_@v% %1 /t:%2 /p:Configuration=%3
goto excuted_log

:execute_platform
%_@v% %1 /t:%2 /p:Configuration=%3 /p:Platform=%4
goto excuted_log

:excuted_log
echo.
echo Executed %_@v% %1 /t:%2 /p:Configuration=%3 /p:Platform=%4
echo.
:end
