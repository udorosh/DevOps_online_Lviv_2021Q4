## Task 4.1

### Part 1
**3. Select a subject area and describe the database schema (minimum 3 tables).**

My subject area is electronics store. I have 3 tables: for users, phones and orders.

**Users table:**

| id | email              | password                                                         | city     | is_admin |
|----|--------------------|------------------------------------------------------------------|----------|----------|
| 1  | example1@gmail.com | 49c7f17bd6e02132099260a1b0a448b8bbb56d466d9756c6cd9bf3b717593a58 | Ternopil | 1        |
| 2  | example1@gmail.com | 382c36b3cff1836160f5fb9f313372c9aa504b6de92369f3ac0f6e00eded0ba1 | Kyiv     | 0        |
| 3  | example1@gmail.com | 65d4e36d4ffafc369c4528e85f93579fa7a26f7812ecb0ffc65f7864310919c0 | Lviv     | 0        |

**Products table:**

| id | chassis | label                       | resolution | cpu              | ram | rom | price |
|----|---------|-----------------------------|------------|------------------|-----|-----|-------|
| 1  | handset | Google Pixel 5 8/128GB      | 2340x1080  | Qualcomm SM7250  | 8   | 128 | 20000 |
| 2  | handset | Apple iPhone 13 Pro 6/128GB | 2532x1170  | Apple A15 Bionic | 6   | 128 | 30000 |
| 3  | handset | Samsung Galaxy S21 8/256GB  | 2400x1080  | Exynos 2100      | 8   | 256 | 35000 |

**Orders table:**

| id | user_id | product_id |
|----|---------|------------|
| 1  | 2       | 1          |
| 2  | 3       | 2          |
| 3  | 2       | 3          |

**4. Create a database on the server through the console.**
```commandline
mysql> CREATE DATABASE store;
Query OK, 1 row affected (1.62 sec)

mysql> USE store;
Database changed

mysql> CREATE TABLE users(id MEDIUMINT NOT NULL AUTO_INCREMENT, email TEXT(320) NOT NULL, password TEXT(255) NOT NULL, city CHAR(120) NOT NULL, is_admin TINYINT NOT NULL,PRIMARY KEY(id));
Query OK, 0 rows affected (6.27 sec)

mysql> CREATE TABLE products(id MEDIUMINT NOT NULL AUTO_INCREMENT, chassis CHAR(20) NOT NULL,label CHAR(150) NOT NULL, panel_resolution CHAR(30) NOT NULL, cpu CHAR(50) NOT NULL, ram SMALLINT NOT NULL, rom SMALLINT NOT NULL, price MEDIUMINT NOT NULL, PRIMARY KEY(id));
Query OK, 0 rows affected (6.33 sec)

mysql> CREATE TABLE orders(id MEDIUMINT NOT NULL AUTO_INCREMENT, user_id MEDIUMINT NOT NULL, product_id MEDIUMINT NOT NULL, INDEX(product_id), INDEX(user_id), PRIMARY KEY(id), FOREIGN KEY(user_id) REFERENCES users(id), FOREIGN KEY(product_id) REFERENCES products(id));
Query OK, 0 rows affected (9.64 sec)
```

**5. Fill in tables.**
```commandline
mysql> INSERT INTO users(email, password, city, is_admin) VALUES ('example1@gmail.com', '49c7f17bd6e02132099260a1b0a448b8bbb56d466d9756c6cd9bf3b717593a58', 'Ternopil', 1), ('example2@gmail.com', '382c36b3cff1836160f5fb9f313372c9aa504b6de92369f3ac0f6e00eded0ba1', 'Kyiv', 0), ('example3@gmail.com', '65d4e36d4ffafc369c4528e85f93579fa7a26f7812ecb0ffc65f7864310919c0', 'Lviv', 0);
Query OK, 3 rows affected (1.78 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO products(chassis, label, panel_resolution, cpu, ram, rom, price) VALUES  ('handset', 'Google Pixel 5 8/128GB', '2340x1080', 'Qualcomm SM7250', 8, 128, 20000), ('handset', 'Apple iPhone 13 Pro 6/128GB', '2532x1170', 'Apple A15 Bionic', 6, 128, 30000), ('handset', 'Samsung Galaxy S21 8/256Gb', '2400x1080', 'Exynos 2100', 8, 256, 35000);
Query OK, 3 rows affected (1.58 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO orders(user_id, product_id) VALUES (2, 1), (3, 2), (2, 3);
Query OK, 3 rows affected (1.50 sec)
Records: 3  Duplicates: 0  Warnings: 0
```

**6. Construct and execute SELECT operator with WHERE, GROUP BY and ORDER BY.**
```commandline
mysql> SELECT label FROM products WHERE chassis = 'handset';
+-------------------------------------------------------------------+
| label                                                             |
+-------------------------------------------------------------------+
| Google Pixel 5 8/128GB                                            |
| Apple iPhone 13 Pro 6/128GB                                       |
+-------------------------------------------------------------------+
2 rows in set (0.00 sec)

mysql> SELECT label FROM products GROUP BY id;
+-------------------------------------------------------------------+
| label                                                             |
+-------------------------------------------------------------------+
| Google Pixel 5 8/128GB                                            |
| Apple iPhone 13 Pro 6/128GB                                       |
| Samsung Galaxy S21 8/256Gb                                        |
+-------------------------------------------------------------------+
3 rows in set (0.00 sec)

mysql> SELECT label, ram, rom, price FROM products ORDER BY ram;
+-------------------------------------------------------------------+-----+-----+-------+
| label                                                             | ram | rom | price |
+-------------------------------------------------------------------+-----+-----+-------+
| Samsung Galaxy S21 8/256Gb                                        |   8 | 256 | 35000 |
| Apple iPhone 13 Pro 6/128GB                                       |   6 | 128 | 30000 |
| Google Pixel 5 8/128GB                                            |   8 | 128 | 20000 |
+-------------------------------------------------------------------+-----+-----+-------+
3 rows in set (0.00 sec)
```

**7. Execute other different SQL queries DDL, DML, DCL.**
```commandline
mysql> UPDATE products SET price = 15499 WHERE id = 3;
Query OK, 1 row affected (0.53 sec)
Rows matched: 1  Changed: 1  Warnings: 0
```

**8. Create a database of new users with different privileges. Connect to the database a new user and verify that the privileges allow or deny certain actions.**
```commandline
mysql> CREATE USER 'reader'@'localhost' IDENTIFIED BY '12345';
Query OK, 0 rows affected (0.97 sec)

mysql> GRANT SELECT on *.* TO 'reader'@'localhost';
Query OK, 0 rows affected (1.35 sec)

mysql> CREATE USER 'writer'@'localhost' IDENTIFIED BY '54321';
Query OK, 0 rows affected (1.58 sec)

mysql> GRANT SELECT, UPDATE, INSERT on *.* TO 'writer'@'localhost';
Query OK, 0 rows affected (1.03 sec)

mysql> CREATE USER 'admin'@'localhost' IDENTIFIED BY '12121';
Query OK, 0 rows affected (0.84 sec)

mysql> GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost';
Query OK, 0 rows affected (0.50 sec)

mysql> ^DGoodbye!
user@pc-vm:~$ mysql -u reader -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.27-0ubuntu0.20.04.1 (Ubuntu)

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> USE store;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SELECT * FROM orders; -- should work
+----+---------+------------+
| id | user_id | product_id |
+----+---------+------------+
|  1 |       2 |          1 |
|  2 |       3 |          2 |
|  3 |       2 |          3 |
+----+---------+------------+
3 rows in set (0.00 sec)

mysql> DROP TABLE orders; -- should not work
ERROR 1142 (42000): DROP command denied to user 'reader'@'localhost' for table 'orders'
```

**9. Make a selection from the main table DB MySQL.**
```commandline
mysql> USE mysql
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SELECT * FROM global_grants WHERE user = 'root';
+------+-----------+-----------------------------+-------------------+
| USER | HOST      | PRIV                        | WITH_GRANT_OPTION |
+------+-----------+-----------------------------+-------------------+
| root | localhost | APPLICATION_PASSWORD_ADMIN  | Y                 |
| root | localhost | AUDIT_ADMIN                 | Y                 |
| root | localhost | AUTHENTICATION_POLICY_ADMIN | Y                 |
| root | localhost | BACKUP_ADMIN                | Y                 |
| root | localhost | BINLOG_ADMIN                | Y                 |
| root | localhost | BINLOG_ENCRYPTION_ADMIN     | Y                 |
| root | localhost | CLONE_ADMIN                 | Y                 |
| root | localhost | CONNECTION_ADMIN            | Y                 |
| root | localhost | ENCRYPTION_KEY_ADMIN        | Y                 |
| root | localhost | FLUSH_OPTIMIZER_COSTS       | Y                 |
| root | localhost | FLUSH_STATUS                | Y                 |
| root | localhost | FLUSH_TABLES                | Y                 |
| root | localhost | FLUSH_USER_RESOURCES        | Y                 |
| root | localhost | GROUP_REPLICATION_ADMIN     | Y                 |
| root | localhost | GROUP_REPLICATION_STREAM    | Y                 |
| root | localhost | INNODB_REDO_LOG_ARCHIVE     | Y                 |
| root | localhost | INNODB_REDO_LOG_ENABLE      | Y                 |
| root | localhost | PASSWORDLESS_USER_ADMIN     | Y                 |
| root | localhost | PERSIST_RO_VARIABLES_ADMIN  | Y                 |
| root | localhost | REPLICATION_APPLIER         | Y                 |
| root | localhost | REPLICATION_SLAVE_ADMIN     | Y                 |
| root | localhost | RESOURCE_GROUP_ADMIN        | Y                 |
| root | localhost | RESOURCE_GROUP_USER         | Y                 |
| root | localhost | ROLE_ADMIN                  | Y                 |
| root | localhost | SERVICE_CONNECTION_ADMIN    | Y                 |
| root | localhost | SESSION_VARIABLES_ADMIN     | Y                 |
| root | localhost | SET_USER_ID                 | Y                 |
| root | localhost | SHOW_ROUTINE                | Y                 |
| root | localhost | SYSTEM_USER                 | Y                 |
| root | localhost | SYSTEM_VARIABLES_ADMIN      | Y                 |
| root | localhost | TABLE_ENCRYPTION_ADMIN      | Y                 |
| root | localhost | XA_RECOVER_ADMIN            | Y                 |
+------+-----------+-----------------------------+-------------------+
32 rows in set (0.00 sec)
```

### Part 2
**10. Make backup of your database.**
```commandline
user@pc-vm:~$ sudo mysqldump -u root -p store > backup.sql
Enter password: 
user@pc-vm:~$ ls backup.sql 
backup.sql
```
**11. Delete the table and/or part of the data in the table.**
```commandline
mysql> USE store;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> DROP TABLE orders;
Query OK, 0 rows affected (4.71 sec)

mysql> SELECT * FROM orders;
ERROR 1146 (42S02): Table 'store.orders' doesn't exist
```
**12. Restore your database.**
```commandline
user@pc-vm:~$ sudo mysql -u root -p store < backup.sql 
Enter password: 
user@pc-vm:~$ sudo mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 18
Server version: 8.0.27-0ubuntu0.20.04.1 (Ubuntu)

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> USE store;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SELECT * FROM orders;
+----+---------+------------+
| id | user_id | product_id |
+----+---------+------------+
|  1 |       2 |          1 |
|  2 |       3 |          2 |
|  3 |       2 |          3 |
+----+---------+------------+
3 rows in set (0.00 sec)
```