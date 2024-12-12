# Raft

## todo

- how leader find other servers in a cluster ?
- If followers crash or run slowly, or if network packets are lost, the leader retries AppendEntries RPCs indefinitely (even after it has responded to
the client) until all followers eventually store all log entries.
- does leader response to client after it commits the log?
- When reconfiguration, the removed servers can disrupt the cluster. How to use minimum election timeout and heartbeat timeout to avoid this case.
- 8

## References

- [tikv github](https://github.com/tikv/tikv)
- [raft introduce](https://raft.github.io/)
- [raft paper:In Search of an Understandable Consensus Algorithm](https://raft.github.io/raft.pdf)
- [github: dragonboat](https://github.com/lni/dragonboat)
- [得物：实战从零开始实现Raft](https://mp.weixin.qq.com/s/R2XXYFoR67VsiGwT6XM96A)
- [TiKV 源码解析系列文章（一）序](https://cn.pingcap.com/blog/tikv-source-code-reading-1/)
- [tikv/raft-rs](https://github.com/tikv/raft-rs)