
# Adding credentials to Windows Proxy Settings

## Setting up the Proxy Settings

In the Windows 10 menu, I went to settings (WinKey+I) and searched for "Configure Proxy Settings". Select Internet Settings > Local LAN Settings >Proxy Server Settings.

Select the option to make use of a proxy server, and enter the Server Address and Port

## Setting up the credentials for the Proxy Server

In Windows 10 menu, go to Settings (WIN+I) and search for "Credential Manager". Under Windows Credentials, add a new entry for Windows Credentials. Enter the Proxy Server address (without the port number), your domain user name and the password.

Once these details are active, you should be able to make use of the proxy server under your custom entered user credentials.

Just remember to deactivate the "Use a Proxy Server" setting (first step) when browsing from outside the network where the proxy is required.
