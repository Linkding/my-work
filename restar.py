#!/usr/bin/python
#-*-coding:utf-8 -*-

import paramiko
port = 36000
user = 'root'
passwd = 'Efun@168'
#passwd = 'Egamehk'
#port = 22
CMD = "yum install -y  ntpdate|echo '*/10 * * * * /usr/sbin/ntpdate www.pool.ntp.org' >>  /tmp/crotab.txt|crontab /tmp/crotab.txt|service ntpd stop|chkconfig ntpd off|init 6"
out = ''
def do_ssh(user,passwd,cmd):
    for ip in open('/lin/ip.txt'):
        try:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            ssh.connect(ip,port,user,passwd,timeout=5)
            stdin,stdout,stderr = ssh.exec_command(cmd)
            print stdout.read()
            print '%s\tok\n' % ip
            ssh.close()
        except:
            print '%s\tError\n' % ip


do_ssh(user,passwd,CMD)
