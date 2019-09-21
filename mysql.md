## 初始化数据库，需要保证data文件夹为空
```
mysqld --initialize --console
```
## 安装服务
```
mysqld --install
```
## 启动以及关闭服务
```
net start mysql
net stop mysql
```
## 卸载mysql
```
mysqld --remove mysql
```
## 修改密码
```
mysql -u root -p
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'zhou123qaz';
```