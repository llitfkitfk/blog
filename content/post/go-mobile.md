---
title: "使用Go语言开发Android&IOS应用"
date: 2015-09-11T15:00:00+08:00
lastmod: 2018-12-27T15:39:00+08:00
draft: false
tags: ["golang", "Android", "Ios", "App"]
categories: ["golang", "Android", "Ios"]
---


~~TL:DR~~

### 1.  下载安装Go语言（版本1.5+）

[Golang链接](https://www.golang.org/)

### 2. 下载安装 gomobile
  * 下载
  `$ go get golang.org/x/mobile/cmd/gomobile`
  
  * 安装（需要等待几分钟）
  `gomobile init`

### 3. Golang开发手机应用有两种方式
  
#### a. 原生应用开发
  
`$ go get -d golang.org/x/mobile/example/basic`

* 主要应用领域：
    * *应用控制管理与配置*
    * *OpenGL ES 2 绑定*
    * *Asset 管理*
    * *Event 管理*
    * *试验中的包，含有OpenAL 绑定、音频、字体、图形以及运动传感器*

* Android开发
    * `$ gomobile build -target=android golang.org/x/mobile/example/basic`      
        *此命令会生成名为basic的apk安装包*
    * `$ gomobile install golang.org/x/mobile/example/basic`
        *此命令将安装apk包到已连接的android设备*
    
* IOS开发
    * `$ gomobile build -target=ios golang.org/x/mobile/example/basic`
        *此命令会生成名为basic的app安装包*
  
    * 下载IOS安装包命令行工具 - [ios-deploy](https://github.com/phonegap/ios-deploy)
    `$ ios-deploy -b basic.app`
      *此命令将安装app文件到已开启的IOS模拟器或者已连接的IOS设备*

#### b. 混合绑定开发

`$ go get -d golang.org/x/mobile/example/bind/...`

* 优势
    * *Go code复用*
    * *在Android和IOS开发中共享通用的Go代码通过调用绑定的Golang包名*
* 限制
    * *当前仅支持的[一些Go类型](https://godoc.org/golang.org/x/mobile/cmd/gobind)*
    * *语言之间的绑定会有性能开销*  

##### Android开发

* 开启Android studio，导入Project，选择路径`$GOPATH/src/golang.org/x/mobile/example/bind/android`
![](/images/attachment/590399-8b525b62a7525b9b.png)
      
* 修改配置文件`hello/build.gradle`
![](/images/attachment/590399-978f80b85d96ba06.png)

* 最后 Build & Run <完>
    
* ~~备用选项：~~
    
    ~~`$ gomobile bind -target=android golang.org/x/mobile/example/bind/hello`~~

    ~~*此命令会在`hello/`路径下生成aar文件*，用户可以直接在Android Studio内导入~~

##### IOS开发

`$ cd $GOPATH/src/golang.org/x/mobile/example/bind
$ gomobile bind -target=ios golang.org/x/mobile/example/bind/hello`

*此命令在`ios/`路径下生成`bind.xcodeproj`xcode项目以及 在`bind/`目录下生成一个 `hello.framework`*


* 打开xcode项目
`$ open ios/bind.xcodeproj`
![](/images/attachment/590399-38dca62cd4efb927.png)

* 拖拽`hello.framework`文件到xcode项目内
![](/images/attachment/590399-ecd13d0777599fbf.png)

* 最后 Build & Run <完>
    ![](/images/attachment/590399-c8484b110943783f.png)


---

------ 2018-05-09 更新 ------

android studio 3.0+ 支持有问题 [链接](https://github.com/golang/go/issues/23307)

请手动构建生成aar文件, 然后加入app

![](/images/attachment/590399-672bab2456d8da29.png)

---