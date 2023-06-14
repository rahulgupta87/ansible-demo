@echo off

REM Output filename with hostname
set "outputFile=Report_%COMPUTERNAME%.txt"

REM System Information
echo ***** System Information ***** > %outputFile%
echo Hostname: %COMPUTERNAME% >> %outputFile%
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" >> %outputFile%

REM CPU Information
echo. >> %outputFile%
echo ***** CPU Information ***** >> %outputFile%
wmic cpu get Name | findstr /v Name >> %outputFile%
wmic cpu get NumberOfCores | findstr /v NumberOfCores >> %outputFile%

REM Memory Information
echo. >> %outputFile%
echo ***** Memory Information ***** >> %outputFile%
wmic memorychip get Capacity | findstr /v Capacity | (
    set /P totalMemory=
    echo Total Memory: %totalMemory:~0,-9% GB
) >> %outputFile%

REM Disk Usage
echo. >> %outputFile%
echo ***** Disk Usage ***** >> %outputFile%
wmic logicaldisk where DriveType=3 get DeviceID,Size,FreeSpace | findstr /v "DeviceID Size" | (
    setlocal enabledelayedexpansion
    for /F "tokens=*" %%A in ('findstr /R "^"') do (
        set "line=%%A"
        set "drive=!line:~0,2!"
        set "size=!line:~3,18!"
        set "freeSpace=!line:~22,18!"
        echo Drive !drive! - Total Size: !size! Bytes, Free Space: !freeSpace! Bytes
    )
    endlocal
) >> %outputFile%

REM Network Information
echo. >> %outputFile%
echo ***** Network Information ***** >> %outputFile%
ipconfig | findstr /C:"Ethernet adapter" /C:"IPv4 Address" >> %outputFile%
