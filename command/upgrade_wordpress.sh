#!/bin/bash

WP_Version=""

read -p "请输入 WordPress 版本号 (如: 4.6.1 ): " WP_Version

wget -O /tmp/wordpress-${WP_Version}-no-content.zip https://downloads.wordpress.org/release/wordpress-${WP_Version}-no-content.zip

echo "+---------------------------------------------------------+"
echo "|  即将升级服务器上的所有站点到 WordPress ${WP_Version}"
echo "+---------------------------------------------------------+"

unzip -o /tmp/wordpress-${WP_Version}-no-content.zip -d /tmp/

#  升级前，先关闭 nginx 服务，避免因解锁文件出现安全文件
service nginx stop

# 先解锁文件
find /home/wwwroot -mindepth 1 -maxdepth 1 -type d| xargs -n 1 chattr -R -i

# 再复制更新
find /home/wwwroot -mindepth 1 -maxdepth 1 -type d| xargs -n 1 \cp /tmp/wordpress/* -fra

rm /home/wwwroot/zhongcaidepu.com/*.php
rm /home/wwwroot/kewei99.com/*.php

# 然后锁定文件
find /home/wwwroot -mindepth 1 -maxdepth 1 -type d| xargs -n 1 chattr -R +i
find /home/wwwroot -mindepth 1 -maxdepth 3 -type d -name 'upload*'| xargs -n 1 chattr -R -i
find /home/wwwroot -mindepth 1 -maxdepth 3 -type d -name 'cache*'| xargs -n 1 chattr -R -i

find /home/wwwroot -mindepth 1 -maxdepth 3 -type d -name 'kewei99*'| xargs -n 1 chattr -R -i

service nginx start

echo "+---------------------------------------------------------+"
echo "|  已更新所有站点到 WordPress ${WP_Version}"
echo "+---------------------------------------------------------+"