# WordPress 服务器常用的配置文件和管理脚本


## 命令工具

下面的几个工具是维护运行在 LNMP 上的 WordPress 站点的常用工具，使用之前，请先编辑脚本文件，根据时间情况修改配置。

- clean.sh 清理没有 PHP 文件的目录中的所有 PHP 文件
- safe.sh 给所有没必要经常修改的 WordPress 文件加只读属性，提高安全性。
- update_wordpress.sh 一键升级服务器上的所有站点
