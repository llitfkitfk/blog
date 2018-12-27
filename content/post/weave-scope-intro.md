---
title: "Weave Scope - Docker和Kubernetes的故障诊断与检测工具"
date: 2017-11-08T18:09:00+08:00
lastmod: 2018-12-27T17:57:00+08:00
draft: false
tags: ["weave", "docker", "kubernetes"]
categories: ["Weave Scope"]
---

Weave Scope 自动生成应用程序的映射，使你能够直观地了解、监控并公职你的微服务容器应用。

### 实时了解Docker容器状态
![](http://upload-images.jianshu.io/upload_images/590399-4290235bf060e157.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

查看容器基础设施的概况，或者专注于一个特殊的微服务。从而轻松发现并纠正问题，确保你的容器化应用的稳定与性能。

### 内部细节与深度链接

![](http://upload-images.jianshu.io/upload_images/590399-131428caa611e11b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

查看容器的指标、标签和元数据。
在一个可扩展、可排序的列表内，从容器内的进程到容器运行的主机之间轻松切换。
对于指定的主机或者服务，很容易找高负载（CPU或内存）的容器。

### 容器的交互与管理

![](http://upload-images.jianshu.io/upload_images/590399-a2daaf7e1298ecdb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

直接与容器交互：暂停、重启或者停止容器，以及启动命令行。这些都在Scope的浏览器内进行。

### 插件的扩展与定制

通过创建Scope插件可以在你的主机及容器上添加定制或交互；或者选择Github上已完善的[Weaveworks Scope插件](https://github.com/weaveworks-plugins/)

## 入门

```
sudo curl -L git.io/scope -o /usr/local/bin/scope
sudo chmod a+x /usr/local/bin/scope
scope launch

```
下载该脚本并执行，它会从Docker Hub下载Scope镜像。
现在，在浏览器内打开 **[http://localhost:4040](http://localhost:4040/)**。(如果你使用的是boot2docker，将localhost替换为 `boot2docker ip` 的输出)

在 [Kubernetes](https://www.weave.works/docs/scope/latest/installing/#k8s)、[DCOS](https://www.weave.works/docs/scope/latest/installing/#dcos) 或者 [ECS](https://www.weave.works/docs/scope/latest/installing/#ecs)安装Scope，请查阅 [安装文档](https://www.weave.works/docs/scope/latest/introducing/).

## 获取帮助

如果对Scope有任何问题或者反馈：

* 查阅[Weave Scope文档](https://www.weave.works/docs/scope/latest/introducing/)。
* 加入[#weave-community](https://weaveworks.github.io/community-slack/) slack频道。
* 在[#weave-community](https://weave-community.slack.com/messages/general/) slack频道提交问题。
* 加入[Weave用户组](https://www.meetup.com/pro/Weave/) 在线探讨、操作培训以及参与聚会。
* 发送email到[](mailto:weave-users@weave.works)[weave-users@weave.works](mailto:weave-users@weave.works)
*   [提交issue](https://github.com/weaveworks/scope/issues/new)

欢迎您的反馈！
