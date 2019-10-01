SELECT prod_name FROM products;
SELECT prod_id, prod_name, prod_price FROM products;
SELECT * FROM products;
SELECT vend_id FROM products;
SELECT DISTINCT vend_id FROM products;
SELECT prod_name FROM products LIMIT 5;
SELECT prod_name FROM products LIMIT 5,5;
SELECT products.prod_name FROM products;
SELECT products.prod_name FROM crashcourse.products;
SELECT prod_name FROM products ORDER BY prod_name;
SELECT prod_id, prod_name, prod_price FROM products ORDER BY prod_price, prod_name;
SELECT prod_id, prod_name, prod_price FROM products ORDER BY prod_price DESC;
SELECT prod_id, prod_name, prod_price FROM products ORDER BY prod_price DESC, prod_name;
SELECT prod_id, prod_name, prod_price FROM products ORDER BY prod_price DESC LIMIT 1;
SELECT prod_name, prod_price FROM products WHERE prod_price = 2.50;
SELECT prod_name, prod_price FROM products WHERE prod_name = 'fuses';
SELECT prod_name, prod_price FROM products WHERE prod_price < 10;
SELECT prod_name, prod_price FROM products WHERE prod_price <= 10;
SELECT vend_id, prod_name FROM products WHERE vend_id <> 1003;
SELECT prod_name, prod_price FROM products WHERE prod_price BETWEEN 5 AND 10;
SELECT prod_name FROM products WHERE prod_price IS NULL;
SELECT cust_id FROM customers WHERE cust_email IS NULL;
SELECT prod_name, prod_price, prod_id FROM products WHERE vend_id = 1003 AND prod_price <= 10;
SELECT prod_name, prod_price FROM products WHERE vend_id = 1003 OR vend_id = 1002;
SELECT prod_name, prod_price FROM products WHERE (vend_id = 1003 OR vend_id = 1002) AND prod_price >= 10;
SELECT prod_name, prod_price FROM products WHERE vend_id  IN (1002,1003) ORDER BY prod_name;
SELECT prod_name, prod_price FROM products WHERE vend_id  NOT IN (1002,1003) ORDER BY prod_name;
SELECT prod_id, prod_name FROM products WHERE prod_name LIKE 'jet%';
SELECT prod_id, prod_name FROM products WHERE prod_name LIKE '%anvil%';
SELECT prod_id, prod_name FROM products WHERE prod_name LIKE 's%e';
SELECT prod_id, prod_name FROM products WHERE prod_name LIKE '_ ton anvil';
SELECT prod_id, prod_name FROM products WHERE prod_name LIKE '% ton anvil';
SELECT prod_name FROM products WHERE prod_name REGEXP '1000' ORDER BY prod_name;
SELECT prod_name FROM products WHERE prod_name REGEXP '.000' ORDER BY prod_name;
SELECT prod_name FROM products WHERE prod_name REGEXP '1000|2000' ORDER BY prod_name;
SELECT prod_name FROM products WHERE prod_name REGEXP '[123] Ton' ORDER BY prod_name;
SELECT prod_name FROM products WHERE prod_name REGEXP '[1-5] Ton' ORDER BY prod_name;
SELECT vend_name FROM vendors WHERE vend_name REGEXP '\\.' ORDER BY vend_name;
SELECT prod_name FROM products WHERE prod_name REGEXP '\\([0-9] sticks?\\)' ORDER BY prod_name;
SELECT prod_name FROM products WHERE prod_name REGEXP '[[:digit:]]{4}' ORDER BY prod_name;
SELECT prod_name FROM products WHERE prod_name REGEXP '^[0-9\\.]' ORDER BY prod_name;
SELECT Concat(vend_name, '(', vend_country, ')') FROM vendors ORDER BY vend_name;
SELECT Concat(RTrim(vend_name), '(', RTrim(vend_country), ')') FROM vendors ORDER BY vend_name;
SELECT Concat(vend_name, '(', vend_country, ')') AS vend_title FROM vendors ORDER BY vend_name;
SELECT prod_id, quantity, item_price, quantity*item_price AS expanded_price FROM orderitems WHERE order_num = 20005;
SELECT vend_name, Upper(vend_name) AS vend_name_upcase FROM vendors ORDER BY vend_name;
SELECT cust_name, cust_contact FROM customers WHERE Soundex(cust_contact) = Soundex('Y. Lie');
SELECT cust_id, order_num FROM orders WHERE Date(order_date) = '2005-09-01';
SELECT cust_id, order_num FROM orders WHERE Date(order_date) BETWEEN '2005-09-01' AND '2005-09-30';
SELECT cust_id, order_num FROM orders WHERE Year(order_date) =2005 AND Month(order_date) = 9 ;
SELECT AVG(prod_price) AS avg_price FROM products;
SELECT AVG(prod_price) AS avg_price FROM products WHERE vend_id = 1003;
SELECT COUNT(*) AS num_cust FROM customers;
SELECT COUNT(cust_email) AS num_cust FROM customers;
SELECT MAX(prod_price) AS max_price FROM products;
SELECT MIN(prod_price) AS min_price FROM products;
SELECT SUM(quantity) AS items_ordered FROM orderitems WHERE order_num = 20005;
SELECT SUM(item_price*quantity) AS total_price FROM orderitems WHERE order_num = 20005;
SELECT AVG(DISTINCT prod_price) AS avg_price FROM products WHERE vend_id = 1003;
SELECT COUNT(*) AS num_items, MIN(prod_price) AS price_min, MAX(prod_price) AS price_max, AVG(prod_price) AS price_avg FROM products;
SELECT vend_id, COUNT(*) AS num_prods FROM products GROUP BY vend_id;
SELECT vend_id, COUNT(*) AS num_prods FROM products GROUP BY vend_id with rollup;
SELECT cust_id, COUNT(*) AS orders FROM orders GROUP BY cust_id HAVING COUNT(*) >= 2;
SELECT vend_id, COUNT(*) AS num_prods FROM products WHERE prod_price >= 10 GROUP BY vend_id HAVING COUNT(*) >= 2;
SELECT order_num, SUM(quantity*item_price) AS ordertotal FROM orderitems GROUP BY order_num HAVING SUM(quantity*item_price) >= 50;
SELECT cust_name, cust_contact FROM customers WHERE cust_id IN (SELECT cust_id FROM orders WHERE order_num IN (SELECT order_num FROM orderitems WHERE prod_id = 'TNT2'));
SELECT cust_name, cust_state, (SELECT COUNT(*) FROM orders WHERE orders.cust_id = customers.cust_id) AS orders FROM customers ORDER BY cust_name;
SELECT vend_name, prod_name, prod_price FROM vendors, products WHERE vendors.vend_id = products.vend_id ORDER BY vend_name, prod_name;
SELECT vend_name, prod_name, prod_price FROM vendors, products  ORDER BY vend_name, prod_name;
SELECT vend_name, prod_name, prod_price FROM vendors INNER JOIN products ON vendors.vend_id = products.vend_id ORDER BY vend_name, prod_name;
SELECT prod_name, vend_name, prod_price, quantity FROM orderitems, products, vendors WHERE products.vend_id = vendors.vend_id AND orderitems.prod_id = products.prod_id AND order_num = 20005;
SELECT cust_name, cust_contact FROM customers, orders, orderitems WHERE customers.cust_id = orders.cust_id AND orders.order_num = orderitems.order_num AND prod_id = 'TNT2';
SELECT cust_name, cust_contact FROM customers AS c, orders AS o, orderitems AS oi WHERE c.cust_id = o.cust_id AND oi.order_num = o.order_num AND prod_id = 'TNT2';
SELECT prod_id, prod_name FROM products WHERE vend_id = (SELECT vend_id FROM products WHERE prod_id = 'DTNTR');
SELECT p1.prod_id, p1.prod_name FROM products AS p1, products AS p2 WHERE p1.vend_id = p2.vend_id AND p2.prod_id = 'DTNTR';
SELECT customers.cust_id, orders.order_num FROM customers INNER JOIN orders ON customers.cust_id = orders.cust_id;
SELECT customers.cust_id, orders.order_num FROM customers LEFT OUTER JOIN orders ON customers.cust_id = orders.cust_id;
SELECT customers.cust_id, orders.order_num FROM customers RIGHT OUTER JOIN orders ON customers.cust_id = orders.cust_id;
SELECT customers.cust_name, customers.cust_id, COUNT(orders.order_num) AS num_ord FROM customers INNER JOIN orders ON customers.cust_id = orders.cust_id GROUP BY customers.cust_id;
SELECT customers.cust_name, customers.cust_id, COUNT(orders.order_num) AS num_ord FROM customers LEFT OUTER JOIN orders ON customers.cust_id = orders.cust_id GROUP BY customers.cust_id;
SELECT vend_id, prod_id, prod_price FROM products WHERE prod_price <= 5 UNION SELECT vend_id, prod_id, prod_price FROM products WHERE vend_id IN (1001, 1002);
SELECT vend_id, prod_id, prod_price FROM products WHERE prod_price <= 5 OR vend_id IN (1001, 1002);
SELECT vend_id, prod_id, prod_price FROM products WHERE prod_price <= 5 UNION ALL SELECT vend_id, prod_id, prod_price FROM products WHERE vend_id IN (1001, 1002);
SELECT vend_id, prod_id, prod_price FROM products WHERE prod_price <= 5 UNION SELECT vend_id, prod_id, prod_price FROM products WHERE vend_id IN (1001, 1002) ORDER BY vend_id, prod_id;
SELECT note_text FROM productnotes WHERE Match(note_text) Against('rabbit');
SELECT note_text FROM productnotes WHERE note_text LIKE '%rabbit%';
SELECT note_text, match(note_text) against('rabbit') AS rand FROM productnotes;
SELECT note_text FROM productnotes WHERE match(note_text) against('anvils');
SELECT note_text FROM productnotes WHERE match(note_text) against('anvils' WITH QUERY EXPANSION);
SELECT note_text FROM productnotes WHERE match(note_text) against('heavy' IN BOOLEAN MODE);
SELECT note_text FROM productnotes WHERE match(note_text) against('heavy -rope*' IN BOOLEAN MODE);
SELECT note_text FROM productnotes WHERE match(note_text) against('+rabbit +bait' IN BOOLEAN MODE);
SELECT note_text FROM productnotes WHERE match(note_text) against('rabbit bait' IN BOOLEAN MODE);
SELECT note_text FROM productnotes WHERE match(note_text) against('"rabbit bait"' IN BOOLEAN MODE);
SELECT note_text FROM productnotes WHERE match(note_text) against('>rabbit <carrot' IN BOOLEAN MODE);
SELECT note_text FROM productnotes WHERE match(note_text) against('+safe +(<combination)' IN BOOLEAN MODE);
INSERT INTO customers VALUES(NULL, 'Pep E. LaPew', '100 Main Street', 'Los Angeles', 'CA', '90046', 'USA', NULL, NULL);
INSERT INTO customers(cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email) VALUES('Pep E. LaPew', '100 Main Street', 'Los Angeles', 'CA', '90046', 'USA', NULL, NULL);
INSERT INTO customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email) SELECT cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email FROM custnew;
CREATE TABLE custnew
(
  cust_id      int       NOT NULL AUTO_INCREMENT,
  cust_name    char(50)  NOT NULL ,
  cust_address char(50)  NULL ,
  cust_city    char(50)  NULL ,
  cust_state   char(5)   NULL ,
  cust_zip     char(10)  NULL ,
  cust_country char(50)  NULL ,
  cust_contact char(50)  NULL ,
  cust_email   char(255) NULL ,
  PRIMARY KEY (cust_id)
) ENGINE=InnoDB;
select * from customers;
UPDATE customers SET cust_email = 'elmer@fudd.com' WHERE cust_id =10005;
UPDATE customers SET cust_name = 'The Fudds', cust_email = 'elmer@fudd.com' WHERE cust_id =10005;
UPDATE customers SET cust_email = NULL WHERE cust_id = 10005;
DELETE FROM customers WHERE cust_id = 10007;
ALTER TABLE vendors ADD vend_phone CHAR(20);
ALTER TABLE vendors DROP COLUMN vend_phone ;
ALTER TABLE orderitems ADD CONSTRAINT fk_orderitems_orders FOREIGN KEY (order_num) REFERENCES orders (order_num);
ALTER TABLE orderitems ADD CONSTRAINT fk_orderitems_products FOREIGN KEY (prod_id) REFERENCES products (prod_id);
ALTER TABLE orders ADD CONSTRAINT fk_orders_customers FOREIGN KEY (cust_id) REFERENCES customers (cust_id);
ALTER TABLE products ADD CONSTRAINT fk_products_vendors FOREIGN KEY (vend_id) REFERENCES vendors (vend_id);
DROP TABLE customers;
RENAME TABLE customers2 TO customers;
CREATE VIEW productcustomers AS SELECT cust_name, cust_contact, prod_id FROM  customers, orders, orderitems WHERE customers.cust_id = orders.cust_id AND orderitems.order_num = orders.order_num;
SELECT cust_name, cust_contact FROM productcustomers WHERE prod_id = 'TNT2';
CREATE VIEW vendorlocations AS SELECT Concat(RTrim(vend_name), '(', RTrim(vend_country), ')') AS vend_title FROM vendors ORDER BY vend_name;
SELECT * FROM vendorlocations;
CREATE VIEW customeremaillist AS SELECT cust_id, cust_name, cust_email FROM customers WHERE cust_email IS NOT NULL;
SELECT * FROM  customeremaillist;
DELIMITER //
CREATE PROCEDURE productpricing()
BEGIN	 
	SELECT Avg(prod_price) AS priceaverage FROM products;
END//
DELIMITER ;
CALL productpricing();
DROP PROCEDURE processorders;
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
DELIMITER //
CREATE PROCEDURE processorders()
BEGIN
	-- Declare local variables
    DECLARE done BOOLEAN DEFAULT 0;
    DECLARE o INT;
    DECLARE t DECIMAL(8,2);
    
	-- Declare the cursor
	DECLARE ordernumbers CURSOR
    FOR
	SELECT order_num FROM orders;
    -- Declare continue handler
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;
    
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
        CALL ordertotal(o,1,t);
        
        -- Insert order and total into ordertotals
        INSERT INTO ordertotals(order_num, total) VALUES(o, t);
    
    -- End of loop
    UNTIL done END REPEAT;
    
    -- Close the cursor
    CLOSE ordernumbers;
END//
DELIMITER ;
select * from orderitems;
CALL processorders();
SELECT * FROM ordertotals;
CREATE TRIGGER neworder AFTER INSERT ON orders FOR EACH ROW SELECT NEW.order_num into @args;
INSERT INTO orders(order_date, cust_id) VALUES(Now(), 10001);
DROP TRIGGER neworder;
select * from orders;
SELECT * FROM ordertotals;
START TRANSACTION;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM ordertotals;
SELECT * FROM ordertotals;
ROLLBACK;
SELECT * FROM ordertotals;
START TRANSACTION;
DELETE FROM orderitems WHERE order_num = 20010;
DELETE FROM orders WHERE order_num = 20010;
COMMIT;
SHOW CHARACTER SET;
SHOW COLLATION;
SHOW VARIABLES LIKE 'character%';
SHOW VARIABLES LIKE 'collation%';
CREATE TABLE mytable(columnn1 INT, columnn2 VARCAHR(10)) DEFAULT CHARACTER SET hebrew COLLATE hebrew_general_ci;
USE mysql;
SELECT user FROM user;
CREATE USER ben IDENTIFIED BY 'zhou123qaz';
RENAME USER ben TO bforta;
DROP USER bforta;
SHOW GRANTS FOR bforta;
GRANT SELECT ON crashcourse.* TO bforta;
REVOKE SELECT ON crashcourse.* FROM bforta;
SET PASSWORD FOR bforta = Password('zhou123QAZ');
ANALYZE TABLE orders;
CHECK TABLE orders, orderitems;






