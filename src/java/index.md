# JAVA

## 访问修饰符号

JAVA的访问修饰符定义了不同包和类之间的可访问性规则。关于可访问性的另外一个方面是反射，所有反射对象都可以调用 setAccessible(true), 使得任何元素(不管元素是public还是private)都变为可访问。 但是 JAVA9 模块化以后，反射也不会破坏强封装性了。

| 当前类 | 同一个包 | 不同包的子类 | 不同包的非子类 |
| :---: | :---: | :---: | :---: |
| private | default | protected | public|

## volatile的作用

1. 防止重排序(并发环境下单例的实现)(有序性原理)

```java
public class Singleton {
    public static volatile Singleton singleton;

    /**
     * 构造函数私有化，禁止外部实例化
     */
    private Singleton() {
    }

    public static Singleton getInstance() {
        if (singleton == null) {
            synchronized (singleton) {
                if (singleton == null) {
                    singleton = new Singleton();
                }
            }
        }
        return singleton;
    }
}
现在分析一下为什么要在变量singleton前面加上volatile关键字。要理解这个问题，先要了解对象的构造过程，实例化一个对象其实可以分为三个步骤：
    （1）分配内存空间
    （2）初始化对象
    （3）将内存空间的地址赋值给对应的引用
但是由于操作系统可以对指令进行重排序，所以上面的过程也可能会变成如下过程：
    （1）分配内存空间
    （2）将内存空间的地址赋值给对应的引用
    （3）初始化对象
如果是这个流程，多线程环境下就可能将一个未初始化的对象的引用给暴露出来，从而导致不可预料的结果。因此，为了防止这个过程
的重排序，我们需要将变量设置为volatile类型的变量。 
原理：JSR 133中定义了java的happen-before规则，简单说就是如果a happen-before b,则a所做的任何操作对b是可见的。
然后在happen-before规则中有这么一条： A write to a volatile field happens before every subsequent read of that volatile.
```

2. 实现可见性（可见性原理）

```java
public class ShareData{
    int a=1;
    int b=1;

    change(){
        a=2;
        b=2;
    }
}
两个线程共享变量ShareData,线程1调用change()方法修改共享变量，
线程2输出共享变量，理论上数值要么是(1,1),要么是(2,2),可是多次执行后会出现(1,2),(2,1)的情况；
原因就是每个线程都从自己的线程工作内存中读写数据，导致两个不能及时知道对方的修改。
原理：线程本身并不直接与主内存进行数据的交互，而是通过线程的工作内存来完成相应的操作，volatile变量的写操作与普通变量有以下两点区别：
（1）修改volatile变量时会强制将修改后的值刷新到主内存中；
（2）修改volatile变量后会导致其他线程工作内存中的对应变量值失效，因此，再读取该变量的时候就需要重新读取主内存中的值；
```

3. 保证对64bit值的单次写的原子性

```text
double 和 long都是64bit的数据，jvm的内存模型允许将64位数据分成高32位和低32位来进行处理；
这样就会导致一次写操作实际上对应了两个写操作。 虽然鼓励jvm实现时避免将 64-bit的数据分成两个32-bit来处理，
不过程序员最好将 64-bit的数据定义为 volatile or synchronize来避免在并发情况下可能出现的问题；
```

## Synchronized

Synchronized 通过 monitorenter 指令获取到对象的 monitor (通常称之为对象锁,互斥锁)，如果程序正常执行，则在 return 之前通过 moniterexit 指令释放 monitor；如果程序执行过程中产生了异常，需要抛出异常，则在抛出异常之前通过 moniterexit 指令释放掉 monitor。

Synchronized 可以用来给对象，对象的实例加锁，同时也可以用来标识一个方法在执行时会获取对象锁。当使用在不同的位置时，被锁定的target也不一样。

|使用位置|被锁的target|示例代码|
|:-:|:-:|:-:|
|class|class|synchoronized(HelloWorld.class){......}|
|class实例|class实例|final String lock="str_lock"; synchonized (lock) {......}|
|普通方法|class实例|public synchronized void hi() {......}|
|静态方法|class|public static synchronized void hello() {......}|

## References

* [简书: 让你彻底理解Synchronized](https://www.jianshu.com/p/d53bf830fa09)
