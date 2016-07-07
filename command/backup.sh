#!/bin/bash
# 一些配置
DROPBOX_DIR=/$(date +%Y-%m-%d) # Dropbox 目录，根目录 / 是你已经创建的 app 目录
MYSQL_USER="root"
MYSQL_PASS="password"
MYSQL_DB=('wordpress' 'project2')
BACK_DATA=/home/backup # 备份文件保存在本地的目录
DATA=/home/wwwroot # 需要备份的网站文件
 
# 定义备份文件名
DataBakName=Database_$(date +"%Y-%m-%d").tar.gz
WebBakName=Web_$(date +%Y-%m-%d).tar.gz
OldData=Database_$(date -d -6day +"%Y-%m-%d").tar.gz
OldWeb=Web_$(date -d -6day +"%Y-%m-%d").tar.gz
# Dropbox 里 30 天以上的旧数据可以清除
Old_DROPBOX_DIR=/$(date -d -30day +%Y-%m-%d) 
# 清理本地保存了 6 天的备份
echo -ne "Delete local data of 6 days old..."
rm -rf $BACK_DATA/$OldData $BACK_DATA/$OldWeb
echo -e "Done"
 
cd $BACK_DATA
# 导出 MySQL 数据库，并压缩
echo -ne "Dump mysql..."
for db in ${MYSQL_DB[@]}; do
    (/usr/bin/mysqldump -u$MYSQL_USER -p$MYSQL_PASS ${db}.sql)
done
tar zcf $BACK_DATA/$DataBakName *.sql
rm -rf $BACK_DATA/*.sql
echo -e "Done"
 
# 备份网站文件
echo -ne "Backup web files..."
cd $DATA
tar zcf $BACK_DATA/$WebBakName *
echo -e "Done"
 
cd ~
# 开始上传到 Dropbox
echo -e "Start uploading..."
./dropbox_uploader.sh upload  $BACK_DATA/$DataBakName $DROPBOX_DIR/$DataBakName
./dropbox_uploader.sh upload  $BACK_DATA/$WebBakName $DROPBOX_DIR/$WebBakName
 
# 清理 Dropbox 里 30 天前的旧数据
./dropbox_uploader.sh delete $Old_DROPBOX_DIR/
 
echo -e "Thank you! All done."