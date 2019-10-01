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
## 14 子查询
```
SELECT cust_name, cust_contact FROM customers WHERE cust_id IN (SELECT cust_id FROM orders WHERE order_num IN (SELECT order_num FROM orderitems WHERE prod_id = 'TNT2'));   //查找购买了TNT的客户信息
SELECT cust_name, cust_state, (SELECT COUNT(*) FROM orders WHERE orders.cust_id = customers.cust_id) AS orders FROM customers ORDER BY cust_name;   //统计客户的订单数量
```
## 15 联结表
```
SELECT vend_name, prod_name, prod_price FROM vendors, products WHERE vendors.vend_id = products.vend_id ORDER BY vend_name, prod_name;  //
SELECT vend_name, prod_name, prod_price FROM vendors, products  ORDER BY vend_name, prod_name;  //笛卡尔积，返回数量等于两张表乘积
SELECT vend_name, prod_name, prod_price FROM vendors INNER JOIN products ON vendors.vend_id = products.vend_id ORDER BY vend_name, prod_name;   //内部联结，等同于1
SELECT prod_name, vend_name, prod_price, quantity FROM orderitems, products, vendors WHERE products.vend_id = vendors.vend_id AND orderitems.prod_id = products.prod_id AND order_num = 20005;  //订单号20005的所有商品的供应商信息
SELECT cust_name, cust_contact FROM customers, orders, orderitems WHERE customers.cust_id = orders.cust_id AND orders.order_num = orderitems.order_num AND prod_id = 'TNT2';    //修改14章的例子
```
## 16 创建高级联结
```
SELECT cust_name, cust_contact FROM customers AS c, orders AS o, orderitems AS oi WHERE c.cust_id = o.cust_id AND oi.order_num = o.order_num AND prod_id = 'TNT2';  //给表取别名，简洁
SELECT prod_id, prod_name FROM products WHERE vend_id = (SELECT vend_id FROM products WHERE prod_id = 'DTNTR');     //查询一个表两次
SELECT p1.prod_id, p1.prod_name FROM products AS p1, products AS p2 WHERE p1.vend_id = p2.vend_id AND p2.prod_id = 'DTNTR';     //使用自联结替代子查询，提高效率
SELECT customers.cust_id, orders.order_num FROM customers INNER JOIN orders ON customers.cust_id = orders.cust_id;  //内部联结
SELECT customers.cust_id, orders.order_num FROM customers LEFT OUTER JOIN orders ON customers.cust_id = orders.cust_id;     //外部联结，统计所有客户下的订单，包括未下单的客户
SELECT customers.cust_id, orders.order_num FROM customers RIGHT OUTER JOIN orders ON customers.cust_id = orders.cust_id;    //RIGHT表示联结右侧的表
SELECT customers.cust_name, customers.cust_id, COUNT(orders.order_num) AS num_ord FROM customers INNER JOIN orders ON customers.cust_id = orders.cust_id GROUP BY customers.cust_id;
SELECT customers.cust_name, customers.cust_id, COUNT(orders.order_num) AS num_ord FROM customers LEFT OUTER JOIN orders ON customers.cust_id = orders.cust_id GROUP BY customers.cust_id;   //统计每个用户下了多少订单，包括未下单的客户
```
## 17 组合查询
```
SELECT vend_id, prod_id, prod_price FROM products WHERE prod_price <= 5 UNION SELECT vend_id, prod_id, prod_price FROM products WHERE vend_id IN (1001, 1002);  //用UNION组合两个SELECT
SELECT vend_id, prod_id, prod_price FROM products WHERE prod_price <= 5 OR vend_id IN (1001, 1002);     //WHERE等同于UNION
SELECT vend_id, prod_id, prod_price FROM products WHERE prod_price <= 5 UNION ALL SELECT vend_id, prod_id, prod_price FROM products WHERE vend_id IN (1001, 1002);  //UNION ALL显示重复行
SELECT vend_id, prod_id, prod_price FROM products WHERE prod_price <= 5 UNION SELECT vend_id, prod_id, prod_price FROM products WHERE vend_id IN (1001, 1002) ORDER BY vend_id, prod_id;
```
## 18 全文本搜索
```
//并非所有引擎都支持全文本搜索，InnoDB不支持，MyISAM支持
//布尔文本搜索结果不按等级排序
//文本搜索时短词被忽略
SELECT note_text FROM productnotes WHERE Match(note_text) Against('rabbit');    //全文本搜索结果会按搜索匹配等级进行排序
SELECT note_text FROM productnotes WHERE note_text LIKE '%rabbit%';
SELECT note_text, match(note_text) against('rabbit') AS rand FROM productnotes; //出现在越前等级越高，出现次数越多等级越高
SELECT note_text FROM productnotes WHERE match(note_text) against('anvils' WITH QUERY EXPANSION);   //查询扩展能找出可能相关的结果，比如只有一行有anvils，查询扩展找的的行里面包含匹配那行里面的其他的词
SELECT note_text FROM productnotes WHERE match(note_text) against('heavy' IN BOOLEAN MODE); //布尔文本搜索在没有定义FULLTEXT时也可以使用
SELECT note_text FROM productnotes WHERE match(note_text) against('heavy -rope*' IN BOOLEAN MODE);  //匹配heavy，但排除以rope开始的词的行
SELECT note_text FROM productnotes WHERE match(note_text) against('+rabbit +bait' IN BOOLEAN MODE); //匹配包含rabbit和bait的行
SELECT note_text FROM productnotes WHERE match(note_text) against('rabbit bait' IN BOOLEAN MODE);   //匹配包含rabbit或bait的行
SELECT note_text FROM productnotes WHERE match(note_text) against('"rabbit bait"' IN BOOLEAN MODE); //匹配包含rabbit bait的行
SELECT note_text FROM productnotes WHERE match(note_text) against('>rabbit <carrot' IN BOOLEAN MODE);   //匹配rabbit或者carrot的行，增加前者的等级，降低后者等级
SELECT note_text FROM productnotes WHERE match(note_text) against('+safe +(<combination)' IN BOOLEAN MODE); //匹配包含safe和cambination的行，增加前者等级，降低后者等级
```
## 19 插入数据
```
INSERT INTO customers VALUES(NULL, 'Pep E. LaPew', '100 Main Street', 'Los Angeles', 'CA', '90046', 'USA', NULL, NULL); //cust_id为NULL，表示使用默认值，这种方式的插入需要指定所有列值
INSERT INTO customers(cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email) VALUES('Pep E. LaPew', '100 Main Street', 'Los Angeles', 'CA', '90046', 'USA', NULL, NULL); //这种方式的插入只需要指定部分列值
INSERT INTO customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email) SELECT cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email FROM custnew; //从别的表select数据插入
```
## 20 更新和删除数据
```
UPDATE customers SET cust_email = 'elmer@fudd.com' WHERE cust_id =10005;    //更新或者删除数据需要使用WHERE否则就会更新所有行
UPDATE customers SET cust_name = 'The Fudds', cust_email = 'elmer@fudd.com' WHERE cust_id =10005;
UPDATE customers SET cust_email = NULL WHERE cust_id = 10005;
DELETE FROM customers WHERE cust_id = 10007;    //删除所有行可以使用TRUNCATE TABLE
```
## 21 创建和操纵表
```
CREATE TABLE custnew
(
  cust_id      int       NOT NULL AUTO_INCREMENT,
  cust_name    char(50)  NOT NULL DEFAULT 'ZHOU',
  cust_address char(50)  NULL ,
  cust_city    char(50)  NULL ,
  cust_state   char(5)   NULL ,
  cust_zip     char(10)  NULL ,
  cust_country char(50)  NULL ,
  cust_contact char(50)  NULL ,
  cust_email   char(255) NULL ,
  PRIMARY KEY (cust_id)
) ENGINE=InnoDB;
//InnoDB是一个可靠的事务处理引擎，不支持全文本搜索
//MEMORY在功能等同于MyISAM，但由于数据存储在内存中，速度很快，特别适合于临时表
//MyISAM是一个性能极高的引擎，支持全文本搜索，但不支持事务处理
ALTER TABLE vendors ADD vend_phone CHAR(20);    //修改表
ALTER TABLE vendors DROP COLUMN vend_phone ;
ALTER TABLE orderitems ADD CONSTRAINT fk_orderitems_orders FOREIGN KEY (order_num) REFERENCES orders (order_num);   //添加外键
ALTER TABLE orderitems ADD CONSTRAINT fk_orderitems_products FOREIGN KEY (prod_id) REFERENCES products (prod_id);
ALTER TABLE orders ADD CONSTRAINT fk_orders_customers FOREIGN KEY (cust_id) REFERENCES customers (cust_id);
ALTER TABLE products ADD CONSTRAINT fk_products_vendors FOREIGN KEY (vend_id) REFERENCES vendors (vend_id);
DROP TABLE customers;   //删除表    
RENAME TABLE customers2 TO customers;   //重命名表
```
## 22 使用视图
```
CREATE VIEW productcustomers AS SELECT cust_name, cust_contact, prod_id FROM  customers, orders, orderitems WHERE customers.cust_id = orders.cust_id AND orderitems.order_num = orders.order_num;
SELECT cust_name, cust_contact FROM productcustomers WHERE prod_id = 'TNT2';
CREATE VIEW vendorlocations AS SELECT Concat(RTrim(vend_name), '(', RTrim(vend_country), ')') AS vend_title FROM vendors ORDER BY vend_name;
SELECT * FROM vendorlocations;
CREATE VIEW customeremaillist AS SELECT cust_id, cust_name, cust_email FROM customers WHERE cust_email IS NOT NULL;
SELECT * FROM  customeremaillist;
```
## 23 使用存储过程
```
//MYSQL中需要临时更改命令行实用程序的语句分隔符，此时分隔符是//
DELIMITER //
CREATE PROCEDURE productpricing()
BEGIN	 
	SELECT Avg(prod_price) AS priceaverage FROM products;
END//
DELIMITER ;
CALL productpricing();  //调用存储过程
DROP PROCEDURE ordertotal;  //删除存储过程
//OUT为存储过程的输出参数，IN为存储过程的输入参数
DELIMITER //
CREATE PROCEDURE productpricing(OUT pi DECIMAL(8,2), OUT ph DECIMAL(8,2), OUT pa DECIMAL(8,2))
BEGIN	 
	SELECT Avg(prod_price) INTO pa FROM products;
	SELECT Min(prod_price) INTO pi FROM products;
	SELECT Max(prod_price) INTO ph FROM products;
END//
CREATE PROCEDURE ordertotal(IN onumber INT, OUT ototal DECIMAL(8,2))
BEGIN	 
	SELECT Sum(item_price*quantity) FROM orderitems WHERE order_num = onumber INTO ototal;
END//
DELIMITER ;
CALL productpricing(@pricelow, @pricehigh, @priceaverage);
SELECT @pricehigh, @pricelow, @priceaverage;
CALL ordertotal(20005, @total);
SELECT @total;
-- Name: ordertotal
-- Parameters: onumber = order number
--			   taxable = 0 if not taxable, 1 if taxable
--   		   ototal  = order total variable
DELIMITER //
CREATE PROCEDURE ordertotal(IN onumber INT, IN taxable BOOLEAN, OUT ototal DECIMAL(8,2)) COMMENT 'Obtain order total, optionally adding tax'
BEGIN
	-- Declare variable for total
    DECLARE total DECIMAL(8,2);
    -- Declare tax percentage
    DECLARE taxrate INT DEFAULT 6;
    
    -- Get the order total
    SELECT Sum(item_price*quantity) FROM orderitems WHERE order_num = onumber INTO total;
    -- Is this taxable?
	IF taxable THEN
		-- Yex, so add taxrate to the total
        SELECT total+(total/100*taxrate) INTO total;
	END IF;
    -- And finally, save to out variable
    SELECT total INTO ototal;
END//
DELIMITER ;
CALL ordertotal(20005, 0, @total);
SELECT @total;
CALL ordertotal(20005, 1, @total);
SELECT @total;
SHOW CREATE PROCEDURE ordertotal;
SHOW PROCEDURE STATUS;
```
## 24 使用游标
```
DELIMITER //
CREATE PROCEDURE processorders()
BEGIN
	-- Declare local variables
    DECLARE done BOOLEAN DEFAULT 0;
    DECLARE o INT;
    DECLARE t DECIMAL(8,2);
    
	-- Declare the cursor
	DECLARE ordernumbers CURSOR //声明游标，变量的声明要在游标和句柄之前
    FOR
	SELECT order_num FROM orders;
    -- Declare continue handler
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;   //声明句柄，SQLSTATE '02000'当REPEAT没有更多的行供循环时出现。
    
    -- Create a table to store the results
    CREATE TABLE IF NOT EXISTS ordertotals
		(order_num INT, total DECIMAL(8,2));
        
    -- Open the cursor
    OPEN ordernumbers;
    -- Loop through all rows
    REPEAT
		
		-- Get order number
		FETCH ordernumbers INTO o;
		
        -- Get the total for this order
        CALL ordertotal(o,1,t);     //调用另一个计算订单总价的存储过程
        
        -- Insert order and total into ordertotals
        INSERT INTO ordertotals(order_num, total) VALUES(o, t); //在表中插入数据
    
    -- End of loop
    UNTIL done END REPEAT;  //当done为1时停止REPEAT
    
    -- Close the cursor
    CLOSE ordernumbers;
END//
```
## 25 使用触发器
```
//BEFORE触发器失败，将不会执行请求的的操作
//触发器仅支持表，每个表最多支持六个触发器
CREATE TRIGGER neworder AFTER INSERT ON orders FOR EACH ROW SELECT NEW.order_num into @args;    //引用名为NEW的虚拟的表，访问被插入的行
INSERT INTO orders(order_date, cust_id) VALUES(Now(), 10001);   //NOW()中为现在的参数值，NEW.order_num为20010
DROP TRIGGER newproduct;
```
## 26 管理事务处理
```
//事务处理是一种机制，用来管理必须成批处理的MySQL操作，要么作为整体执行，要么完全不执行，以保证数据操作完整性
//ROLLBACK可以回退INSERT UPDATE DELETE，但是不能回退CREATE DROP
SELECT * FROM ordertotals;
START TRANSACTION;  //开始事务处理
SET SQL_SAFE_UPDATES = 0;   //设置update safe mode，使得能不使用where 和主键来删除表中的行
DELETE FROM ordertotals;
SELECT * FROM ordertotals;
ROLLBACK;   //回退MySQL语句
START TRANSACTION;
DELETE FROM orderitems WHERE order_num = 20010;
DELETE FROM orders WHERE order_num = 20010;
COMMIT;     //当COMMIT或ROLLBACK语句执行后，事务会自动关闭
SAVEPOINT delete1;      //占位符
ROLLBACK TO delete1;    //回退到保留点，在ROLLBACK或者COMMIT之后自动释放
```
## 27 全球化和本地化
```
SHOW CHARACTER SET; //查看支持的字符集列表
SHOW COLLATION;     //查看支持的校对集列表
SHOW VARIABLES LIKE 'character%';   //查看现在使用的字符
SHOW VARIABLES LIKE 'collation%';   //查看现在使用的校对
```
## 28 安全管理
```
USE mysql;  //mysql数据库中存储着用户信息
SELECT user FROM user;  //查看所有的用户
CREATE USER ben IDENTIFIED BY 'zhou123qaz'; //创建用户
RENAME USER ben TO bforta;  /给用户重命名
DROP USER bforta;
SHOW GRANTS FOR bforta; //查看用户权限
GRANT SELECT ON crashcourse.* TO bforta;    //给用户设置权限
REVOKE SELECT ON crashcourse.* FROM bforta; //取消用户的权限
SET PASSWORD FOR bforta = Password('zhou123QAZ');   //设置用户的密码

```
## 29 数据库维护
```
//错误日志，查询日志，二进制日志，缓慢查询日志
ANALYZE TABLE orders;
CHECK TABLE orders, orderitems;
```
## 30 改善性能
```
//存储过程执行得比一条一套地执行其中的各条语句快
//LIKE很慢，最好用FULLTEXT
```