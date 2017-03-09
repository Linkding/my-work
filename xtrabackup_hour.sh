#!/bin/bash
day=$(date  '+%Y-%m-%d-%H')
day_hour_before=$(date  -d "-1 hour" '+%Y-%m-%d-%H')
day_hour=$(date '+%H')
config_file='/etc/my.cnf'
user='xtrabackup'
password='xtrabackup911'
base_dir="/xtrabackup/efun_2012_full-$day"
last_full_dir="/xtrabackup/efun_2012_full-$day_hour_before"
#last_full_dir="/xtrabackup/efun_2012_full-2016-07-13-14"
incremental_dir="/xtrabackup/efun_2012_incremental-$day"
next_base_dir="/xtrabackup/efun_2012_incremental-$day_hour_before"
logfile=/xtrabackup/efun_2012_$day.log
if [ $day_hour -eq 10 ]
then
innobackupex --defaults-file=$config_file --user=$user --password=$password  --slave-info --no-timestamp $base_dir > $logfile 2>&1
elif [ -d $next_base_dir ]
then
innobackupex --defaults-file=$config_file --user=$user --password=$password  --slave-info --no-timestamp --incremental --incremental-basedir=$next_base_dir $incremental_dir > $logfile 2>&1
else
innobackupex --defaults-file=$config_file --user=$user --password=$password  --slave-info --no-timestamp --incremental --incremental-basedir=$last_full_dir $incremental_dir > $logfile 2>&1
fi

cd /xtrabackup
chown -R efun:efun *
tail  $logfile |grep -q 'completed OK!'
if [ $? -eq 0 ]
then
        echo "successful"
else
        /home/efun/sendmaildb.py $logfile
fi
