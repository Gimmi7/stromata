# Distributed Store

## DynamoDB

### [Primary key](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html#HowItWorks.CoreComponents.PrimaryKey)

The Primary key can consist of one attribute(partition key) or two attributes (partition key adn sort key). KeyType=HASH (for a partition key), KeyType=RANGE (for a sort key).

The only data types allowed for pairmary key attributes are string, number, or binary.

[DynamoDB builds an unordered hash index on this primary key attribute.](https://docs.aws.amazon.com/mobile/sdkforxamarin/developerguide/dynamodb.html)

### [Secondary indexes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html#HowItWorks.CoreComponents.SecondaryIndexes)

DynamoDB supports two kinds of indexes:

- Global secondary index- An Index with a partition key and sort key that can be different from those on the table. (default quota 20)
- Local secondary index- An index that has the same partition key as the table, but a different sort key. (default quota 5)

[SecondaryIndexes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/SecondaryIndexes.html)
[Managing Global Secondary Indexes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GSI.OnlineOps.html)

You can project attributes of any data type into a global secondary index. The attributes to be projected from the table into the index:
    - KEYS-ONLY: Each item in the index consists only of the table partition key and sort key values, plus the index key values.
    - INCLUDE:  In addition to the attributes desribed in KEYS-ONLY, the secondary index includes other non-key attributes that you specify.
    - ALL: The index includes all of the attributes from the source table.

**Must specify the index when query data:**
You can access the data in a secondary index using either the Query or Scan operation. You must specify the name of the base table and the name of the index that you want to use, the attributes to be returned in the results, and any condition expressions or filters that you want to apply.

### [Best practices for using secondary indexes in DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/bp-indexes.html)

**Take advantage of sparse indexes: use sparse index:**
For any item in a table, DynamoDB writes a corresponding index entry only if the index sort key value is present in the item. If the sort key doesn't appear in every table item, or if the index partition key is not present in the item, the index is said to be sparse.

- [Using sort keys for version control](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/bp-sort-keys.html)
- [many-to-many relationships](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/bp-adjacency-graphs.html)
- [DynamoDB transactions](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/transactions.html)
- [Global tables - multi-Region replication for DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GlobalTables.html)

### [Partitions and data distribution](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.Partitions.html)

[Partitions today are only split, never merged.](https://aws.amazon.com/blogs/database/part-3-scaling-dynamodb-how-partitions-hot-keys-and-split-for-heat-impact-performance/)

**Max partition size is 10GB:**
[Be aware of item-collection size limits when creating local secondary indexes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/bp-indexes-general.html#bp-indexes-general-expanding-collections)
An item collection is all the items in a table and its local secondary indexes that have the same partition key.

DynamoDB allocates additional partitions to a table in the following situations:
    - If you increase the table's provisioned throughput settings beyond what the existing partitions can support.
    - If an existing partition fills to capacity and more storage space is required.

If your table doesn't have local secondary indexes, DynamoDB will automatically split your item collection over as many partitions as required to store the data and to serve read and write throughput.

>In a DynamoDB table, there is no upper limit on the number of distinct sort key values per partition key value.
>If you need to save many billions of items with the same partition key, DynamoDB would allocate enough storage to handel this requirement automatically.

### [DynamoDB: split for heat](https://aws.amazon.com/blogs/database/part-2-scaling-dynamodb-how-partitions-hot-keys-and-split-for-heat-impact-performance/)

DynamoDB might split a partition if that partitions receives sustained read or write traffic. However, split for heat cannot split within an item collection if there’s an LSI present or if the split is determined to not be beneficial, such as when writing an ever-increasing sort key.

**Will DynamoDB merge the splited partition when decreasing the provisioned capacity unit?**

### [DynamoDB Accelerator (DAX)](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DAX.html)

DAX is a write-through cache.

**Will DAX persist cache data to disk?**
DAX is an in-memory cache service,DAX itself doesn't flush cache data to disk, but it relies on DynamoDB's underlying storage mechanisms for data durability.

### [DynamoDB Well-Architected Lens](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/bp-wal.html)

## References

- [TiDB的数据库存储原理](http://www.voidme.com/nosql/nl-tidb-storage-principle)
- [DynamoDB](https://aws.amazon.com/dynamodb/features/?pg=dynamodbt&sec=hs)
- [How Uber Serves Over 40 Million Reads Per Second from Online Storage Using an Integrated Cache](https://www.uber.com/en-HK/blog/how-uber-serves-over-40-million-reads-per-second-using-an-integrated-cache/)
- [数据结构：图的存储结构之邻接表](https://zhuanlan.zhihu.com/p/466362219)
