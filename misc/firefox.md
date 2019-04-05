

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

