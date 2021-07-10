

# MISC
## Tutorial - Use PowerShell Active Directory Cmdlets Without Installing Any Software

// env: PC is Windows 7, domain controllers are running Windows 2008 R2.

```ps
Enter-PSSession -ComputerName dc1 –credential domainname001\administrator

	Set-Location c:\

	Import-Module activedirectory

	new-aduser -name user001

	Get-aduser user001

	Get-ADOrganizationalUnit –LDAPFilter “(name=ouname001)”

	$oupath = (Get-ADOrganizationalUnit -LDAPFilter "name=ouname001").distinguishedname
	Move-ADObject -TargetPath $oupath -Identify "cn=user001,cn=users,dc=domainname001,do=com"
	$pwd = ConvertTo-SecureString -String “P@ssword1” -AsPlainText –Force
	Set-ADAccountPassword -Identity user001 -NewPassword $pwd –Reset
	Enable-ADAccount -Identity user001

	Get-ADUser user001

```


##

```adduser.csv
"cn=Users,dc=ad,dc=rem-system,dc=com" test1 3!bntso テスト1 test-group
"cn=Users,dc=ad,dc=rem-system,dc=com" test2 8?bhlo5 テスト2 test-group
```

```cmd
for /f "tokens=1-5" %A in (C:\adduser.csv) do dsadd user "cn=%D,%A" -pwd %C -samid %B -upn %B@ad.rem-system.com -display %D -memberof "cn=%E,dc=ad,dc=rem-system,dc=com"
OR
for /f "tokens=1-5" %A in (C:\adduser.csv) do dsadd user "cn=%D,%A" -pwd %C -pwdneverexpires yes -samid %B -upn %B@ad.rem-system.com -display %D -memberof "cn=%E,dc=ad,dc=rem-system,dc=com"
```

> dsadd user "cn=ユーザー名,オブジェクトの識別子(DN)" -pwd パスワード -samid アカウント名 -upn アカウント名@ドメイン名 -display 表示名 -memberof "メンバーのオブジェクト識別子(DN)"
