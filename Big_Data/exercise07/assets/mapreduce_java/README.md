https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-hbase-build-java-maven-linux

## When you start
```bash
SSHUSER="sshuser"
CLUSTERNAME="..."
ssh-copy-id $SSHUSER@$CLUSTERNAME-ssh.azurehdinsight.net
scp $SSHUSER@$CLUSTERNAME-ssh.azurehdinsight.net:/etc/hbase/conf/hbase-site.xml ./conf/
alias mapreduce-wc='ssh $SSHUSER@$CLUSTERNAME-ssh.azurehdinsight.net yarn jar wordcount-1.0-SNAPSHOT.jar MapReduceWordCount "$@"'
```

## To compile

```bash
mvn package && scp target/wordcount-1.0-SNAPSHOT.jar $SSHUSER@$CLUSTERNAME-ssh.azurehdinsight.net:
```

## To run the word count map-reduce job (using a file as source)

```bash
mapreduce-wc <hdfs_input_path> <hdfs_output_path>
```

or directly calling `yarn`:

```bash
yarn jar wordcount-1.0-SNAPSHOT.jar MapReduceWordCount <hdfs_input_path> <hdfs_output_path>
```
