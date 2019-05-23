
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

# TODO

- mysqld_multi report
