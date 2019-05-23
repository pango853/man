function FNreadtemp ($id) {
	# Execute smartctl and assign the output to a variable
	$smartctl ="smartctl -A /dev/hd"+$id
	$smartdata = Invoke-Expression  $smartctl

	# Feed the contents of the variable to the pipeline and if a line matches "Temperature_Celsius", then:
	# - Split the line at the hyphen: .split("-")
	# - Use only the last element of the resulting array: [-1]
	# - Trim the leading blanks: .trim()
	# - and finally take the first two characters of the remaining string: .substring(0,2) and return them

	return ((($smartdata | Where-Object {$_ -match "Temperature_Celsius"}).split("-"))[-1]).trim().substring(0,2)
}

function FNcheckSMART {
	$ta =  FNreadtemp a
	if ($ta -ge 48) { $warn = "HDA-Temp is "+$ta+" degrees!`n`r" }
	$tb = FNreadtemp b
	if ($tb -ge 48) { $warn = $warn + "HDB-Temp is "+$tb+" degrees!`n`r" }
	$NotifyIcon.Text = "HDD-Temp ("+(Get-Date -Format HH:mm)+") A: $ta° B: $tb°"
	if ($warn) {
		$NotifyIcon.Icon =  $iconWarn
		$NotifyIcon.ShowBalloonTip(30000,"Attention!",$warn,[system.windows.forms.ToolTipIcon]"Warning")
		Remove-Variable warn
	}else{
		$NotifyIcon.Icon =  $iconOK
	}
}

[void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")
$form1 = New-Object System.Windows.Forms.form
$NotifyIcon= New-Object System.Windows.Forms.NotifyIcon
$ContextMenu = New-Object System.Windows.Forms.ContextMenu
$MenuItem = New-Object System.Windows.Forms.MenuItem
$TimerHDD = New-Object System.Windows.Forms.Timer
$iconOK = New-Object System.Drawing.Icon("D:\tmp\Temperature-1.ico")
$iconWarn = New-Object System.Drawing.Icon("D:\tmp\Temperature-5.ico")

$form1.ShowInTaskbar = $false
$form1.WindowState = "minimized"

$NotifyIcon.Icon =  $iconOK
$NotifyIcon.ContextMenu = $ContextMenu
$NotifyIcon.ContextMenu.MenuItems.AddRange($MenuItem)
$NotifyIcon.Visible = $True

$TimerHDD.Interval = 300000 # (5 min)
$TimerHDD.add_Tick({FNcheckSMART})
$TimerHDD.start()

$MenuItem.Text = "Exit"
$MenuItem.add_Click({
	$TimerHDD.stop()
	$NotifyIcon.Visible = $False
	$form1.close()
})



FNcheckSMART
[void][System.Windows.Forms.Application]::Run($form1)