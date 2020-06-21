

# NSSM（ 非Sucking Service Manager ）

http://nssm.cc/

    ステップ1 ：NSSMをダウンロードする
    ステップ2 ：nssm.exe install [serviceName]でサービスをインストールする
    ステップ3 ：これにより、実行可能ファイルを見つけるために使用するGUIが開きます。

# Others

https://github.com/kflu/serman
https://github.com/winsw/winsw


winswをダウンロードしてきたら、まずは実行ファイルをリネームします。名前はサービス名と同じである必要があります。例えば今回はjenkinsをサービス化するとしましょう。

その場合、winswはjenkins.exeになります。そして同じフォルダにjenkins.xmlというファイルを作成し、以下のように記述をします。

    <service>
      <id>jenkins</id>
      <name>Jenkins</name>
      <description>This service runs Jenkins continuous integration system.</description>
      <env name="JENKINS_HOME" value="%BASE%"/>
      <executable>java</executable>
      <arguments>-Xrs -Xmx256m -jar "%BASE%\jenkins.war" --httpPort=8080</arguments>
      <logmode>rotate</logmode>
    </service>
> jenkins.exe install

# Make Java app as service
Apache daemon binaries for windows


# C#
https://docs.microsoft.com/ja-jp/dotnet/framework/windows-services/walkthrough-creating-a-windows-service-application-in-the-component-designer

[Windows Service (.NET Framework)] Project template

System.ServiceProcess.ServiceBase

# Service registration & control

> sc create DEMO_SERVICE binPath= C:\temp\demo1\chk\demo_service.exe 
displayname= "Demo Service"
[SC] CreateService SUCCESS

> net start DEMO_SERVICE
The Demo Service service is starting.
The Demo Service service was started successfully.

> net stop DEMO_SERVICE

> sc delete DEMO_SERVICE
[SC] DeleteService SUCCESS


# DebugView
Sysinternals > DebugView
https://docs.microsoft.com/en-us/sysinternals/downloads/debugview

うまくトレースが採取できないときは、[Capture Global Win32] オプションを有効にしてください。 

