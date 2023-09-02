# 分布式锁

## 可重入锁的意义

可重入锁主要是为了满足嵌套调用不产生死锁的需求。 比如一个方法加锁进行执行，在方法内部又调用了另外一个同样进行加锁的方法，那么这种情况下可重入锁就不会发生死锁。Java的 **synchronized, ReentrantLock**都是可重入锁。

## 基于redis实现ReentrantLock

redisson的 RedissonLock 就是基于redis实现了可重入锁。

加锁部分的逻辑如下：使用了redis的Hash来实现，hash field为 UUID:ThreadId, hsah value和Java AQS里面的state一样，获取锁是自增，释放锁时自减。

```java
    <T> RFuture<T> tryLockInnerAsync(long waitTime, long leaseTime, TimeUnit unit, long threadId, RedisStrictCommand<T> command) {
        return commandExecutor.syncedEval(getRawName(), LongCodec.INSTANCE, command,
                "if ((redis.call('exists', KEYS[1]) == 0) " +
                            "or (redis.call('hexists', KEYS[1], ARGV[2]) == 1)) then " +
                        "redis.call('hincrby', KEYS[1], ARGV[2], 1); " +
                        "redis.call('pexpire', KEYS[1], ARGV[1]); " +
                        "return nil; " +
                    "end; " +
                    "return redis.call('pttl', KEYS[1]);",
                Collections.singletonList(getRawName()), unit.toMillis(leaseTime), getLockName(threadId));
    }
```

解锁部分的逻辑如下：对Hash结构的下的 state 进行自减，如果锁被释放掉了，则通过 publish redisson_lock__channel:{$name} 0 , 发送解锁消息。

```java
    protected RFuture<Boolean> unlockInnerAsync(long threadId) {
        return evalWriteAsync(getRawName(), LongCodec.INSTANCE, RedisCommands.EVAL_BOOLEAN,
              "if (redis.call('hexists', KEYS[1], ARGV[3]) == 0) then " +
                        "return nil;" +
                    "end; " +
                    "local counter = redis.call('hincrby', KEYS[1], ARGV[3], -1); " +
                    "if (counter > 0) then " +
                        "redis.call('pexpire', KEYS[1], ARGV[2]); " +
                        "return 0; " +
                    "else " +
                        "redis.call('del', KEYS[1]); " +
                        "redis.call(ARGV[4], KEYS[2], ARGV[1]); " +
                        "return 1; " +
                    "end; " +
                    "return nil;",
                Arrays.asList(getRawName(), getChannelName()),
                LockPubSub.UNLOCK_MESSAGE, internalLockLeaseTime, getLockName(threadId), getSubscribeService().getPublishCommand());
    }
```

watchdog部分的逻辑：如果我们不知道任务要执行多久，就可以把 leaseTime 设置为 <=0 的值， wartchdog会每 leaseTime/3 进行一次延长锁的过期时间的操作。 lockWatchdogTimeout 的默认值为30s，当我们把leaseTime设置为 <=0 的值时，redisson会使用 lockWatchdogTimeout 来充当 leaseTime, lockWatchdogTimeout 的默认值可以在构造 redissonClient 的配置里面进行设置。

```java
    protected CompletionStage<Boolean> renewExpirationAsync(long threadId) {
        return evalWriteAsync(getRawName(), LongCodec.INSTANCE, RedisCommands.EVAL_BOOLEAN,
                "if (redis.call('hexists', KEYS[1], ARGV[2]) == 1) then " +
                        "redis.call('pexpire', KEYS[1], ARGV[1]); " +
                        "return 1; " +
                        "end; " +
                        "return 0;",
                Collections.singletonList(getRawName()),
                internalLockLeaseTime, getLockName(threadId));
    }
```

## References

* [redisson github](https://github.com/redisson/redisson)
* [redis的 pub/sub 实现原理](https://juejin.cn/post/6896711655099465735)
* [Redis高级特性之Pub/Sub与Stream](https://cloud.tencent.com/developer/article/1456457)
* [redis三种模式原理介绍](https://blog.csdn.net/qq_38658567/article/details/106840141)
* [阿里云：一文详解Redis中BigKey、HotKey的发现与处理](https://juejin.cn/post/7001030996384546847)
