@ECHO off

IF "%1"=="B" GOTO background

COPY /Y upgrade\upgrade.bat . > NUL
COPY /Y upgrade\do_upgrade.ps1 . > NUL
COPY /Y upgrade\wazuh-agent-*.msi . > NUL
COPY /Y upgrade\do_upgrade.bat . > NUL

START /B upgrade.bat B 2> NUL
GOTO end

:background
SLEEP 5 2> NUL || ping -n 5 127.0.0.1 > NUL
FOR %%x IN (powershell.exe) DO IF NOT [%%~$PATH:x]==[] (
    powershell -ExecutionPolicy ByPass -File do_upgrade.ps1
) else (
    CMD /C do_upgrade.bat
)

DEL do_upgrade.bat
DEL do_upgrade.ps1
DEL wazuh-agent-*.msi
DEL upgrade.bat

:end
