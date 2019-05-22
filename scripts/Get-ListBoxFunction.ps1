# ------------------------------------------------------------------------- 
# Get-ListBoxFunction.ps1 
# ed wilson、Microsoft、2009/8/20 
#  
# キーワード: .NET Framework、反映、windows.Forms、 
# グラフィカル、gui 
# 
# HSG-08-31-09 
# Listbox に関する MSDN のドキュメント:  
http://msdn.microsoft.com/ja-jp/library/system.windows.forms.listbox.aspx 
# ------------------------------------------------------------------------ 
Function Get-ListBox 
{    
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | 
 out-null 
 $WinForm = new-object Windows.Forms.Form    
 $WinForm.text = "ListBox Control"    
 $WinForm.Size = new-object Drawing.Size(200,125) 
 $ListBox = new-object Windows.Forms.ListBox 
  
 $winform.controls.add($listbox) 
 ForEach($i in (Get-Content c:\fso\itemlist.txt)) 
 { $ListBox.items.add($i) | Out-Null } 
 
 $WinForm.Add_Shown($WinForm.Activate())   
 $WinForm.showdialog() | out-null   
 $ListBox.SelectedItem 
} # Get-ListBox 関数の終わり 
 
# *** スクリプトのエントリ ポイント *** 
 
Get-ListBox
