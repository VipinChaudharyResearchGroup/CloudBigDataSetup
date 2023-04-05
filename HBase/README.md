# HBase

HBase is a distributed, scalable, open-source, non-relational, big data sore, written in Java, based on Google’s [BigTable](https://cloud.google.com/bigtable/docs/hbase-bigtable).
It can be run on top of HDFS and Hadoop, or on top of other file systems like Amazon S3.
It is a column-oriented database management system (DBMS).
More information about HBase can be found [here](https://hbase.apache.org/book.html#_reference).

Thanks to [Apache Thrift](https://hbase.apache.org/book.html#_thrift), HBase can be accessed from a client that is not written in Java, like Python.


HBase integrations
- Apache Spark, we can use it alongside Apache Spark to build a big data pipeline.
- Apache Hive, we can use HBase and Hive,
    - to query HBase tables.
    - to query data stored in HDFS.

# HBase Setup

Create a VM with Debian 11 and install HBase on it.

```bash
    ISO=/path/to/isos
    STORAGE=/path/to/storage

    # create a new bridge
    virsh net-define /path/to/bridge.xml
    # start the bridge
    virsh net-start extbr

    NET="extbr"
    VM="deb-hbase-local"


    # create a new VM
    virt-install \
                --name ${VM} \
                --os-variant debian10 \
                --memory 2048 \
                --vcpus 2 \
                --network bridge:${NET} \
                --disk path="${STORAGE}/${VM}.qcow2",size=20 \
                --cdrom "${ISO}/debian-11.6.0-amd64-netinst.iso"

    # VM info
    # hostname hbase
    # domainname hbase
    # user: ***
    # pass: ***

```

# Install HBase on the VM


Install Java jre

```bash
    sudo apt install default-jre
```

Go to download page and download the latest version of HBase from [here](https://hbase.apache.org/downloads.html).

```bash
    wget https://dlcdn.apache.org/hbase/2.5.3/hbase-2.5.3-bin.tar.gz
    tar xzvf hbase-2.5.3-bin.tar.gz 
    mv hbase-2.5.3 /usr/local/hbase
```

# Configure HBase

```bash
    echo export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64 >> /usr/local/hbase/conf/hbase-env.sh
    cd /usr/local/hbase/conf
    cp hbase-env.sh.template hbase-env.sh
    cp hbase-site.xml.template hbase-site.xml
```

edit hbase-env.sh

```bash
    export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
```

start HBase
```bash
    ./bin/start-hbase.sh
```

After starting HBase, you can see the HBase Dashboard at http://localhost:16010/master-status


For more information about HBase configuration, see [here](https://hbase.apache.org/book.html#_configuration).


# Test HBase

```bash
    # go to HBase shell
    ./bin/hbase shell
    # see the list of tables
    list
    # create a table
    create 'test', 'cf'
    # see the list of tables
    list
    # put some data
    put 'test', 'row1', 'cf:a', 'value1'
    put 'test', 'row2', 'cf:a', 'value2'
    # get the data
    get 'test', 'row1'
    # scan the table
    scan 'test'
    # exit the shell
    exit
```


# Test HBase with Python


For using HBase with Python, we need to start the Thrift server.

```bash
    # edit hbase-site.xml
    <property>
        <name>hbase.thrift.port</name>
        <value>9090</value>
    </property>
```
What Thrift does is to provide a way to access HBase from a client that is not written in Java, like Python.

For more information about Thrift, see [here](https://hbase.apache.org/book.html#_thrift).

```bash
    ./bin/hbase-daemon.sh start thrift
```

```python
    # connect to HBase shell with python as a client
    import happybase
    connection = happybase.Connection('localhost', port=9090)
    connection.tables()
    # create a table
    table = connection.table('test')
    # put some data
    table.put(b'row3', {b'cf:a': b'value3'})
    table.put(b'row4', {b'cf:a': b'value4'})
    # get the data
    table.row(b'row3')
    # scan the table
    for key, data in table.scan():
        print(key, data)
    # close the connection
    connection.close()
```




# Google Colab Notebook

https://colab.research.google.com/drive/1n7nPbuGqCTZXvsI7kcHzPt0ELoPikzKU#scrollTo=ARJqJFs6gcNn
