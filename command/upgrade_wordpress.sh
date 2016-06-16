#!/bin/bash

# 升级前，先关闭 nginx 服务
service nginx stop

# 先解锁文件
find /home/wwwroot -mindepth 1 -maxdepth 1 -type d| xargs -n 1 chattr -R -i

# 再复制更新到所有站点
find /home/wwwroot -mindepth 1 -maxdepth 1 -type d| xargs -n 1 \cp /home/www/wordpress/* -fra

# 然后锁定文件
find /home/wwwroot -mindepth 1 -maxdepth 1 -type d| xargs -n 1 chattr -R +i
find /home/wwwroot -mindepth 1 -maxdepth 3 -type d -name 'upload*'| xargs -n 1 chattr -R -i
find /home/wwwroot -mindepth 1 -maxdepth 3 -type d -name 'cache*'| xargs -n 1 chattr -R -i

# 然后启动服务器
service nginx start