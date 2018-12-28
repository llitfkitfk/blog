---
title: "图解MySQL集群"
date: 2018-12-11T12:09:00+08:00
lastmod: 2018-12-28T10:31:00+08:00
draft: false
tags: ["mysql"]
categories: ["MySQL", "图解"]
---

### MySQL主从复制工作流程
![](/images/attachment/590399-25536d177707e860.png)

### MySQL主从复制
![](/images/attachment/590399-92a30bd644532a12.png)

### MySQL主主复制
![](/images/attachment/590399-a5de4691eed99b7a.png)

### MySQL主主复制(带多个从)
![](/images/attachment/590399-ffcf5afbbbfc6410.png)

### MySQL主主复制(带继从)
![](/images/attachment/590399-98fc5fd6cbafabfd.png)

### MySQL主主循环复制
![](/images/attachment/590399-ac163a432ac91c70.png)


Galera集群特性(2012年): http://galeracluster.com/

* 只支持InnoDB的复制
* 不支持`LOCK`/`UNLOCK`声明以及`GET_LOCK()`/`RELEASE_LOCK()`函数
* 不支持使用`log_output`输出日志到数据表, 日志必须输出到`FILE`
* 目前不支持`XA(Extended Architecture)`事务

### MySQL扇入复制
![](/images/attachment/590399-ac50c5cae9096bf7.png)


Amazon RDS for MySQL https://aws.amazon.com/rds/mysql/

Google Cloud SQL https://cloud.google.com/sql/
