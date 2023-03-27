#!/usr/bin/bash

# NEEDS JAVA (just runtim) and JAVA_HOME must be set up

# Change your home path. if using $HOME, don't run as a sudoer user 
HOME=/home/mohsen

sudo apt update
sudo apt install -y wget
wget https://dlcdn.apache.org/spark/spark-3.3.2/spark-3.3.2-bin-hadoop3.tgz
tar -xzf spark-3.3.2-bin-hadoop3.tgz 
mv spark-3.3.2-bin-hadoop3 $HOME/apps/
rm spark-3.3.2-bin-hadoop3.tgz

# if you don't have .bash_custom in .bashrc, you should add it
cat << EOF >> $HOME/.bash_custom
export SPARK_HOME="$HOME/apps/spark-3.3.2-bin-hadoop3"
export PATH="$SPARK_HOME/bin:$SPARK_HOME/sbin:${PATH}"
EOF

source $HOME/.bashrc

start-master.sh

start-worker.sh  spark://localhost:7077

ss -tunelp | grep 8080
ss -tunelp | grep 7077

# Spark Dashboard http://localhost:8080/

