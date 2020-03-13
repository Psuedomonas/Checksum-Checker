# Developer: Nicholas Zehm
# 3/11/2020
# My own checksum checker using powershell
# Interface and function inspired by Raymond Lin's MD5 and Sha Checksum Utility

$global:fileToCheck
$sumType
$md5
$sha1
$sha256
$sha512

$textboxComputerName_KeyDown = {}

## Make GUI
Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = 'Select File to Check'
$main_form.Width = 600
$main_form.Height = 400
$main_form.AutoSize = $true
$formGetService_Load = {
	$formGetService.AcceptButton = $buttonGetService ### Not working yet, supposed to be a custom function for enter press on textbox
}

$Lblfile = New-Object System.Windows.Forms.Label
$Lblfile.Text = "File:"
$Lblfile.Location = New-Object System.Drawing.Point(5,10)
$Lblfile.AutoSize = $true
$main_form.Controls.Add($Lblfile)

$Txtfile = New-Object System.Windows.Forms.TextBox
$Txtfile.Text = $fileToCheck
$Txtfile.Width = 400
$Txtfile.Location = New-Object System.Drawing.Point(80,10)
$Txtfile.AutoSize = $true
$main_form.Controls.Add($Txtfile)

$Btnfile = New-Object System.Windows.Forms.Button
$Btnfile.Text = 'Select File'
$Btnfile.Location = New-Object System.Drawing.Point(490,10)
$Btnfile.AutoSize = $true
$main_form.Controls.Add($Btnfile)

$Lblmd5 = New-Object System.Windows.Forms.Label
$Lblmd5.Text = "MD5:"
$Lblmd5.Location = New-Object System.Drawing.Point(5,30)
$Lblmd5.AutoSize = $true
$main_form.Controls.Add($Lblmd5)

$Txtmd5 = New-Object System.Windows.Forms.TextBox
$Txtmd5.Text = $md5
$Txtmd5.ReadOnly = $true
$Txtmd5.Width = 400
$Txtmd5.Location = New-Object System.Drawing.Point(80,30)
$Txtmd5.AutoSize = $true
$main_form.Controls.Add($Txtmd5)

$Lbl1 = New-Object System.Windows.Forms.Label
$Lbl1.Text = "Sha1:"
$Lbl1.Location = New-Object System.Drawing.Point(5,50)
$Lbl1.AutoSize = $true
$main_form.Controls.Add($Lbl1)

$Txt1 = New-Object System.Windows.Forms.TextBox
$Txt1.Text = $sha1
$Txt1.ReadOnly = $true
$Txt1.Width = 400
$Txt1.Location = New-Object System.Drawing.Point(80,50)
$Txt1.AutoSize = $true
$main_form.Controls.Add($Txt1)

$Lbl256 = New-Object System.Windows.Forms.Label
$Lbl256.Text = "Sha256:"
$Lbl256.Location  = New-Object System.Drawing.Point(5,70)
$Lbl256.AutoSize = $true
$main_form.Controls.Add($Lbl256)

$Txt256 = New-Object System.Windows.Forms.TextBox
$Txt256.Text = $sha256
$Txt256.ReadOnly = $true
$Txt256.Width = 400
$Txt256.Location = New-Object System.Drawing.Point(80,70)
$Txt256.AutoSize = $true
$main_form.Controls.Add($Txt256)

$Lbl512 = New-Object System.Windows.Forms.Label
$Lbl512.Text = "Sha512:"
$Lbl512.Location = New-Object System.Drawing.Point(5,90)
$Lbl512.AutoSize = $true
$main_form.Controls.Add($Lbl512)

$Txt512 = New-Object System.Windows.Forms.TextBox
$Txt512.Text = $sha512
$Txt512.ReadOnly = $true
$Txt512.Width = 400
$Txt512.Location = New-Object System.Drawing.Point(80,90)
$Txt512.AutoSize = $true
$main_form.Controls.Add($Txt512)

$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog

$Txtfile.Add_KeyDown(
{
    if ($_.KeyCode -eq "Enter") {
        if (Test-Path $Txtfile.Text) 
        {
            $global:fileToCheck = $Txtfile.Text
        }
        else
        {
            selectFile
        }
    }
}
)

function selectFile {
    [void] $OpenFileDialog.ShowDialog()
    if ($OpenFileDialog.CheckFileExists)
    {
        $global:fileToCheck = $OpenFileDialog.FileName
        $Txtfile.Text = $global:fileToCheck
        $sumType = 'MD5'
        $MD5Hash = Get-FileHash $global:fileToCheck -Algorithm $sumType | Select-Object Hash
        $Txtmd5.Text = $MD5Hash
        if ($FileHash.Hash -eq $publishedHash)
        {
        }
        $sumType = 'SHA1'
        $SHA1Hash = Get-FileHash $global:fileToCheck -Algorithm $sumType | Select-Object Hash
        $Txt1.Text = $SHA1Hash
        if ($FileHash.Hash -eq $publishedHash)
        {
        }
        $sumType = 'SHA256'
        $SHA256Hash = Get-FileHash $global:fileToCheck  | Select-Object Hash
        $Txt256.Text = $SHA256Hash
        if ($FileHash.Hash -eq $publishedHash)
        {
        }        
        $sumType = 'SHA512'
        $SHA512Hash = Get-FileHash $global:fileToCheck -Algorithm $sumType | Select-Object Hash
        $Txt512.Text = $SHA512Hash
        if ($FileHash.Hash -eq $publishedHash)
        {
        }

    }
}


$Btnfile.Add_Click(
{
    selectFile    
}
)

$main_form.ShowDialog()

