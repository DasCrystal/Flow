Flow ��l�X�իؤu�㻡�� 0.1

�Ϊk�Gflow [�{���y��] <�ﶵ�X�l> [�@��h���ɮ�]

�{���y���G
  c		C�y���C
  cpp		C++�y���C
  efi		�HC�y���s�g�å�QEMU���ժ�efi��l�X�C

  �z�]�i�H�̷ӤU�誺�ҪO�ۦ�W�[�i�諸�{���y���C

�y���ﶵ�ҪO�G
else if "%func%"=="c" (

    set Exec=%~n2.exe              #������O
    set Comp=gcc -o !Exec! %files% #�sĶ���O

)

�ﶵ�X�l�G
  -mstdin <file> �b����ɱN<file>�@��stdin�����e��J�C

�@��h���ɮסG
  �A�n�sĶ����l�X�ɮסC�i�ǤJ���|�Υثe��Ƨ��U���ɮת��W�١C
  �sĶ�Უ�ͪ��i�����ɷ|�ϥβĤ@���ɮת��ɦW�@���ۤv���ɮצW�١A�Ҧp�G
  "flow c frank.c zerotwo.c hiro.c" �|���ͤ@�ӦW�� frank.exe ���i�����ɡC