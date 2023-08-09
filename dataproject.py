##CREATE DATABASE NAMED BOOKSTORE##
import psycopg2

##conn = psycopg2.connect(database = 'postgres', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')
##
##conn.autocommit = True
##
##cursor = conn.cursor()
##
##create_db = '''CREATE database bookstore'''
##
##cursor.execute(create_db)
##
##
##print('Database Created....')
##
##conn.close()

##Check to see if the connection is succesful

conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')

print("The connection is Successful")

#Add Employee Table

conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')

cursor = conn.cursor()


cursor.execute("DROP TABLE IF EXISTS Employee")


sql_table_emp = '''CREATE TABLE Employee(
    EMPLOYEE_ID INT NOT NULL,
    FIRST_NAME CHAR(20) NOT NULL,
    LAST_NAME CHAR(20) NOT NULL,
    YEARS_TENURED INT NOT NULL,
    ROLE CHAR(20) NOT NULL,
    HOURLY_PAY INT NOT NULL)'''

cursor.execute(sql_table_emp)

conn.commit()

#Add Customer Table

conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')

cursor = conn.cursor()


cursor.execute("DROP TABLE IF EXISTS Customer")


sql_table_cust = '''CREATE TABLE Customer(
    Customer_ID INT NOT NULL,
    FIRST_NAME CHAR(20) NOT NULL,
    LAST_NAME CHAR(20) NOT NULL,
    EMAIL VARCHAR(70),
    MONTH_OF_BIRTH INT NOT NULL,
    DAY_OF_BIRTH INT NOT NULL,
    YEAR_OF_BIRTH INT NOT NULL,
    AGE INT NOT NULL)'''

cursor.execute(sql_table_cust)

conn.commit()

conn.close()

#Add Book Table

conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')

cursor = conn.cursor()


cursor.execute("DROP TABLE IF EXISTS Books")


sql_table_books = '''CREATE TABLE Books(
    Book_ID INT NOT NULL,
    Book_TITLE CHAR(40) NOT NULL,
    AUTHOR_FIRST_NAME CHAR(20) NOT NULL,
    AUTHOR_LAST_NAME CHAR(20) NOT NULL,
    GENRE CHAR(70),
    PRICE INT NOT NULL)'''

cursor.execute(sql_table_books)

conn.commit()

conn.close()

#Add Book Table

conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')

cursor = conn.cursor()


cursor.execute("DROP TABLE IF EXISTS Order_T")

sql_table_order = '''CREATE TABLE Order_T(
    PURCHASE_ID INT NOT NULL,
    BOOK_ID INT NOT NULL,
    EMPLOYEE_ID INT NOT NULL,
    CUSTOMER_ID INT NOT NULL,
    PURCHASE_AMOUNT INT NOT NULL,
    BOOK_TITLE char(40) NOT NULL,
    DATE_OF_PURCHASE INT NOT NULL,
    MONTH_OF_PURCHASE INT NOT NULL,
    YEAR_OF_PURCHASE INT NOT NULL)'''

cursor.execute(sql_table_order)

conn.commit()

conn.close()

conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')


cursor = conn.cursor()

statement = "INSERT INTO Employee (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,YEARS_TENURED,ROLE,HOURLY_PAY) VALUES (%s,%s,%s,%s,%s,%s)"
data = [(1,'Lexie','Dickson',12,'Manager',27),
(2,'Ibrahim','Edwards',2,'Cashier',15),
(3,'Valentin','Gonzales',1,'Cashier',15),
(4,'Jaidyn','Mcgarth',4,'Stocker',17),
(5,'Kody','Blackburn',7,'Stocker',20)]

cursor.executemany(statement,data)

retrieve_data = '''SELECT * from Employee'''

cursor.execute(retrieve_data)
result = cursor.fetchall()
for row in result:
    print(row)

conn.commit()
conn.close()

conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')


cursor = conn.cursor()

statement = "INSERT INTO Customer (CUSTOMER_ID,FIRST_NAME,LAST_NAME,EMAIL,MONTH_OF_BIRTH,DAY_OF_BIRTH,YEAR_OF_BIRTH,AGE) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
data = [(101,'Karley','Massey','KarleyMassey5@gmail.com',1,27,1994,27),(102,'Mylee','Spears','MyleeSpears114@gmail.com',2,4,1990,31),(103,'Marcel','Shea','MarcelShea14@gmail.com',7,25,1996,25),
(104,'Jordon','Zimmerman','JordonZimmerman94@gmail.com',7,15,1988,33),(105,'Autumn','Lewis','AutumnLewis54@gmail.com',10,14,1999,22),
(106,'Amy','Boyd','AmyBoyd113@gmail.com',11,27,1985,36),(107,'Rachael','Cisneros','RachaelCisneros8@gmail.com',7,23,1998,23),(108,'Kyler','Fritz','KylerFritz111@gmail.com',4,13,1989,32),
(109,'Cortez','Mays','CortezMays83@gmail.com',6,17,1973,48),(110,'Esteban','Cain','EstebanCain13@gmail.com',5,20,1977,44),(111,'Santos','Mcmahon','SantosMcmahon0@gmail.com',4,12,2000,21),
(112,'Tabitha','Collier','TabithaCollier122@gmail.com',8,9,1989,32),(113,'Olivia','Franklin','OliviaFranklin1@gmail.com',3,10,1988,33),
(114,'Adalyn','Mcdowell','AdalynMcdowell81@gmail.com',5,3,1999,22),(115,'Felipe','Cantrell','FelipeCantrell78@gmail.com',8,14,1976,45),
(116,'Monique','Monreno','MoniqueMonreno73@gmail.com',2,12,1985,36),(117,'Ammanuel','York','AmmanuelYork16@gmail.com',11,16,1977,44),
(118,'Yahir','Collins','YahirCollins60@gmail.com',8,18,1993,28),(119,'Nataly','Mccarty','NatalyMccarty99@gmail.com',11,1,1999,22)
]

cursor.executemany(statement,data)

retrieve_data = '''SELECT * from Customer'''

cursor.execute(retrieve_data)
result = cursor.fetchall()
for row in result:
    print(row)

conn.commit()
conn.close()

conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')


cursor = conn.cursor()

statement = "INSERT INTO Books (BOOK_ID,BOOK_TITLE,AUTHOR_FIRST_NAME,AUTHOR_LAST_NAME,GENRE,PRICE) VALUES (%s,%s,%s,%s,%s,%s)"
data = [(1000,'DaVinci Code','Dan','Brown','Crime',15),(1001,'DaVinci Code','Dan','Brown','Crime',15),(1002,'DaVinci Code','Dan','Brown','Crime',15),
(1003,'DaVinci Code','Dan','Brown','Crime',15),(1004,'DaVinci Code','Dan','Brown','Crime',15),(1005,'DaVinci Code','Dan','Brown','Crime',15),(1006,'DaVinci Code','Dan','Brown','Crime',15),(1007,'DaVinci Code','Dan','Brown','Crime',15),(1008,'DaVinci Code','Dan','Brown','Crime',15),(1009,'DaVinci Code','Dan','Brown','Crime',15),(1010,'DaVinci Code','Dan','Brown','Crime',15),(1011,'Harry Potter','JK','Rowling','Wizards',10),(1012,'Harry Potter','JK','Rowling','Wizards',10),(1013,'Harry Potter','JK','Rowling','Wizards',10),(1014,'Harry Potter','JK','Rowling','Wizards',10),(1015,'Harry Potter','JK','Rowling','Wizards',10),(1016,'Harry Potter','JK','Rowling','Wizards',10),(1017,'Harry Potter','JK','Rowling','Wizards',10),(1018,'Harry Potter','JK','Rowling','Wizards',10),(1019,'Harry Potter','JK','Rowling','Wizards',10),(1020,'Harry Potter','JK','Rowling','Wizards',10),(1021,'Fifty Shades of Grey','EL','James','Romance',25),(1022,'Fifty Shades of Grey','EL','James','Romance',25),(1023,'Fifty Shades of Grey','EL','James','Romance',25),(1024,'Fifty Shades of Grey','EL','James','Romance',25),(1025,'Fifty Shades of Grey','EL','James','Romance',25),
(1026,'Fifty Shades of Grey','EL','James','Romance',25),(1027,'Fifty Shades of Grey','EL','James','Romance',25),(1028,'Twilight','Stephenie','Meyer','Young Adult',12),
(1029,'Twilight','Stephenie','Meyer','Young Adult',12),(1030,'Twilight','Stephenie','Meyer','Young Adult',12),(1031,'Twilight','Stephenie','Meyer','Young Adult',12),
(1032,'Twilight','Stephenie','Meyer','Young Adult',12),(1033,'Twilight','Stephenie','Meyer','Young Adult',12),(1034,'Twilight','Stephenie','Meyer','Young Adult',12),
(1035,'Twilight','Stephenie','Meyer','Young Adult',12),(1036,'Twilight','Stephenie','Meyer','Young Adult',12),(1037,'Twilight','Stephenie','Meyer','Young Adult',12),
(1038,'Twilight','Stephenie','Meyer','Young Adult',12),(1039,'Twilight','Stephenie','Meyer','Young Adult',12),(1040,'Twilight','Stephenie','Meyer','Young Adult',12),
(1041,'The Lost Symbol','Dan','Brown','Crime',15),(1042,'The Lost Symbol','Dan','Brown','Crime',15),(1043,'The Lost Symbol','Dan','Brown','Crime',15),
(1044,'The Lost Symbol','Dan','Brown','Crime',15),(1045,'The Lost Symbol','Dan','Brown','Crime',15),(1046,'The Lost Symbol','Dan','Brown','Crime',15),
(1047,'The Lost Symbol','Dan','Brown','Crime',15),(1048,'The Lost Symbol','Dan','Brown','Crime',15),(1049,'The Lost Symbol','Dan','Brown','Crime',15),
(1050,'Pride and Prejudice','Jane ','Austen','Romance',5),(1051,'Pride and Prejudice','Jane ','Austen','Romance',5),(1052,'Pride and Prejudice','Jane ','Austen','Romance',5),
(1053,'Pride and Prejudice','Jane ','Austen','Romance',5),(1054,'Pride and Prejudice','Jane ','Austen','Romance',5),(1055,'Pride and Prejudice','Jane ','Austen','Romance',5),
(1056,'Pride and Prejudice','Jane ','Austen','Romance',5),(1057,'Pride and Prejudice','Jane ','Austen','Romance',5),(1058,'Pride and Prejudice','Jane ','Austen','Romance',5),
(1059,'Pride and Prejudice','Jane ','Austen','Romance',5),(1060,'Pride and Prejudice','Jane ','Austen','Romance',5),(1061,'Pride and Prejudice','Jane ','Austen','Romance',5),
(1062,'Pride and Prejudice','Jane ','Austen','Romance',5),(1063,'Pride and Prejudice','Jane ','Austen','Romance',5),(1064,'Pride and Prejudice','Jane ','Austen','Romance',5),
(1065,'Hunger Games','Suzanne','Collins','Young Adult',11),(1066,'Hunger Games','Suzanne','Collins','Young Adult',11),(1067,'Hunger Games','Suzanne','Collins','Young Adult',11),
(1068,'Hunger Games','Suzanne','Collins','Young Adult',11),(1069,'Hunger Games','Suzanne','Collins','Young Adult',11),(1070,'Hunger Games','Suzanne','Collins','Young Adult',11),
(1071,'Hunger Games','Suzanne','Collins','Young Adult',11),(1072,'Hunger Games','Suzanne','Collins','Young Adult',11),(1073,'Hunger Games','Suzanne','Collins','Young Adult',11),
(1075,'Hunger Games','Suzanne','Collins','Young Adult',11),(1074,'Hunger Games','Suzanne','Collins','Young Adult',11),(1076,'Hunger Games','Suzanne','Collins','Young Adult',11),
(1077,'Hunger Games','Suzanne','Collins','Young Adult',11),(1078,'Spirit Mage','Layton','Greene','Wizards',7),(1079,'Spirit Mage','Layton','Greene','Wizards',7),
(1080,'Spirit Mage','Layton','Greene','Wizards',7),(1081,'Spirit Mage','Layton','Greene','Wizards',7),(1082,'Spirit Mage','Layton','Greene','Wizards',7),
(1083,'Spirit Mage','Layton','Greene','Wizards',7),(1084,'Spirit Mage','Layton','Greene','Wizards',7),(1085,'Spirit Mage','Layton','Greene','Wizards',7),
(1086,'Spirit Mage','Layton','Greene','Wizards',7),(1087,'Spirit Mage','Layton','Greene','Wizards',7),(1088,'Spirit Mage','Layton','Greene','Wizards',7),
(1089,'Spirit Mage','Layton','Greene','Wizards',7),(1090,'Spirit Mage','Layton','Greene','Wizards',7),(1091,'Spirit Mage','Layton','Greene','Wizards',7),
(1092,'Spirit Mage','Layton','Greene','Wizards',7)
]

cursor.executemany(statement,data)

retrieve_data = '''SELECT * from Books'''

cursor.execute(retrieve_data)
result = cursor.fetchall()
for row in result:
    print(row)

conn.commit()
conn.close()

conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')


cursor = conn.cursor()

statement = "INSERT INTO Order_T (PURCHASE_ID,BOOK_ID,EMPLOYEE_ID,CUSTOMER_ID,PURCHASE_AMOUNT,BOOK_TITLE,DATE_OF_PURCHASE,MONTH_OF_PURCHASE,YEAR_OF_PURCHASE) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
data = [(9000,1090,5,113,7,'Spirit Mage',2,7,2021),(9001,1025,5,117,25,'Fifty Shades of Grey',20,4,2021),(9002,1084,5,111,7,'Spirit Mage',9,11,2021),
(9003,1000,3,101,15,'DaVinci Code',7,1,2021),(9004,1019,3,110,10,'Harry Potter',5,5,2021),(9005,1068,2,110,11,'Hunger Games',17,11,2021),(9006,1045,1,106,15,'The Lost Symbol',8,4,2021),(9007,1024,2,109,25,'Fifty Shades of Grey',15,12,2021),
(9008,1065,3,119,11,'Hunger Games',21,7,2021),(9009,1013,5,118,10,'Harry Potter',22,8,2021),(9010,1036,5,102,12,'Twilight',23,9,2021),(9011,1087,3,112,7,'Spirit Mage',6,11,2021),
(9012,1002,5,112,15,'DaVinci Code',9,9,2021),(9013,1080,2,104,7,'Spirit Mage',16,6,2021),(9014,1026,5,116,25,'Fifty Shades of Grey',9,7,2021),(9015,1035,4,107,12,'Twilight',8,4,2021),
(9016,1083,3,114,7,'Spirit Mage',10,10,2021),(9017,1040,3,102,12,'Twilight',7,8,2021),(9018,1075,3,103,11,'Hunger Games',3,1,2021),(9019,1077,3,106,11,'Hunger Games',6,11,2021),
(9020,1056,2,102,5,'Pride and Prejudice',8,9,2021),(9021,1020,4,112,10,'Harry Potter',9,2,2021),(9022,1007,1,102,15,'DaVinci Code',13,11,2021),
(9023,1016,4,117,10,'Harry Potter',5,3,2021),(9024,1018,2,119,10,'Harry Potter',25,2,2021),(9025,1060,2,111,5,'Pride and Prejudice',5,5,2021),
(9026,1062,5,112,5,'Pride and Prejudice',5,3,2021),(9027,1066,1,109,11,'Hunger Games',6,5,2021),(9028,1072,3,116,11,'Hunger Games',18,3,2021),
(9029,1010,5,104,15,'DaVinci Code',24,10,2021),(9030,1048,4,110,15,'The Lost Symbol',18,6,2021),(9031,1034,3,107,12,'Twilight',3,10,2021),
(9032,1047,1,117,15,'The Lost Symbol',15,9,2021),(9033,1009,2,108,15,'DaVinci Code',17,7,2021),(9034,1003,2,102,15,'DaVinci Code',17,11,2021),
(9035,1055,5,108,5,'Pride and Prejudice',4,2,2021),(9036,1059,4,105,5,'Pride and Prejudice',9,2,2021),(9037,1043,3,116,15,'The Lost Symbol',20,7,2021),
(9038,1005,3,101,15,'DaVinci Code',28,1,2021),(9039,1069,4,119,11,'Hunger Games',18,3,2021),(9040,1046,3,114,15,'The Lost Symbol',19,3,2021),
(9041,1001,4,110,15,'DaVinci Code',18,2,2021),(9042,1063,4,104,5,'Pride and Prejudice',22,4,2021),(9043,1023,1,102,25,'Fifty Shades of Grey',22,1,2021),
(9044,1076,4,103,11,'Hunger Games',20,7,2021),(9045,1021,5,116,25,'Fifty Shades of Grey',27,1,2021),(9046,1015,1,118,10,'Harry Potter',24,4,2021),
(9047,1008,2,106,15,'DaVinci Code',4,2,2021),(9048,1014,5,103,10,'Harry Potter',4,2,2021),(9049,1039,2,116,12,'Twilight',13,1,2021),(9050,1061,1,105,5,'Pride and Prejudice',8,6,2021),
(9051,1058,5,113,5,'Pride and Prejudice',16,4,2021),(9052,1042,3,118,15,'The Lost Symbol',5,6,2021),(9053,1006,3,119,15,'DaVinci Code',28,3,2021),
(9054,1044,4,111,15,'The Lost Symbol',13,3,2021),(9055,1033,1,105,12,'Twilight',11,5,2021),(9056,1038,5,107,12,'Twilight',19,12,2021),
(9057,1064,5,107,5,'Pride and Prejudice',27,3,2021),(9058,1086,5,118,7,'Spirit Mage',2,9,2021),(9059,1074,5,110,11,'Hunger Games',13,3,2021)
]

cursor.executemany(statement,data)

retrieve_data = '''SELECT * from Order_T'''

cursor.execute(retrieve_data)
result = cursor.fetchall()
for row in result:
    print(row)

conn.commit()
conn.close()

#Question 1: What is the average age of customers?
conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')


cursor = conn.cursor()


retrieve_data = '''SELECT AVG(AGE) FROM CUSTOMER'''

cursor.execute(retrieve_data)
result = cursor.fetchall()
for row in result:
    print('The Average Age of the Customers is', row)

conn.commit()
conn.close()

# Question 2: What is the most expensive book?
conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')


cursor = conn.cursor()

retrieve_data = '''SELECT BOOK_TITLE, MAX(PRICE) FROM BOOKS
GROUP BY BOOK_TITLE
ORDER BY MAX(PRICE)
LIMIT 1'''

cursor.execute(retrieve_data)
result = cursor.fetchall()
for row in result:
    print('The most expensive book is', row)

conn.commit()
conn.close()

# Question 3: What is the age of the customer with the most purchases?
conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')


cursor = conn.cursor()

retrieve_data = '''SELECT CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME, CUSTOMER.AGE, COUNT(Order_T.PURCHASE_ID) FROM CUSTOMER
FULL JOIN Order_T on Order_T.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
GROUP BY CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME, CUSTOMER.AGE
ORDER BY COUNT(Order_T.PURCHASE_ID) desc
LIMIT 1'''

cursor.execute(retrieve_data)
result = cursor.fetchall()
for row in result:
    print('The customer with the most purchases is', row)

conn.commit()
conn.close()

# Question 4: Which month has the most number of purchases?
conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')


cursor = conn.cursor()

retrieve_data = '''SELECT MONTH_OF_PURCHASE, COUNT(PURCHASE_ID) FROM Order_T
GROUP BY MONTH_OF_PURCHASE
ORDER BY COUNT(PURCHASE_ID) DESC
LIMIT 1'''

cursor.execute(retrieve_data)
result = cursor.fetchall()
for row in result:
    print('The month with the most purchases is', row)

conn.commit()
conn.close()

# Question 5: How many unique books does the bookstore have?
conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')


cursor = conn.cursor()

retrieve_data = '''SELECT DISTINCT BOOK_TITLE FROM BOOKS'''

cursor.execute(retrieve_data)
result = cursor.fetchall()
for row in result:
    print('The bookstore has ', row, 'unique books')

conn.commit()
conn.close()

# Question 7: Give the employees tenured over a year a 10% raise
conn = psycopg2.connect(database = 'bookstore', user = 'postgres', password = 'dragon909', host = 'localhost', port = '5432')


cursor = conn.cursor()

retrieve_data = '''UPDATE EMPLOYEE
SET HOURLY_PAY = HOURLY_PAY * 0.1
WHERE YEARS_TENURED > 1
'''

cursor.execute(retrieve_data)
result = cursor.fetchall()
for row in result:
    print(row)

conn.commit()
conn.close()

