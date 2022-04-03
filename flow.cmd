::flow
@echo off

setlocal enableextensions
setlocal enabledelayedexpansion

if exist config.cmd (

    call config.cmd

) else (

    echo [ERRO] Can't founmd config.cmd
    echo [FIX]  Copy and rename config-example.cmd to create a new one.

    goto:eof
)

if exist lang\%lang%\strings-%lang%.cmd (

    call lang\%lang%\strings-%lang%.cmd

) else (

    echo [ERRO] Cant' found lang\%lang%\strings-%lang%.cmd
    echo [Fix]  Perhaps you need redownload the source code. 
    goto:eof
)

if "%1"=="" (goto help)
if "%1"=="help" (goto help)

:ReadArg
if "%2"=="-mstdin" (

    if exist "%3" (

        set flag.mstdin=%3
        shift /2

    ) else (

        echo %string.CantFound% %3¡C
        goto:eof

    )

    shift /2
    goto ReadArg
)

cd /d %~dp2

set func=%1
set files=%2 %3 %4 %5 %6 %7 %8 %9

::¼ÒªO
::if "%func%"=="c" (
::
::    set Exec=%~n2.exe              #°õ¦æ«ü¥O
::    set Comp=gcc -o !Exec! %files% #½sÄ¶«ü¥O
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

    if not "%flag.mstdin%"=="" (

        echo -^|%string.Input%^|-
        type "%flag.mstdin%" & echo=
        echo -^|%string.Execute% %Exec%^|-
        %Exec% < "%flag.mstdin%"

    ) else (

        echo -^|%string.Execute% %Exec%^|-
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

if exist lang\%lang%\readme-%lang%.txt (

    lang\%lang%\readme-%lang%.txt

) else (

    echo %string.CantFound% lang\%lang%\readme-%lang%.txt

)

echo=
echo=

goto:eof