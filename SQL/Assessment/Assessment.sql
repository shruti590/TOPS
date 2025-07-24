create database school;
use school;

CREATE TABLE student (
    StdID INT,
    StdName VARCHAR(100),
    Sex VARCHAR(10),
    Percentage INT,
    Class VARCHAR(10),
    Sec VARCHAR(5),
    Stream VARCHAR(20),
    DOB DATE);

INSERT INTO student (StdID, StdName, Sex, Percentage, Class, Sec, Stream, DOB) VALUES
(1001, 'Surekha Joshi', 'Female', 82, '12', 'A', 'Science', '1998-03-08'),
(1002, 'MAAHI AGARWAL', 'Female', 56, '11', 'C', 'Commerce', '2008-11-23'),
(1003, 'Sanam Verma', 'Male', 59, '11', 'C', 'Commerce', '2006-06-29'),
(1004, 'Ronit Kumar', 'Male', 63, '11', 'C', 'Commerce', '1997-11-05'),
(1005, 'Dipesh Pulkit', 'Male', 78, '11', 'B', 'Science', '2003-09-14'),
(1006, 'JAHANVI Puri', 'Female', 60, '12', 'A', 'Science', '2008-11-23'),
(1007, 'Sanam Kumar', 'Male', 23, '12', 'A', 'Science', '1998-03-08'),
(1008, 'SAHIL SARAS', 'Male', 56, '11', 'C', 'Commerce', '2008-11-23'),
(1009, 'AKSHRA AGARWAL', 'Female', 79, '12', 'A', 'Science', '1996-10-11'),
(1010, 'STUTI MISHRA', 'Female', 42, '11', 'C', 'Commerce', '2008-11-23'),
(1011, 'HARSH AGARWAL', 'Male', 49, '11', 'C', 'Science', '1998-03-08'),
(1012, 'NIKUNJ AGARWAL', 'Male', 82, '12', 'A', 'Commerce', '1999-06-28'),
(1013, 'AKRITI SAXENA', 'Female', 59, '12', 'A', 'Science', '2008-11-23'),
(1014, 'TANI RASTOGI', 'Female', 82, '12', 'A', 'Science', '2008-11-23');

-- 1 To display all the records form STUDENT table. SELECT * FROM student.
SELECT * FROM student;

-- 2. To display any name and date of birth from the table STUDENT. SELECT StdName, DOB 
-- FROM student.
SELECT StdName, DOB FROM student;

-- 3. To display all students record where percentage is greater of equal to 80 FROM student table. 
--  SELECT * FROM student WHERE percentage >= 80;
SELECT * FROM student
WHERE percentage >= 80;

-- 4. To display student name, stream and percentage where percentage of student is more than 80 
-- SELECT StdName, Stream, Percentage WHERE percentage > 80; 
SELECT StdName, Stream, Percentage
FROM student
WHERE percentage > 80;

-- 5.  To display all records of science students whose percentage is more than 75 form student table. 
-- SELECT * FORM student WHERE stream = ‘Science’ AND percentage > 75;
SELECT * FROM student
WHERE stream = 'Science' AND percentage > 75;

