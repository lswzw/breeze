#!/bin/bash

#取消SELINUX设定及放开防火墙
systemctl enable firewalld.service
systemctl restart firewalld.service
setenforce 0
sed --follow-symlinks -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
firewall-cmd --set-default-zone=trusted
firewall-cmd --complete-reload

# 设置 yum repository
yum install -y yum-utils \
device-mapper-persistent-data \
lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 安装并启动 docker
yum install -y docker-ce-18.09.8 docker-ce-cli-18.09.8 containerd.io

mkdir -p /etc/docker/
cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
EOF

systemctl enable docker
systemctl start docker

#安装docker-compose命令
yum install -y docker-compose

#下载对应版本的docker-compose文件
#curl -L https://raw.githubusercontent.com/wise2c-devops/breeze/v1.15.4/docker-compose-centos.yml -o docker-compose.yml

#导入离线镜像
#docker load -i breeze.tar

#运行docker-compose
#docker-compose up -d

#ssh免密登录 & 生成秘钥
#ssh-keygen -t rsa
#发送秘钥
#ssh-copy-id 192.168.6.190

#open chrome  IP:88

