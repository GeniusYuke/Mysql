# SQL（Structured Query Language)
## 1 了解SQL
- 行表示表中的一个记录，列表示表中一个字段，一般表示用户的某项数据
- 主键表示能够区分每一行的一列，任意两行的主键值都不相同，每一行必须有主键值，可以使用多个列作为主键
## 2 MYSQL简介
- MYSQL是一种DBMS（数据库管理系统）
## 3 使用MYSQL
```
USE carashcourse;   //选择数据库
SHOW DATABASES;     //显示所有数据库
SHOW TABLES;        //显示所有表
SHOW COLUMNS FROM customers;    //显示customers表里面的所有列
```
## 4 检索数据
- 检索列数据
```
SELECT prod_name FROM products;     
SELECT prod_id, prod_name, prod_price FROM products;
SELECT * FROM products;
```
- 检索不同数据，列名前面加DISTINCT
```
SELECT DISTINCT vend_id FROM products;
```
- 限制结果
```
SELECT prod_name FROM products LIMIT 5; //只返回前五行
SELECT prod_name FROM products LIMIT 5,5;   //返回第六行开始的五行
```
- 使用完全限定的表名
```
SELECT products.prod_name FROM products;
SELECT products.prod_name FROM crashcourse.products;
```
