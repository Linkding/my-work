#!/bin/bash


##配置参数
sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

sed -i -e 's/1024/65535/g' /etc/security/limits.d/90-nproc.conf

echo '* soft nofile 65535' >> /etc/security/limits.conf

echo '* hard nofile 65535' >> /etc/security/limits.conf

cp /etc/sysctl.conf /etc/sysctl.conf.bak

echo '' > /etc/sysctl.conf

cat > /etc/sysctl.conf << EOF
# Kernel sysctl configuration file for Red Hat Linux
#
# For binary values, 0 is disabled, 1 is enabled.  See sysctl(8) and
# sysctl.conf(5) for more details.

# Controls IP packet forwarding
net.ipv4.ip_forward = 0

# Controls source route verification
net.ipv4.conf.default.rp_filter = 1

# Do not accept source routing
net.ipv4.conf.default.accept_source_route = 0

# Controls the System Request debugging functionality of the kernel
kernel.sysrq = 0

# Controls whether core dumps will append the PID to the core filename
# Useful for debugging multi-threaded applications
kernel.core_uses_pid = 1

# Controls the use of TCP syncookies
net.ipv4.tcp_syncookies = 1

# Controls the maximum size of a message, in bytes
kernel.msgmnb = 65536

# Controls the default maxmimum size of a mesage queue
kernel.msgmax = 65536

# Controls the maximum shared segment size, in bytes
kernel.shmmax = 68719476736

# Controls the maximum number of shared memory segments, in pages
kernel.shmall = 4294967296

#sysctl setting

#net.ipv4.netfilter.ip_conntrack_max = 131072
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rmem = 4096        87380   4194304
net.ipv4.tcp_wmem = 4096        16384   4194304
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216

net.ipv4.tcp_max_syn_backlog = 262144
net.core.netdev_max_backlog = 262144
net.core.somaxconn = 262144

net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2

net.ipv4.tcp_tw_recycle = 1
#net.ipv4.tcp_tw_len = 1
net.ipv4.tcp_tw_reuse = 1

net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_max_orphans = 3276800

net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 1

net.ipv4.tcp_keepalive_time = 300
net.ipv4.ip_local_port_range = 1024     65535

#net.ipv4.netfilter.ip_conntrack_tcp_timeout_established = 300
#net.ipv4.netfilter.ip_conntrack_tcp_timeout_time_wait=120
#net.ipv4.netfilter.ip_conntrack_tcp_timeout_close_wait=60
#net.ipv4.netfilter.ip_conntrack_tcp_timeout_fin_wait=120
EOF

sysctl -p

## 安装必须的软件
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install -y wget ntpdate vim salt-minion telnet

#### 时间同步定时任务
ntpdate stdtime.gov.hk

echo "*/10 * * * * /usr/sbin/ntpdate stdtime.gov.hk" >>  /tmp/qqqcrotab.txt

crontab  /tmp/qqqcrotab.txt

## 重启
init 6
