---
title: "CAS登录认证"
date: 2017-07-13T11:17:00+08:00
lastmod: 2018-12-27T18:18:00+08:00
draft: false
tags: ["cas", "authentication"]
categories: ["CAS"]
---

### CAS最基本的协议过程

![](/images/attachment/590399-250d47142315c4fd.png)

### 名词解释
* **Ticket Grangting Ticket(TGT)** ：
TGT是CAS为用户签发的登录票据，拥有了TGT，用户就可以证明自己在CAS成功登录过。TGT封装了Cookie值以及此Cookie值对应的用户信息。用户在CAS认证成功后，CAS生成cookie（叫TGC），写入浏览器，同时生成一个TGT对象，放入自己的缓存，TGT对象的ID就是cookie的值。当HTTP再次请求到来时，如果传过来的有CAS生成的cookie，则CAS以此cookie值为key查询缓存中有无TGT，如果有的话，则说明用户之前登录过，如果没有，则用户需要重新登录。

* **Ticket-granting cookie(TGC)**：
存放用户身份认证凭证的cookie，在浏览器和CAS Server间通讯时使用，并且只能基于安全通道传输（Https），是CASServer用来明确用户身份的凭证。

* **Service ticket(ST)** ：服务票据，服务的惟一标识码 , 由 CASServer 发出（ Http 传送），用户访问Service时，service发现用户没有ST，则要求用户去CAS获取ST.用户向CAS发出获取ST的请求，CAS发现用户有TGT，则签发一个ST，返回给用户。用户拿着ST去访问service，service拿ST去CAS验证，验证通过后，允许用户访问资源
 
### 组成
* CAS 服务端
CASServer 负责完成对用户的认证工作 , 需要独立部署 , CAS Server 会处理用户名 /密码等凭证 (Credentials) 。
 
* CAS 客户端
负责处理对客户端受保护资源的访问请求，需要对请求方进行身份认证时，重定向到 CAS Server 进行认证。（原则上，客户端应用不再接受任何的用户名密码等 Credentials ）。
CASClient 与受保护的客户端应用部署在一起，以 Filter 方式保护受保护的资源。

### CAS Web工作流程

![](/images/attachment/590399-d0ac082fc1613e68.png)

#### CAS登录流程

**步骤 1**：浏览器向CAS客户端发起登陆请求，CAS客户端生成“登陆URL”,并把浏览器重定向到该URL 登陆URL:[https://${cas-server-host}:${cas-server-port}/cas-server/login?service=${client-service-url}](https://%24%7Bcas-server-host%7D:${cas-server-port}/cas-server/login?service=${client-service-url}) 
* 其中 
  * cas-server-host: cas认证服务器的域名 
  * cas-server-port: cas认证服务器的IP 
  * client-service-url: 用于登陆成功后，浏览器重定向的URL

> java举例:
https://cas-server.domain.com/cas/login?service=http%3A%2F%2Fcas.domain.com%3A8080

**步骤 2**: 浏览器向“登陆URL”发起重定向请求，CAS服务端创建会话，把TGT（Ticket Granting Ticket）放入cookie，并返回登陆页面

**步骤 3**：用户输入用户名和密码,然后提交登陆表单. CAS服务端通过登陆验证后，会生成一个ST(service ticket,简称ticket), 然后把浏览器重定向到${client-service-url}?ticket=${service-ticket}

**步骤 4**：浏览器重定向到${client-service-url}?ticket=${service-ticket}发起重定向请求

> java举例:
   http://cas.domain.com/8080?ticket=${service-ticket}

**步骤 5**: CAS客户端取出ticket，生成“ticket验证URL”,然后向"ticket验证URL"发起http GET请求 "ticket验证URL":　[http://${cas-server-host}:${cas-server-port}/cas-server/serviceValidate?ticket=${service-ticket}&service=${client-service-url}](http://%24%7Bcas-server-host%7D:${cas-server-port}/cas-server/serviceValidate?ticket=${service-ticket}&service=${client-service-url})

> java举例:
https://cas-server.domain.com/cas/serviceValidate?ticket=${service-ticket}&service=http://cas.domain.com/8080

**步骤 6**: 如果CAS服务器通过ticket的有效性检查，那么会返回类似如下格式的XML片段 
```
<cas:serviceResponse xmlns:cas='http://www.yale.edu/tp/cas'>
    <cas:authenticationSuccess> 
        <cas:user>AAAA</cas:user>
    </cas:authenticationSuccess> 
</cas:serviceResponse>
```
* 其中AAAA是登陆的用户名 

否则返回： 
```
<cas:serviceResponse xmlns:cas='http://www.yale.edu/tp/cas'> 
    <cas:authenticationFailure code='XXX'> YYY </cas:authenticationFailure> 
</cas:serviceResponse>
```
* 其中：
  * XXX的可能取值是INVALID_REQUEST, INVALID_TICKET, INVALID_SERVICE, INTERNAL_ERROR
  * YYY是错误描述信息


至此CAS的登陆流程结束

登陆成功后，CAS客户端应该在会话中保存登陆状态信息。CAS服务器通常在步骤 6会建立ticket和${client-service-url}的映射关系，以便在登出时通知其业务系统清除缓存中的状态信息


#### CAS登出流程

浏览器或CAS客户端向“登出URL”发起GET请求： "登出URL"： [https://${cas-server-host}:${cas-server-port}/cas-server/logout](https://%24%7Bcas-server-host%7D:${cas-server-port}/cas-server/logout) CAS服务器销毁TGT和ST，并向所有已登陆的业务系统发出登出通知请求

> java举例:
https://cas-server.domain.com/cas/logout?service=http://cas.domain.com:8080


<end>

---


<strike>
请求方法：POST
请求URL: ${client-service-url} ( http://cas.domain.com/8080)
请求头： ```Content-Type：application/x-www-form-urlencoded```
请求正文： 
```
<!-- lang: xml --> 
logoutRequest=
<samlp:LogoutRequest xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol" ID="#LR_TICKET_ID#" Version="2.0" IssueInstant="#CURRENT_DATETIME#"> 
    <saml:NameID xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">@NOT_USED@</saml:NameID> 
    <samlp:SessionIndex>#ST#</samlp:SessionIndex> 
</samlp:LogoutRequest>
```
* 其中
  * LR_TICKET_ID:　　      CAS服务器为每个登出通知请求所生成的一个值
  * ST　　　　　　　　      之前登陆成功后CAS服务端传回来的Service Ticket
  * CURRENT_DATETIME 发出该请求时，CAS服务器的日期/时间
</strike>