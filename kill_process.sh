##批量杀死进程脚本
ps_uid=$1
kill -9 `ps aux|grep $ps_uid|awk '{print $2}'`

#批量删除旧文件
#场景：目录文件按时间排列，删除一些历史最旧的若干文件
## ll -lut 文件按时间顺序排列，tail -2 取排列最尾（旧）文件。
rm -rf `ll -lut|tail -2|awk '{print $9}'`
