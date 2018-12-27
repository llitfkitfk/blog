---
title: "Moby 简介"
date: 2017-04-20T14:59:00+08:00
lastmod: 2018-12-27T17:40:00+08:00
draft: false
tags: ["Moby", "docker"]
categories: ["Moby"]
---

【编者的话】Moby简介  [https://mobyproject.org/](https://mobyproject.org/)

### Moby

**Moby**是由Docker创建的一个开源框架，用于组装专门的容器系统，而无需重新设计轮子。它提供了几十个标准组件，并将它们组装成定制平台的框架。


![Paste_Image.png](http://upload-images.jianshu.io/upload_images/590399-7938fa3e7a81631a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 概述
**Moby**的核心是组装专门的容器系统的框架。它提供了：
- 容器系统所有重要方面的容器化组件库：操作系统，容器运行时，编排工具，基础架构管理，网络，存储，安全，构建，镜像分发等等。
- 为各种平台以及架构组装组件到可运行构件中的工具: 如裸机（x86和arm）、Linux，Mac和Windows的可执行文件 以及 很受欢迎的云服务和虚拟化提供商的VM镜像。
- 一组参考组件，可以直接使用、修改或作为创造自己组件的灵感。

所有Moby组件都是容器，因此创建新组件与构建一个新的OCI兼容的容器一样简单。

[更多信息](https://github.com/moby/moby/blob/moby/README.md)

### 原则
**Moby**是一个原则性很强的开源项目，但是对模块化、弹性化以及用户体验并没有太强烈的意见，因此向社区开放来来帮助确定方向。
以下是指导原则：
- 组件可切换：**Moby**包括足够的组件来构建功能齐全的容器系统，但其模块化架构确保大多数组件可以通过不同的实现来进行切换。
- 安全可用：**Moby**会提供默认的安全措施，但不会影响可用性。
- 以容器为中心：**Moby**用容器建造，用于运行容器。

使用**Moby**，您可以描述你的分布式应用程序的所有组件从高级配置文件到要你想要使用的内核，并轻松构建和部署。

**Moby**使用[containerd](https://github.com/containerd/containerd)作为默认的容器运行时。

### 受众

推荐使用**Moby**给那些想要组装基于容器系统的人，包括：
- 想要定制或修补Docker构建的骇客们
- 系统工程师或构建容器系统的集成商
- 希望将现有容器系统适应其环境的基础设施供应商
- 想要实验最新容器技术的容器爱好者
- 希望在各种不同系统中测试他们项目的开源开发者
- 对Docker内部以及它是如何建造的任何人

**Moby**不推荐用于：
- 寻找一种在容器中运行其程序的简单方式的应用程序开发人员。我们推荐 [**Docker CE**](https://www.docker.com/community-edition)。
- 寻找一个即用型商业上支持的容器平台的企业IT和开发团队。我们推荐 [**Docker EE**](https://www.docker.com/enterprise-edition)。
- 任何对容器好奇在寻找一种简单的学习方法的人。我们推荐 [**docker.com**](https://docs.docker.com/)。

### Moby入门
您可以通过运行[LinuxKit](https://github.com/linuxkit/linuxkit/tree/master/examples)中的一些示例程序来入门**Moby**。