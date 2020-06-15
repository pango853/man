
# BACKUP

- mysqldump -u root -p -x -A > my_dumpall.db
  簡単だが、復旧時間の問題、ログ問題あり
- バックアップ datadirのコピー  
  簡単かつ高速だが、整合性懸念
- mysqldump -u root -p --single-transaction -A > my_dumpall.db
  innodbであれば可能
- slaveにてdump
- LVMのスナップショットでdatadirをコピー
  スナップショット作成中は非常に負荷が高くなるそうで、 該当時間の書き込み処理の性能がガタ落ちするそう


> $ ./bin/mysqldump -uroot --socket=<SOCKET> --add-drop-table --all-databases --force > alldatabases.dump
> $ mysql -uroot --socket=<SOCKET> --execute="source alldatabases.dump"


# MySQL Product
- MySQL Notifier 1.1.7
- MySQL Query Browser 1.1.20	mysql-query-browser-1.1.20-win-noinstall.zip
- MySQL Control Center 0.9.2	mysqlcc-0.9.2-win32.zip
- MySQL Administrator 1.1.10a	mysql-administrator-1.1.10a-linux-i386.tar.gz
- MySQL Migration Toolkit 1.0.25	mysql-migration-toolkit-noinstall-1.0.25-win32.zip
- MySQL GUI Tools 5.0.17	mysql-gui-tools-noinstall-5.0-r17-win32.zip
- MySQL Router 8.0.16	mysql-router-8.0.16-winx64.zip
- MySQL Shell 8.0.16	mysql-shell-8.0.16-windows-x86-64bit.zip
- MySQL Utilities 1.6.5	mysql-utilities-1.6.5-winx64.msi




# TODO

- mysqld_multi report
