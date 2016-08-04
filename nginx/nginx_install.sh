#!/bin/bash

. /etc/rc.d/init.d/functions
date=$(date +%F)
base_dir="/usr/local/src/"
#pcre_file="pcre-8.35.tar.gz"
nginx_file="nginx-1.8.0.tar.gz"

yum -y install zlib zlib-devel openssl openssl-devel pcre pcre-devel gcc* ncurses-devel patch wget

# Install pcre(可选)_
#echo ""
#echo "$date"
#echo -e "\033[40;32m############################Starting install pcre#############################\n\033[40;37m"
#cd $soft_dir
#tar -zxf $pcre_file
#cd ${pcre_file%.tar.gz}
#./configure > /dev/null 2>&1
#[ $? -ne 0 ] && echo -e "\033[40;32mpcre configure failed.\n\033[40;37m" && exit 1
#make && make install
#[ $? -ne 0 ] && echo -e "\033[40;32mpcre installed failed.\n\033[40;37m" && exit 1
#ln -s $base_dir/lib/libpcre.so.1 /lib64/
#echo -e "\033[40;32mPCRE installed successfully.\n\033[40;37m"

#Install nginx
echo ""
echo "$date"
echo -e "\033[40;32m###########################Starting install nginx############################\n\033[40;37m"


if [ -x $nginx_prefix/sbin/nginx ];then
 echo -e "\033[40;32mNginx already installed.\n\033[40;37m"
else
 echo -e "\033[40;32mInstalling $nginx_file, please wait.\n\033[40;37m"
fi
cd $base_dir
wget  nginx.org/download/$nginx_file
tar -xzvf $nginx_file
cd ${nginx_file%.tar.gz}

./configure --prefix=/usr/local/nginx --with-http_ssl_module --with-http_realip_module --with-http_sub_module  --with-http_gunzip_module --with-http_gzip_static_module --with-http_stub_status_module --with-pcre
[ $? -ne 0 ] && echo -e "\033[40;32mNginx configure failed.\n\033[40;37m" && exit 1
make && make install
[ $? -ne 0 ] && echo -e "\033[40;32mNginx installed failed.\n\033[40;37m" && exit 1
echo ""
echo ""
echo -e "\033[40;32mNginx installed successfully.\n\033[40;37m"
echo ""
