---
title: "高效的Android线程"
date: 2017-12-27T21:55:00+08:00
lastmod: 2018-12-27T18:34:00+08:00
draft: false
tags: ["android", "thread"]
categories: ["Android"]
---

## 1. Android组件
![](/images/attachment/590399-e2e5547a528b07e8.png)

  * **Application**
  * **Core Java**
  * **Application framework**: Android classes
  * **Native Lib**: C/C++ libs
  * **Runtime**: Dalvik / ART (Android Runtime)
  * **Linux kernel**: Underlying OS

### Activity
![](/images/attachment/590399-ee55be0af1b7ac4e.png)
### Service
  * Started Service
  * Bound Service
### ContentProvider
### BroadcastReceiver

### Linux进程
![](/images/attachment/590399-a92cd13681ea960e.png)

### 生命周期
![](/images/attachment/590399-db2b3bfe6f4d9ab5.png)

## 2. Java多线程

### 基础
![](/images/attachment/590399-142b969318d4d0a7.png)

### 内部锁与Java监视器

![](/images/attachment/590399-7dcbb1489de45149.png)
  * Blocked
  * Executing
  * Waiting

## 3. Android多线程应用

### Android线程
  * UI线程
  * Binder线程
  * Background线程

### Linux进程与线程
  * **UID**: User ID 
  * **PID**: Process identifier
  * **PPID**: Parent process identifier (For Android: Zygote)
  * **Stack**: 本地指针与变量
  * **Heap**: 进程地址空间

### 调度

  * Priority

  ```
  Process.setThreadPriority(int priority); // 当前线程. 
  Process.setThreadPriority(int     threadId, int priority); // 指定线程id
  ```

  * Control group
  ![](/images/attachment/590399-eac23ecdd4c19e6a.png)
  - Background Group总共有不能多于 ~5 - 10%的执行时间  

## 线程通信

### 管道  [demo](https://github.com/gitLibs/eatbookexamples/blob/master/EatApplication/Eat/src/main/java/com/eat/chapter4/PipeExampleActivity.java)

![](/images/attachment/590399-feeab00b65a743ba.png)

### 共享内存
![](/images/attachment/590399-9ad4cc5a8263eba5.png)

### 队列
![](/images/attachment/590399-aa6552911e1b8a26.png)

### Android Message
![](/images/attachment/590399-659ec6a3dcd10c97.png)

* **android.os.Looper**: 消息分配器与一个且唯一一个消费线程关联
* **android.os.Handler**: 将消息插入队列，Looper有许多handlers，但是他们都将消息插入同一队列
* **android.os.MessageQueue**: 不受限制的消息链表每个Looper最多一个链表
* **android.os.Message**: 在消费线程执行

![](/images/attachment/590399-16ebf8063ceb18ab.png)
![](/images/attachment/590399-bd42b7fba2ff8391.png)
![](/images/attachment/590399-88ec3d32bd6be411.png)
![](/images/attachment/590399-4d5f108f19a01f38.png)


![](/images/attachment/590399-462607687d9a2bd9.png)
![](/images/attachment/590399-4e052d3483e930fb.png)

## 进程通信

### Android RPC
![](/images/attachment/590399-a018fd9eba794ef2.png)

### AIDL
![](/images/attachment/590399-db2173d1f7222c4b.png)

![](/images/attachment/590399-e576e75cf10b1fd6.png)

### Messenger
![](/images/attachment/590399-8df7e3418c404544.png)

## 内存管理
![](/images/attachment/590399-85d72df41bef83f7.png)
![](/images/attachment/590399-ee20a5b7fa617212.png)
![](/images/attachment/590399-25d20a00e659e8a8.png)
![](/images/attachment/590399-c193adb5db94c0c6.png)
![](/images/attachment/590399-9b86e0fef5d7fcd9.png)
![](/images/attachment/590399-a9bbed9d48082d2e.png)
![](/images/attachment/590399-faa61f381560f6eb.png)
![](/images/attachment/590399-1ba6cea898e1e4c7.png)
![](/images/attachment/590399-06404ce9c1ab6941.png)
![](/images/attachment/590399-bd8a1bf85d515409.png)

## 线程生命周期
![](/images/attachment/590399-78fd3b5c9bd3247c.png)

## 线程池生命周期
![](/images/attachment/590399-96e7e6dd405204d7.png)
![](/images/attachment/590399-e7b0194e697eb119.png)
![](/images/attachment/590399-51f78a5351cf1c6f.png)

## AsyncTask
![](/images/attachment/590399-95503fbb67c0cf1f.png)
![](/images/attachment/590399-0f288f3de10ccd47.png)
![](/images/attachment/590399-d1300289b9cb6c2f.png)

## Services
![](/images/attachment/590399-71b27160279be272.png)
![](/images/attachment/590399-06bed1e408767975.png)
![](/images/attachment/590399-e19b444fa4bf15cb.png)

## AsyncQueryHandler
![](/images/attachment/590399-95885ad405851336.png)

## Loader框架
![](/images/attachment/590399-3b6355966fcac7d2.png)
![](/images/attachment/590399-06ee3270f2555f57.png)
![](/images/attachment/590399-cd5cd5f5e1582644.png)

## Android异步机制
![](/images/attachment/590399-1d75b6f7dc788fa7.png)

---

**References:**

*   《[Efficient Android Threading: Asynchronous Processing Techniques for Android Applications](https://www.amazon.com/Efficient-Android-Threading-Asynchronous-Applications/dp/1449364136/ref=la_B00KP8TPDA_1_1?s=books&ie=UTF8&qid=1514382839&sr=1-1)》