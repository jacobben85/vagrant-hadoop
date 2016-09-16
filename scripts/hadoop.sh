#!/usr/bin/env bash

addgroup hadoop
usermod -a -G hadoop $USER

#ssh-keygen -f /home/vagrant/.ssh/id_rsa -t rsa -P ""
#cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
#ssh-keyscan localhost >> /home/vagrant/.ssh/known_hosts

wget http://mirrors.sonic.net/apache/hadoop/common/hadoop-2.6.0/hadoop-2.6.0.tar.gz
tar xvzf hadoop-2.6.0.tar.gz
mv hadoop-2.6.0 /usr/local/hadoop

chown -R vagrant:hadoop /usr/local/hadoop

cat <<EOF >> /home/vagrant/.bashrc

#HADOOP VARIABLES START
export JAVA_HOME=\$JAVA_HOME
export HADOOP_INSTALL=/usr/local/hadoop
export PATH=\$PATH:\$HADOOP_INSTALL/bin
export PATH=\$PATH:\$HADOOP_INSTALL/sbin
export HADOOP_MAPRED_HOME=\$HADOOP_INSTALL
export HADOOP_COMMON_HOME=\$HADOOP_INSTALL
export HADOOP_HDFS_HOME=\$HADOOP_INSTALL
export YARN_HOME=\$HADOOP_INSTALL
export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_INSTALL/lib/native
export HADOOP_OPTS="-Djava.library.path=\$HADOOP_INSTALL/lib"
#HADOOP VARIABLES END

EOF

export JAVA_HOME=$JAVA_HOME
export HADOOP_INSTALL=/usr/local/hadoop
export PATH=$PATH:$HADOOP_INSTALL/bin
export PATH=$PATH:$HADOOP_INSTALL/sbin
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export YARN_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"

sed -i "s/export JAVA_HOME=\${JAVA_HOME}/export JAVA_HOME=\/usr\/lib\/jvm\/java-8-oracle/" /usr/local/hadoop/etc/hadoop/hadoop-env.sh

mkdir -p /app/hadoop/tmp
chown vagrant:hadoop /app/hadoop/tmp

sed -i '/<configuration>/r /vagrant/configs/core-site.txt' /usr/local/hadoop/etc/hadoop/core-site.xml
sed -i 's///' /usr/local/hadoop/etc/hadoop/core-site.xml

cp /usr/local/hadoop/etc/hadoop/mapred-site.xml.template /usr/local/hadoop/etc/hadoop/mapred-site.xml
sed -i '/<configuration>/r /vagrant/configs/mapred-site.txt' /usr/local/hadoop/etc/hadoop/mapred-site.xml
sed -i 's///' /usr/local/hadoop/etc/hadoop/mapred-site.xml

mkdir -p /usr/local/hadoop_store/hdfs/namenode
sudo mkdir -p /usr/local/hadoop_store/hdfs/datanode
sudo chown -R vagrant:hadoop /usr/local/hadoop_store

sed -i '/<configuration>/r /vagrant/configs/hdfs-site.txt' /usr/local/hadoop/etc/hadoop/hdfs-site.xml
sed -i 's///' /usr/local/hadoop/etc/hadoop/hdfs-site.xml

sudo -H -u vagrant bash -c "hadoop namenode -format"

chown -R vagrant:hadoop /usr/local/hadoop

