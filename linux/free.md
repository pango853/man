
free�R�}���h�ɒǉ����ꂽavailable

3.14�����2.6.27����Afree�R�}���h�̏������ς��A
-/+ buffers/cache��������available�Ƃ������ڂ������܂����B

available��/proc/meminfo�̒��ɂ���MemAvailabl�̒l���Q�Ƃ��Ă��܂��B
���̒l�́A�V�����A�v�����X���b�v�����Ɏg����e�ʂ͂ǂꂭ�炢���B�Ƃ������l�������Ă���悤�ł�

available
Estimation of how much memory  is  available  for  starting  new
applications,  without swapping. Unlike the data provided by the
cache or free fields, this field takes into account  page  cache
and also that not all reclaimable memory slabs will be reclaimed
due to items being in use (MemAvailable in /proc/meminfo, available on kernels 3.14, emulated on kernels 2.6.27+, otherwise the same as free)

# �R�[�h

/proc/meminfo�͈ȉ��̃R�[�h�ɂ���č쐬�����悤�ł��B
https://github.com/torvalds/linux/blob/master/fs/proc/meminfo.c

available = i.freeram - wmark_low;

pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
pagecache -= min(pagecache / 2, wmark_low);
available += pagecache;

available += global_page_state(NR_SLAB_RECLAIMABLE) -
			 min(global_page_state(NR_SLAB_RECLAIMABLE) / 2, wmark_low);

# �R�[�h���e

�����ƌ����Ƃ���Asysinfo��freeram�̒l����A�y�[�W�L���b�V����slab�L���b�V���̒��̍ė��p�\�ȕ��𑫂����l���AMemAvailable�Ƃ��Čv�Z�����悤�ł��B

���ۂ̋󂫗e�ʁ{�����ɉ���\�ȗe�ʁ����p�\�ȃ������e�ʂƂ����������̂悤�ł��B
���̂��߁A�قڂ��̒l�����ă������̋󂫗e�ʂ𔻒f���Ă悳�����ł��B
