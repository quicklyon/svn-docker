#!/bin/bash

set -xe

CONFIG_DIR="/data/config"
SVN_DIR="/data/svn"
export ADMIN_USERNAME=${ADMIN_USERNAME:-admin}
export ADMIN_PASSWORD=${ADMIN_PASSWORD:-pass4You}

mkdir -pv $CONFIG_DIR $SVN_DIR 
chown apache.apache $CONFIG_DIR $SVN_DIR

# 根据环境变量，初始化管理员用户名和密码
if [ ! -f /data/config/passwd ];then
    # 初始化管理员用户名和密码
    htpasswd -c -b /data/config/passwd "$ADMIN_USERNAME" "$ADMIN_PASSWORD"
fi

# 初始化 subversion-access-control 文件
if [ ! -f /data/config/subversion-access-control ];then
    cp /etc/subversion/subversion-access-control /data/config/
fi

# 初始化svnadmin目录
if [ ! -d /data/svnadmin ];then
    mv /opt/svnadmin/data /data/svnadmin
    /usr/bin/render-template /data/svnadmin/userroleassignments.ini.tpl > /data/svnadmin/userroleassignments.ini
else
    mv /opt/svnadmin/data /opt/svnadmin/data.$$
fi

# 修改权限
chown apache.apache /data/config /data/svnadmin -R

# 软连接svnadmin目录
[ ! -L /opt/svnadmin/data ] && ln -s /data/svnadmin /opt/svnadmin/data

# start s6
/init