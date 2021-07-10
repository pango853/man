
# Command-line options
https://developer.mozilla.org/en-US/docs/Mozilla/Command_Line_Options#-private

-private
-private-window URL


# Tuning
http://kb.mozillazine.org/about:config
about:config

Search signon.autologin.proxy and network.websocket.enabled in the Search Input Box then change their values as follow:

signon.autologin.proxy=true
network.websocket.enabled=false

Disable multi-process windows
	browser.tabs.remote.autostart = false
	browser.tabs.remote.autostart.2 = false 

Reduce Firefox Session History
	browser.sessionhistory.max_entries	10		default:50

Delete the content-prefs.sqlite and let it create again
	about:support
	Open Folder, shown next to Profile Folder, and delete content-prefs.sqlite there

Refresh Firefox if fails
	about:support
	Refresh Firefox.
	

Proxy password problem in Mozilla Firefox 3 - SOLVED by accident :)

    Start Firefox 3
    In Address bar write "about:config"
    In filter write network.auth.use-sspi
    Double click on "true" and it should become "false"
    If things does not become better write here to give other changes I made. So far nothing else worked until this change

Try it. It might solve your problem. Credits to Revell


network.negotiate-auth.allow-proxies : false network.proxy.share_proxy_settings  : false network.automatic-ntlm-auth.allow-proxies : false network.auth.use : false signon.autologin.proxy : true 


I figured out the solution by myself. The address of proxy was unfortunately added to list of sites for which passwords are not remembered. After removing the proxy address from this list, I am able to save username and password using Password manager. 


Double-click network.negotiate-auth.allow-proxies to toggle between true and false. The option must be set to false. (It seems counterintuitive, but you set it to false to make it work with the ISA proxy.)


about:memory





about:config > New boolean > config.trim_on_minimize=true
browser.cache.memory.enable=true
browser.cache.memory.capacity=8192	(~256M?)
browser.sessionhistory.max_total_viewers=3


about:config
└network.http.pipelining → "true"
└network.http.proxy.pipelining → 'true'
└network.http.pipelining.maxrequests → "8"
└browser.cache.memory.enable → "true"
　→ Right click → "Create new" → "Integer value"
　→ browser.cache.memory.capacity → numeric input
※ 1GB installed memory: 16384
※ 2GB installed memory: 32768
* When the installed memory is 3 GB: 49152
※ When installed memory is 4GB: 65536

Also try
browser.tabs.remote.autostart=true
dom.ipc.processCount=2


Add-ons > Shockwave Flash > 実行時に確認する


コンテンツプロセス数の制限: Options > General > Performance > Use hardware acceleration when available = 2 (smaller for bad performance but less memory comsumption)


C:\Program Files\Mozilla Firefox\defaults\profile\user.js


about:memory to tuning


Use SpeedyFox, Fireboot
Use nightly Waterfox , Palemoon

