# Annotation

## 注解的定义

Java 注解用于为 Java 代码提供元数据。作为元数据，注解不直接影响你的代码执行，但也有一些类型的注解实际上可以用于这一目的。Java 注解是从 Java5 开始添加到 Java 的。

### 5种元注解

* @Retention （保留，持久力）解释说明了注解的存活时间，它的取值如下
    1. RetentionPolicy.SOURCE 注解只在源码阶段保留，在编译器进行编译时它将被丢弃忽视；
    2. RetentionPolicy.CLASS 注解只被保留到编译进行的时候，它并不会被加载到JVM中；
    3. RetentionPolicy.RUNTIME 注解可以保留到程序运行的时候，它会被加载到JVM中
* @Documented 它的作用是能够将注解中的元素包含到Javadoc中去；
* @Target (目标) 指定了注解运用的地方，它的取值如下
    1. ElementType.ANNOTATION_TYPE 可以给一个注解进行注解
    2. ElementType.CONSTRUCTOR 可以给构造方法进行注解
    3. ElementType.FIELD 可以给属性进行注解
    4. ElementType.LOCAL_VARIABLE 可以给局部变量进行注解
    5. ElementType.METHOD 可以给方法进行注解
    6. ElementType.PACKAGE 可以给一个包进行注解
    7. ElementType.PARAMETER 可以给一个方法内的参数进行注解
    8. ElementType.TYPE 可以给一个类型进行注解，比如类、接口、枚举
* @Inherited (继承)

    ```text
    它并不是说注解本身可以被继承，而是说如果一个超类被@Inherited注解过的话，
    那么如果它的子类没有被任何注解注解的话，那么这个子类就继承了超类的注解。
    ```

* Repeatable (可重复)

```java
@interface Persons {
 Person[]  value();
}


@Repeatable(Persons.class)
@interface Person{
 String role default "";
}


@Person(role="artist")
@Person(role="coder")
@Person(role="PM")
public class SuperMan{
 
}
上面的例子，一个人即是艺术家，又是程序员，还是产品经理，
使用 @Repeatable注解了注解Person,@Repeatable(Persons.class)括号里面的Persons.class相当于一个
容器注解，用来存放其他注解。按照规定，容器注解必须要有一个value属性，属性类型是一个被@Repeatable
注解过的注解的数组；
```

### 注解的属性

```java
注解的属性也叫成员变量。注解只有成员变量，没有方法。注解的成员变量以“无性参的方法”形式来声明，
其方法名定义了该成员变量的名字，其返回值定义了该成员变量的类型。

@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface TestAnnotation {
 
 int id();
 
 String msg();

}

上面的代码定义了TestAnnotation这个注解中有id和msg两个属性，在使用的时候，我们应该给他们赋值

@TestAnnotation(id=3,msg="hello annotation")
public class Test {

}

注解中的属性可以有默认值，默认值需要用default关键字指定

@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface TestAnnotation {
 
 public int id() default -1;
 
 public String msg() default "Hi";

}
```

### java预置的注解

* @Deprecated 这个注解用来标识过时的元素
* @Override 提示字类要复写父类中被@Overfide修饰的方法
* @SuppressWarnings 抑制警告，@SuppressWarnings("deprection")可以忽略掉过时警告
* @SafeVarargs 参数安全类型注解，它的目的是提醒开发者不要用参数做一些不安全的操作，它的存在会阻止编译器产生unchecked这样的警告
* @FunctionalInterface 函数式接口注解，函数式接口就是只有一个方法的普通接口

### 注解的使用场景

* 提供信息给编译器：编译器可以利用注解来探测错误和警告信息
* 编译阶段时的处理：软件工具可以利用注解信息来生成代码、Html文档或者做其他相应的处理
* 运行时的处理： 某些注解可以在程序运行时接受代码的提取

### 注解给编译器或者APT使用

```text
编译使用的场景如上；当开发者使用Annotation修饰了类、方法、Field成员之后，这些Annotation并不会
自己生效，必须由开发者提供相应的代码来提取并处理Annotation信息，这些提取和处理Annotation的代码
统称为APT(Annotation Processing Tool);
```
