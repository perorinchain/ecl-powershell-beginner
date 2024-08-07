# PowerShellを触ってみよう！

PowerShellをちょっと触れるようになるのが目的です！

※以下はWindows 10環境で試していますが、他の環境で動かなかったらすみません。
※ディレクトリ＝フォルダと思ってOKです。

## 準備：PowerShellを開いてみよう！

Windowsでコマンドレットを実行するには、PowerShellを使います。PowerShellは、たとえば以下の方法で開けます。

- スタートメニューの検索のところで「PowerShell」と打って出てくる「Windows PowerShell」をクリックして開く
- `Windowsキー+R` で「ファイル名を指定して実行」を開いて、「powershell」と入力してEnter or [OK]

※開くときに「管理者として実行」というオプションがあったりしますが、今回は特に使わなくて大丈夫です。管理者の実行権限が必要な場合に使う機能です。<br>
※PowerShellを始めて使う場合、権限で怒られる可能性があります。この場合には「ExecutionPolicy」というのをググってみてください。 [`Set-ExecutionPolicy` で適切な権限に設定する](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.4)と、PowerShellを実行できるようになります。

## おためし１：よく使うコマンドレットを使ってみよう！
### Get-Help
`Get-Help [cmdlet]` でコマンドレットの詳細を表示します。（ローカルでダメそうだったら ` -Online` オプションを付けてMicrosoftの公式ページを開くのが良さそう）
コマンドレットを使うときは、ぜひ `Get-Help [cmdlet]` でコマンドレットの詳細を確認してみましょう！いろいろ書いてます。

### Get-Command
コマンドレットの一覧を表示します。

### Set-Location (cd)
カレントディレクトリ（PowerShell上で今いるフォルダ）を移動します。こんな感じで、パスが変わることが分かります。
```
PS C:> Set-Location C:\work

PS C:\work>
```

### Write-Output (echo)、Write-Host
`Write-Output` の後に書いた文字列を表示します。スクリプトだと、ログを出したりしたいときに使います。
```
PS C:\work> Write-Output "表示したい文字列"
表示したい文字列
PS C:\work> Write-Host "表示したい文字列"
表示したい文字列
```
※Write-OutputとWrite-Hostの違いは調べてみてください！

### Get-Date
日時を取得します。
```
PS C:\work> Get-Date

2024年4月18日 17:48:51
```

### Get-NetIPAddress (ipconfig)
IPアドレスとかのネットワーク情報を調べたいときに使います。詳細情報を出す `-All` を付けた `Get-NetIPAddress -All` をよく使います。

### Get-ChildItem (dir)
フォルダ配下のファイルやフォルダを表示します。
```
PS C:\work> Get-ChildItem


    ディレクトリ: C:\work


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        2024/04/13     20:15                sampleBat_Beginner
d-----        2024/04/17     19:09                samplePowerShell_Beginner

```

### New-Item (mkdir)
ファイルやフォルダなどを作成します。
C:\workに居る状態でtestfile1.txtファイルを作成するとこんな感じです。testfile1.txtの中身は「This is a text string.」と書かれます。

```
PS C:\work> New-Item -Path . -Name "testfile1.txt" -ItemType "file" -Value "This is a text string."


    ディレクトリ: C:\work


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        2024/04/18     17:56             22 testfile1.txt


PS C:\work> Get-ChildItem


    ディレクトリ: C:\work


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        2024/04/13     20:15                sampleBat_Beginner
d-----        2024/04/17     19:09                samplePowerShell_Beginner
-a----        2024/04/18     17:56             22 testfile1.txt

```

### Select-String (find, findstr)
ファイルから文字列を検索します。

```
PS C:\work> Get-Content test.txt | Select-String -Pattern "test"

testmojiretsu
```
↑のように、「|」（パイプ）を使うと、「|」の前に使ったコマンドレットの結果を「|」の後のコマンドレットに渡せます。

### Get-Variable
定義された変数の一覧が表示されます。
自前の変数を定義するときは、以下のように「$」を頭につけた変数名に「=」で値を代入します。
```
PS C:\work> $a = "teststring"
PS C:\work> Get-Variable -Name a

Name                           Value
----                           -----
a                              teststring
```

### Copy-Item
ファイルやフォルダをコピーします。
```
PS C:\work> Copy-Item -Path test.txt -Destination test2.txt
```

### Start-Process (start)
プロセスを開始します。たとえば、以下でメモ帳を開きます。
```
PS C:\work> Start-Process "notepad"
```

### Exit
PowerShellを終了します。



## おためし２：簡単なPowerShellスクリプトを作成してみよう！
拡張子は「ps1」です。
ps1ファイルは、基本はPowerShellコンソールにパスを入れて実行ですが、ダブルクリックで実行する方法もあります。powershellコマンドでps1ファイルを呼び出すバッチファイルを作る、というのもよくやる手です。

### お題①：
以下の動きをするPowerShellスクリプトを作成してみましょう！
1. テンプレートのフォルダをコピペして日付名フォルダを作成する（コピー元のテンプレートフォルダを作成してから、日付を取得して、テンプレートフォルダをコピペして日付名にする）
2. コピーしたテンプレート内にあるテキストファイル名にも日付を付ける（テンプレートフォルダ配下にあるテキストファイルの名前を変更する）
3. ファイル名に日付を入れたテキストファイルをメモ帳で開く（2のテキストファイル名を引数にメモ帳のプロセスを開く）

### お題②：
以下の動きをするPowerShellスクリプトを作成してみましょう！（その２）
1. 引数で渡したパスのリストファイルを読み込む
2. 読み込んだリストファイルに書かれたファイル名のファイルに文字列を追加する


## おためし３：作ったPowerShellスクリプトをカスタマイズしてみよう！
おためし２で作ったPowerShellスクリプトの不便なところを改善したり、機能を追加したり改造してみましょう！

ここに出てこなかったコマンドレットやオプションもぜひ試してみてください！作り方もググると結構出てきます！

