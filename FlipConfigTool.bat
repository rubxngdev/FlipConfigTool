@echo off
cd /d "%~dp0"
setlocal

color F0
title FLIP CONFIGURATION TOOL @ rubxngdev

:START
cls
echo                FLIP CONFIGURATION TOOL
echo                          @ rubxngdev
echo                     github.com/rubxngdev
echo.
echo Run this script after installing your games.
echo.
echo [1] Continue
echo [0] Exit
echo.
choice /c 10 /n /m "Select an option: "
if errorlevel 2 goto EXIT
if errorlevel 1 goto SETAPPLICATIONPATH

:SETAPPLICATIONPATH
cls
echo                SELECT APPLICATION
echo.
echo Select the main executable (.exe) of the game.
echo.
set "application="
for /f "delims=" %%I in ('powershell -noprofile -command "Add-Type -AssemblyName System.Windows.Forms; $f=New-Object Windows.Forms.OpenFileDialog; $f.Filter='Executable (*.exe)|*.exe'; $f.ShowDialog()|Out-Null; $f.FileName"') do set "application=%%I"
if not defined application goto START
for %%A in ("%application%") do if /i "%%~xA"==".exe" goto MENU
goto INVALID

:INVALID
cls
echo ERROR!
echo.
echo The selected file is not a valid .exe executable.
echo.
echo Please select the game executable again...
timeout /t 3 /nobreak > nul
goto SETAPPLICATIONPATH

:MENU
cls
echo                FLIP CONFIGURATION
echo.
echo Selected application:
echo.
echo %application%
echo.
echo ============================================================
echo.
echo Select the configuration you want to apply:
echo.
echo [1] INDEPENDENT FLIP
echo     Use Fullscreen Optimizations (FSO).
echo.
echo [2] LEGACY FLIP
echo     Disable Fullscreen Optimizations (DFSO).
echo.
echo [3] SELECT ANOTHER GAME
echo [0] EXIT
echo.
choice /c 1230 /n /m "Select an option: "
if errorlevel 4 goto EXIT
if errorlevel 3 goto SETAPPLICATIONPATH
if errorlevel 2 goto FSE
if errorlevel 1 goto FSO

:FSO
cls
echo                  INDEPENDENT FLIP (FSO)
echo.
echo Independent Flip has been selected.
echo.
echo Fullscreen Optimizations will be restored for:
echo.
echo %application%
echo.
reg query "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%application%" >nul 2>&1
if errorlevel 1 (
    echo.
    echo Default configuration is already active.
) else (
    reg delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%application%" /f >nul 2>&1
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to modify the Windows Registry.
    ) else (
        echo.
        echo Independent Flip configuration restored successfully.
    )
)
echo.
echo Please fully restart the game for the changes to take effect.
echo.
pause
goto MENU

:FSE
cls
echo                    LEGACY FLIP (FSE)
echo.
echo Legacy Flip has been selected.
echo.
echo Fullscreen Optimizations will be disabled for:
echo.
echo %application%
echo.
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%application%" /t REG_SZ /d "~ DISABLEDXMAXIMIZEDWINDOWEDMODE" /f >nul 2>&1
if errorlevel 1 (
    echo.
    echo ERROR: Failed to modify the Windows Registry.
    echo.
    pause
    goto MENU
)
echo.
echo Legacy Flip configuration applied successfully.
echo.
echo Please fully restart the game for the changes to take effect.
echo.
pause
goto MENU

:EXIT
cls
echo.
echo You can run this tool again at any time
echo to configure another game.
echo.
echo                 github.com/rubxngdev
echo.
pause
endlocal
exit /b