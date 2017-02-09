wget -P /usr/local/src/  http://7xvj0k.com1.z0.glb.clouddn.com/mysql57-community-release-el6-9.noarch.rpm
#此为mysql5.7
rpm -vhi /usr/local/src/mysql57-community-release-el6-9.noarch.rpm
yum install  mysql-community-server -y
