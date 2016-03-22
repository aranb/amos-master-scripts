hadoop_tmp="/mnt/extra/app/hadoop/tmp"
sudo mkdir -p $hadoop_tmp
sudo chown aranb -R $hadoop_tmp
sudo chmod 750 $hadoop_tmp

zk_dir="/mnt/extra/app/zookeeper/data"
sudo mkdir -p $zk_dir
sudo chown aranb -R $zk_dir
sudo chmod 750 $zk_dir

hadoop_name="/mnt/extra/mydata/hdfs/namenode"
hadoop_data="/mnt/extra/mydata/hdfs/datanode"
sudo mkdir -p $hadoop_name
sudo chown aranb -R $hadoop_name
sudo chmod 750 $hadoop_name
sudo mkdir -p $hadoop_data
sudo chown aranb -R $hadoop_data
sudo chmod 750 $hadoop_data
