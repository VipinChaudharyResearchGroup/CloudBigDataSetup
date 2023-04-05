
# Hive
- Hive is a data warehouse infrastructure that provides data summarization and ad hoc queries.
- We can use Hive to query data in HDFS, HBase, and other data sources.
- Convert SQL to MapReduce
- SQL in Hive is called HiveQL, it is a superset of SQL-92, which supports around 90% of ANSI SQL.


source: https://www.quora.com/What-is-the-difference-between-Hive-and-Spark-SQL



# Setup Hive on a single node



```bash
install java jdk 11
apt install openjdk-11-jre-headless
apt install wget
```

Download the latest version of Hive from the [Apache Hive website](https://hive.apache.org/downloads.html)
```bash
wget https://downloads.apache.org/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz
tar -xvf apache-hive-3.1.3-bin.tar.gz
mv apache-hive-3.1.3-bin /usr/local/hive
```

configure hive
```bash
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> /usr/local/hive/conf/hive-env.sh'
```



start hive
```bash
/usr/local/hive/bin/hive
```

Check if hive is running by running the following command:
```bash
ss -tulpn | grep 10002
```

The hive dashboard is available at http://IP:10002

