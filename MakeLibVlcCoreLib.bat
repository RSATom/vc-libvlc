@echo off
for %%i in ("%~0") do set THIS_BAT_PATH=%%~dpi

if "%~1"=="" (
  set LIB_FILE="%THIS_BAT_PATH%libvlccore.lib"
) else (
  set LIB_FILE="%~1"
)

set DEF_FILE="%THIS_BAT_PATH%libvlccore.def"
lib /NOLOGO /def:%DEF_FILE% /out:%LIB_FILE% /machine:x86
