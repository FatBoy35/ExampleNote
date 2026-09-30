USE java_note;

INSERT INTO languages (id, name, slug, description, sort_order, enabled)
VALUES
  (1, 'Java', 'java', 'Java 基础语法、面向对象、集合与框架学习路径。', 1, TRUE)
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  description = VALUES(description),
  sort_order = VALUES(sort_order),
  enabled = VALUES(enabled);

INSERT INTO modules (id, language_id, name, slug, description, sort_order, enabled)
VALUES
  (1, 1, '语法基础', 'syntax', '变量、运算符、流程控制与基础语法。', 1, TRUE),
  (2, 1, '面向对象', 'oop', '类、对象、封装、继承、多态与接口。', 2, TRUE),
  (3, 1, '集合框架', 'collections', 'List、Set、Map 和容器操作。', 3, TRUE),
  (4, 1, '框架与进阶', 'framework', 'Spring Boot 和工程化开发入门。', 4, TRUE)
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  description = VALUES(description),
  sort_order = VALUES(sort_order),
  enabled = VALUES(enabled);

INSERT INTO tags (id, name, slug)
VALUES
  (1, '变量', 'variable'),
  (2, '流程控制', 'flow-control'),
  (3, '类', 'class'),
  (4, '继承', 'inheritance'),
  (5, '集合', 'collection'),
  (6, 'Spring', 'spring'),
  (7, 'JDK', 'jdk'),
  (8, 'JVM', 'jvm'),
  (9, '关键字', 'keyword'),
  (10, '流程控制', 'process-control'),
  (11, '数组', 'array'),
  (12, '字符串', 'string'),
  (13, '封装', 'encapsulation'),
  (14, '继承', 'inheritance-2'),
  (15, '异常', 'exception'),
  (16, '泛型', 'generic')
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  slug = VALUES(slug);

INSERT INTO knowledge_points (id, module_id, title, summary, content_markdown, difficulty, sort_order, enabled)
VALUES
  (1, 1, 'Java 变量与数据类型', '学习 Java 中的基本变量和基本数据类型。', '# Java 变量与数据类型\n\nJava 是强类型语言，变量必须先声明类型。\n\n```java\nint age = 18;\nString name = "Tom";\nboolean active = true;\n```\n\n常用数据类型包括：`byte`、`short`、`int`、`long`、`float`、`double`、`char`、`boolean`。', 'BEGINNER', 1, TRUE),
  (2, 2, '类与对象', '理解类、对象、字段和方法的关系。', '# 类与对象\n\n类就是模板，对象则是具体实例。\n\n```java\nclass Person {\n    String name;\n    int age;\n    void sayHello() {\n        System.out.println("Hi, I am " + name);\n    }\n}\n```', 'BEGINNER', 1, TRUE),
  (3, 3, 'List 与 Set', '掌握列表与集合的基本使用区别。', '# List 与 Set\n\n`List` 允许重复元素，`Set` 不允许重复元素。\n\n```java\nList<String> names = new ArrayList<>();\nSet<Integer> nums = new HashSet<>();\n```', 'INTERMEDIATE', 1, TRUE),
  (4, 4, 'Spring Boot 初识', '了解 Spring Boot 的核心特点和基本用法。', '# Spring Boot 初识\n\nSpring Boot 通过约定优于配置，能够快速搭建应用。\n\n```java\n@SpringBootApplication\npublic class DemoApplication {\n    public static void main(String[] args) {\n        SpringApplication.run(DemoApplication.class, args);\n    }\n}\n```', 'ADVANCED', 1, TRUE),
  (5, 1, 'Java 运行机制与开发环境', '理解 JDK、JRE、JVM 之间的关系，以及 Java 程序的执行流程。', '# Java 运行机制与开发环境

学习 Java，最先要搞清楚几个基本概念：JDK、JRE、JVM。

## 1. 三者的关系

- JDK（Java Development Kit）：Java 开发工具包，包含开发、编译、调试等工具
- JRE（Java Runtime Environment）：Java 运行环境，包含 JVM 和 Java 标准库
- JVM（Java Virtual Machine）：Java 虚拟机，负责执行字节码

简单理解：

- 想开发 Java 程序 → 安装 JDK
- 想运行 Java 程序 → 安装 JRE
- 真正在执行代码的是 JVM

## 2. Java 程序的执行流程

Java 源文件：`Hello.java`

1. 程序员编写 Java 代码
2. 使用 `javac` 编译器把 `.java` 文件编译成 `.class` 字节码
3. JVM 读取字节码并解释执行
4. 最终程序在操作系统上运行

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, Java!");
    }
}
```

## 3. 为什么 Java 能跨平台

因为 Java 代码先编译成字节码，再由不同平台上的 JVM 去执行。也就是说，Java 代码本身不直接依赖某个平台，真正的执行由 JVM 负责适配。', 'BEGINNER', 2, TRUE),
  (6, 1, 'Java 关键字、标识符与注释', '掌握 Java 命名规则和注释的写法，避免常见错误。', '# Java 关键字、标识符与注释

## 1. 关键字

关键字是 Java 语言里已经被定义好的特殊单词，不能拿来当作变量名、类名等。

例如：

```java
public class Demo {
    public static void main(String[] args) {
        int age = 18;
        if (age >= 18) {
            System.out.println("成年人");
        }
    }
}
```

这里的 `public`、`class`、`static`、`void`、`if` 等都是关键字。

## 2. 标识符

标识符是程序中给变量、类、方法等起的名字。

命名规则：

- 只能由字母、数字、下划线 `_`、美元符号 `$` 组成
- 不能以数字开头
- 不能使用 Java 关键字
- 一般建议使用驼峰命名法：`userName`、`studentAge`

例如：

```java
int age = 18;
String userName = "Tom";
```

## 3. 注释

注释是给程序员看的，不参与运行。它能帮助你解释代码逻辑。

```java
// 单行注释

/*
 * 多行注释
 */

/**
 * 文档注释
 */
```

养成写注释的习惯，非常重要，尤其在团队开发中。', 'BEGINNER', 3, TRUE),
  (7, 1, 'Java 运算符与流程控制', '学会如何进行计算、比较和按条件执行代码。', '# Java 运算符与流程控制

## 1. 算术运算符

```java
int a = 10;
int b = 3;
System.out.println(a + b); // 13
System.out.println(a - b); // 7
System.out.println(a * b); // 30
System.out.println(a / b); // 3
System.out.println(a % b); // 1
```

注意：整数除法得到的是整数，`10 / 3` 会得到 `3`，不是 `3.33`。

## 2. 比较运算符

- `==`：等于
- `!=`：不等于
- `>`：大于
- `<`：小于
- `>=`：大于等于
- `<=`：小于等于

## 3. 逻辑运算符

- `&&`：与
- `||`：或
- `!`：非

```java
int age = 20;
boolean isAdult = age >= 18 && age < 60;
System.out.println(isAdult); // true
```

## 4. if / else

```java
int score = 85;
if (score >= 90) {
    System.out.println("优秀");
} else if (score >= 70) {
    System.out.println("良好");
} else {
    System.out.println("继续努力");
}
```

## 5. for / while

```java
for (int i = 0; i < 5; i++) {
    System.out.println(i);
}
```

```java
int i = 0;
while (i < 5) {
    System.out.println(i);
    i++;
}
```

流程控制是 Java 程序最基础的一部分，它决定了程序“什么时候做什么”。', 'BEGINNER', 4, TRUE),
  (8, 1, 'Java 数组与字符串', '理解数组的存储方式，以及字符串在 Java 里的常见用法。', '# Java 数组与字符串

## 1. 数组

数组用于存放多个相同类型的数据。

```java
int[] scores = {90, 88, 76, 95};
System.out.println(scores[0]); // 90
System.out.println(scores.length); // 4
```

数组有两个很重要的特征：

- 长度固定
- 下标从 0 开始

## 2. 二维数组

```java
int[][] matrix = {
    {1, 2},
    {3, 4}
};
System.out.println(matrix[1][0]); // 3
```

## 3. 字符串

Java 中字符串常用 `String` 表示。

```java
String name = "Tom";
System.out.println(name.length());
System.out.println(name.toUpperCase());
```

注意：`String` 是不可变对象，很多方法返回的是新字符串，而不是直接修改原字符串。

## 4. 为什么数组和字符串很重要

它们在真实项目中经常出现。比如：

- 批量处理学生成绩
- 处理用户输入
- 读取配置文件
- 提取文本内容', 'BEGINNER', 5, TRUE),
  (9, 2, 'Java 类与对象详解', '把现实事物抽象成对象，理解类的作用和对象的创建方式。', '# Java 类与对象详解

## 1. 类是什么

类是一个模板，规定了对象有哪些属性和行为。

```java
class Person {
    String name;
    int age;

    void sayHello() {
        System.out.println("Hi, I am " + name + ", age " + age);
    }
}
```

## 2. 对象是什么

对象是类的实例，也就是“具体存在的东西”。

```java
Person p = new Person();
p.name = "Alice";
p.age = 20;
p.sayHello();
```

## 3. 构造方法

构造方法用于创建对象时初始化数据。

```java
class Person {
    String name;
    int age;

    Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

对象创建和初始化是 Java 面向对象编程的核心基础。', 'BEGINNER', 2, TRUE),
  (10, 2, 'Java 封装、继承与多态', '理解面向对象三大特性，写出更清晰、更可维护的代码。', '# Java 封装、继承与多态

## 1. 封装

封装是把属性和方法放进类中，并隐藏内部细节，只对外暴露必要接口。

```java
class Account {
    private double balance;

    public void setBalance(double balance) {
        if (balance >= 0) {
            this.balance = balance;
        }
    }

    public double getBalance() {
        return balance;
    }
}
```

优点：

- 更安全
- 更容易维护
- 更符合对象设计原则

## 2. 继承

继承让子类可以复用父类的属性和方法。

```java
class Animal {
    void eat() {
        System.out.println("吃东西");
    }
}

class Dog extends Animal {
    void bark() {
        System.out.println("汪汪叫");
    }
}
```

## 3. 多态

同一个方法对不同对象表现不同行为。

```java
class Animal {
    void sound() {
        System.out.println("动物发声");
    }
}

class Cat extends Animal {
    @Override
    void sound() {
        System.out.println("喵喵");
    }
}
```

这三大特性是 Java 面向对象设计的基础，后续 Spring、MyBatis 等框架都建立在这些思想之上。', 'INTERMEDIATE', 3, TRUE),
  (11, 2, 'Java 异常处理', '学会处理程序运行中可能出现的错误，并让程序更稳定。', '# Java 异常处理

程序在运行时可能出现很多问题，例如：

- 数组越界
- 空指针异常
- 文件不存在
- 除数为 0

这些都属于异常。

## 1. try-catch

```java
try {
    int result = 10 / 0;
} catch (ArithmeticException e) {
    System.out.println("除数不能为 0");
}
```

## 2. finally

`finally` 里的代码不管有没有异常都会执行。

```java
try {
    // 可能出错的代码
} catch (Exception e) {
    e.printStackTrace();
} finally {
    System.out.println("无论如何都会执行");
}
```

## 3. 为什么要处理异常

因为异常会让程序直接崩掉，用户体验很差。如果合理处理异常，可以让程序更健壮，更容易排查问题。', 'INTERMEDIATE', 4, TRUE),
  (12, 3, 'Java 集合框架基础', '理解 List、Set、Map 的用法与区别，掌握常用容器。', '# Java 集合框架基础

集合用于存储多个数据，常见的有：

- `List`：有序，可重复
- `Set`：无序，不重复
- `Map`：键值对

## 1. List

```java
List<String> names = new ArrayList<>();
names.add("A");
names.add("B");
System.out.println(names);
```

`ArrayList` 适合查询多、增删少的场景。

## 2. Set

```java
Set<String> unique = new HashSet<>();
unique.add("A");
unique.add("A");
System.out.println(unique);
```

Set 会自动去重。

## 3. Map

```java
Map<String, Integer> map = new HashMap<>();
map.put("Tom", 18);
System.out.println(map.get("Tom"));
```

Map 适合用“名字 -> 值”的方式存储数据。

集合是 Java 开发中非常常见的知识点，几乎所有业务都要用到。', 'INTERMEDIATE', 2, TRUE),
  (13, 4, 'Java 泛型与常用类库', '学习泛型的意义和常见工具类如何提升开发效率。', '# Java 泛型与常用类库

## 1. 泛型

泛型可以帮助我们在编译期约束数据类型，减少类型转换错误。

```java
List<String> names = new ArrayList<>();
names.add("Alice");
```

如果不用泛型，就可能出现：

```java
List list = new ArrayList();
list.add(123);
String value = (String) list.get(0);
```

这种写法容易出错，泛型则更安全。

## 2. 常用工具类

Java 中常用工具类包括：

- `Math`：数学运算
- `Arrays`：数组工具
- `Collections`：集合工具
- `Scanner`：控制台输入

```java
import java.util.*;

Scanner sc = new Scanner(System.in);
String input = sc.nextLine();
System.out.println("你输入的是：" + input);
```

泛型和常用类库是 Java 程序开发效率提升的重要基础。', 'INTERMEDIATE', 2, TRUE)
ON DUPLICATE KEY UPDATE
  title = VALUES(title),
  summary = VALUES(summary),
  content_markdown = VALUES(content_markdown),
  difficulty = VALUES(difficulty),
  sort_order = VALUES(sort_order),
  enabled = VALUES(enabled);

INSERT INTO knowledge_point_tags (knowledge_point_id, tag_id)
VALUES
  (5, 7),
  (5, 8),
  (6, 9),
  (7, 10),
  (8, 11),
  (8, 12),
  (9, 3),
  (10, 13),
  (10, 14),
  (11, 15),
  (12, 5),
  (13, 16)
ON DUPLICATE KEY UPDATE
  knowledge_point_id = VALUES(knowledge_point_id);

INSERT INTO code_examples (id, knowledge_point_id, title, description, code, language, expected_output, sort_order, enabled)
VALUES
  (5, 5, 'JDK/JRE/JVM 关系示例', '演示 Java 程序编译和执行的基本流程。', 'public class Demo {
    public static void main(String[] args) {
        System.out.println("Java 程序从 main 方法开始执行");
    }
}', 'Java', 'Java 程序从 main 方法开始执行', 1, TRUE),
  (6, 6, '标识符与注释示例', '展示合法变量名和注释写法。', 'public class Demo {
    public static void main(String[] args) {
        // 这是单行注释
        int userAge = 18;
        String userName = "Tom";
        System.out.println(userName + "，年龄：" + userAge);
    }
}', 'Java', 'Tom，年龄：18', 1, TRUE),
  (7, 7, '条件分支示例', '使用 if 语句判断是否成年人。', 'public class Demo {
    public static void main(String[] args) {
        int age = 20;
        if (age >= 18) {
            System.out.println("成年人");
        } else {
            System.out.println("未成年人");
        }
    }
}', 'Java', '成年人', 1, TRUE),
  (8, 8, '数组和字符串示例', '数组索引和字符串操作。', 'public class Demo {
    public static void main(String[] args) {
        int[] nums = {10, 20, 30};
        String text = "Java";
        System.out.println(nums[1]);
        System.out.println(text.toUpperCase());
    }
}', 'Java', '20
JAVA', 1, TRUE),
  (9, 9, '类与对象示例', '创建对象并调用实例方法。', 'class Person {
    String name;
    int age;

    Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    void sayHello() {
        System.out.println("Hi, I am " + name + ", age " + age);
    }
}

public class Demo {
    public static void main(String[] args) {
        Person p = new Person("Lucy", 21);
        p.sayHello();
    }
}', 'Java', 'Hi, I am Lucy, age 21', 1, TRUE),
  (10, 10, '封装与多态示例', '演示封装和方法重写。', 'class Animal {
    void sound() {
        System.out.println("动物发声");
    }
}

class Dog extends Animal {
    @Override
    void sound() {
        System.out.println("汪汪");
    }
}

public class Demo {
    public static void main(String[] args) {
        Animal a = new Dog();
        a.sound();
    }
}', 'Java', '汪汪', 1, TRUE),
  (11, 11, '异常处理示例', '处理除零异常。', 'public class Demo {
    public static void main(String[] args) {
        try {
            int result = 10 / 0;
            System.out.println(result);
        } catch (ArithmeticException e) {
            System.out.println("除数不能为 0");
        }
    }
}', 'Java', '除数不能为 0', 1, TRUE),
  (12, 12, '集合示例', '演示 List 与 Set 的去重行为。', 'import java.util.*;

public class Demo {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>();
        names.add("A");
        names.add("B");
        names.add("A");

        Set<String> set = new HashSet<>(names);
        System.out.println(names);
        System.out.println(set);
    }
}', 'Java', '[A, B, A]
[A, B]', 1, TRUE),
  (13, 13, '泛型示例', '演示泛型让集合更安全。', 'import java.util.*;

public class Demo {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>();
        names.add("Java");
        names.add("Spring");
        System.out.println(names.get(0));
    }
}', 'Java', 'Java', 1, TRUE)
ON DUPLICATE KEY UPDATE
  title = VALUES(title),
  description = VALUES(description),
  code = VALUES(code),
  language = VALUES(language),
  expected_output = VALUES(expected_output),
  sort_order = VALUES(sort_order),
  enabled = VALUES(enabled);

INSERT INTO admin_users (id, username, password_hash, nickname, role, enabled)
VALUES
  (1, 'admin', '$2a$10$9mP6kJ7KXc7h2Qz4D2sVQeMia4R7eaV6lN4w4l3B0hxT3sLniWWyC', '系统管理员', 'ADMIN', TRUE)
ON DUPLICATE KEY UPDATE
  username = VALUES(username),
  password_hash = VALUES(password_hash),
  nickname = VALUES(nickname),
  role = VALUES(role),
  enabled = VALUES(enabled);
