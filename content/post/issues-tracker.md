---
title: "Issues跟踪"
date: 2016-11-03T14:09:00+08:00
lastmod: 2018-12-27T17:19:00+08:00
draft: false
tags: ["issues", "github", "react-native", "kubernetes"]
categories: ["Issues"]
---

## 各类项目Issues收集

## React Native

### react-navigation

Issue:

```
isMounted(...) is deprecated warning
```
https://github.com/react-navigation/react-navigation/issues/3956

Fixed:

https://www.hellojava.com/article/19116

Issue & Fixed:
https://github.com/johanneslumpe/react-native-fs/pull/238/commits

### JPush issue:

https://community.jiguang.cn/t/sdk--objc-class---jpushservice-referenced/12631/7

Issue: 
https://github.com/facebook/react-native/issues/7308


![注意红框部分](/images/attachment/590399-006db337a2727074.png)


### API 请求

info.plist
```
...
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
	<key>NSExceptionDomains</key>
	<dict>
		<key>localhost</key>
		<dict>
			<key>NSExceptionAllowsInsecureHTTPLoads</key>
			<true/>
		</dict>
	</dict>
</dict>
...
```
### 重装watchman

```
rm -rf /usr/local/var/run/watchman/ && brew uninstall watchman && brew install watchman
```


### 权限

```
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

sudo chown -R $USER /usr/local/lib/node_modules
```


[编译问题](https://github.com/auth0/react-native-lock/issues/75)


### SSZipArchive._zip duplicate

https://github.com/Microsoft/react-native-code-push/issues/241

### React Native Upgrade

![Upgrade 0.36 to 0.41](/images/attachment/590399-15f94f27a0beda76.png)

[upgrade  release build issue](https://github.com/facebook/react-native/issues/11285)



## Kubernetes

### Kube-dns is not running:

* Issue: 
```
kubectl get pods --all-namespaces
```
[related-issue](https://github.com/kubernetes/kubernetes/issues/33671)

* Solve: 
```
kubectl apply -f https://git.io/weave-kube
```

## Gitlab

admin身份如果不加入对应群组, 查看不到对应群组内添加的Deploy Keys

但是用API 就可以查看访问:

[Deploy Keys API](https://docs.gitlab.com/ee/api/deploy_keys.html)
