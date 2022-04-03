::flow
@echo off

setlocal enableextensions
setlocal enabledelayedexpansion

if "%1"=="init" (goto init)

if exist %~dp0\config.cmd (

    call %~dp0\config.cmd

) else (

    echo [ERRO] Can't found config.cmd
    echo [FIX]  Copy and rename config-example.cmd to create a new one.

    goto:eof
)

if exist %~dp0\lang\%lang%\strings-%lang%.cmd (

    call %~dp0\lang\%lang%\strings-%lang%.cmd

) else (

    echo [ERRO] Cant' found lang\%lang%\strings-%lang%.cmd
    echo [Fix]  Perhaps you need redownload the source code. 
    goto:eof
)

if "%1"==""     (goto help)
if "%1"=="help" (goto help)

:ReadArg
if "%2"=="-mstdin" (

    if exist "%3" (

        set flag.mstdin=%3
        shift /2

    ) else (

        echo %string.CantFound% %3
        goto:eof

    )

    shift /2
    goto ReadArg
)

cd /d %~dp2

set func=%1
set files=%2 %3 %4 %5 %6 %7 %8 %9

::if "%func%"=="c" (
::
::    set Exec=%~n2.exe              
::    set Comp=gcc -o !Exec! %files%
::
::)

if "%func%"=="c" (

    set Exec=%~n2.exe
    set Comp=gcc -o !Exec! %files%

) else if "%func%"=="cpp" (

    set Exec=%~nx2.exe
    set Comp=g++ -o !Exec! %files%

) else if "%func%"=="efi" (

    set Exec= %QemuPath% ^
                -m 5120 ^
                -smp 1 ^
                -bios %UefiFirmware% ^
                -global e1000.romfile="" ^
                -machine q35 ^
                -hda fat:rw:%DiskFolder% ^
                --net none

    set Comp=gcc -isystem D:\_AirProject\tool\MinGW-w64-IncludeEfiLib\Include -Wall -Wextra -e UefiMain -nostdinc -nostdlib ^
                    -fno-builtin -Wl,--subsystem,10 -o %~n2.efi %files% ^
                    ^&^& del "%DiskFolder%\EFI\boot\bootx64.efi" ^&^& copy %~n2.efi "%DiskFolder%\EFI\boot\bootx64.efi"

) else (

    echo [ERRO] %string.InvaildLanguage%
    echo [FIX]  %string.FixInvaildLanguage%
    goto:eof
)

::-------
%Comp%
::-------

if "%errorlevel%"=="0" (

    echo -^|%string.Execute% %Exec%^|-
    
    if not "%flag.mstdin%"=="" (

        echo %string.Input%:
        type "%flag.mstdin%" & echo=
        echo --------
        echo %string.OutPut%:
        %Exec% < "%flag.mstdin%"

    ) else (

        %Exec%

    )

    echo -^|%string.ExecuteEnded%[!errorlevel!]^|-

)

:flow.end
set ExecName=& set command=& set Exec=
set flag.mstdin=
set timeoout=0& goto:eof


::------
:help

echo=

if exist %~dp0\lang\%lang%\readme-%lang%.txt (

    type %~dp0\lang\%lang%\readme-%lang%.txt

) else (

    echo %string.CantFound% lang\%lang%\readme-%lang%.txt

)

echo=
echo=

goto:eof


:init

:InitStep0

choice /c CE /m "Choose Init Display Language:[Chinese/English]" /n

if "%errorlevel%"=="1" (

    set lang=zh

) else (

    set lang=en

)

if exist %~dp0\lang\%lang%\strings-%lang%.cmd (

    call %~dp0\lang\%lang%\strings-%lang%.cmd

) else (

    echo [ERRO] Cant' found lang\%lang%\strings-%lang%.cmd
    echo [Fix]  Perhaps you need redownload the source code. 
    goto:eof
)


:InitStep1
title %title.Step1%
echo=
choice /m "%string.Step1%"
if "%errorlevel%"=="1" (

    setx Path "%path%;%~dp0"

)

:InitStep2
title %title.Step2%
echo=
echo %string.Step2.1%
set editor=notepad
set /p editor=%String.Step2.2%
echo %string.Step2.3%
copy %~dp0\config-example.cmd %~dp0\config.cmd
%editor% config.cmd

:InitStep3
title %title.Step3%
echo=
echo %string.StepFinish.1%
echo %string.StepFinish.2%