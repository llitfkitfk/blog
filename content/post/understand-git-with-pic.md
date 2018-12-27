---
title: "图解Git相关工作流"
date: 2015-08-17T13:40:00+08:00
lastmod: 2017-12-12T11:40:00+08:00
draft: false
tags: ["git"]
categories: ["Git", "图解"]
---

## 集中式（svn） VS 分布式（git）版本控制系统

### 1. 集中式（svn）

![](/images/attachment/590399-ee67b9accb16656d.png)

### 2. 分布式（git）

![](/images/attachment/590399-53638353c03276c5.png)

## git文件状态生命周期

![](/images/attachment/590399-a269341d0d35eedc.png)

## patch评审过程

![](/images/attachment/590399-1e08ea1ff2da80d6.png)

## 克隆repository的链条创建

![](/images/attachment/590399-74efe6fef6e5443b.png)

## 推荐git工作流

![](/images/attachment/590399-8a38252efd54d36f.png)

## 团队成员间的工作流

![](/images/attachment/590399-34b09e711700cc34.png)

## 单分支开发流程线

![](/images/attachment/590399-f01245d955a5261f.png)

## 分支区分不同工作的开发流程线

![](/images/attachment/590399-d025918a7ad31904.png)

## 分支区分不同功能的开发流程线

![](/images/attachment/590399-6a8e77b4aadeed2d.png)

![](/images/attachment/590399-2bc8cee1b0736b82.png)

## 部署工作流

![](/images/attachment/590399-2ddb1d2a35e41f22.png)

## hotfix工作流

![](/images/attachment/590399-044d0ccd63ed8410.png)



## 功能性分支工作流

![](/images/attachment/590399-7f0af856c462091e.png)

## Git一些命令工作流

### > rebase

![](/images/attachment/590399-2d26a5fbd3b0d0ea.png)

### > merge

{{% center %}}

![](/images/attachment/590399-ee29412547eab0fa.png)

使用*fast-forward*
{{% /center %}}

{{% center %}}
![](/images/attachment/590399-325b51712fa599fb.png)

不使用*fast-forward*
{{% /center %}}

### > add & commit
![](/images/attachment/590399-83d18cd3d9bcf76d.png)

### > checkout

![](/images/attachment/590399-c2d4217d38f0cb9b.png)

### > 删除文件

![](/images/attachment/590399-c8128432f2030eed.png)

### > 撤销merge

![](/images/attachment/590399-b4cbdc150011dac2.png)

### > 撤销共享分支的merge

![](/images/attachment/590399-333092b4910eb9a1.png)

## 推荐git学习教程：

* [learnGitBranching](http://pcottle.github.io/learnGitBranching/)

---

**References:**
- 《[Git for Teams](https://www.amazon.com/Git-Teams-User-Centered-Efficient-Workflows/dp/1491911182/ref=sr_1_1?s=books&ie=UTF8&qid=1513049965&sr=1-1)》
* 《[Git Essentials](https://www.amazon.com/Git-Essentials-Ferdinando-Santacroce/dp/1785287907/ref=la_B0785YHD4K_1_1?s=books&ie=UTF8&qid=1513049998&sr=1-1)》