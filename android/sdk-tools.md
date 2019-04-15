
sdkmanager --list
sdkmanager --install platform-tools

sdkmanager --update tools
sdkmanager --update platform-tools



# ADB

## Disable/uninstall pesky bloatware apps pre-loaded by carriers

1. Install USB drivers for your Device
2. Download and Install ADB tools
3. Enable Developer Options and USB Debugging
4. Plug a USB cable into your computer and then to your device. When the pop-up appears asking you to authorize the device, allow it. 
5. Open a command prompt (cmd in windows) and type:
   > adb devices
   This should return the ID of your device. If not, please go back and retrace your steps.
6. Use the following commands to find the apps you want to disable (replace 'amazon' with the manufacturer, i.e. 'samsung'
   > adb shell pm list packages | findstr /i docomo
   Pick up those you want to remove.
7. 

Now type:
> adb shell
This should give you a new prompt, something to the effect of (device-model):/ - here type the following: 
> pm uninstall -k --user 0 <name of package>
This should return 'Success' at which point the package has been removed!

e.g.
> pm uninstall -k --user 0 com.nttdocomo.android.applicationmanager
> pm uninstall -k --user 0 com.nttdocomo.android.iconcier
> pm uninstall -k --user 0 com.nttdocomo.android.iconcier_contents
> pm uninstall -k --user 0 com.nttdocomo.android.devicehelp
> pm uninstall -k --user 0 com.nttdocomo.android.initialization
> pm uninstall -k --user 0 com.nttdocomo.android.dhome
> pm uninstall -k --user 0 com.nttdocomo.android.store
> pm uninstall -k --user 0 jp.co.nttdocomo.carriermail
> pm uninstall -k --user 0 com.nttdocomo.android.areamail
> pm uninstall -k --user 0 com.nttdocomo.android.remotelock
> pm uninstall -k --user 0 jp.co.nttdocomo.lcsappsub
> pm uninstall -k --user 0 com.nttdocomo.android.cloudset
> pm uninstall -k --user 0 com.nttdocomo.android.idmanager
> pm uninstall -k --user 0 com.nttdocomo.android.dmenu2

This method does not require root, will not prevent your device from receiving OTAs, and all applications can be restored with a factory reset.
