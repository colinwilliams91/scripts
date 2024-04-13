@echo off

:: BatchGotAdmin
:: -------------------------------------
:: --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "C:\Program Files (x86)\path\to\file.exe", "", "", "runas", 1 >> "%temp%\getadmin.vbs" & :: 1. Replace <\path\to\file.exe> with any *.exe

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:: --------------------------------------
:: 2. Save this file as Your_File_Shortcut.bat
:: 3. Double click Your_File_Shortcut.bat to open the *.exe you plugged in as Admin