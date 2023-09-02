# ZooKeeper

## ZooKeeper watch的过程(会重试吗，有ack吗)

zookeeper的watch通知不是可靠的，没有进行ack.

```java
public class NIOServerCnxn extends ServerCnxn {
    @Override
    public void process(WatchedEvent event) {
        ReplyHeader h = new ReplyHeader(ClientCnxn.NOTIFICATION_XID, event.getZxid(), 0);
        if (LOG.isTraceEnabled()) {
            ZooTrace.logTraceMessage(
                    LOG,
                    ZooTrace.EVENT_DELIVERY_TRACE_MASK,
                    "Deliver event " + event + " to 0x" + Long.toHexString(this.sessionId) + " through " + this);
        }

        // Convert WatchedEvent to a type that can be sent over the wire
        WatcherEvent e = event.getWrapper();

        // The last parameter OpCode here is used to select the response cache.
        // Passing OpCode.error (with a value of -1) means we don't care, as we don't need
        // response cache on delivering watcher events.
        int responseSize = sendResponse(h, e, "notification", null, null, ZooDefs.OpCode.error);
        ServerMetrics.getMetrics().WATCH_BYTES.add(responseSize);
    }

    @Override
    public int sendResponse(ReplyHeader h, Record r, String tag, String cacheKey, Stat stat, int opCode) {
        int responseSize = 0;
        try {
            ByteBuffer[] bb = serialize(h, r, tag, cacheKey, stat, opCode);
            responseSize = bb[0].getInt();
            bb[0].rewind();
            sendBuffer(bb);
            decrOutstandingAndCheckThrottle(h);
        } catch (Exception e) {
            LOG.warn("Unexpected exception. Destruction averted.", e);
        }
        return responseSize;
    }
}
```

## ZooKeeper 怎么保证有序执行

zookeeper采用了全局递增的事务id来标识所有的proposal, zxid 为事务id,是一个64位的数字。高32位为epoch, 用来标识 leader
周期，如果有新的 leader 选举出来，epoch 会自增。低32位用来递增proposal。依赖两阶段提交过程，首先向其他server发出事务执行请求，
如果超过半数机器都执行成功，那么事务才会被提交。

## 为什么ZooKeeper 重连时要使用老的 session_id，而不是完全重新建立连接

zookeeper的 session 分为 local session 和 global session。\
global session 的连接信息保存在所有的 server 节点，所以创建 global session 开销比较大，需要经过共识算法。
在有效期内进行重新连接不需要经过共识算法，开销低还能恢复到断开连接前的工作状态。
只有 global session 支持创建临时节点。

## persistent recursive watch 不会触发 NodeChildrenChanged 事件

持久递归监视器会触发 NodeCreated, NodeDeleted, NodeDataChanged 三个事件，同时如果需要递归的话，则是对子节点也触发这三个事件，所以
NodeChildrenChanged 就显得多余了。

zookeeper的监听器设计成一次性的是位性能考虑，如果server端的每次数据更新都需要同步客户端，在并发度高的情况下，性能下降会很明显。
持久递归监听器其实也是一次性的，跟普通的 watcher 一样，当递归监听器的某个子节点事件被触发之后，在对其调用 getData()
之前，不会再次触发事件。

## ZooKeeper怎么保证客户端先接收到 watch 事件，然后才能看到数据

a client will never see a change for which it has set a watch until it first sees the watch event.
ZooKeeper确保了事件和异步应答的有序分发，具体实现细节是通过synchronized加锁把所有的出站数据进行入队列操作。

```java
public class NIOServerCnxn extends ServerCnxn {

    private final Queue<ByteBuffer> outgoingBuffers = new LinkedBlockingQueue<>();

    /**
     * sendBuffer pushes a byte buffer onto the outgoing buffer queue for
     * asynchronous writes.
     */
    public void sendBuffer(ByteBuffer... buffers) {
        if (LOG.isTraceEnabled()) {
            LOG.trace("Add a buffer to outgoingBuffers, sk {} is valid: {}", sk, sk.isValid());
        }

        synchronized (outgoingBuffers) {
            for (ByteBuffer buffer : buffers) {
                outgoingBuffers.add(buffer);
            }
            outgoingBuffers.add(packetSentinel);
        }
        requestInterestOpsUpdate();
    }
}
```

## ZooKeeper的watch维护在local server

Watches are maintained locally at the ZooKeeper server to which the client is connected.

## ZooKeeper SSL 为什么需要客户端提供keystore

## ZooKeeper的客户端在重连时处理了 "羊群效应" 问题

Only create a new session when you are notified of session expiration (mandatory).
只有在session过期时才创建新的session，其他情况下都使用老的session_id进行连接，这样就不用经过共识算法投票。

## References

* [使用Docker搭建ZooKeeper集群](https://cloud.tencent.com/developer/article/1680299)
* [[Linux内存机制]Swap机制以及如何手动释放swap和内存](https://zhuanlan.zhihu.com/p/552203964)
* [curator recipes](https://curator.apache.org/docs/recipes)
* [知乎: Zookeeper 通知更新可靠吗？ 解读源码找答案](https://zhuanlan.zhihu.com/p/46329541)
* [zookeeper永久递归监听器其实也是一次性的](https://blog.51cto.com/u_15162069/2901274)