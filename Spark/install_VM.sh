
# Add JAVA installation


# use profile.d instead of user home
cat <<EOF | sudo tee /etc/profile.d/hadoop_java.sh
export JAVA_HOME=\$(dirname \$(dirname \$(readlink \$(readlink \$(which javac)))))
export HBASE_HOME=/usr/local/hbase
export PATH=\$PATH:\$JAVA_HOME/bin:\$HBASE_HOME/bin
EOF


# set iptables to expose spark ports
# Dashboard
# Master