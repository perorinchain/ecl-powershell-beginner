# このスクリプトのフォルダパスを取得
$ThisScriptDirPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# リストファイルのパスを引数で取得
$ListPath = $args[0]

# テキストファイルに追加する文字列を指定
$StringToAdd = "追加文字列"

# 環境変数の値を確認
Write-Host $ThisScriptDirPath
Write-Host $ListPath
Write-Host $StringToAdd
# ユーザーの入力を待つ
Read-Host "Press Enter to continue..."

# リストファイルが存在しなければスクリプトを終了
if (-Not (Test-Path $ListPath)) {
    exit
}

# リストファイル内の各行を読み込み、処理を実行
Get-Content -Path $ListPath | ForEach-Object {
    $currentLine = $_
    
    # 現在の行の値を確認
    Write-Host $currentLine
    # ユーザーの入力を待つ
    Read-Host "Press Enter to continue..."
    
    # 環境変数の値を再度確認
    Write-Host $ThisScriptDirPath
    Write-Host $ListPath
    Write-Host $StringToAdd
    # ユーザーの入力を待つ
    Read-Host "Press Enter to continue..."
    
    # リストファイルにあるファイル名のファイルに指定した文字列を追記
    $filePath = Join-Path -Path $ThisScriptDirPath -ChildPath "$currentLine.txt"
    Add-Content -Path $filePath -Value $StringToAdd
}

