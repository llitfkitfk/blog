---
title: "Golang Tips"
date: 2018-01-23T11:04:00+08:00
lastmod: 2018-12-27T19:00:00+08:00
draft: false
tags: ["golang", "tips"]
categories: ["Golang"]
---

## Golang Programming 教学视频截图

### Bits

#### Bit 图解

![](/images/attachment/590399-861e8df6e5dd6ac9.png)

#### Bits 分组

![](/images/attachment/590399-a04c0d88dba17fc1.png)

#### Binary Number

![](/images/attachment/590399-355c1df9d0c54832.png)

#### Signed & Unsigned Bits

![](/images/attachment/590399-22b1c9611ff43e3c.png)

#### Signed vs Unsigned Bits

![](/images/attachment/590399-2d961e568781dcba.png)

#### Bits in Memory

![](/images/attachment/590399-f48c2f21109687fb.png)

#### Memory Address

![](/images/attachment/590399-c687987588f9a895.png)

#### Book vs Computer 信息存储

![](/images/attachment/590399-df114c86caabc1ba.png)

#### ASCII

![](/images/attachment/590399-5df23a999b31282f.png)

### Data Type

#### Data & Data Type

![](/images/attachment/590399-77d50b89b0430075.png)

#### Type 的使用

![](/images/attachment/590399-945ac399d8b39a8f.png)

#### Memory 设备

![](/images/attachment/590399-91433ae6a017edf5.png)

#### Data 读写

![](/images/attachment/590399-37fa51d21de17435.png)

#### Boolean 类型

![](/images/attachment/590399-c610a650d197d8b5.png)

#### Integer 类型

![](/images/attachment/590399-7c5a1ca06a4eb739.png)

#### String 类型

![](/images/attachment/590399-22fb04f404578549.png)

### Constant

#### Constant

![](/images/attachment/590399-f665ed98481b6852.png)

#### 显式 vs 隐式类型

![](/images/attachment/590399-6ff09a70dad765f4.png)

#### Constants & Variables

![](/images/attachment/590399-0f9c8c6adace26f8.png)

### Pointers

#### Pointer

![](/images/attachment/590399-fb18b4d17389e5f3.png)

#### Address (reference)

![](/images/attachment/590399-548053d77fb295bc.png)

#### dereference

![](/images/attachment/590399-52fbf6886188daa5.png)

### Slice

#### Slice

![](/images/attachment/590399-d2fa81d318f7f048.png)

#### append

![](/images/attachment/590399-af06770e994ae99d.png)

### Map

![](/images/attachment/590399-1abb34419b463225.png)

## Go Channel 操作状态及结果

| 操作 |     状态     |                          结果                           |
| :--: | :----------: | :-----------------------------------------------------: |
|  读  |     nil      |                          阻塞                           |
|  读  | 开启并不为空 |                       获得对应值                        |
|  读  |  开启并为空  |                          阻塞                           |
|  读  |     关闭     |                      默认值, false                      |
|  读  |   只能写入   |                        编译错误                         |
|      |              |                                                         |
|  写  |     nil      |                          阻塞                           |
|  写  |  开启并塞满  |                          阻塞                           |
|  写  | 开启并未塞满 |                       写入对应值                        |
|  写  |     关闭     |                          panic                          |
|  写  |   只能接收   |                        编译错误                         |
|      |              |                                                         |
| 关闭 |     nil      |                          panic                          |
| 关闭 | 开启并不为空 | 关闭; 读取对应值直到 channel 为空, 之后读取时输出默认值 |
| 关闭 |  开启并为空  |                 关闭; 读取时输出默认值                  |
| 关闭 |     关闭     |                          panic                          |
| 关闭 |   只能接收   |                        编译错误                         |

## 理解 goroutine

【编者的话】虽然已经有很多解释 goroutine 的优秀文章，但是对于初学者来说，大多都比较晦涩难懂，在这里总结一下自己对 goroutine 的理解以及相关资料

### Goroutine

- [Goroutine vs Thread - 推荐视频](https://www.youtube.com/watch?v=dIpYZ6ijsrQ)
- [Understanding Channels - 推荐视频](https://www.youtube.com/watch?v=KBZlN0izeiY)

- Goroutines 既不是 OS 线程，也并非[Green 线程](https://en.wikipedia.org/wiki/Green_threads)

- Goroutines 是更高层次的[coroutines(协程)](https://en.wikipedia.org/wiki/Coroutine)抽象

- Goroutine 是并发的子程序（函数、闭包、方法），它们是 nonpreemptive（非抢占式的） - 不能被中断。相反，协程有多个可允许中断或重入的点。

- Go 运行时观察 Goroutines 的状态，当阻塞时自动暂停它们，当它们非阻塞后又重新开启。这样 Goroutine 就是[抢占式](<https://en.wikipedia.org/wiki/Preemption_(computing)>)的协程，而且只有当它们阻塞时。

- 运行 goroutines 的机制是由 M:N 调度器实现的，该调度器将 M 个 green 线程映射到 N 个 OS 线上，然后将 Goroutines 调度到 green 线程上。

- 当 goroutines 多于可用的 green 线程，调度器将在可用的线程中处理 goroutines 的分布确保当某些 goroutines 阻塞时，其他的 goroutines 依然可以执行。

### Work Stealing

- [Work Stealing](https://en.wikipedia.org/wiki/Work_stealing)
- [fair scheduling](https://en.wikipedia.org/wiki/Fair-share_scheduling)
  n 个处理器， x 个任务：每个处理器分配 x/n 个任务

### Scheduler

- G go 协程
- M OS 线程（源代码中表示 machine）
- P context（源代码中表示 processor）

![](/images/attachment/590399-bc16e18552c27d6b.png)

- GOMAXPROCS 控制着有多少 context 被用于运行时

### <待续>

## Issues

### golang 应用使用 alpine 打包 Issue 总结:

[Alpine linux doesn't have nsswitch configuration file #367](https://github.com/gliderlabs/docker-alpine/issues/367)

### golang http 默认请求 需要手动关闭

https://stackoverflow.com/a/41512208
`It is the caller's responsibility to close Body.`

## coding 建议

1. error 处理: 要么输出 log, 要么 return, 不要同时处理
2. 用接口定义行为,不要用 data 或者 data 结构来定义
3. 使用 io.Reader 和 io.Writer 接口,使你的 Go 代码更具可扩展性
4. 确保传入的 function 的指针参数在需要时, 其他情况只需传入值
5. Error 不是 string, 他们是 error
6. 不要在 production 测试你的 Go 代码
7. 不熟悉的 Go 语言的某些功能, 最好先测试一下,尤其是要开发一个应用或者大量用户会使用的工具
8. 不要害怕出错, 尽可能多的尝试

## 机器学习

### 1. 数据组织 (数据收集/组织/解析)

- CSV 数据处理
  [encoding/csv](https://golang.org/pkg/encoding/csv/)
  [gota/dataframe](https://godoc.org/github.com/kniren/gota/dataframe)

- JSON 数据处理
  [encoding/json](https://golang.org/pkg/encoding/json/)
  [Go Walkthrough: encoding/json package](https://medium.com/go-walkthrough/go-walkthrough-encoding-json-package-9681d1d37a8f)

- 缓存
  [go-cache](https://godoc.org/github.com/patrickmn/go-cache)
  [boltdb](https://godoc.org/github.com/boltdb/bolt)

- 数据 VCS
  [Pachyderm](http://docs.pachyderm.io/en/latest/)

### 2. 数据矩阵

- Vectors

### <待续>

## 易错点

* `defer` 遵循`LIFO`(后进先出)原则
https://play.golang.org/p/kIqLpGJRjgi

* `defer` 内有函数时,先计算再执行
https://play.golang.org/p/9T7lgXqxdyJ

* `for range` 时 `&value`不变
https://play.golang.org/p/lNma7BEAzsw

* 组合 vs 继承 https://play.golang.org/p/8eJR4uFUS67



---

**References:**

- [Golang Programming](https://www.youtube.com/playlist?list=PL0aDKsruoiW3DkO4l_cBi-g0iSS7ZD5H_)
- [Concurrency in Go: Tools and Techniques for Developers 1st Edition](https://www.amazon.com/Concurrency-Go-Tools-Techniques-Developers/dp/1491941197/ref=la_B07567T8NX_1_1?s=books&ie=UTF8&qid=1517276752&sr=1-1)
- [c08s10 - Goroutine vs Thread (golang)](https://youtu.be/dIpYZ6ijsrQ)
- [GopherCon 2017: Kavya Joshi - Understanding Channels](https://youtu.be/KBZlN0izeiY)
- [Concurrency in Go: Tools and Techniques for Developers 1st Edition](https://www.amazon.com/Concurrency-Go-Tools-Techniques-Developers/dp/1491941197/ref=la_B07567T8NX_1_1?s=books&ie=UTF8&qid=1517276752&sr=1-1)
- [Coroutines](https://en.wikipedia.org/wiki/Coroutine)
- [Green threads](https://en.wikipedia.org/wiki/Green_threads)
- [Go 线程调度器](http://www.chenquan.me/archives/258)
