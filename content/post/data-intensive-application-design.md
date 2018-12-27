---
title: "数据密集型应用设计"
date: 2017-12-12T11:24:00+08:00
lastmod: 2018-12-27T18:27:00+08:00
draft: false
tags: ["design", "data-intensive"]
categories: ["Application"]
---



# 一）数据系统基础

## 1. 入门
![数据系统架构](/images/attachment/590399-d769403916aceb26.png)

### 可靠性
  * 硬件故障
  * 软件错误
  * 人为错误

### 可扩展
  * 负载描述
  ![](/images/attachment/590399-0520751b62853366.png)
  * 性能描述
  * 应对负荷

### 可维护
  * 便于操作
  * 复杂性管理
  * 易于改变

## 2. 数据模型与查询语言

### 关系模型 vs 文档模型
### 数据查询语言
### 图表数据模型

## 3. 存储与检索

### 数据结构
### 事务处理或分析
### 面向列的存储

## 4. 数据序列化
### 编码格式
### 数据流模式

# 二）分布式数据系统

## 5. 复制
### 主从
### 复制延迟问题
![](/images/attachment/590399-043b2e293afda334.png)
### 多主复制
![](/images/attachment/590399-6052fb868a76c9d4.png)
### 无主复制

## 6. 分区/分片

### 键值分区
### 分区与二级索引
### 调整分区
### 请求路由
![](/images/attachment/590399-e5d6fc0d2f38a447.png)


## 7. 事务
### 概念
![](/images/attachment/590399-4736c5720dac13ad.png)
### 弱隔离级别
### 序列化


## 8. 分布式系统的故障
### 故障与局部故障
### 不稳定的网络
![](/images/attachment/590399-722d1badad0d28e9.png)

### 不稳定的时钟


## 9. 一致性
### 线性化
![](/images/attachment/590399-ecdd23cb1479608a.png)

![](/images/attachment/590399-b67b14b3e94457d7.png)
### 排序担保
### 分布式事务


# 三）构建异构系统

## 10. 批处理
### UNIX工具批处理
```
cat /var/log/nginx/access.log |      awk '{print $7}' |      sort             |      uniq -c          |      sort -r -n       |      head -n 5
```
### MapReduce与分布式文件系统
![](/images/attachment/590399-ca8245819cc97ea0.png)

## 11. 流处理
### 发送事件流
### 数据库与流


---

**References:**
- 《[Designing Data-Intensive Applications](https://www.amazon.com/Designing-Data-Intensive-Applications-Reliable-Maintainable-ebook/dp/B06XPJML5D/ref=la_B00Q43XKD6_1_1?s=books&ie=UTF8&qid=1513048991&sr=1-1)》
