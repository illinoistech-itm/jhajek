cat << EOT >> ~/.bashrc 

########## Inserted by User
export JAVA_HOME=/usr
export HADOOP_HOME=/home/vagrant/hadoop-2.8.5
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_CLASSPATH=/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar
EOT