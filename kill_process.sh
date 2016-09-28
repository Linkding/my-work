##批量杀死进程脚本
ps_uid=$1
kill -9 `ps aux|grep $ps_uid|awk '{print $2}'`
