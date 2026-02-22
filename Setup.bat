@echo off
REM SetupScript Juergen Riegel 
echo  [32mSetup the build environment.[0m


echo  [94mSearch for VCPKG:[0m

IF NOT EXIST "%~dp0vcpkg\vcpkg.exe" (
    ECHO [91mERROR: vcpkg.exe was not found in the vcpkg subfolder![0m
    ECHO Please run bootstrap-vcpkg.bat in the vcpkg subfolder first.
    ECHO Command: vcpkg\bootstrap-vcpkg.bat
    pause
    exit 1
)
SET VCPKG_DIR=%~dp0vcpkg\
echo Using VCPKG in %VCPKG_DIR%

echo  [94mSearch for cMake:[0m
WHERE cmake
IF %ERRORLEVEL% NEQ 0 (
    ECHO [91mERROR: cmake.exe whas not found in path! Download and install CMAKE first! [0m
    ECHO See: https://cmake.org/ on details for you system.
    pause
    exit 1
)
   
  
echo  [94mCheck for compiler version:[0m
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community" (
  SET GENERATOR_STRING="Visual Studio 17 2022"
) else if exist "C:\Program Files\Microsoft Visual Studio\2022\Professional" (
  SET GENERATOR_STRING="Visual Studio 17 2022"
) else if exist "C:\Program Files\Microsoft Visual Studio\2019\Community" (
  SET GENERATOR_STRING="Visual Studio 16 2019"
) else if exist "C:\Program Files\Microsoft Visual Studio\2019\Professional" (
  SET GENERATOR_STRING="Visual Studio 16 2019"
) else (
  ECHO [91mERROR: compiler whas not found ! [0m
  pause
  exit 1
)
echo Using cMake generator: %GENERATOR_STRING%

cmake.exe -G %GENERATOR_STRING% -B WinBuild -S . -A x64 -DCMAKE_TOOLCHAIN_FILE=%VCPKG_DIR%scripts\buildsystems\vcpkg.cmake -DVCPKG_TARGET_TRIPLET=x64-windows


