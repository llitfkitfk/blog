---
title: "Containerd Server学习"
date: 2018-01-31T20:04:00+08:00
lastmod: 2018-12-28T10:38:00+08:00
draft: false
tags: ["docker", "containerd", "golang" ]
categories: ["Containerd"]
---


## Part 1

【编者的话】containerd v1.0.0的源码分析，以` docker-containerd --config /var/run/docker/containerd/containerd.toml`为入口，看大神们如何组织Go语言代码

[containerd.io](https://containerd.io/)
[github: containerd v1.0.0](https://github.com/containerd/containerd/tree/v1.0.0)

### 准备
```
go get -v github.com/containerd/containerd
cd $GOPATH/src/github.com/containerd/containerd
git checkout v1.0.0 -b v1.0.0
```
### 分析 

![](/images/attachment/590399-53d6993ce39e8d6c.png)

#### 命令行
* 位置：`cmd/containerd/main.go`
* 作用：定义containerd 命令行相关参数与配置文件
* 依赖：[github.com/urfave/cli](https://github.com/urfave/cli)

```
package main

import (
	"fmt"
	"os"

	"github.com/containerd/containerd/version"
	"github.com/urfave/cli"
)

const usage = `
                    __        _                     __
  _________  ____  / /_____ _(_)___  ___  _________/ /
 / ___/ __ \/ __ \/ __/ __ ` + "`" + `/ / __ \/ _ \/ ___/ __  /
/ /__/ /_/ / / / / /_/ /_/ / / / / /  __/ /  / /_/ /
\___/\____/_/ /_/\__/\__,_/_/_/ /_/\___/_/   \__,_/

high performance container runtime
`

func main() {
	app := cli.NewApp()
	app.Name = "containerd"
	app.Version = version.Version
	app.Usage = usage
	app.Flags = []cli.Flag{
		cli.StringFlag{
			Name:  "config,c",
			Usage: "path to the configuration file",
			Value: defaultConfigPath,
		},
	}
	app.Commands = []cli.Command{}
	app.Action = func(context *cli.Context) error {
		return nil
	}
	if err := app.Run(os.Args); err != nil {
		fmt.Fprintf(os.Stderr, "containerd: %s\n", err)
		os.Exit(1)
	}
}

```

#### 配置文件解析
* 位置：`server/config.go`
* 作用：解析配置文件相关参数
* 依赖：
  [github.com/BurntSushi/toml](https://github.com/BurntSushi/toml)
  [github.com/pkg/errors](https://github.com/pkg/errors)

```
// LoadConfig loads the containerd server config from the provided path
func LoadConfig(path string, v *Config) error {
	if v == nil {
		return errors.Wrapf(errdefs.ErrInvalidArgument, "argument v must not be nil")
	}
	md, err := toml.DecodeFile(path, v)
	if err != nil {
		return err
	}
	v.md = md
	return nil
}
```


#### 添加参数
* 位置：`cmd/containerd/main.go`
* 作用：应用参数到相关配置

```
func applyFlags(context *cli.Context, config *server.Config) error {
	// the order for config vs flag values is that flags will always override
	// the config values if they are set
	if err := setLevel(context, config); err != nil {
		return err
	}
	for _, v := range []struct {
		name string
		d    *string
	}{
		{
			name: "root",
			d:    &config.Root,
		},
		{
			name: "state",
			d:    &config.State,
		},
		{
			name: "address",
			d:    &config.GRPC.Address,
		},
	} {
		if s := context.GlobalString(v.name); s != "" {
			*v.d = s
		}
	}
	return nil
}
```
#### 日志
* 位置：`log/context.go`
* 作用：应用日志
* 依赖：  [github.com/sirupsen/logrus](https://github.com/sirupsen/logrus)

```
...
var ctx    = log.WithModule(gocontext.Background(), "containerd")
...
log.G(ctx).WithFields(logrus.Fields{
			"version":  version.Version,
			"revision": version.Revision,
		}).Info("starting containerd")
...

# log/context.go
func WithModule(ctx context.Context, module string) context.Context {
	parent := GetModulePath(ctx)
	if parent != "" {
		if path.Base(parent) == module {
			return ctx
		}
		module = path.Join(parent, module)
	}

	ctx = WithLogger(ctx, GetLogger(ctx).WithField("module", module))
	return context.WithValue(ctx, moduleKey{}, module)
}

```

### 整理

[https://github.com/llitfkitfk/containerd/tree/part-1](https://github.com/llitfkitfk/containerd/tree/part-1)


## Part 2

### 分析 

#### 程序信号处理
* 位置：`cmd/containerd/main.go`

```
...
var (
  signals = make(chan os.Signal, 2048)
  ctx     = log.WithModule(gocontext.Background(), "containerd")
)
done := handleSignals(ctx, signals, serverC)
...
signal.Notify(signals, handledSignals...)

...

<-done
...
```

#### 初始化服务
* 位置：`cmd/containerd/main.go`

```
...
server, err := server.New(ctx, config)
if err != nil {
	return err
}
...
```

#### 开启debug / metrics / grpc服务
* 位置：`cmd/containerd/main.go`
* 依赖：
  [github.com/docker/go-metrics](https://github.com/docker/go-metrics)
  [github.com/grpc-ecosystem/go-grpc-prometheus](https://github.com/grpc-ecosystem/go-grpc-prometheus)

```
...
if config.Debug.Address != "" {
	l, err := sys.GetLocalListener(config.Debug.Address, config.Debug.UID, config.Debug.GID)
	if err != nil {
		return errors.Wrapf(err, "failed to get listener for debug endpoint")
	}
	serve(log.WithModule(ctx, "debug"), l, server.ServeDebug)
}

if config.Metrics.Address != "" {
	l, err := net.Listen("tcp", config.Metrics.Address)
	if err != nil {
		return errors.Wrapf(err, "failed to get listener for metrics endpoint")
	}
	serve(log.WithModule(ctx, "metrics"), l, server.ServeMetrics)
}
l, err := sys.GetLocalListener(address, config.GRPC.UID, config.GRPC.GID)
if err != nil {
	return errors.Wrapf(err, "failed to get listener for main endpoint")
}
serve(log.WithModule(ctx, "grpc"), l, server.ServeGRPC)
...
```
![containerd架构](/images/attachment/590399-f8ada8bb077e355a.png)



### 初始化服务解析

#### 载入插件
* 位置：`server/server.go`
```
plugins, err := loadPlugins(config)
if err != nil {
  return nil, err
}
```

#### 初始化 grpc服务 和 传输服务
* 位置：`server/server.go`

```
type Server struct {
	rpc    *grpc.Server
	events *exchange.Exchange
}
```


#### grpc服务

* 位置：`server/server.go`
* 依赖：
  [google.golang.org/grpc](https://godoc.org/google.golang.org/grpc)
  [github.com/grpc-ecosystem/go-grpc-prometheus](https://github.com/grpc-ecosystem/go-grpc-prometheus)

```
rpc := grpc.NewServer(
	grpc.UnaryInterceptor(interceptor),
	grpc.StreamInterceptor(grpc_prometheus.StreamServerInterceptor),
)

```

#### 传输服务

* 位置：`events/exchange/exchange.go`
* 作用：负责传播事件
* 依赖：[github.com/docker/go-events](https://github.com/docker/go-events)

```
// Exchange broadcasts events
type Exchange struct {
	broadcaster *goevents.Broadcaster
}
```

### 整理

[github.com/llitfkitfk/containerd/tree/part-2](https://github.com/llitfkitfk/containerd/tree/part-2)

## Part 3

### 初始化Snapshot插件

* 位置：`cmd/containerd/builtins_xxx.go`

```
package main

import (
	_ "github.com/llitfkitfk/containerd/snapshots/naive"
)

# `snapshots/naive/naive.go`
func init() {
	plugin.Register(&plugin.Registration{
		Type: plugin.SnapshotPlugin,
		ID:   "naive",
		InitFn: func(ic *plugin.InitContext) (interface{}, error) {
			ic.Meta.Platforms = append(ic.Meta.Platforms, platforms.DefaultSpec())
			return NewSnapshotter(ic.Root)
		},
	})
}
```

### 初始化Content插件

* 位置：`server/server.go`

```
plugin.Register(&plugin.Registration{
	Type: plugin.ContentPlugin,
	ID:   "content",
	InitFn: func(ic *plugin.InitContext) (interface{}, error) {
		ic.Meta.Exports["root"] = ic.Root
		return local.NewStore(ic.Root)
	},
})

```
### 初始化Metadata插件

* 位置：`server/server.go`
* 依赖：[github.com/boltdb/bolt](https://github.com/boltdb/bolt)

```

          plugin.Register(&plugin.Registration{
		Type: plugin.MetadataPlugin,
		ID:   "bolt",
		Requires: []plugin.Type{
			plugin.ContentPlugin,
			plugin.SnapshotPlugin,
		},
```

### grpc服务拦截器

* 位置：`server/server.go`

```
func interceptor(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
	ctx = log.WithModule(ctx, "containerd")
	switch info.Server.(type) {
	case tasks.TasksServer:
		ctx = log.WithModule(ctx, "tasks")
	case containers.ContainersServer:
		ctx = log.WithModule(ctx, "containers")
	case contentapi.ContentServer:
		ctx = log.WithModule(ctx, "content")
	case images.ImagesServer:
		ctx = log.WithModule(ctx, "images")
	case grpc_health_v1.HealthServer:
		// No need to change the context
	case version.VersionServer:
		ctx = log.WithModule(ctx, "version")
	case snapshotsapi.SnapshotsServer:
		ctx = log.WithModule(ctx, "snapshot")
	case diff.DiffServer:
		ctx = log.WithModule(ctx, "diff")
	case namespaces.NamespacesServer:
		ctx = log.WithModule(ctx, "namespaces")
	case eventsapi.EventsServer:
		ctx = log.WithModule(ctx, "events")
	case introspection.IntrospectionServer:
		ctx = log.WithModule(ctx, "introspection")
	case leasesapi.LeasesServer:
		ctx = log.WithModule(ctx, "leases")
	default:
		log.G(ctx).Warnf("unknown GRPC server type: %#v\n", info.Server)
	}
	return grpc_prometheus.UnaryServerInterceptor(ctx, req, info, handler)
}
```

### 整理

[github.com/llitfkitfk/containerd/tree/part-3](https://github.com/llitfkitfk/containerd/tree/part-3)



## 操作与管理


### 命令行

* 默认配置文件路径`/etc/containerd/config.toml`, 可通过`--config,-c`修改

### systemd

```
[Unit]
Description=containerd container runtime
Documentation=https://containerd.io
After=network.target

[Service]
ExecStartPre=/sbin/modprobe overlay
ExecStart=/usr/local/bin/containerd
Delegate=yes
KillMode=process

[Install]
WantedBy=multi-user.target
```

* `Delegate` 允许containerd及其运行时管理它所创建的容器的cgroups
* `KillMode` 设置为`process`确保systemd只杀掉containerd守护进程，任何子进程像容器都会被保留

### 基本配置

* **`oom_score`** 确保在containerd守护进程内存溢出前容器被杀掉
* **`subreaper`** `shim` → `runc` → `container`，如果`runc`退出，正常情况，`container` 将会成为 `init` (`pid:1`) 的`child`，而`shim`使用了`subreaper`后，将会截断这个收养进程的上溯过程，`shim` 将成为 `container` 的新 `parent`。

- [Reference: 视频笔记：Containerd - 构建容器 Supervisor - Michael Crosby](https://blog.lab99.org/post/docker-2016-07-11-video-containerd-building-a-container-supervisor.html)



