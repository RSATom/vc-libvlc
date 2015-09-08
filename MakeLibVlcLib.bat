@echo off
for %%i in ("%~0") do set THIS_BAT_PATH=%%~dpi
rem cd "%THIS_BAT_PATH%"
for %%i in (libvlc.dll) do set LIBVLC_DLL="%%~$PATH:i"

if not exist %LIBVLC_DLL% (
  echo libvlc.dll not found in PATH
  exit /b 1
) else (
  echo Found %LIBVLC_DLL%.
)

set DEF_FILE="%THIS_BAT_PATH%libvlc.def"
set DUMP_FILE="%THIS_BAT_PATH%libvlc.dump"

if "%~1"=="" (
  set LIB_FILE="%THIS_BAT_PATH%libvlc.lib"
  set X64_LIB_FILE="%THIS_BAT_PATH%libvlc.x64.lib"
) else (
  set LIB_FILE="%~1libvlc.lib"
  set X64_LIB_FILE="%~1libvlc.x64.lib"
)

echo EXPORTS > %DEF_FILE%

dumpbin /exports /out:%DUMP_FILE% %LIBVLC_DLL%

for /f "usebackq tokens=4,* delims=_ " %%i in (%DUMP_FILE%) do if %%i==libvlc echo %%i_%%j >> %DEF_FILE%
lib /NOLOGO /def:%DEF_FILE% /out:%LIB_FILE% /machine:x86
lib /NOLOGO /def:%DEF_FILE% /out:%X64_LIB_FILE% /machine:x64
del %DUMP_FILE% /f
del %DEF_FILE% /f
