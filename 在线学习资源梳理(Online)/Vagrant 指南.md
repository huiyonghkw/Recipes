# Vagrant 指南

---

```json
Vagrant 是一款用来构建虚拟开发环境的工具，非常适合 php/python/ruby/java 这类语言开发 web 应用，“代码在我机子上运行没有问题”这种说辞将成为历史。
```

1. [使用 Vagrant 打造跨平台开发环境](http://segmentfault.com/a/1190000000264347)
2. [vagrant 简明使用方法](http://my.oschina.net/guanyue/blog/390287)
3. [Vagrant简介和安装配置](http://rmingwang.com/vagrant-commands-and-config.html)
4. [用 Vagrant 管理虚拟机](http://ninghao.net/blog/2077)


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
