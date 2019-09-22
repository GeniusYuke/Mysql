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
## 5 排序检索数据
```
SELECT prod_name FROM products ORDER BY prod_name;
SELECT prod_id, prod_name, prod_price FROM products ORDER BY prod_price, prod_name;
SELECT prod_id, prod_name, prod_price FROM products ORDER BY prod_price DESC;   //按价格降序
SELECT prod_id, prod_name, prod_price FROM products ORDER BY prod_price DESC, prod_name;    //按价格降序，名字升序
SELECT prod_id, prod_name, prod_price FROM products ORDER BY prod_price DESC LIMIT 1;   //只检索价格最高的
```
## 6 过滤数据
- ORDER 位于WHERE之后
```
SELECT prod_name, prod_price FROM products WHERE prod_price = 2.50;
SELECT prod_name, prod_price FROM products WHERE prod_name = 'fuses';   //默认不区分大小写
SELECT prod_name, prod_price FROM products WHERE prod_price < 10;
SELECT prod_name, prod_price FROM products WHERE prod_price <= 10;
SELECT vend_id, prod_name FROM products WHERE vend_id <> 1003;      //不匹配检查
SELECT prod_name, prod_price FROM products WHERE prod_price BETWEEN 5 AND 10;   //中间值检查
SELECT prod_name FROM products WHERE prod_price IS NULL;
SELECT cust_id FROM customers WHERE cust_email IS NULL;     //空值检查
```
## 7 数据过滤
```
SELECT prod_name, prod_price, prod_id FROM products WHERE vend_id = 1003 AND prod_price <= 10;
SELECT prod_name, prod_price FROM products WHERE vend_id = 1003 OR vend_id = 1002;
SELECT prod_name, prod_price FROM products WHERE (vend_id = 1003 OR vend_id = 1002) AND prod_price >= 10;   //不加括号就先处理AND
SELECT prod_name, prod_price FROM products WHERE vend_id  IN (1002,1003) ORDER BY prod_name;    //括号里面的数据用逗号隔开，比用OR效率更高
SELECT prod_name, prod_price FROM products WHERE vend_id  NOT IN (1002,1003) ORDER BY prod_name;
```
## 8 用通配符进行过滤
```
SELECT prod_id, prod_name FROM products WHERE prod_name LIKE 'jet%';    //搜索jet开头的，%表示任意字符出现任意次数，不区分大小写，不能搜索NULL
SELECT prod_id, prod_name FROM products WHERE prod_name LIKE '%anvil%'; //搜索包含anvil的
SELECT prod_id, prod_name FROM products WHERE prod_name LIKE 's%e';     //搜索s开头e结尾的
SELECT prod_id, prod_name FROM products WHERE prod_name LIKE '_ ton anvil'; // _ 匹配单个字符
SELECT prod_id, prod_name FROM products WHERE prod_name LIKE '% ton anvil';
通配符的效率很低，尽量避免使用
```
## 9 用正则表达式进行搜索
```
SELECT prod_name FROM products WHERE prod_name REGEXP '1000' ORDER BY prod_name;    //正则表达式只要包含即可，不同于LIKE
SELECT prod_name FROM products WHERE prod_name REGEXP '.000' ORDER BY prod_name;    // .表示单个字符
SELECT prod_name FROM products WHERE prod_name REGEXP '1000|2000' ORDER BY prod_name;
SELECT prod_name FROM products WHERE prod_name REGEXP '[123] Ton' ORDER BY prod_name; 
SELECT prod_name FROM products WHERE prod_name REGEXP '[1-5] Ton' ORDER BY prod_name;
SELECT vend_name FROM vendors WHERE vend_name REGEXP '\\.' ORDER BY vend_name;  // \\匹配特殊字符
SELECT prod_name FROM products WHERE prod_name REGEXP '\\([0-9] sticks?\\)' ORDER BY prod_name; // \\(匹配左括号，s?匹配单复数。
SELECT prod_name FROM products WHERE prod_name REGEXP '[[:digit:]]{4}' ORDER BY prod_name;  //匹配连续四个数字
SELECT prod_name FROM products WHERE prod_name REGEXP '^[0-9\\.]' ORDER BY prod_name;   //匹配数字或者小数点开头
```
## 10 创建计算字段
```
SELECT Concat(vend_name, '(', vend_country, ')') FROM vendors ORDER BY vend_name;   //Concat把多个串拼接成一个串
SELECT Concat(RTrim(vend_name), '(', RTrim(vend_country), ')') FROM vendors ORDER BY vend_name; //RTrim去掉右侧空格
SELECT Concat(vend_name, '(', vend_country, ')') AS vend_title FROM vendors ORDER BY vend_name; //别名
SELECT prod_id, quantity, item_price, quantity*item_price AS expanded_price FROM orderitems WHERE order_num = 20005;
```
## 11 使用数据处理函数
```
SELECT vend_name, Upper(vend_name) AS vend_name_upcase FROM vendors ORDER BY vend_name; 
SELECT cust_name, cust_contact FROM customers WHERE Soundex(cust_contact) = Soundex('Y. Lie');  //Soundex匹配发音类似的词
SELECT cust_id, order_num FROM orders WHERE Date(order_date) = '2005-09-01';    //yyyy-mm-dd是mysql里面日期的首选格式，Date（）只返回日期，Time（）只返回时间
SELECT cust_id, order_num FROM orders WHERE Date(order_date) BETWEEN '2005-09-01' AND '2005-09-30';
SELECT cust_id, order_num FROM orders WHERE Year(order_date) =2005 AND Month(order_date) = 9 ;
```
## 12 汇总数据
```
SELECT AVG(prod_price) AS avg_price FROM products;
SELECT AVG(prod_price) AS avg_price FROM products WHERE vend_id = 1003;
SELECT COUNT(*) AS num_cust FROM customers;     //计入NULL
SELECT COUNT(cust_email) AS num_cust FROM customers;
SELECT MAX(prod_price) AS max_price FROM products;
SELECT MIN(prod_price) AS min_price FROM products;
SELECT SUM(quantity) AS items_ordered FROM orderitems WHERE order_num = 20005;
SELECT SUM(item_price*quantity) AS total_price FROM orderitems WHERE order_num = 20005;
SELECT AVG(DISTINCT prod_price) AS avg_price FROM products WHERE vend_id = 1003;
SELECT COUNT(*) AS num_items, MIN(prod_price) AS price_min, MAX(prod_price) AS price_max, AVG(prod_price) AS price_avg FROM products;
```
## 13 分组数据
```
SELECT vend_id, COUNT(*) AS num_prods FROM products GROUP BY vend_id;   //分组进行计算
SELECT vend_id, COUNT(*) AS num_prods FROM products GROUP BY vend_id with rollup;   //最后输出汇总的一行
SELECT cust_id, COUNT(*) AS orders FROM orders GROUP BY cust_id HAVING COUNT(*) >= 2;   //WHERE在分组前过滤，HAVING在分组后过滤
SELECT vend_id, COUNT(*) AS num_prods FROM products WHERE prod_price >= 10 GROUP BY vend_id HAVING COUNT(*) >= 2;   //每个供货商提供的价格大于10的数量
SELECT order_num, SUM(quantity*item_price) AS ordertotal FROM orderitems GROUP BY order_num HAVING SUM(quantity*item_price) >= 50;  //订单总价大于50的订单号
```
