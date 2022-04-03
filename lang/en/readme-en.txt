Flow Source Code Build Tool Manual 0.1

Usage:flow [language] <option flag> [one to multiple file(s)]

Language:
  c     C language.
  cpp   C++ language.
  efi   EFI sourcecode in C format, and test using QEMU.

  You can also use the temple below to create a option by yourself.

Language option temple:
else if "%func%"=="c" (

    set Exec=%~n2.exe              #Execute command
    set Comp=gcc -o !Exec! %files% #Compile command

)

Option flag:
  -mstdin Input <file> as content of stdin when execute.

One to multiple file(s):
  The source code you want compile (or execute).

  You can use full or relatively path to specific the file.

  Generated executable will use first source code file's file name as itself's name,
  for example: "flow c monika.c yuri.c sayori.c natsuki.c" will generate a
  executable file names "monika.exe" when compile is success.