#!/bin/bash

ISO=/media/mohsen/ssd500/virtspace/isos
#ISO = /home/mohsen/virtspace/isos
STORAGE=/media/mohsen/ssd500/virtspace/storages


NET="extbr"
VM="deb-hbase-local"



virt-install \
            --name ${VM} \
            --os-variant debian10 \
            --memory 2048 \
            --vcpus 2 \
            --network bridge:${NET} \
            --disk path="${STORAGE}/${VM}.qcow2",size=20 \
            --cdrom "${ISO}/debian-11.6.0-amd64-netinst.iso"


# hostname hbase
# domainname hbase
# user: ***
# pass: ***


sudo apt install default-jre

https://hbase.apache.org/downloads.html

wget https://dlcdn.apache.org/hbase/2.5.3/hbase-2.5.3-bin.tar.gz

tar xzvf hbase-2.5.3-bin.tar.gz 


echo export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64 >> /path/to/hbase/conf/hbase-env.sh
echo export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64 >> /home/hu/down/hbase-2.5.3/conf/hbase-env.sh



start HBase
./bin/start-hbase.sh

Dashboard  http://localhost:16010/master-status

#go to HBase shell
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

# start thrift server
./bin/hbase-daemon.sh start thrift


# connect to HBase shell with python as a client
import happybase
connection = happybase.Connection('localhost')
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



stop HBase
./bin/stop-hbase.sh

# stop thrift server
# ./bin/hbase-daemon.sh stop thrift