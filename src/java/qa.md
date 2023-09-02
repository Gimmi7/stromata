# QA

- **Kafka为什么吞吐量大、速度快**

  Kafka的吞吐量大、速度快可以从三个方面进行分析，读，写，传输, 缓存。
  Kafka的读写都是都是以**零拷贝**的方式进行**顺序读写**，在传输过程中通过**批量读写**和**批量压缩**来增加吞吐量。

  - Kafka的一个Partition就是一个文件夹，文件夹下有多个sements，每次写的时候把消息插入到文件末尾(顺序写)，而且写的时候是通过mmap减少了CPU在用户态和内核态的切换次数。

  ```java
  MappedByteBuffer mappedByteBuffer = fileChannel.map
  (FileChannel.MapMode.READ_WRITE, 0, filechannel.size());
  ```

  - Kafka读的时候，把数据从磁盘加载到内核缓冲区后,通过sendfile直接将数据复制到socket缓冲区，然后直接复制到NIC缓冲区(network interface card)，发送到网络上。

  ```java
  sun.nio.ch.FileChannelImpl
  public long transferTo(long position, long count,
                           WritableByteChannel target)
        throws IOException
    {...}
  ```

  - Kafka的读写操作都支持批量模式，压缩也支持批量模式，提升了吞吐量
  - Kafka中的读写操作都会利用操作系统的 Page Cache 来做缓存，这样部分的能够命中缓存的读写都不需要进行磁盘IO。Kafka同时也提供了同步刷盘和间歇性刷盘的功能，这些功能通过 log.flush.interval.messages, log.flush.interval.ms 等参数来控制。

- **Kafka Coordinator都存储哪些数据**

  每个KafkaServer都有一个GroupCoordinatior实例，管理多个Consumer group,主要用于offset管理和Consumer rebalance.
  - Consumer group的配置信息，如 session timeout
  - Consumer group中每个Consumer的元数据，包括主机名，consumer id 等
  - Consumer group 对应的 topic partition的 offsets
  - consumer和partition的映射关系

- **Kafka的消息存储结构**
  
  Kafka的消息是按照分区分段的方式来存储的，存储的文件包括数据文件和索引文件。每个Partition对应一个文件夹，这个文件夹下包含这个Partition的所有数据文件和索引文件。索引文件的存储格式为 (kth, positon), 其中 kth 表示该条记录为索引文件的第几行(也就对应来数据文件中的第几条消息)， position 表示该条消息在数据文件中的物理偏移地址。另外Kafka的索引文件采用的是稀疏索引，并没有保存每一条消息的物理偏移地址，这样可以节省磁盘空间。

- **Kafka使用场景**
  - 日志聚合(N-1)：可以将多台主机的日志抽象成一个个的日志事件流，然后利用spark,flink等大数据批流处理系统进行日志分析。
  - 数据中转枢纽(1-N)：通常，同一份数据需要被多个系统使用。举个例子，可以将mysql binlog日志，通过flink CDC 处理后投递到Kafka,然后同步数据给ES,redis等进行数据同步。
  - 广播数据(1-N): 可以将消息广播给所有的在线用户，广播给一个群或者直播间等所有用户。
  - 解耦：点赞，关注等行为会触发一系列的任务活动，可以把互动消息投递到Kafka,然任务系统和互动系统解耦。
  - 异步通信：注册和发送短信验证码，可以通过Kafka来达到异步通信的效果。
  - 消峰填谷：在秒杀场景中，可以将请求通过Kafka来将请求入队列，防止后端服务被峰值流量打垮。

- **如何规避mysql死锁**
  - innodb_lock_wait_timeout, innodb事务等待一个行锁的默认等待时间为50s, 通过 show engine innodb status 查看LATEST DETECTED DEADLOCK(最新一次死锁的日志)，然后分析产生死锁的原因，修改代码。
  - 如果对性能要求不高，且代码短时间不好优化，调整事务隔离级别为串行化。
  - 添加一个version字段，使用CAS来避免出现死锁。
  - 在代码层面，尽量让多个事务sql顺序一致，将大事务拆分为小事务等可以降低死锁的概率。
  
- **docker build 的缓存机制**

  通过 ``` docker image history ``` 我们可用发现docker镜像在每一条命令后都创建了一个新的镜像层。在构建过程中，docker会通过一条命令是否完全相同来判断是否使用 Layer caching,对于 ```ADD,COPY```命令,docker 需要额外检查复制前后文件的校验和是否相同来判断是否命中缓存，不过校验和的计算不使用文件的最后修改和最后访问时间。

## References

- [Kafka为什么吞吐量大、速度快](https://zhuanlan.zhihu.com/p/120967989)
- [Java 两种zero-copy零拷贝技术mmap和sendfile的介绍](https://juejin.cn/post/7016498891365302302)
- [kafka知识点--offset管理和Consumer Rebalance](https://cloud.tencent.com/developer/article/1596725)
- [Kafka 的消息存储结构：索引文件与数据文件](https://shuyi.tech/archives/kafka-message-storage)
- [docker 镜像构建时的缓存机制](https://blog.csdn.net/wenyichuan/article/details/106994660)
- [Java JVM 可观测的原理解释和落地方案对比](https://www.infoq.cn/article/3iwv28hezcgcypdfmwsd)
