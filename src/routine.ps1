# テンプレートファイルのパスを設定
$TemplatePath = "C:\work\samplePowerShell_Beginner\src\_template"
# ファイル名に入れるyyyyMMddを設定
$TodayYYYYMMDD = Get-Date -Format "yyyyMMdd"

# テンプレートのフォルダを、配下含めてコピーして日付フォルダを作成
Copy-Item -Path $TemplatePath -Destination "C:\work\samplePowerShell_Beginner\src\$TodayYYYYMMDD" -Recurse -Force

# コピーしたフォルダに移動
Set-Location $TodayYYYYMMDD

# メモのファイル名を日付ファイルに変更
Rename-Item -Path "memo_yyyyMMdd.txt" -NewName "memo_$TodayYYYYMMDD.txt"

# メモ帳でメモファイルを開く
Start-Process notepad "memo_$TodayYYYYMMDD.txt"
