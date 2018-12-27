---
title: "Go语言实战"
date: 2018-11-05T14:58:00+08:00
lastmod: 2018-12-27T11:38:00+08:00
draft: false
tags: ["golang", "Best Practice"]
categories: ["golang"]
---

### 1. 指导原则

如果我要谈论任何编程语言的最佳实践，我需要一些方法来定义“什么是最佳”。 如果你昨天来到我的主题演讲，你会看到Go团队负责人Russ Cox的这句话：

> Software engineering is what happens to programming when you add time and other programmers. (软件工程就是你和其他程序员花费时间在编程上所发生的事情。)
   — Russ Cox

Russ作出了软件编程与软件工程的区分。 前者是你自己写的一个程序。 后者是很多人会随着时间的推移而开发的产品。 工程师们来来去去，团队会随着时间增长与缩小，需求会发生变化，功能会被添加，错误也会得到修复。 这是软件工程的本质。

我可能是这个房间里Go最早的用户之一，~但要争辩说我的资历给我的看法更多是假的~。 相反，今天我要提的建议是基于我认为的Go语言本身的指导原则：

  1. 简单性
  2. 可读性
  3. 生产力

> 注意:
你会注意到我没有说性能或并发。 有些语言比Go语言快一点，但它们肯定不像Go语言那么简单。 有些语言使并发成为他们的最高目标，但它们并不具有可读性及生产力。
性能和并发是重要的属性，但不如简单性，可读性和生产力那么重要。

#### 1.1. 简单性
我们为什么要追求简单？ 为什么Go语言程序的简单性很重要？

我们都曾遇到过这样的情况: “我不懂这段代码”，不是吗？ 我们都做过这样的项目:你害怕做出改变，因为你担心它会破坏程序的另一部分; 你不理解的部分，不知道如何修复。

这就是复杂性。 复杂性把可靠的软件中变成不可靠。 复杂性是杀死软件项目的罪魁祸首。

简单性是Go语言的最高目标。 无论我们编写什么程序，我们都应该同意这一点:它们很简单。

#### 1.2. 可读性

> Readability is essential for maintainability.
 (可读性对于可维护性是至关重要的。)
    — Mark Reinhold (2018 JVM语言高层会议)

为什么Go语言的代码可读性是很重要的？我们为什么要争取可读性？

> Programs must be written for people to read, and only incidentally for machines to execute. (程序应该被写来让人们阅读，只是顺便为了机器执行。)
 — Hal Abelson 与 Gerald Sussman (计算机程序的结构与解释)

可读性很重要，因为所有软件不仅仅是Go语言程序，都是由人类编写的，供他人阅读。执行软件的计算机则是次要的。

代码的读取次数比写入次数多。一段代码在其生命周期内会被读取数百次，甚至数千次。

> The most important skill for a programmer is the ability to effectively communicate ideas. (程序员最重要的技能是有效沟通想法的能力。)
  — Gastón Jorquera [[1]]((https://gaston.life/books/effective-programming/))

可读性是能够理解程序正在做什么的关键。如果你无法理解程序正在做什么，那你希望如何维护它？如果软件无法维护，那么它将被重写;最后这可能是你的公司最后一次投资Go语言。

~如果你正在为自己编写一个程序，也许它只需要运行一次，或者你是唯一一个曾经看过它的人，然后做任何对你有用的事。~但是，如果是一个不止一个人会贡献编写的软件，或者在很长一段时间内需求、功能或者环境会改变，那么你的目标必须是你的程序可被维护。

编写可维护代码的第一步是确保代码可读。

#### 1.3. 生产力

> Design is the art of arranging code to work today, and be changeable forever. (设计是安排代码到工作的艺术，并且永远可变。)
— Sandi Metz

我要强调的最后一个基本原则是生产力。开发人员的工作效率是一个庞大的主题，但归结为此; 你花多少时间做有用的工作，而不是等待你的工具或迷失在一个外国的代码库里。Go程序员应该觉得他们可以通过Go语言完成很多工作。

有人开玩笑说，Go语言是在等待C ++语言程序编译时设计的。快速编译是Go语言的一个关键特性，也是吸引新开发人员的关键工具。虽然编译速度仍然是一个持久的战场，但可以说，在其他语言中需要几分钟的编译，在Go语言中只需几秒钟。这有助于Go语言开发人员感受到与使用动态语言的同行一样的高效，而且没有那些语言固有的可靠性问题。

对于开发人员生产力问题更为基础的是，Go程序员意识到编写代码是为了阅读，因此将读代码的行为置于编写代码的行为之上。 Go语言甚至通过工具和自定义强制执行所有代码以特定样式格式化。这就消除了项目中学习特定格式的摩擦，并帮助发现错误，因为它们看起来不正确。

Go程序员不会花费整天的时间来调试不可思议的编译错误。他们也不会将浪费时间在复杂的构建脚本或在生产中部署代码。最重要的是，他们不用花费时间来试图了解他们的同事所写的内容。

当他们说语言必须扩展时，Go团队会谈论生产力。