'[smart.vbs]
strComputer = "." 
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\WMI") 
Set colItems = objWMIService.ExecQuery("SELECT * FROM MSStorageDriver_FailurePredictData",,48)
For Each objItem in colItems 
	strMsg = strMsg & "-----------------------------------" & vbCRLF
	strMsg = strMsg & "DeviceName: " & mid(objItem.InstanceName,1,22) & vbCRLF
	For i = 2 To UBound(objItem.VendorSpecific) Step 12
		If objItem.VendorSpecific(i) = 1 Then		' == Raw Read Error Rate
			HDDHealth = objItem.VendorSpecific(i+3)
		ElseIf objItem.VendorSpecific(i) = 194 Then	' == temprature
			Temperature = objItem.VendorSpecific(i+5)
		End If
	Next
	strMsg = strMsg & "HDD Health : " & HDDHealth & " %" & vbCRLF
	strMsg = strMsg & "Temperature: " & Temperature & " ℃" & vbCRLF
Next
strMsg = strMsg & "-----------------------------------" & vbCRLF
msgBox strMsg, vbInformation, WScript.ScriptName
