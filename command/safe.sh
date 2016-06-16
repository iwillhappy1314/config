#!/bin/bash

# 所有目录加写保护
find /home/wwwroot -mindepth 1 -maxdepth 1 -type d| xargs -n 1 chattr -R +i

# 需要写入文件的目录去写保护
find /home/wwwroot -mindepth 1 -maxdepth 3 -type d -name 'upload*'| xargs -n 1 chattr -R -i
find /home/wwwroot -mindepth 1 -maxdepth 3 -type d -name 'cache*'| xargs -n 1 chattr -R -i
find /home/wwwroot -mindepth 1 -maxdepth 3 -type d -name 'xxx*'| xargs -n 1 chattr -R -i
chattr -R -i /home/wwwroot/xxx.com/