阿里云RDS 数据库恢复工具Percona XtraBackup 实战心得
===

[到这里查看完整信息](https://app.yinxiang.com/shard/s5/nl/5189159/75fab3c9-de81-4012-bc3c-27ba2c792653/)

@(车护宝)


> 随着业务变化与时间的推移，我们租用在阿里云的RDS数据也不断增长。阿里云提供了非常稳定而高效的数据备份机制（备份一次仅仅耗时1s）。数据却是备份了，但是恢复却耗费了精力，今天专门针对阿里云官方提供的帮助文档 - [DS备份文件恢复到自建数据库](http://help.aliyun.com/knowledge_detail/5973700.html?spm=5176.788314901.3.1.cJEBu8)进行实际操作与研究，虽然结果是美好的，但是这中间的过程却坡坡坎坎、“委婉而曲折”。下面总结下自己实际的操作过程与心得，以为遇到类似问题的同伴提供一些有效的帮助。

##环境与工具

+ 操作系统： OS X 10.10.4
+ 服务器环境：CentOS 6.5
+ 终端工具：iTerm (Mac)
+ 数据压缩解压工具：rds_backup_extract （仅仅适用RDS）
+ 数据库恢复工具：Percona XtraBackup 2.2 Release 2.2.12
+ 本地数据库环境：Server version: 5.6.21-log MySQL Community Server (GPL)
+ 生产数据库环境：MySQL5.5


##操作过程

> 备份文件请按照文档中给出的流程操作

###1、下载RDS官方提供的压缩工具包rds_backup_extract

按照它提供的官方文档 [RDS备份文件恢复到自建数据库](http://help.aliyun.com/knowledge_detail/5973700.html?spm=5176.788314901.3.1.cJEBu8)，直接下载文中提到的地址即可：有个警告提示就是，不要在终端中直接wget该地址。我尝试了很久都没有能下载到本地。

###2、安装备份还原工具Percona XtraBackup 2.2

官方文档中提供的版本是2.2.9，不过我是用的最新版本2.2.12 (强迫症)。不要去搜索网上很多安装资料，如果中文的，英文的，baidu的, google的。直接在官方下载[Percona XtraBackup](https://www.percona.com/downloads/XtraBackup/LATEST/)安装，官方也提供了安装指南（https://www.percona.com/doc/percona-xtrabackup/2.2/installation/yum_repo.html）。我也搜索了很多安装信息，但是大多版本，系统环境不一致，所以小心坑。

###3、 根据帮助文档解压备份文件
文档中给出的命令是这个
```bash
sh rds_backup_extract -f /home/mysql/backup/hins575175_xtra_20150429091224.tar.gz -C /home/mysql/data
```
实际操作时，可能环境不同，操作的命令和方式不同。我实际操作的命令是

```bash
rds_backup_extract.sh -f /alidata/www/databases_backups/hins651261_xtra_20150814021723.tar.gz -C /alidata/www/databases_backups/20150814
```

###4、还原备份文件

心酸的要来了，文中提到的一个还原命令
```bash
innobackupex --defaults-file=/home/mysql/data/backup-my.cnf --apply-log /home/mysql/data
```
却让我摸不着头脑啊。我执行了命令，一直报错：
```bash

[vagrant@localhost ~]$ sudo innobackupex --defaults-file=/alidata/www/databases_backups/20150814/backup-my.cnf --apply-log /alidata/www/databases_backups/20150814/

InnoDB Backup Utility v1.5.1-xtrabackup; Copyright 2003, 2009 Innobase Oy
and Percona LLC and/or its affiliates 2009-2013.  All Rights Reserved.

This software is published under
the GNU GENERAL PUBLIC LICENSE Version 2, June 1991.

Get the latest version of Percona XtraBackup, documentation, and help resources:
http://www.percona.com/xb/p

150814 08:55:39  innobackupex: Starting the apply-log operation

IMPORTANT: Please check that the apply-log run completes successfully.
           At the end of a successful apply-log run innobackupex
           prints "completed OK!".

Warning: World-writable config file '/alidata/www/databases_backups/20150814/backup-my.cnf' is ignored
innobackupex: got a fatal error with the following stacktrace: at /usr/bin/innobackupex line 4545
	main::get_option('innodb_data_file_path') called at /usr/bin/innobackupex line 2631
	main::apply_log() called at /usr/bin/innobackupex line 1578
innobackupex: Error: no 'innodb_data_file_path' option in group 'mysqld' in server configuration file '/alidata/www/databases_backups/20150814/backup-my.cnf' at /usr/bin/innobackupex line 4545.
[vagrant@localhost ~]$
```

Google了很多资源，大多看不懂也不太明白，于是发了个[Segment问题:Percona XtraBackup 数据库备份工具使用问题](http://segmentfault.com/q/1010000003096058)，基本上是无人问津。

然后又继续搜索Percona工具的相关问题，整理了一些[有用的在Github中](https://github.com/Brave-Cheng/Materials/blob/master/%E5%9C%A8%E7%BA%BF%E5%AD%A6%E4%B9%A0%E8%B5%84%E6%BA%90%E6%A2%B3%E7%90%86%28Online%29/Mysql%E5%A4%87%E4%BB%BD.md)。

上面的问题还是一直缠绕着我，之前我也做过类似的操作，也遇到了这个问题。云里雾里的时候，我仔细对比了上面的一些资料，发现backup-my.conf有些端倪，有的文档中用的是mysql安装目录中的my.conf文件，![Alt text](./1439548648031.png)

对比这段内容后，我好像明白了点什么。其实原理就是图片的那句“2.2备份恢复”

```bash
innobackupex --defaults-file 这里应该是mysql的my.conf的路径 --copy-back 后面就是备份的路径
```

**这个推测与阿里云帮助文档中的命令确实有些差异咯**。我心想反正之前两此都不成功了，何不按照这样的理解是试试呢？在CentOS中查找mysql运行目录`ps -ef | grep mysql`；将mysql数据目录备份`mv data data_backup`；做了一些辅助工作后，带着试一试的想法开始实施。


按照我猜想的命令执行后，报了"...no datadir option ..."字样的错误。然后又搜素到了[这篇文章](http://blog.csdn.net/mchdba/article/details/12970991)。于是继续修改，将系统的my.conf文件进行修改，打开了datadir选项。最后执行，还原命令终于执行了。


###5、各类环境配置

 看到complete ok字样后，感觉终于对了样，实际却不然。`innobackupex`将文件还原后，需要进一步做配置（我的环境）：
+ mysql启动报错:`mysql Starting MySQL..The server quit without updating PID file`，可能会修改还原datadir配置，也可能需要给data目录分配权限（chmod & chown）
+ mysql连接本地不成功: 还原数据后，使用mysql root密码为空，试了很久，发现官方也是这么干的！
+ phpmyadmin/navicat等工具连接不上：这时需要设置mysql数据表的host字段为%（这里也有一些坑，比如多个root账号）。


最后，总结一下，当我们在遇到问题时，千万别因为它陌生，看不懂就抛开了。反而是我们要善于在过程中发现细节，总结归纳，有效试错，这样收获会更多！


### 参考资料整理

1. http://www.111cn.net/database/mysql/47258.htm
2. http://blog.csdn.net/mchdba/article/details/12970991
3. http://segmentfault.com/q/1010000003096058
4. https://github.com/Brave-Cheng/Materials/blob/master/%E5%9C%A8%E7%BA%BF%E5%AD%A6%E4%B9%A0%E8%B5%84%E6%BA%90%E6%A2%B3%E7%90%86(Online)/Mysql%E5%A4%87%E4%BB%BD.md
5. http://www.drupal001.com/2014/02/percona-xtrabackup-mysql/
6. http://ju.outofmemory.cn/entry/189507
