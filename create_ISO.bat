@echo off
REM Ensure the script runs as administrator
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo This script requires administrative privileges.
    echo Please run it as an administrator.
    pause
    exit /b
)

REM List available drives using WSL lsblk
echo Listing drives using WSL...
wsl lsblk
echo.

REM Prompt user to select the WSL device name
set /p Drive_Letter=Select the WSL device name (e.g., /dev/sdb) from which you want to create an ISO file: 
if "%Drive_Letter%"=="" (
    echo No device selected. Exiting.
    pause
    exit /b
)

REM Use PowerShell to prompt for a folder selection
echo Opening folder selection dialog...
for /f "delims=" %%F in ('powershell -NoProfile -Command ^
    "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.FolderBrowserDialog; $f.ShowDialog() | Out-Null; $f.SelectedPath"') do set OutputFolder=%%F

if "%OutputFolder%"=="" (
    echo No folder selected. Exiting.
    pause
    exit /b
)

REM Confirm operation
echo You selected device: %Drive_Letter%
echo ISO file will be saved in: %OutputFolder%
set /p Confirm=Type "YES" to confirm and proceed: 
if /i not "%Confirm%"=="YES" (
    echo Operation canceled.
    pause
    exit /b
)

REM Create ISO file using dd in WSL
echo Creating ISO file from %Drive_Letter%...
wsl sudo dd if=/dev/%Drive_Letter% of=~/linux_usb_backup.iso bs=4M status=progress

REM Copy the ISO file to the selected folder
echo Copying ISO file to the selected folder...
wsl cp ~/linux_usb_backup.iso "$(wslpath -a '%OutputFolder%')/linux_usb_backup.iso"

echo Operation complete. ISO file saved in %OutputFolder%\linux_usb_backup.iso
pause
