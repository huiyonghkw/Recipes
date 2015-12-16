# Vagrant 指南

---

```json
Vagrant 是一款用来构建虚拟开发环境的工具，非常适合 php/python/ruby/java 这类语言开发 web 应用，“代码在我机子上运行没有问题”这种说辞将成为历史。
```

##资源整理

1. [使用 Vagrant 打造跨平台开发环境](http://segmentfault.com/a/1190000000264347)
2. [vagrant 简明使用方法](http://my.oschina.net/guanyue/blog/390287)
3. [Vagrant简介和安装配置](http://rmingwang.com/vagrant-commands-and-config.html)
4. [用 Vagrant 管理虚拟机](http://ninghao.net/blog/2077)

##开发环境推荐配置

Github Stars & Avaliable resources

> 1. [NREL / vagrant-boxes](https://github.com/NREL/vagrant-boxes)
> 2. [lj2007331 / lnmp](https://github.com/lj2007331/lnmp)
> 3. [Vagrantbox.es](http://www.vagrantbox.es/)

Step

1. [Vagrant Base Box Downloads](http://nrel.github.io/vagrant-boxes/)
2. Add boxes
```json
 $ vagrant box add {title} {url}
 $ vagrant init {title}
 $ vagrant up
 //This is a demo
 $ vagrant box add weipei_develop_server https://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.7-x86_64-v20151108.box
 //may be use the demo
 $ vagrant box add weipei_develop_server packages.box
```

3. [PHP install tools](http://oneinstack.com/)








##问题集锦

[Fixed the bug on Mac](http://stackoverflow.com/questions/22717428/vagrant-error-failed-to-mount-folders-in-linux-guest)

```
Failed to mount folders in Linux guest. This is usually because
the "vboxsf" file system is not available. Please verify that
the guest additions are properly installed in the guest and
can work properly. The command attempted was:

mount -t vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` vagrant /vagrant
mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` vagrant /vagrant

The error output from the last command was:

/sbin/mount.vboxsf: mounting failed with the error: No such device

```


```

The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

ARPCHECK=no /sbin/ifup eth1 2> /dev/null

Stdout from the command:

Device eth1 does not seem to be present, delaying initialization.


Stderr from the command:
```
Fixed the bug
```
sudo rm -rf /etc/udev/rules.d/70-persistent-net.rules
```


##Vagrant 推荐配置Vagrantfle

```
config.vm.network "private_network", ip: "192.168.33.10"

config.vm.synced_folder "/Users/chenghuiyong/Applications/server", "/alidata/www",:mount_options => ["dmode=777","fmode=777"]

config.ssh.username = "vagrant"
config.ssh.password = "vagrant"
```
