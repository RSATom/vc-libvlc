@echo off
for %%i in ("%~0") do set THIS_BAT_PATH=%%~dpi

for %%i in (libvlc.dll) do set LIBVLC_DLL="%%~$PATH:i"

if not exist %LIBVLC_DLL% (
  echo libvlc.dll not found in PATH
  exit /b 1
) else (
  echo Found %LIBVLC_DLL%.
)

set LIBVLC_DUMP_FILE="%THIS_BAT_PATH%libvlc.dump"
set LIBVLCCORE_DUMP_FILE="%THIS_BAT_PATH%libvlccore.dump"

dumpbin /exports /out:%LIBVLC_DUMP_FILE% %LIBVLC_DLL%
dumpbin /exports /out:%LIBVLCCORE_DUMP_FILE% %LIBVLC_DLL%\..\libvlccore.dll
