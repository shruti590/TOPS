-- ASSIGNMENT

-- CRATE DATABSE

create database management;
use management;

-- 1) Statement to create the Contact table 
CREATE TABLE Contact (
    ContactID INT PRIMARY KEY,
    CompanyID INT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10),
    IsMain BOOLEAN,
    Email VARCHAR(45),
    Phone VARCHAR(12));
    insert into contact (contactID,companyID,FirstName,LastName,Street,City,State,Zip,IsMain,Email,Phone)
    values 
    (1,1,'Dianne','commor','789 oak st','Boston','MA','02118',TRUE,'dianne@example.com','111-111-1111'),
    (2,2,'jack','lee','321 pine st','chocago','IL','60616',false,'jack@example.com','222-222-2222');
    
    
-- 2) Statement to create the Employee table  
CREATE TABLE Employee (
    EmployeeID INT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Salary DECIMAL(10,2),
    HireDate DATE,
    JobTitle VARCHAR(25),
    Email VARCHAR(45),
    Phone VARCHAR(12));
    insert into employee(employeeID,firstname,lastname,salary,hiredate,jobtitle,email,phone)
    values
    (1,'lesley','bland',60000.00,'2020-01-15','manager','lesley@exmple.com','123-456-7890'),
    (2,'Anna','smith',55000.00,'2019-07-10','consultant','anna@exmple.com','987-654-3210');
    
--  3) Statement to create the ContactEmployee table

CREATE TABLE ContactEmployee (
    ContactEmployeeID INT,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,
    Description VARCHAR(100));
insert into contactemployee (contactID,EmployeeID,Contactdate,Description)
values 
(1,1,'2024-05-10','meeting with dianne connor'),
(2,1,'2024-06-15','Call with jack lee');

CREATE TABLE Company (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(2),
    zip VARCHAR(10));
    insert  Company (company_id, company_name, street, city, state, zip)
VALUES
(1, 'Tata Consultancy Services', '100 Industrial Rd', 'Mumbai',    'MH', '400001'),
(2, 'Infosys Ltd',                '200 Tech Park',    'Bengaluru', 'KA', '560001'),
(3, 'Toll Brothers',          '50 IT Hub',       'Hyderabad', 'TS', '500001'),
(4, 'Urban Outfitters, Inc.',    '213 pine st',      'chennai',   'TN','606160');
    
SET SQL_SAFE_UPDATES = 0;

-- 4) In the Employee table, the statement that changes Lesley Bland’s phone number 
-- to 215-555-8800 
UPDATE Employee
SET Phone = '215-555-8800'
WHERE FirstName = 'Lesley' AND LastName = 'Bland';

SET SQL_SAFE_UPDATES = 1;

-- 5) In the Company table, the statement that changes the name of “Urban 
-- Outfitters, Inc.” to “Urban Outfitters
UPDATE Company
SET Company_Name = 'Urban Outfitters'
WHERE Company_Name = 'Urban Outfitters, Inc.';

-- 6) In ContactEmployee table, the statement that removes Dianne Connor’s contact 
-- event with Jack Lee (one statement). 
delete from contactemployee
where contactid = 101 and employeeid = 202;

-- 7) Write the SQL SELECT query that displays the names of the employees that 
-- have contacted Toll Brothers (one statement). Run the SQL SELECT query in 
-- MySQL Workbench. Copy the results below as well. 
SELECT e.FirstName, e.LastName
FROM Contact c
JOIN ContactEmployee ce ON c.ContactID = ce.ContactID
JOIN Employee e ON ce.EmployeeID = e.EmployeeID
WHERE c.CompanyID IN (
    SELECT CompanyID FROM Company WHERE Company_Name = 'Toll Brothers');
    
-- 8) What is the significance of “%” and “_” operators in the LIKE statement? 
-- ANS: %: Represents zero or more characters.
-- _: Represents exactly one character.
-- Example:
-- WHERE name LIKE 'A%'     -- names starting with A
-- WHERE name LIKE '_a%'    -- second letter is 'a

-- 9) Explain normalization in the context of databases. 
-- ANS: Normalization is the process of organizing data to reduce redundancy and improve data integrity.
	-- •	It breaks down large tables into smaller related ones.
	-- •	Ensures data is stored in one place.
	-- •	Helps avoid anomalies (update, delete, insert).
	-- •	Normal forms (1NF, 2NF, 3NF…) define levels of normalization
    
-- 10) What does a join in MySQL mean? 
-- ANS: 
SELECT * FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- 11) What do you understand about DDL, DCL, and DML in MySQL? 
-- ANS: DDL (Data Definition Language) – Defines DB structure:
	-- •	Commands: CREATE, ALTER, DROP, TRUNCATE
	-- •	DML (Data Manipulation Language) – Manipulates data:
	-- •	Commands: SELECT, INSERT, UPDATE, DELETE
	-- •	DCL (Data Control Language) – Manages access:
	-- •	Commands: GRANT, REVOKE
    
-- 12) What is the role of the MySQL JOIN clause in a query, and what are some 
-- common types of joins? 
-- ANS: JOIN clause combines data from multiple tables using related columns.
-- Common types:
-- 	1.	INNER JOIN – Only matching rows in both tables.
-- 	2.	LEFT JOIN – All rows from left table + matched from right.
-- 3.	RIGHT JOIN – All rows from right table + matched from left.
-- 4.	FULL OUTER JOIN – All rows from both tables (not supported directly in MySQL but can be simulated).
-- 5.	CROSS JOIN – Cartesian product (all combinations)




