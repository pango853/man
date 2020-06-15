

# Citrix Receiver keyboard shortcuts

## Windows Remote Desktop Client (9 shortcuts) 

Ctrl + Alt + End 
Open the Windows Security dialog box. (similar to the CTRL+ALT+DEL) 

Ctrl + Alt + Break 
Toggle the RDS client display from Window to Full Screen 

Alt + Insert 
Cycle through running programs on the remote computer (similar to ALT+ESC) 

Alt + Home 
Display the remote computer’s Start Menu (similar to CTRL+ESC) 

Alt + Del 
Displays the remote window’s Control Menu (similar to ALT+SPACEBAR) 

Alt + Page Up 
Switch between programs from left to right (similar to ALT+TAB) 

Alt + Page Down 
Switch between programs from right to left (similar to ALT+SHIFT+TAB) 

Ctrl + Alt + Num - 
Place an image of the active window onto the RDS Clipboard (similar to ALT+PRINT SCREEN) 

CTR + Alt + Num + 
Place an image of the entire RDS client on the RDS Clipboard (similar to PRINT SCREEN) 


## Citrix Receiver Client (9 shortcuts) 
↑   Shift + F1 
Display the Windows Task List 

↑   Shift + F2 
Display or hide the Windows Title Bar for the Citrix Receiver Client window 

↑   Shift + F3 
Disconnect the ICA session and exit the Citrix Receiver 

Ctrl + F1 
Open the Windows Security dialog box (similar to CTRL+ALT+DEL) 

Ctrl + F2 
Display the remote computer’s Start Menu (similar to CTRL+ESC) 

Ctrl + F3 
Display the Windows Task Manager (similar to CTRL+SHIFT+ESC) 

Alt + F2 
Cycle through running programs in the Citrix session (similar to ALT+ESC) 

Alt + + 
Switch between programs from left to right (similar to ALT+TAB) 

Alt + - 
Switch between programs from right to left (similar to ALT+SHIFT+TAB) 


# How to configure Desktop or Start Menu shortcuts With Citrix Receiver 4.x
https://support.citrix.com/article/CTX201261

Configure the Citrix Receiver icaclient.adm template and client side registry keys.

The icaclient.adm template is part of the Citrix Receiver install and located in the following folder:
%SYSTEM ROOT%\Programs Files (x86)\Citrix\ICA Client\Configuration\icaclient.adm

Computer Configuration
Computer Configuration > Administrative Templates  > Classic Administrative Templates (ADM)  > Citrix Components > Citrix receiver > SelfService


1. Import the icaclient.adm template either locally on the client machine you would like to configure for desktop shortcuts or Active Directory if you wish to have this configuration for multiple client workstations in your Windows domain.
After the icaclient.ADM template is imported, the settings we need to adjust are located under Computer Configuration.


2. We want to Enable the Manage App Shortcut policy with the following settings: 
Enable Desktop Shortcut
Remove apps on Logoff
Remove apps on Exit


3. Open the registry editor on the user's machine using the REGEDIT command and navigate the to the following location: 
HKEY_LOCAL_MACHINE > Software > Wow6432Node > Citrix > Dazzle


# Customize App Shortcuts with Receiver for Windows
https://support.citrix.com/article/CTX200924
