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

### Get-FileHash
ファイルのハッシュ値を計算できます。ダウンロードしたファイルの整合性チェックに使ったりします。`-Algorithm MD5`部分はハッシュ計算のアルゴリズムを指定しています（他も使える）。
```
PS C:\work> Get-FileHash C:\work\test.txt -Algorithm MD5

Algorithm       Hash                                                                   Path
---------       ----                                                                   ----
MD5             8744320A5722F94517C2F87699A9AEB1                                       C:\work\test.txt
```

### アプリ起動
「.exe」ファイルをPowerShellコンソールから実行できます。たとえば、Windows Media Playerで動画を全画面再生してみましょう。
```
PS C:\work> & "C:\Program Files (x86)\Windows Media Player\wmplayer.exe" /fullscreen "C:\work\180283-863760534_small.mp4"
```
※ファイルパスに空白が含まれる場合は、パスを「"」で囲む必要があります。<br>
※[「&」は呼び出し演算子](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.4#call-operator-)と呼ばれるものです。直後の`"C:\Program Files (x86)\Windows Media Player\wmplayer.exe"`を文字列としてではなく、コマンドとして解釈させるためにつけています。<br>
※`/fullscreen`は、起動時にフルスクリーンにする[オプション](https://learn.microsoft.com/ja-jp/previous-versions/windows/desktop/wmp/command-line-parameters)です。

### Exit
PowerShellを終了します。

### 補足：powershellコマンド
`powershell`コマンドを使うと、PowerShellスクリプト（「.ps1」ファイル）をコマンドプロンプトから起動できます。
```
C:\work>powershell C:\work\testEcho.ps1
test ps1 file
```
「.bat」ファイルはデフォルトでダブルクリックすると実行できるのですが、「.ps1」ファイルはデフォルトではダブルクリックで実行できません。
`powershell`コマンドを使うと何がうれしいかと言うと、「.bat」ファイル内で`powershell`コマンドを使って「.ps1」ファイルを呼び出すようにしておけば、実質的に「.ps1」ファイルを（「.bat」ファイルの）ダブルクリックで実行できることです。

※これだけ、PowerShellのコマンドレットではなくWindowsバッチのコマンドの話です。


## おためし２：はじめての「.ps1」ファイル

### echoするだけの「.ps1」ファイルを作ってみる：
拡張子は「ps1」です。以下の手順でPowerShellの実行ファイルを作ってみましょう！
1. テキストファイルを新規作成して、ファイル名を「XXXXX.ps1」（「XXXXX」のところは何でも良い）にする
2. 「XXXXX.ps1」を右クリックして「編集」をクリック（これでPowerShellの編集画面が開く）
3. 「XXXXX.ps1」に「echo "test ps1 file"」と書きこんで保存してファイルを閉じる（「×」で閉じてOK）
4. PowerShellのコンソールを開いて、以下のようにファイルを実行してみる
```
PS C:\work> C:\work\testEcho.ps1
test ps1 file
```


## おためし３：簡単なPowerShellスクリプトを作成してみよう！
ps1ファイルは、基本はPowerShellコンソールにパスを入れて実行ですが、ダブルクリックで実行する方法もあります。powershellコマンドでps1ファイルを呼び出すバッチファイルを作る、というのもよくやる手です。

### お題①：
以下の動きをするPowerShellスクリプトを作成してみましょう！
1. テンプレートのフォルダをコピペして日付名フォルダを作成する<br>
  ヒント：<br>
    1. コピー元のテンプレートフォルダを作成してから、
    2. 日付を取得して（日付のフォーマットにも注意）、
    3. テンプレートフォルダをコピペして日付名にする
2. コピーしたテンプレート内にあるテキストファイル名にも日付を付ける<br>
  ヒント：<br>
    1. テンプレートフォルダ配下にあるテキストファイルのパスを名前を把握して、
    2. ファイル名を変更する
3. ファイル名に日付を入れたテキストファイルをメモ帳で開く<br>
  ヒント：<br>
    1. 2のテキストファイル名を引数で指定して、
    2. メモ帳のプロセスを開く

### お題②：
以下の動きをするPowerShellスクリプトを作成してみましょう！（その２）
1. 引数で渡したパスのリストファイルを読み込む
2. 読み込んだリストファイルに書かれたファイル名のファイルに文字列を追加する

ヒント：
 - 引数を取得する必要があります
 - ファイル読み込みの方法を調べる必要があります
 - 読み込んだファイルの内容を使う方法が必要です
 - リストファイルに書かれたファイル名分、ループ処理が必要です
 - ファイルに文字列を書き込む方法を調べる必要があります


## おためし４：作ったPowerShellスクリプトをカスタマイズしてみよう！
おためし２で作ったPowerShellスクリプトの不便なところを改善したり、機能を追加したり改造してみましょう！

ここに出てこなかったコマンドレットやオプションもぜひ試してみてください！作り方もググると結構出てきます！


## おためし５：スクリプトを自作してみよう！
こういう作業が自動化できるといいな、というアイデアを出してみて、実際にスクリプトを自作してみましょう！
これまで出てきた内容を応用してみたり、こういうのできないかな？と検索してみたり、ぜひ挑戦してみてください。

もちろん、生成AIに聞いてみるのもアリです！やり込んでみると深い設定もできたりするので、いろいろと試してみると勉強になります。
新しいコマンドレットを使うときは、ぜひヘルプも見てみるのもオススメです！
