echo off

SET /P strInputDir="�Ώۃf�B���N�g������͂��Ă�������: "
SET strInputDir="%strInputDir%"

SET time_tmp=%time: =0%
SET now=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
echo %now%

SET strDP=%~dp0
SET strFN=�n�b�V��
SET strT=.txt
SET strFP="%strDP%%strFN%%now%%strT%"

echo ���s���܂�
echo �Ώۃf�B���N�g���F%strInputDir%
echo �o�̓t�@�C���F%strFP%
pause

echo �t���p�X	�f�B���N�g��	�t�@�C����	�g���q	�n�b�V���l> %strFP%

cd %strInputDir%

for /f "delims=" %%i in ('dir /b/s/a-d') do for /F "skip=1 tokens=*" %%j in (
'certutil -hashfile "%%i" MD5 ^| findstr /v [C]ertUtil'
) do echo %%i	%%~dpi	%%~nxi	%%~xi	%%j>> %strFP%

Rem ��̃��[�v�ł�0�o�C�g�̃t�@�C���������ł��Ȃ����߂���for����0�o�C�g�̃t�@�C���̂ݎ擾
for /f "delims=" %%k in ('dir /b/s/a-d') do if %%~zk equ 0 echo %%k	%%~dpk	%%~nxk	%%~xk	d41d8cd98f00b204e9800998ecf8427e>> %strFP%

echo �I�����܂���

pause