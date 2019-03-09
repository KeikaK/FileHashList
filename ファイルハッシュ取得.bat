echo off

SET /P strInputDir="対象ディレクトリを入力してください: "
SET strInputDir="%strInputDir%"

SET time_tmp=%time: =0%
SET now=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
echo %now%

SET strDP=%~dp0
SET strFN=ハッシュ
SET strT=.txt
SET strFP="%strDP%%strFN%%now%%strT%"

echo 実行します
echo 対象ディレクトリ：%strInputDir%
echo 出力ファイル：%strFP%
pause

echo フルパス	ディレクトリ	ファイル名	拡張子	ハッシュ値> %strFP%

cd %strInputDir%

for /f "delims=" %%i in ('dir /b/s/a-d') do for /F "skip=1 tokens=*" %%j in (
'certutil -hashfile "%%i" MD5 ^| findstr /v [C]ertUtil'
) do echo %%i	%%~dpi	%%~nxi	%%~xi	%%j>> %strFP%

Rem 上のループでは0バイトのファイルが処理できないためこのfor文で0バイトのファイルのみ取得
for /f "delims=" %%k in ('dir /b/s/a-d') do if %%~zk equ 0 echo %%k	%%~dpk	%%~nxk	%%~xk	d41d8cd98f00b204e9800998ecf8427e>> %strFP%

echo 終了しました

pause