# -#!/bin/bash

# 更新系统包
sudo apt update && sudo apt upgrade -y

# 安装Docker
sudo apt install docker.io -y

# 启动Docker服务
sudo systemctl start docker
sudo systemctl enable docker

# 拉取云手机Docker镜像（这里以Redroid为例，需要根据实际情况选择正确的镜像）
docker pull redroid/redroid

# 生成随机密码
VNC_PASSWORD=$(openssl rand -base64 12)

# 创建云手机容器（请根据需要调整参数）
docker run -d \
  --name redroid \
  -p 6080:6080 \
  -e EMULATOR_DEVICE="Nexus 5X" \
  -e ANDROID_VERSION="9.0" \
  -e WEB_VNC=true \
  -e VNC_PASSWORD="$VNC_PASSWORD" \
  --device /dev/kvm \
  redroid/redroid

# 获取服务器的公网IP地址
SERVER_IP=$(curl -s https://api.ipify.org)

# 显示启动信息和访问详情
echo "云手机容器已启动。"
echo "访问云手机，请使用以下信息："
echo "IP地址：$SERVER_IP"
echo "端口：6080"
echo "账号：vnc"
echo "密码：$VNC_PASSWORD"

# 提示用户记录密码
echo "请记录下随机生成的VNC密码，以便后续访问云手机。"
echo "一旦这个脚本执行完毕，你将无法再次获取这个密码。"
