DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := 2.0.0-hadoop3.3.5-java11
build:
	docker build --tag bde2023/hadoop-base-aarch64:$(current_branch) ./base
	docker build --tag bde2023/hadoop-namenode-aarch64:$(current_branch) ./namenode
	docker build --tag bde2023/hadoop-datanode-aarch64:$(current_branch) ./datanode
	docker build --tag bde2023/hadoop-resourcemanager-aarch64:$(current_branch) ./resourcemanager
	docker build --tag bde2023/hadoop-nodemanager-aarch64:$(current_branch) ./nodemanager
	docker build --tag bde2023/hadoop-historyserver-aarch64:$(current_branch) ./historyserver
