# Developer: Nicholas Zehm
# 3/11/2020
# My own checksum checker using powershell
# Interface and function inspired by Raymond Lin's MD5 and Sha Checksum Utility

# Load external assemblies
[void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][Reflection.Assembly]::LoadWithPartialName("System.Drawing")

$MS_main = new-object System.Windows.Forms.MenuStrip
$fileMenuItem = new-object System.Windows.Forms.ToolStripMenuItem
$exitMenuItem = new-object System.Windows.Forms.ToolStripMenuItem
$aboutMenuItem = new-object System.Windows.Forms.ToolStripMenuItem
$helpMenuItem = new-object System.Windows.Forms.ToolStripMenuItem
#
# MS_Main
#
$MS_Main.Items.AddRange(@($fileMenuItem, $helpMenuItem, $aboutMenuItem))
$MS_Main.Location = new-object System.Drawing.Point(0, 0)
$MS_Main.Name = "MS_Main"
$MS_Main.Size = new-object System.Drawing.Size(354, 24)
$MS_Main.TabIndex = 0
$MS_Main.Text = "main menu"
#
# File Menu object
#
$fileMenuItem.DropDownItems.AddRange(@($exitMenuItem))
$fileMenuItem.Name = "fileMenuItem"
$fileMenuItem.Size = new-object System.Drawing.Size(35, 20)
$fileMenuItem.Text = "&File"
#
# About menu strip item
#
$aboutMenuItem.Name = "aboutMenuItem"
$aboutMenuItem.Size = new-object System.Drawing.Size(152, 22)
$aboutMenuItem.Text = "&About"
function OnClick_aboutMenuItem($Sender,$e){
	[void][System.Windows.Forms.MessageBox]::Show(
		"Developer: Nicholas Zehm
Date: 3/11/2020
My own checksum checker using powershell
Interface and function inspired by Raymond Lin's MD5 and Sha Checksum Utility
Github: https://github.com/Psuedomonas/Checksum-Checker"
	)
}
	
$aboutMenuItem.Add_Click( { OnClick_aboutMenuItem $aboutMenuItem $EventArgs} )
#
# Help menu strip item
#
$helpMenuItem.Name = "helpMenuItem"
$helpMenuItem.Size = new-object System.Drawing.Size(152, 22)
$helpMenuItem.Text = "&Help"
function OnClick_helpMenuItem($Sender,$e){
	[void][System.Windows.Forms.MessageBox]::Show(
"1. Press 'Select File' to choose a file to process the checksum
2. Paste the checksum provided by the distributer in the checksum box
3. 'Verify' the checksum matches the provider's"
	)
}

$helpMenuItem.Add_Click( { OnClick_helpMenuItem $helpMenuItem $EventArgs} )
#
# Exit menu strip item
#
$exitMenuItem.Name = "exitMenuItem"
$exitMenuItem.Size = new-object System.Drawing.Size(152, 22)
$exitMenuItem.Text = "&Exit"
function OnClick_exitMenuItem($Sender,$e){
	$main_form.Close()
}

$exitMenuItem.Add_Click( { OnClick_exitMenuItem $exitMenuItem $EventArgs} )
#
# Make GUI (Windows Form)
#
Add-Type -assembly System.Windows.Forms
$main_form = new-object System.Windows.Forms.Form
$main_form.Controls.Add($MS_main)
$main_form.MainMenuStrip = $MS_main
$main_form.Text = 'Select File to Check'
$main_form.Width = 600
$main_form.Height = 300
$main_form.AutoSize = $true
$formGetService_Load = {
	$formGetService.AcceptButton = $buttonGetService ### Not working yet, supposed to be a custom function for enter press on textbox
}
function OnFormClosing_MenuForm($Sender,$e){ 
    # $this represent sender (object)
    # $_ represent  e (eventarg)

    # Allow closing
    ($_).Cancel= $False
}

## File
$Lblfile = new-object System.Windows.Forms.Label
$Lblfile.Text = "File:"
$Lblfile.Location = new-object System.Drawing.Point(5,30)
$Lblfile.AutoSize = $true
$main_form.Controls.Add($Lblfile)

$Txtfile = new-object System.Windows.Forms.TextBox
$Txtfile.Text = $fileToCheck
$Txtfile.Width = 400
$Txtfile.Location = new-object System.Drawing.Point(80,30)
$Txtfile.AutoSize = $true
$main_form.Controls.Add($Txtfile)

$Btnfile = new-object System.Windows.Forms.Button
$Btnfile.Text = 'Select File'
$Btnfile.Location = new-object System.Drawing.Point(490,28)
$Btnfile.Width = 90
$main_form.Controls.Add($Btnfile)

## MD5
$Lblmd5 = new-object System.Windows.Forms.Label
$Lblmd5.Text = "MD5:"
$Lblmd5.Location = new-object System.Drawing.Point(5,60)
$Lblmd5.AutoSize = $true
$main_form.Controls.Add($Lblmd5)

$Txtmd5 = new-object System.Windows.Forms.TextBox
$Txtmd5.Text = $md5
$Txtmd5.ReadOnly = $true
$Txtmd5.Width = 400
$Txtmd5.Location = new-object System.Drawing.Point(80,60)
$Txtmd5.AutoSize = $true
$main_form.Controls.Add($Txtmd5)

$Btnmd5copy = new-object System.Windows.Forms.Button
$Btnmd5copy.Text = 'Copy MD5'
$Btnmd5copy.Location = new-object System.Drawing.Point(490,58)
$Btnmd5copy.Width = 90
$main_form.Controls.Add($Btnmd5copy)

## Sha1
$Lbl1 = new-object System.Windows.Forms.Label
$Lbl1.Text = "Sha1:"
$Lbl1.Location = new-object System.Drawing.Point(5,90)
$Lbl1.AutoSize = $true
$main_form.Controls.Add($Lbl1)

$Txt1 = new-object System.Windows.Forms.TextBox
$Txt1.Text = $sha1
$Txt1.ReadOnly = $true
$Txt1.Width = 400
$Txt1.Location = new-object System.Drawing.Point(80,90)
$Txt1.AutoSize = $true
$main_form.Controls.Add($Txt1)

$Btnsha1copy = new-object System.Windows.Forms.Button
$Btnsha1copy.Text = 'Copy SHA1'
$Btnsha1copy.Location = new-object System.Drawing.Point(490,88)
$Btnsha1copy.Width = 90
$main_form.Controls.Add($Btnsha1copy)

## Sha256
$Lbl256 = new-object System.Windows.Forms.Label
$Lbl256.Text = "Sha256:"
$Lbl256.Location  = new-object System.Drawing.Point(5,120)
$Lbl256.AutoSize = $true
$main_form.Controls.Add($Lbl256)

$Txt256 = new-object System.Windows.Forms.TextBox
$Txt256.Text = $sha256
$Txt256.ReadOnly = $true
$Txt256.Width = 400
$Txt256.Location = new-object System.Drawing.Point(80,120)
$Txt256.AutoSize = $true
$main_form.Controls.Add($Txt256)

$Btnsha256copy = new-object System.Windows.Forms.Button
$Btnsha256copy.Text = 'Copy SHA256'
$Btnsha256copy.Location = new-object System.Drawing.Point(490,118)
$Btnsha256copy.Width = 90
$main_form.Controls.Add($Btnsha256copy)

## Sha512
$Lbl512 = new-object System.Windows.Forms.Label
$Lbl512.Text = "Sha512:"
$Lbl512.Location = new-object System.Drawing.Point(5,150)
$Lbl512.AutoSize = $true
$main_form.Controls.Add($Lbl512)

$Txt512 = new-object System.Windows.Forms.TextBox
$Txt512.Text = $sha512
$Txt512.ReadOnly = $true
$Txt512.Width = 400
$Txt512.Location = new-object System.Drawing.Point(80,150)
$Txt512.AutoSize = $true
$main_form.Controls.Add($Txt512)

$Btnsha512copy = new-object System.Windows.Forms.Button
$Btnsha512copy.Text = 'Copy SHA512'
$Btnsha512copy.Location = new-object System.Drawing.Point(490,148)
$Btnsha512copy.Width = 90
$main_form.Controls.Add($Btnsha512copy)

#Other stuff
$Btncopyall = new-object System.Windows.Forms.Button
$Btncopyall.Text = 'Copy All'
$Btncopyall.Location = new-object System.Drawing.Point(490,180)
$Btncopyall.Width = 90
$Btncopyall.AutoSize = $true
$main_form.Controls.Add($Btncopyall)

$Btnpaste = new-object System.Windows.Forms.Button
$Btnpaste.Text = 'Paste'
$Btnpaste.Location = new-object System.Drawing.Point(490,210)
$Btnpaste.Width = 90
$Btnpaste.AutoSize = $true
$main_form.Controls.Add($Btnpaste)

$Lblcompare = new-object System.Windows.Forms.Label
$Lblcompare.Text = "Checksum:"
$Lblcompare.Location = new-object System.Drawing.Point(5,250)
$Lblcompare.AutoSize = $true
$main_form.Controls.Add($Lblcompare)

$Txtcompare = new-object System.Windows.Forms.TextBox
$Txtcompare.Width = 400
$Txtcompare.Location = new-object System.Drawing.Point(80,250)
$Txtcompare.AutoSize = $true
$main_form.Controls.Add($Txtcompare)

$BtnVerify = new-object System.Windows.Forms.Button
$BtnVerify.Text = 'Verify'
$BtnVerify.Location = new-object System.Drawing.Point(490,248)
$BtnVerify.Width = 90
$BtnVerify.AutoSize = $true
$main_form.Controls.Add($BtnVerify)

$OpenFileDialog = new-object System.Windows.Forms.OpenFileDialog
#
# Global variables
#
$global:fileToCheckfileToCheck
$global:md5 = ''
$global:sha1 = ''
$global:sha256 = ''
$global:sha512 = ''
#
# Enables 'enter' key one textbox
#
$textboxComputerName_KeyDown = {}

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
#
# Select File Function
#
function selectFile {
    [void] $OpenFileDialog.ShowDialog()
    if ($OpenFileDialog.CheckFileExists -and $OpenFileDialog.FileName -ne '')
    {
		#Clear Output
		$md5 = ''
		$sha1 = ''
		$sha256 = ''
		$sha512 = ''
		$Txtmd5.Text = $md5
		$Txt1.Text = $sha1
		$Txt256.Text = $sha256
		$Txt512.Text = $sha512
		#
		#Set the file
		#
		$global:fileToCheck = $OpenFileDialog.FileName
        $Txtfile.Text = $global:fileToCheck
		
        $sumType = 'MD5'
        $MD5Hash = Get-FileHash $global:fileToCheck -Algorithm $sumType | Select-Object Hash
		$md5 = $MD5Hash -replace '@{Hash=', ''
		$global:md5 = $md5 -replace '}', ''
        $Txtmd5.Text = $global:md5

        $sumType = 'SHA1'
        $SHA1Hash = Get-FileHash $global:fileToCheck -Algorithm $sumType | Select-Object Hash
		$sha1 = $SHA1Hash -replace '@{Hash=', ''
		$global:sha1 = $sha1 -replace '}', ''
        $Txt1.Text = $global:sha1

        $sumType = 'SHA256'
        $SHA256Hash = Get-FileHash $global:fileToCheck  | Select-Object Hash
		$sha256 = $SHA256Hash -replace '@{Hash=', ''
		$global:sha256 = $sha256 -replace '}', ''
        $Txt256.Text = $global:sha256

        $sumType = 'SHA512'
        $SHA512Hash = Get-FileHash $global:fileToCheck -Algorithm $sumType | Select-Object Hash
		$sha512 = $SHA512Hash -replace '@{Hash=', ''
		$global:sha512 = $sha512 -replace '}', ''
        $Txt512.Text = $global:sha512
    }
	else
	{
		#Dump everything
		$global:md5 = ''
		$global:sha1 = ''
		$global:sha256 = ''
		$global:sha512 = ''
		$global:fileToCheck = ''
		$Txtmd5.Text = $global:md5
		$Txt1.Text = $global:sha1
		$Txt256.Text = $global:sha256
		$Txt512.Text = $global:sha512
		$Txtfile.Text = $global:fileToCheck
	}
}
#
# The Select File button
#
$Btnfile.Add_Click(
{
    selectFile    
}
)
#
# Verify file button & checksum verification
#
$BtnVerify.Add_Click(
{
	if (($global:md5 -ne '') -and ($global:fileToCheck -ne ''))
	{
		if ($global:md5 -eq $Txtcompare.Text)
		{
			[void][System.Windows.Forms.MessageBox]::Show('MD5 Matched!')
		}
		elseif ($global:sha1 -eq $Txtcompare.Text)
		{
			[void][System.Windows.Forms.MessageBox]::Show('SHA1 Matched!')
		}
		elseif ($global:sha256 -eq $Txtcompare.Text)
		{
			[void][System.Windows.Forms.MessageBox]::Show('SHA256 Matched!')
		}
		elseif ($global:sha512 -eq $Txtcompare.Text)
		{
			[void][System.Windows.Forms.MessageBox]::Show('SHA512 Matched!')
		}
		else
		{
			[void][System.Windows.Forms.MessageBox]::Show('File checksum does not match!!!')
		}
	}
}
)
#
# Copy MD5 checksum
#
$Btnmd5copy.Add_Click(
{
	if ($global:md5)
	{
		Set-Clipboard -Value $global:md5
	}
}
)
#
# Copy Sha1 checksum
#
$Btnsha1copy.Add_Click(
{
	if ($global:sha1)
	{
		Set-Clipboard -Value $global:sha1
	}
}
)
#
# Copy Sha256 checksum
#
$Btnsha256copy.Add_Click(
{
	if ($global:sha256) 
	{
		Set-Clipboard -Value $global:sha256
	}
}	
)
#
# Copy Sha512 checksum
#
$Btnsha512copy.Add_Click(
{
	if ($global:sha512)
	{
		Set-Clipboard -Value $global:sha512
	}
}
)
#
# Copy all checksum as seperate lines, no labels
#
$Btncopyall.Add_Click(
{
	if ($global:md5) #check for $null
	{
		Set-Clipboard -Value $global:md5
	}
	if ($global:sha1)
	{
		Set-Clipboard -Append -Value $global:sha1
	}
	if ($global:sha256) {
		Set-Clipboard -Append -Value $global:sha256
	}
	if ($global:sha512)
	{
		Set-Clipboard -Append -Value $global:sha512
	}
}
)
#
# Paste string from clipboard to the comparison checkbox
#
$Btnpaste.Add_Click(
{
	$Txtcompare.Text = Get-Clipboard
}
)
#
# Main Form load and close
#
$main_form.Add_FormClosing( { OnFormClosing_MenuForm $main_form $EventArgs} )
$main_form.Add_Shown({$main_form.Activate()})
$main_form.ShowDialog()
#Free ressources
$main_form.Dispose()
