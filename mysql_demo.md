创建内银和港银的表
```
load data local infile '/lin/easybankPB/NeiBank/${i}.csv' replace into table easypb.${i} fields terminated by \",\" lines terminated BY \"\\n\" IGNORE 1 LINES(@vDate,@vOpen,@vHigh,@vLow,@vClose,@vVolume,@vAdj_Close,@vcodenumber,@vname,@vbookvalue,@vchangerate, @vPB) set Date=nullif(@vDate,''), Open=nullif(@vOpen,''), High=nullif(@vHigh,''), Low=nullif(@vLow,''), Close=nullif(@vClose,''), Volume=nullif(@vVolume,''), Adj_Close=nullif(@vAdj_Close,''), codenumber=nullif(@vcodenumber,''),name=nullif(@vname,''),bookvalue=nullif(@vbookvalue,''),changerate=nullif(@vchangerate,''), PB=nullif(@vPB,'')
```





创建每日排行表nei_pb
```
create table nei_pb (Date date null, Codenumber varchar(20) null,name varchar(20) null, Close decimal(5,2) null, bookvalue decimal(5,2) null,PB decimal(5,3) null)
```

创建每日排行表hk_pb
```
create table hk_pb (Date date null, Codenumber varchar(20) null,Name varchar(20) null, Close decimal(5,2) null, bookvalue decimal(5,2) null, changerate decimal(5,2) null, PB decimal(5,3) null)
```
