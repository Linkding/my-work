#!/usr/bin/python
#-*-coding:utf-8 -*-

import paramiko
port = 36000
user = 'root'
passwd = '**'
#passwd = 'Egamehk'
#port = 22
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


do_ssh(user,passwd,"cat /proc/cpuinfo |grep process|wc -l;free;df -h;cat /etc/issue;ifconfig|grep Bcast;cat /etc/fstab|grep -v ^#")
