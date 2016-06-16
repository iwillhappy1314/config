#!/bin/bash

# 定义没有 PHP 文件的目录
UPLOAD=$(find /home/wwwroot -mindepth 1 -maxdepth 3 -type d -name 'upload*');
UPGRADE=$(find /home/wwwroot -mindepth 1 -maxdepth 3 -type d -name 'upgrade*');
LANGS=$(find /home/wwwroot -mindepth 1 -maxdepth 3 -type d -name 'languages*');

# 遍历所有目录, 移除这些目录中的所有 PHP 文件
for SITE in $UPLOAD $UPGRADE $LANGS
do
        find $SITE -name '*.php' -type f -print -exec rm -rf {} \;
done