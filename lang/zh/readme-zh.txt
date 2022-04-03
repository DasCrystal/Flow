Flow 原始碼組建工具說明 0.1

用法：flow [程式語言] <選項旗子> [一到多個檔案]

程式語言：
  c		C語言。
  cpp		C++語言。
  efi		以C語言編寫並用QEMU測試的efi原始碼。

  您也可以依照下方的模板自行增加可選的程式語言。

語言選項模板：
else if "%func%"=="c" (

    set Exec=%~n2.exe              #執行指令
    set Comp=gcc -o !Exec! %files% #編譯指令

)

選項旗子：
  -mstdin <file> 在執行時將<file>作為stdin的內容輸入。

一到多個檔案：
  你要編譯的原始碼檔案。可傳入路徑或目前資料夾下的檔案的名稱。
  編譯後產生的可執行檔會使用第一個檔案的檔名作為自己的檔案名稱，例如：
  "flow c frank.c zerotwo.c hiro.c" 會產生一個名為 frank.exe 的可執行檔。