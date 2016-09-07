## 版本控制系统

集中式版本控制系统：版本库是集中存放在中央服务器，必须连网

分布式版本控制系统：每个客户端都有完整的版本库

## git和svn比较

svn仓库中每个目录都有一个.svn目录, 而git仓库只有一个.git目录

git提交到服务器才算一次版本变更，而git每一次提交都算一次变更且无需连网，推送到服务器时同时把多次提交历史推送到服务器中


## git安装

红帽系列平台： yum -y install git

源码安装:

       tar xf git-$VERSION.tar.gz   
       cd git-$VERSION  
       make prefix=/usr/local/git all   
       make prefix=/usr/local/git install

       echo 'PATH=/usr/local/git/bin:$PATH' > /etc/profile.d/git.sh

## git命令使用

初始化仓库git init

添加文件到仓库git add file1.txt file2.txt

提交到仓库 git commit -m ‘comment’

查看当前工作区状态git status

对比修改过的文件 git diff

查看提交历史
           git log
           git reflog

版本回滚git reset --hard commit_id

删除文件git rm filename

恢复rm误删文件git checkout – filename

恢复git rm误删除的文件:
            git commit
            git log
            git reset –hard commit_id

查看分支：git branch

创建分支：git branch 分支名

切换分支：git checkout 分支名

创建+切换分支：git checkout -b 分支名

合并某分支到当前分支：git merge 分支名

删除分支：git branch -d 分支名


## 自建分布式的版本控制系统
开源代码库以及版本控制系统github

跟github差不多的开源工具gitlab， 个人感觉部署维护比较麻烦

gogs基于go语言开发，轻量级，部署简单

### 二进制包安装
(1)下载
```
# su - git
$ wget -c https://cdn.gogs.io/gogs_v0.9.71_linux_386.tar.gz
$ tar xf gogs_v0.9.71_linux_386.tar.gz
```

(2)初始化数据库
```
$ mysql -S /tmp/mysql.sock -uroot -p < scripts/mysql.sql
```
(3)创建gogs数据库账号
```
mysql> create user 'gogs'@'localhost' identified by 'gogs';
mysql> grant all privileges on gogs.* to 'gogs'@'localhost';
mysql> flush privilesgs;
mysql> exit;
```
(4)运行gogs,访问http://ip:3000完成初始化

(5)配置调整
参考gogs官网

(6)配置服务启动脚本
```
# cp /home/git/gogs/scripts/init/centos/gogs /etc/init.d/gogs
# chmod +x /etc/init.d/gogs
# /etc/init.d/gogs start
目前最新版本v0.9.97支持web在线编辑，需要使用git2+版本，centos自带git1.7或1.8
建议安装git 2+版本后， 修改/etc/init.d/gogs，在. /etc/init.d/functions下一行添加export PATH=/usr/local/git/bin:$PATH
否则将无法还使用web在线编辑功能
```

(7)页面定制
```
小图标路径gogs/public/img/favicon.png
首页大图路径gogs/public/img/gogs-lg.png

首页
gogs/templates/home.tmpl修改为
{{template "base/head" .}}
<div class="home">
        <meta http-equiv="refresh" content="3;url=/user/login">
        <div class="ui stackable middle very relaxed page grid">
                <div class="sixteen wide center aligned centered column">
                        <div>
                                <img class="logo" src="{{AppSubUrl}}/img/favicon.png" />
                        </div>
                        <div class="hero">
                                <h1 class="ui icon header title">
                                        Efun Code Git Service
                                </h1>
                                <h2>{{.i18n.Tr "app_desc"}}</h2>
                        </div>
                </div>
        </div>
</div>
{{template "base/footer" .}}

修改页脚
gogs/templates/base/footer.tmpl
把<a target="_blank" href="http://gogs.io">{{.i18n.Tr "website"}}</a>
改为Efun运维开发
```

(8)使用nginx反向代理
```
server {
    listen 443 ssl;
    server_name domain_name;

    ssl on;
    ssl_certificate /home/efun/ssl/efun.cer;
    ssl_certificate_key /home/efun/ssl/efun.key;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-RC4-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES256-SHA:DHERSA-AES128-SHA:RC4-SHA:!aNULL:!eNULL:!EXPORT:!DES:!3DES:!MD5:!DSS:!PKS;
    ssl_session_timeout 5m;

    client_max_body_size    10240m;

    access_log logs/gogs.access.log main;


    location / {
        proxy_pass            http://127.0.0.1:3000/;
        proxy_redirect        off;
        proxy_set_header      Host             $host;
        proxy_set_header      X-Forwarded-For  $proxy_add_x_forwarded_for;
        proxy_set_header      X-Real-IP        $remote_addr;
        proxy_connect_timeout 10;
        proxy_read_timeout    30;
        proxy_send_timeout    60;
        proxy_next_upstream   http_502 http_504 error timeout invalid_header;
        fastcgi_param PATH_INFO $uri;
        fastcgi_param REMOTE_USER $remote_user;
    }
}

记得修改gogs配置文件ROOT_URL = https://gogs.efun.com/
```

### 源码安装gogs(不推荐)
#### 1. 安装go语言环境
#### 下载
```
# su - git
$ wget -c https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz
$ mkdir local
$ tar xf go1.7.linux-amd64.tar.gz -C local/
```

#### 设置环境变量
```
$ echo 'export GOROOT=$HOME/local/go' >> $HOME/.bashrc
$ echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
$ echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/.bashrc
$ source $HOME/.bashrc
```

#### 验证
```
$ go version
go version go1.7 linux/amd64
```

#### 2. 构建develop分支版本
```
$ echo $GOPATH
/home/git/go
$ mkdir -p $GOPATH/src/github.com/gogits
$ cd $GOPATH/src/github.com/gogits
$ git clone --depth=1 -b develop https://github.com/gogits/gogs
Cloning into 'gogs'...
remote: Counting objects: 2108, done.
remote: Compressing objects: 100% (1958/1958), done.
remote: Total 2108 (delta 107), reused 1785 (delta 69), pack-reused 0
Receiving objects: 100% (2108/2108), 8.00 MiB | 561.00 KiB/s, done.
Resolving deltas: 100% (107/107), done.

$ go get -u ./...
$ go build
```

以上两步没报错就说明构建完成，接下来测试

#### 3. 测试
```
$ ./gogs web
2016/08/31 03:13:58 [W] Custom config '/home/git/go/src/github.com/gogits/gogs/custom/conf/app.ini' not found, ignore this if you're running first time
2016/08/31 03:13:58 [T] Custom path: /home/git/go/src/github.com/gogits/gogs/custom
2016/08/31 03:13:58 [T] Log path: /home/git/go/src/github.com/gogits/gogs/log
2016/08/31 03:13:58 [I] Gogs: Go Git Service 0.9.96.0830
2016/08/31 03:13:58 [I] Log Mode: Console(Trace)
2016/08/31 03:13:58 [I] Cache Service Enabled
2016/08/31 03:13:58 [I] Session Service Enabled
2016/08/31 03:13:58 [I] Run Mode: Development
2016/08/31 03:13:58 [I] Listen: http://0.0.0.0:3000
```
如果没有任何错误信息，则可使用ctrl+c中止运行

#### 4. 打包
```
$ cd $GOPATH/src/github.com/gogits
$ tar czf gogs.tar.gz gogs/{gogs,LICENSE,public,README.md,README_ZH.md,scripts,templates}
```

#### 5. 部署
与二进制包一样部署即可


### gogs升级
gogs升级非常简单

首先把gogs停掉再备份
```
# /etc/init.d/gogs stop
$ mv gogs gogs_$VERSION
```
根据系统和类型获取相应的二进制版本
```
$ wget https://dl.gogs.io/gogs_v$VERSION_$OS_$ARCH.tar.gz
$ tar -zxvf gogs_v$VERSION_$OS_$ARCH.tar.gz
$ cp -R gogs_$VERSION/{custom,data,log} gogs

如果你曾经做过页面的定制，记得也把文件原还一下
```
切回root, 启动gogs
```
/etc/init.d/gogs
```
