
freeコマンドに追加されたavailable

3.14および2.6.27から、freeコマンドの書式が変わり、
-/+ buffers/cacheが消えてavailableという項目が増えました。

availableは/proc/meminfoの中にあるMemAvailablの値を参照しています。
この値は、新しいアプリがスワップせずに使える容量はどれくらいか。といった値を示しているようです

available
Estimation of how much memory  is  available  for  starting  new
applications,  without swapping. Unlike the data provided by the
cache or free fields, this field takes into account  page  cache
and also that not all reclaimable memory slabs will be reclaimed
due to items being in use (MemAvailable in /proc/meminfo, available on kernels 3.14, emulated on kernels 2.6.27+, otherwise the same as free)

# コード

/proc/meminfoは以下のコードによって作成されるようです。
https://github.com/torvalds/linux/blob/master/fs/proc/meminfo.c

available = i.freeram - wmark_low;

pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
pagecache -= min(pagecache / 2, wmark_low);
available += pagecache;

available += global_page_state(NR_SLAB_RECLAIMABLE) -
			 min(global_page_state(NR_SLAB_RECLAIMABLE) / 2, wmark_low);

# コード内容

ざっと見たところ、sysinfoのfreeramの値から、ページキャッシュやslabキャッシュの中の再利用可能な分を足した値が、MemAvailableとして計算されるようです。

実際の空き容量＋直ぐに解放可能な容量＝利用可能なメモリ容量といった感じのようです。
そのため、ほぼこの値を見てメモリの空き容量を判断してよさそうです。
