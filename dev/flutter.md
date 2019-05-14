
# Install
1. Download
```
   $url="https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_v1.2.1-stable.zip"
   $output="flutter.zip"
   Invoke-WebRequest -Uri $url -OutFile $output
   Expand-Archive -Path $output -DestinationPath .\flutter
```
2. Extract and run flutter_console.bat
3. Run `flutter doctor`
4. Upgrade if needed.
```
	$ flutter channel
	$ flutter channel dev
	$ flutter upgrade
```
5. (OPTIONAL) Install the Flutter and Dart plugins on VS Code
   Extensions: Install Extensions > Flutter > install
   View > Command Palette... > Flutter: Run Flutter Doctor

6. (OPTIONAL) Install the Flutter and Dart plugins on Android Studio
   Android Studio > File > Settings > Plugins > Browse repositories > search Flutter and click Install, also Click Yes when prompted to install the Dart plugin.
   Then restart.

# Tutorials

## Create an app via Android Studio
1. File > New Flutter Project > select Flutter Application as the project type > press Next
3. Make sure that the Flutter SDK Path text field specifies the location of the SDK. Install the SDK if you haven’t yet done so.
4. Enter a project name (for example, myapp), and press Next and click Finish.
5. Wait for Android Studio to install the SDK, and create the project.

In the target selector, select an Android device for running the app.
If none are listed as available, select Tools> Android > AVD Manager and create one there. For details, see Managing AVDs.
Click the run icon in the toolbar, or invoke the menu item Run > Run.



## Create an app
$ flutter create myapp
$ cd myapp
$ flutter devices
$ flutter run

