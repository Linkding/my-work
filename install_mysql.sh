wget -P /usr/local/src/  http://7xvj0k.com1.z0.glb.clouddn.com/mysql57-community-release-el6-9.noarch.rpm
#此为mysql5.7
rpm -vhi /usr/local/src/mysql57-community-release-el6-9.noarch.rpm
rm -rf /etc/yum.repos.d/mysql-community.repo
wget -P /etc/yum.repos.d/ http://7xvj0k.com1.z0.glb.clouddn.com/mysql-community.repo
yum install  mysql-community-server -y

create table nei_pb_sort (Date date,codenumber int(6),name varchar(20),Close decimal(5,2), bookvalue decimal(5,2),PB decimal(5,3))
Date,Codenumber,Name,bookvalue,changerate,Close,PB
create table hk_pb_sort (Date date,Codenumber int(6),Name varchar(20),bookvalue decimal(5,2), changerate decimal(5,2),Close decimal(5,2), PB decimal(5,3))


load data local infile '/lin/easybankPB/NeiBank/nei_pb.csv' into table nei_pb_sort fields terminated by "," IGNORE 1 LINES;
load data local infile '/lin/easybankPB/NeiBank/hk_pb.csv' into table hk_pb_sort fields terminated by "," IGNORE 1 LINES;
