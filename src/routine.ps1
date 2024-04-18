# �e���v���[�g�t�@�C���̃p�X��ݒ�
$TemplatePath = "C:\work\samplePowerShell_Beginner\src\_template"
# �t�@�C�����ɓ����yyyyMMdd��ݒ�
$TodayYYYYMMDD = Get-Date -Format "yyyyMMdd"

# �e���v���[�g�̃t�H���_���A�z���܂߂ăR�s�[���ē��t�t�H���_���쐬
Copy-Item -Path $TemplatePath -Destination "C:\work\samplePowerShell_Beginner\src\$TodayYYYYMMDD" -Recurse -Force

# �R�s�[�����t�H���_�Ɉړ�
Set-Location $TodayYYYYMMDD

# �����̃t�@�C��������t�t�@�C���ɕύX
Rename-Item -Path "memo_yyyyMMdd.txt" -NewName "memo_$TodayYYYYMMDD.txt"

# �������Ń����t�@�C�����J��
Start-Process notepad "memo_$TodayYYYYMMDD.txt"
