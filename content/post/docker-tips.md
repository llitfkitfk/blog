---
title: "Docker Tips"
date: 2018-01-02T12:33:00+08:00
lastmod: 2018-12-27T18:42:00+08:00
draft: false
tags: ["docker", "tips"]
categories: ["Docker"]
---

## Docker交流群组

[Telegram Docker群组](https://t.me/dockertutorial)

## YouTube Link

[Docker Storage: Designing a Platform for Persistent Data](https://embed.vidyard.com/share/k4bboQRbr3V28GQqgiWBEP)

[Question: How do you deal with big companies that they can do it all?Speaker: #Solomon_Hykes](https://youtu.be/raOCEErZHQ0?t=2643)

[Understand Kubernetes](https://www.youtube.com/playlist?list=PL7bmigfV0EqQw4WnD0wF-SRBYttCFeBbF)

[Kubernetes Deconstructed: Understanding Kubernetes by Breaking It Down](https://youtu.be/90kZRyPcRZw)

## Container Messaging

### First-In, First-Out (FIFO)

#### Message queue
![](http://upload-images.jianshu.io/upload_images/590399-ee2a3535e668cd90.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### Message processing by containers
![](http://upload-images.jianshu.io/upload_images/590399-98524da6481541fb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### Container1 failed, message put on top of message queue
![](http://upload-images.jianshu.io/upload_images/590399-05577875fff03192.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### After message B completed, message A processing by container2 
![](http://upload-images.jianshu.io/upload_images/590399-5f241266fbfbde1d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Messaging System

* [Apache Kafka](https://kafka.apache.org/)
  
    ![](http://upload-images.jianshu.io/upload_images/590399-e8a9edd982f0d399.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* [RabbitMQ](https://www.rabbitmq.com/)
    
    ![](http://upload-images.jianshu.io/upload_images/590399-0cb1fa5cbeff031a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* [Redis-custom](https://redis.io/): [bull](https://www.npmjs.com/package/bull)


## privileged mode


* `--privileged` Give extended privileges to this container

```
$ docker run -it --rm  ubuntu:14.04 ip link add dummy0 type dummy
RTNETLINK answers: Operation not permitted
$  docker run -it --rm  --privileged ubuntu:14.04 ip link add dummy0 type dummy
success!
```

###  --cap-add & --cap-drop

* `--cap-drop` Drop Linux capabilities
* `--cap-add` Add Linux capabilities
* [capabilities list](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities)

```
$  docker run -it --rm ubuntu:14.04 ip link add dummy0 type dummy
RTNETLINK answers: Operation not permitted
$ docker run --rm -ti --cap-drop ALL --cap-add NET_ADMIN ubuntu:14.04 ip link add dummy0 type dummy
success!
```
## --init (孤儿进程回收)

### `PID 1`的问题

* 容器内没有host的init进程来回收孤儿进程。
* 当一个父进程开启一个子进程，但是在某个时间，当父进程退出或者被杀掉后，在该容器内由于没有父进程以及其他回收孤儿进程的进程，该子进程会成为一个僵尸进程。
* 由于容器内进程都在同一个命名空间，如果容器退出了，该僵尸进程也会被清除。

```
$ docker run -ti ubuntu bash -c 'sleep 50'
^C^C^C^C^C^C^C^C^C
<Ctrl-C not working>
```

### 孤儿进程回收

* 如果想在容器内运行多个进程，容器的起始进程必须回收孤儿进程(orphan reaping)

```
$ docker run -ti --init ubuntu bash -c 'sleep 50'
^C <Ctrl-C worked just fine>
```

### 其他选择

* `--init`
* shell: bash
* [supervisord](http://supervisord.org/)

### 推荐阅读

- [理解Linux进程](https://www.kancloud.cn/kancloud/understanding-linux-processes/52173)

## Attach docker-for-mac tty

Attach to docker for mac tty:
```
screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
```


## Quick Install

### Docker
```
curl -fsSL get.docker.com | CHANNEL=stable  sh
```

### Start Docker

```
systemctl enable docker
systemctl start docker
```

### Docker Compose

```
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
```

### Docker App

```
# linux
wget https://github.com/docker/app/releases/download/v0.2.0/docker-app-linux.tar.gz
tar xf docker-app-linux.tar.gz
cp docker-app-linux /usr/local/bin/docker-app

# macOS
wget https://github.com/docker/app/releases/download/v0.2.0/docker-app-darwin.tar.gz
tar xf docker-app-darwin.tar.gz
cp docker-app-darwin /usr/local/bin/docker-app
```

## modify docker lib dir

```
docker ps -q | xargs docker kill
stop docker
cd /var/lib/docker/devicemapper/mnt
umount ./*
mv /var/lib/docker $dest
ln -s $dest /var/lib/docker
start docker
```

## remove <none> image

```
docker image ls | grep '<none>' | awk '{print $3}' | xargs docker rmi
```

## Bugfix

docker daemon卡住的一些解决方法

```
# 查看docker daemon日志
 journalctl -f -u docker
```

```
systemctl reset-failed docker
```
```
systemctl stop docker
```
```
systemctl restart docker
```
```
rm -rf /var/run/docker.pid
systemctl restart docker
```

---

**References:**

- [Deployment with Docker](https://www.amazon.com/Deployment-Docker-continuous-integration-applications/dp/1786469006/ref=sr_1_1?s=books&ie=UTF8&qid=1514870689&sr=1-1)
- [Understanding When to use RabbitMQ or Apache Kafka](https://content.pivotal.io/blog/understanding-when-to-use-rabbitmq-or-apache-kafka)
- [Runtime privilege and Linux capabilities](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities)
- [Principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege)
- [capabilities](http://man7.org/linux/man-pages/man7/capabilities.7.html)
- [快速理解孤儿进程和僵尸进程](http://www.cnblogs.com/idorax/p/6279664.html)
