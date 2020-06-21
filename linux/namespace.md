Namespaceはコンテナで使われている技術の一つ

例えばPID namespaceはPIDの number spaceを隔離する。
これは同じホスト上で実行されている2つのプロセスが同じPIDを持つことができるということになる。

> # ps ax
OSのプロセスがすべて出るでしょう

> # unshare --mount-proc -p --fork /bin/bash
> # ps ax
こうするとbash(とps)しかでなくなるはず

```sh
$ ROOTFS=$(mktemp -d)
$ CID=$(sudo docker container create centos:centos7)
$ sudo docker container expoert $CID | tar -x -C $ROOTFS
$ ln -s /usr/local/bin/bash $ROOTFS/bin/bash
$ sudo docker container rm $CID
$ UUID=$(uuidgen)
$ sudo cgcreate -t $(id -un):$(id -gn) -a $(id -un):$(id -gn) -g cpu,memory:$UUID
$ cgset -r memory.limit_in_bytes=10000000 $UUID
$ cgset -r cpu.cfs_period_us=1000000 $UUID
$ cgset -r cpu.cfs_quota_us=300000 $UUID
$ CMD="/bin/sh"
$ cgexec -g cpu,memory:$UUID \
  unshare -muinpfr /bin/sh -c "
   mount -t proc proc $ROOTFS/proc &&
   touch $ROOTFS$(tty); mount --bind $(tty) $ROOTFS$(tty) &&
   touch $ROOTFS/dev/pts/ptmx; mount --bind /dev/pts/ptmx $ROOTFS/dev/pts/ptmx &&
   ln -sf /dev/pts/ptmx $ROOTFS/dev/ptmx &&
   touch $ROOTFS/dev/null && mount --bind /dev/null $ROOTFS/dev/null &&
   /bin/hostname $UUID &&
   exec capsh --chroot=$ROOTFS --drop=cap_sys_chroot --c 'exec $CMD'
  "
```

namespaceがなくて隔離されてないとコンテナAがコンテナB、C、Dなどに filesystemのunmountやホスト名の変更、NWインターフェースの削除など できたりしてしまうので、必ず他のコンテナのプロセスがみれないようにする。

Namespace
Kernel/OSのリソースで、物理リソースは制限しない(cgroupsでする)が、 以下の項目についてNamespaceを分離する。 namespaceを分離した環境では、許可されたリソースしか見えなくなるので コンテナ内の要素だけ見えるように制限できる。

Mount Namespace(ファイルシステムのマウントポイントを分離: Namespace 内の mount / umount が他の Namespace に影響を与えないようにする)
UTS Namespace(ホスト名，ドメイン名の分離)
PID Namespace(PID 空間の分離、新しい PID Namespace では PID 1 から始まる)
IPC Namespace(セマフォ、MQ、共有メモリなどのプロセス間通信の分離)
User Namespace(UID、GID Namespaceの分離)
Network Namespace(インターフェース、ルーティングテーブル、ソケットなど)
cgroup Namespace(cgroupのルートディレクトリを分離)
cgroups
cpuやmemory、ディスクなどの物理リソース制限は cgroupsと呼ばれるカーネル機能で計測されアクセス制限される。 cgroupsではタスクをグループ化したり、そのグループ内のタスクに対して 以下のような物理リソースを制限できる。使用量やアクセスを制限する。

CPU
メモリ
ブロックデバイス(mmap可能なストレージとほぼ同義)
ネットワーク
/dev以下のデバイスファイル
unshareコマンドでNamespaceについて確認
unshare コマンドはparentから unshared されている namespaceを使用してプログラムを実行できるらしい。 unshare が新しいnamespace でどんなプログラムでも走らせることができるということ。実際にUTS Namespaceを例に unshareコマンドの動きを確認してみる。

    $ unshare -h
    
    Usage:
     unshare [options] <program> [<argument>...]
    
    Run a program with some namespaces unshared from the parent.
    
    オプション:
     -m, --mount               unshare mounts namespace
     -u, --uts                 unshare UTS namespace (hostname etc)
     -i, --ipc                 unshare System V IPC namespace
     -n, --net                 unshare network namespace
     -p, --pid                 unshare pid namespace
     -U, --user                unshare user namespace
     -f, --fork                fork before launching <program>
         --mount-proc[=<dir>]  mount proc filesystem first (implies --mount)
     -r, --map-root-user       map current user to root (implies --user)
         --propagation <slave|shared|private|unchanged>
                               modify mount propagation in mount namespace
     -s, --setgroups allow|deny  control the setgroups syscall in user namespaces
    
     -h, --help     display this help and exit
     -V, --version  output version information and exit
    
    For more details see unshare(1).
UTS Namespaceは名前空間ごとにホスト名やドメイン名を独自に持つことができる。 以下で UTS Namespace を unshare コマンドで操作してみる。

unshare -u /bin/sh はUTS名前空間を指定してunshare実行している これでホスト名、ドメイン名が分離されたので、 もとのホスト名は test-ozawa-dev01.amb-infra-dev.incvb.io だが、 unshare で切り替え後、 my-new-hostname に変更している。

もちろんこのホスト名は新たな namespace だけで有効なので、 unshareで起動したシェルを終了すると、ホスト名はもとに戻る。

    $ sudo su       # root userになる
    # uname -n   # 現在のhostnameを確認
    test01
    # unshare -u /bin/sh  # 新しいUTS namespaceでshellを作成
    sh-4.2# hostname my-new-hostname                 # hostnameを設定
    sh-4.2# uname -n                                 # 新しいhostnameを確認
    my-new-hostname
    sh-4.2# exit                        # 新しいUTS namespaceから出る
    exit
    # uname -n   # 元のhostnameが変更されていないことを確認
    test01


```
$ mkdir test_container
$ cd test_container
$ cp -r /bin /lib /lib64 .
$ sudo unshare -pf chroot . bash
	$ mkdir -p /proc /dev/pts
	$ mount proc proc /proc
	$ mount -t devpts devpts /dev/pts
	$ ps
```


