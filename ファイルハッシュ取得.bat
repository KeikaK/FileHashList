echo off

rem ���͒l�i�Ώۃf�B���N�g���p�X�j���擾
SET /P strInputDir="�Ώۃf�B���N�g������͂��Ă�������: "
SET strInputDir="%strInputDir%"

rem ���ݎ������擾
SET time_tmp=%time: =0%
SET now=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%

rem �t�@�C������g�ݗ���
SET strDP=%~dp0
SET strFP="%strDP%���s����%now%.txt"

rem �J�n���b�Z�[�W���o��
echo ���s���܂�
echo �Ώۃf�B���N�g���F%strInputDir%
echo �o�̓t�@�C���F%strFP%
pause

rem �w�b�_��������o��
echo �t���p�X	�f�B���N�g��	�t�@�C����	�g���q	�n�b�V���l> %strFP%

rem �J�����g�f�B���N�g����ݒ�
cd %strInputDir%

rem �B���t�@�C�����Ώۂɂ��邽��dir�R�}���h��for�����Ŏg�p
rem �t�@�C�����ƃn�b�V���l���o��
for /f "delims=" %%i in ('dir /b/s/a-d') do (
    if %%~zi equ 0 (
        rem �t�@�C����0�o�C�g�̏ꍇ�n�b�V���l�͌Œ�ŏo��
        echo %%k	%%~dpk	%%~nxk	%%~xk	d41d8cd98f00b204e9800998ecf8427e>> %strFP%
    ) else (
        rem �t�@�C����0�o�C�g�ȊO�̏ꍇ�n�b�V���l���擾
        for /F "skip=1 tokens=*" %%j in ('certutil -hashfile "%%i" MD5 ^| findstr /v [C]ertUtil') do (
            echo %%i	%%~dpi	%%~nxi	%%~xi	%%j>> %strFP%
        )
    )
)

echo �I�����܂���
pause