echo off

rem 入力値（対象ディレクトリパス）を取得
SET /P strInputDir="対象ディレクトリを入力してください: "
SET strInputDir="%strInputDir%"

rem 現在時刻を取得
SET time_tmp=%time: =0%
SET now=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%

rem ファイル名を組み立て
SET strDP=%~dp0
SET strFP="%strDP%実行結果%now%.txt"

rem 開始メッセージを出力
echo 実行します
echo 対象ディレクトリ：%strInputDir%
echo 出力ファイル：%strFP%
pause

rem ヘッダ文字列を出力
echo フルパス	ディレクトリ	ファイル名	拡張子	ハッシュ値> %strFP%

rem カレントディレクトリを設定
cd %strInputDir%

rem 隠しファイルも対象にするためdirコマンドをfor内部で使用
rem ファイル情報とハッシュ値を出力
for /f "delims=" %%i in ('dir /b/s/a-d') do (
    if %%~zi equ 0 (
        rem ファイルが0バイトの場合ハッシュ値は固定で出力
        echo %%k	%%~dpk	%%~nxk	%%~xk	d41d8cd98f00b204e9800998ecf8427e>> %strFP%
    ) else (
        rem ファイルが0バイト以外の場合ハッシュ値を取得
        for /F "skip=1 tokens=*" %%j in ('certutil -hashfile "%%i" MD5 ^| findstr /v [C]ertUtil') do (
            echo %%i	%%~dpi	%%~nxi	%%~xi	%%j>> %strFP%
        )
    )
)

echo 終了しました
pause