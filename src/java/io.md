# IO

一个输入操作通常包括两个阶段：

* 等待数据准备好
* 从内核向进程复制数据

## Unix 下有5种 IO 模型

* 阻塞式IO (BIO)

  >应用进程调用 recvfrom 后被阻塞，直到等待数据和复制数据两个阶段都完成。\
  > 效率高。

* 非阻塞式IO (NIO)

  > 应用进程不停地调用 recvfrom 直到操作系统返回OK。\
  > cpu需要处理多次系统调用，效率低。
  
* IO复用 (select,poll,epoll)

  > 使用select或者poll等待数据，等待多个套接字中的一个变为可读，然后调用 recvfrom。\
  > IO复用不需要进程线程的创建和切换，系统开销小。

* 信号驱动IO (SIGIO)

  > 数据准备好后内核会给应用进程发送信号，收到信号后调用 recvfrom。 \
  > 比NIO不停地轮询更加高效合理。

* 异步IO (AIO)

  > 等待数据和复制数据两个阶段都完成后，内核再给应用进程发送信号。  \
  > 效率最高的方案， BIO,NIO,IO复用,SIGIO 在复制数据阶段都会阻塞，AIO完全无阻塞。

## 零拷贝

零拷贝(英语: Zero-copy) 技术是指计算机执行操作时，CPU不需要先将数据从某处内存复制到另一个特定区域。这种技术通常用于通过网络传输文件时节省CPU周期和内存带宽。

* mmap 内存映射

  > 数据从磁盘经过DMA加载在内核后，对应用程序缓冲区和内核缓冲区进行映射，省略掉从kernel buffer到 application buffer的复制。

* sendfile

  > 当进行 sendfile() 系统调用时，数据从磁盘经过DMA加载到 kernel buffer, 然后从 kernel buffer 直接复制到 socket buffer， 再从 socket buffer 拷贝到 网卡buffer, 然后发送到网络上。如果网卡支持 SG-DMA（The Scatter-Gather Direct Memory Access）技术，数据就可以直接从 kernel buffer 复制到 网卡buffer, 完全不通过cpu。

## Reactor 模式

![reactor schema](../assets/reactor_schema.png)

1. mainReactor对象通过select监听事件
2. 如果是建立连接到事件，则由Acceptor进行处理
3. 如果不是连接事件，则由subReactor进行处理
4. 把读取到的事件通过线程池调用handler进行处理
5. 处理完成后发送给subReactor，返回响应

## References

* [Java全栈知识体系:IO模型](https://pdai.tech/md/java/io/java-io-model.html#i-o-%E6%A8%A1%E5%9E%8B%E6%AF%94%E8%BE%83)
