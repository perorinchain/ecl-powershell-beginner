# ���̃X�N���v�g�̃t�H���_�p�X���擾
$ThisScriptDirPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# ���X�g�t�@�C���̃p�X�������Ŏ擾
$ListPath = $args[0]

# �e�L�X�g�t�@�C���ɒǉ����镶������w��
$StringToAdd = "�ǉ�������"

# ���ϐ��̒l���m�F
Write-Host $ThisScriptDirPath
Write-Host $ListPath
Write-Host $StringToAdd
# ���[�U�[�̓��͂�҂�
Read-Host "Press Enter to continue..."

# ���X�g�t�@�C�������݂��Ȃ���΃X�N���v�g���I��
if (-Not (Test-Path $ListPath)) {
    exit
}

# ���X�g�t�@�C�����̊e�s��ǂݍ��݁A���������s
Get-Content -Path $ListPath | ForEach-Object {
    $currentLine = $_
    
    # ���݂̍s�̒l���m�F
    Write-Host $currentLine
    # ���[�U�[�̓��͂�҂�
    Read-Host "Press Enter to continue..."
    
    # ���ϐ��̒l���ēx�m�F
    Write-Host $ThisScriptDirPath
    Write-Host $ListPath
    Write-Host $StringToAdd
    # ���[�U�[�̓��͂�҂�
    Read-Host "Press Enter to continue..."
    
    # ���X�g�t�@�C���ɂ���t�@�C�����̃t�@�C���Ɏw�肵���������ǋL
    $filePath = Join-Path -Path $ThisScriptDirPath -ChildPath "$currentLine.txt"
    Add-Content -Path $filePath -Value $StringToAdd
}

