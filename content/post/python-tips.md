---
title: "Python Tips"
date: 2018-07-10T22:33:00+08:00
lastmod: 2018-12-28T10:55:00+08:00
draft: false
tags: ["python", "tips"]
categories: ["Python"]
---

# 1. 介绍

## Python的特征与生态环境

* 特征：轻便/一致/开发者生产力高/大量的库/软件质量/软件集成/满足与享受
* 缺点：执行速度

* 当运行Python程序时，会生成`.pyc`文件 - Python编译后的字节码，然后被Python解释器运行

* 使用Python的公司：Goolge, YouTube, Dropbox, Red Hat, IBM, HP, Yahoo ...
* 使用Python的游戏：Battlefield 2，Civilization IV, QuArK ...
* Python用途：系统编程，Web开发，GUI应用，游戏和机器人，数据科学，数据库应用 ...

## Python环境搭建 

> 注意: 简便起见，开发环境统一用Docker搭建, Docker for mac/win/linux, 安装详情请移步Docker贴士文集

* 在某些方面Python 2 和 Python 3不兼容

* 安装Python: 
```docker run -ti --rm python:alpine python```

## 运行Python程序

* 四种方式: Python脚本/Python交互式shell/Python服务/Python GUI应用

* 交互式shell: 
```
➜  ~ docker run --rm -ti python:alpine python
Python 3.7.0 (default, Jul  4 2018, 02:26:27) 
[GCC 6.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> 1 + 1
2
>>> 100 / 23
4.3478260869565215
>>> 2 ** 2048
32317006071311007300714876688669951960444102669715484032130345427524655138867890893197201411522913463688717960921898019494119559150490921095088152386448283120630877367300996091750197750389652106796057638384067568276792218642619756161838094338476170470581645852036305042887575891541065808607552399123930385521914333389668342420684974786564569494856176035326322058077805659331026192708460314150258592864177116725943603718461857357598351152301645904403697613233287231227125684710820209725157101726931323469678542580656697935045997268352998638215525166389437335543602135433229604645318478604952148193555853611059596230656
>>> 
```
* GUI:
  PyQt / wxPython / PyGTK

## Python代码组织与执行模型

### 代码组织

* `.py`文件 作为 Python模块
* 包含`__init__.py`(Python 3.3 不再是必需的)文件夹 作为package 
  
### 执行模型:

* name vs namespace
  `from library.second_floor.section_x.row_three import book`
  namespace: `library` `second_floor` `section_x` `row_three`
  name: `book`

* Scopes (LEGB)
查找name的顺序: local -> enclosing -> global -> built-in

* 对象与类
  类用来创建对象, 对象是类的实例

 
### 编写好的代码

[PEP 8 -- Style Guide for Python Code](https://www.python.org/dev/peps/pep-0008/?)

```
➜  ~ docker run --rm -ti python:alpine python
Python 3.7.0 (default, Jul  4 2018, 02:26:27) 
[GCC 6.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import this
The Zen of Python, by Tim Peters

Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse is better than dense.
Readability counts.
Special cases aren't special enough to break the rules.
Although practicality beats purity.
Errors should never pass silently.
Unless explicitly silenced.
In the face of ambiguity, refuse the temptation to guess.
There should be one-- and preferably only one --obvious way to do it.
Although that way may not be obvious at first unless you're Dutch.
Now is better than never.
Although never is often better than *right* now.
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.
Namespaces are one honking great idea -- let's do more of those!
>>> 
```

# 2. 数据类型


## 开启Python
```
➜  ~ docker run --rm -ti python:alpine python
Python 3.7.0 (default, Jul  4 2018, 02:26:27) 
[GCC 6.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

## Python对象结构

[Visualize your code and get live help now](http://pythontutor.com/)

## 可变与不可变对象

* 值可以改变的对象是mutable, 否则为immutable

```
>>> age = 18
>>> id(age)
140068432251328
>>> age
18
>>> age = 30
>>> id(age)
140068432251712
>>> age
30
>>> 
>>> class Person():
...     def __init__(self, age):
...             self.age = age
... 
>>> me = Person(age=30)
>>> me.age
30
>>> id(me)
140068426091544
>>> id(me.age)
140068432251712
>>> me.age = 18
>>> id(me)
140068426091544
>>> id(me.age)
140068432251328
>>> 
```

## 内置类型: Numbers, Strings, Sequences, Collections 与 Mapping类型

### Numbers

* Integer(整数):

```
>>> a = 18
>>> b = 3
>>> a + b
21
>>> a - b
15
>>> a * b
54
>>> a / b
6.0
>>> a // b
6
>>> a % b
0
>>> a ** b
5832
>>> 
```
* Boolean:

```
>>> int(True)
1
>>> int(False)
0
>>> bool(1)
True
>>> bool(-1)
True
>>> bool(0)
False
>>> not True
False
>>> not False
True
>>> True and False
False
>>> False or True
True
>>> 1 + True
2
>>> 1 - False
1
>>> 
```
* Real Number(实数) (浮点型numbers):

```
>>> pi = 3.1415926
>>> r = 10.5
>>> area = pi * (r ** 2)
>>> area
346.36058415
>>> 
>>> import sys
>>> sys.float_info
sys.float_info(max=1.7976931348623157e+308, max_exp=1024, max_10_exp=308, min=2.2250738585072014e-308, min_exp=-1021, min_10_exp=-307, dig=15, mant_dig=53, epsilon=2.220446049250313e-16, radix=2, rounds=1)
>>> 
>>> 0.3 - 0.1 * 3 
-5.551115123125783e-17
>>> 
```
* Complex numbers(复数):

```
>>> c = 3.14 + 2.73j
>>> c
(3.14+2.73j)
>>> c.real
3.14
>>> c.imag
2.73
>>> c.conjugate()
(3.14-2.73j)
>>> c * 2
(6.28+5.46j)
>>> c ** 2
(2.4067000000000007+17.1444j)
>>> d = 1 + 1j
>>> c - d
(2.14+1.73j)
>>> 
```
* Fractions(分数)与decimals(小数)

```
>>> from fractions import Fraction
>>> Fraction(100, 48)
Fraction(25, 12)
>>> Fraction(1,3) + Fraction(2,3)
Fraction(1, 1)
>>> f = Fraction(100000, 2358)
>>> f.numerator
50000
>>> f.denominator
1179
>>> 
>>> from decimal import Decimal as D
>>> D(3.1415926)
Decimal('3.14159260000000006840537025709636509418487548828125')
>>> D('3.1415926')
Decimal('3.1415926')
>>> D(0.1) * D(3) - D(0.3)
Decimal('2.775557561565156540423631668E-17')
>>> D('0.1') * D('3') - D('0.3')
Decimal('0.0')
>>> D('2.4').as_integer_ratio()
(12, 5)
>>> 
```
### 不可变序列

* strings(字符串)与bytes(字节):

```
>>> str1 = 'Hello World'
>>> str2 = "Hello World"
>>> str3 = '''Hello World
... Hello World
... Hello World'''
>>> str4 = """Hello World
... Hello World
... Hello World
... Hello World
... Hello World"""
>>> len(str1)
11
>>> str4
'Hello World\nHello World\nHello World\nHello World\nHello World'
>>> print(str4)
Hello World
Hello World
Hello World
Hello World
Hello World
>>> 
>>> s = "Hello World Long Test Text"
>>> s[0]
'H'
>>> s[6]
'W'
>>> s[:6]
'Hello '
>>> s[6:]
'World Long Test Text'
>>> s[6:26:3]
'WlLge x'
>>> s[:]
'Hello World Long Test Text'
>>> 
```

* tuples(元组):

```
>>> t=()
>>> type(t)
<class 'tuple'>
>>> one_element_tuple=(18,)
>>> three_element_tuple=(18,30,50)
>>> a,b,c=1,2,3
>>> a,b,c
(1, 2, 3)
>>>
>>> a,b=1,2
>>> a,b=b,a
>>> a,b
(2, 1)
>>>
```
### 可变序列
* List:

```
>>> []
[]
>>> list()
[]
>>> [1,2,3]
[1, 2, 3]
>>> [x + 5 for x in [2,3,4]]
[7, 8, 9]
>>> list((1,3,5,7,9))
[1, 3, 5, 7, 9]
>>> list('hello')
['h', 'e', 'l', 'l', 'o']
>>> 
```

* Byte arrays:

```
>>> bytearray()
bytearray(b'')
>>> bytearray(10)
bytearray(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
>>> bytearray(range(5))
bytearray(b'\x00\x01\x02\x03\x04')
>>> me = bytearray(b'Paul')
>>> me.endswith(b'l')
True
>>> me.upper()
bytearray(b'PAUL')
>>> me.count(b'l')
1
>>> 
```
### Set类型

* `set` 可变 
* `frozenset` 不可变

```
>>> s = set()
>>> s.add(2)
>>> s.add(5)
>>> s.add(7)
>>> s
{2, 5, 7}
>>> s.add(1)
>>> s
{1, 2, 5, 7}
>>> s.remove(1)
>>> s
{2, 5, 7}
>>> s.add(5)
>>> s
{2, 5, 7}
>>> s2 = set([5,7,11])
>>> s | s2
{2, 5, 7, 11}
>>> s & s2
{5, 7}
>>> s -  s2
{2}
>>> 
>>> fs = frozenset([2,5,7])
>>> fs.add(2)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: 'frozenset' object has no attribute 'add'
>>> fs
frozenset({2, 5, 7})
>>> 
```
### Mapping类型 - dictionaries(字典)

```
>>> a = dict(A=2, B=3)
>>> b = {'A': 2, 'B': 3}
>>> c = dict(zip(['A', 'B'], [2, 3]))
>>> d = dict([('A',2), ('B',3)])
>>> e = dict({'A': 2, 'B': 3})
>>> a == b == c == d == e
True
>>> 
```


## 集合模块

* `namedTuple` 工厂方法创建带有名字的tuple
* `deque` 列表式容器
* `ChainMap` 字典式类 用于创建多个mappings
* `Counter` 字典子类 用于计数哈希对象
* `OrderedDict` 带顺序的字典子类
* `defaultdict` 带默认值的字典子类
* `UserDict` 简易的字典对象封装
* `UserList` 简易的列表对象封装
* `UserString` 简易的字符串对象封装

`namedtuple`:
```
>>> from collections import namedtuple
>>> Vision = namedtuple('Vision', ['left', 'right'])
>>> vision = Vision(18,30)
>>> vision.left
18
>>>
```

## 枚举类型

```
>>> from enum import Enum
>>> class TrafficLight(Enum):
...     GREEN=1
...     YELLOW=2
...     RED=3
...
>>> TrafficLight.GREEN
<TrafficLight.GREEN: 1>
>>> TrafficLight.GREEN.name
'GREEN'
>>> TrafficLight.GREEN.value
1
>>>
```

## 注意点

* 很小的值的缓存
    ```
    >>> a = 1
    >>> b = 1
    >>> id(a) == id(b)
    True
    >>> a = 100000
    >>> b = 100000
    >>> id(a) == id(b)
    False
    >>>
    ```

* O(n)
* 索引:
    ```
    >>> a = list(range(5))
    >>> a
    [0, 1, 2, 3, 4]
    >>> len(a)
    5
    >>> a[len(a)-1]
    4
    >>> a[-1]
    4
    >>> a[-2]
    3
    >>> a[-5]
    0
    ```

# 3. 迭代与决策

## 条件编程

```
>>> late = False
>>> if late:
...     print('I need call my manager')
... else:
...     print('no need to call my manager')
...
no need to call my manager
>>>
>>> if alert_system == 'console':
...     print('console logging')
... elif alert_system == 'email':
...     print('sending email')
... else:
...     print('no logging')
... 
console logging
>>> 
```
* 三元运算符

```
>>> can_discount = True
>>> total = 100 if can_discount else 50
>>> total
100
>>> can_discount = False
>>> total = 100 if can_discount else 50
>>> total
50
>>> 
```

## 循环

* for 

```
>>> for number in [18, 30, 50]:
...     print(number)
... 
18
30
50
>>> 
```
* range

```
>>> list(range(3,8))
[3, 4, 5, 6, 7]
```
* Sequence

```
>>> surnames = ['Paul', 'llitfkitfk', 'Tian']
>>> for surname in surnames:
...     print(surname)
... 
Paul
llitfkitfk
Tian
>>> 
```
* for 循环可以用于lists / tuples等可以迭代的任何类型

```
>>> people = ['Paul', 'llitfkitfk', 'Tian']
>>> ages = [18, 30, 45]
>>> for person, age in zip(people, ages):
...     print(person, age)
...
Paul 18
llitfkitfk 30
Tian 45

>>>
```

* while

```
>>> n = 39
>>> while n > 0:
...     remainder = n % 2
...     remainders.insert(0, remainder)
...     n //= 2
...
>>> print(remainders)
>>>
>>> products = ['car', 'bike', 'truck']
>>> for product in products:
...     if product == 'car':
...             continue
...     print(product)
...
bike
truck
>>>
```
* break & continue

* 特殊的else

```
>>> class DriverException(Exception):
...     pass
... 
>>> products = ['car', 'bike', 'truck']
>>> for product in products:
...     if product == 'ship':
...         buy = 'ship'
...         break
... else:
...     raise DriverException('Driver not found')
... 
Traceback (most recent call last):
  File "<stdin>", line 6, in <module>
__main__.DriverException: Driver not found
>>> 
```