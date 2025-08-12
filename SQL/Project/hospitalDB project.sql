CREATE DATABASE HospitalDB;
USE HospitalDB;


CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    contact VARCHAR(15));
    INSERT INTO patients (name, gender, age, contact) VALUES
('Amit Sharma', 'Male', 45, '9876543210'),
('Rina Das', 'Female', 32, '9876501234'),
('John Paul', 'Male', 60, '9988776655');


CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    specialization VARCHAR(50),
    contact VARCHAR(15));
    INSERT INTO doctors (name, specialization, contact) VALUES
('Dr. Mehta', 'Cardiology', '9001234567'),
('Dr. Anjali', 'Orthopedics', '9012345678'),
('Dr. Vinod', 'Dermatology', '9023456789');


CREATE TABLE admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    admission_date DATE,
    discharge_date DATE,
    diagnosis VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id));
    INSERT INTO admissions (patient_id, doctor_id, admission_date, discharge_date, diagnosis) VALUES
(1, 1, '2025-08-01', '2025-08-04', 'Heart Disease'),
(2, 2, '2025-08-02', NULL, 'Fracture'),
(3, 3, '2025-08-03', '2025-08-06', 'Skin Infection');


CREATE TABLE bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT,
    total_amount DECIMAL(10,2),
    paid_amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id));
    INSERT INTO bills (admission_id, total_amount, paid_amount, payment_date) VALUES
(1, 15000.00, 15000.00, '2025-08-04'),
(2, 10000.00, 5000.00, '2025-08-06'),
(3, 8000.00, 8000.00, '2025-08-06');


CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT,
    treatment_date DATE,
    description VARCHAR(255),
    cost DECIMAL(10,2),
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id));
    INSERT INTO treatments (admission_id, treatment_date, description, cost) VALUES
(1, '2025-08-01', 'ECG', 2000.00),
(1, '2025-08-02', 'Angioplasty', 13000.00),
(2, '2025-08-02', 'X-Ray', 1500.00),
(3, '2025-08-03', 'Skin Test', 3000.00);


-- Create the appointments table
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id));
-- Sample data
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-08-09', 'Completed'),
(2, 2, '2025-08-10', 'Pending'),
(3, 3, '2025-08-11', 'Cancelled');


-- (1) List all patients' names and phone numbers.
SELECT name, contact
FROM patients;
INSERT INTO patients (name, gender, age, contact)
VALUES ('Kamla Devi', 'Female', 67, '9888899999');


-- (2) Find all female patients who are older than 50. 
SELECT name, gender, age, contact
FROM patients
WHERE gender = 'Female' AND age > 50;


-- (3) Show doctors ordered by their years of experience in descending order.
ALTER TABLE doctors
ADD COLUMN experience INT;
UPDATE doctors SET experience = 15
 WHERE doctor_id = 1;
UPDATE doctors SET experience = 10 
WHERE doctor_id = 2;  
UPDATE doctors SET experience = 5  
WHERE doctor_id = 3; 

SELECT name, specialization, experience
FROM doctors
ORDER BY experience DESC;


-- (4) List all unique specializations available in the hospital.
SELECT DISTINCT specialization
FROM doctors;


-- (5) Find appointments scheduled between '2025-01-01' and '2025-08-01'.
SELECT admission_id, patient_id, doctor_id, admission_date, diagnosis
FROM admissions
WHERE admission_date BETWEEN '2025-01-01' AND '2025-08-01';


-- (6) List details of patients whose age is either 25, 30, or 40.
SELECT * FROM patients
WHERE age IN (25, 30, 40);
select * from patients;


-- (7) Find patient names that start with 'A'.
SELECT name
FROM patients
WHERE name LIKE 'A%';


-- (8) Retrieve appointments where status is not updated (i.e., NULL).
ALTER TABLE admissions
ADD COLUMN status VARCHAR(50);
UPDATE admissions SET status = 'Admitted' 
WHERE admission_id = 1;
UPDATE admissions SET status = NULL
 WHERE admission_id = 2;
UPDATE admissions SET status = 'Discharged'
 WHERE admission_id = 3;
 SELECT * FROM admissions
WHERE status IS NULL;


-- (9) Show top 5 most expensive treatments.
SELECT treatment_id, admission_id, treatment_date, description, cost
FROM treatments
ORDER BY cost DESC
LIMIT 5;


-- (10) Get patient name and doctor name for all appointments. 
SELECT p.name AS patient_name,
	   d.name AS doctor_name,
       a.admission_date,
       a.diagnosis
FROM admissions a
LEFT JOIN patients p ON a.patient_id = p.patient_id
LEFT JOIN doctors d ON a.doctor_id = d.doctor_id;


-- (11) Show treatments given by doctors with specialization = 'Cardiology'.
SELECT t.treatment_id,
       t.treatment_date,
       t.description,
       t.cost,
       d.name AS doctor_name,
       d.specialization
FROM treatments t
right join  admissions a ON t.admission_id = a.admission_id
RIGHT JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE d.specialization = 'Cardiology';


-- (12) Count how many appointments each doctor has.
SELECT d.name AS doctor_name,COUNT(a.admission_id) AS total_appointments
FROM doctors d
LEFT JOIN admissions a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name;


-- (13) Calculate total bill amount paid by each patient.
SELECT p.name AS patient_name,SUM(b.paid_amount) AS total_paid
FROM bills b
RIGHT JOIN admissions a ON b.admission_id = a.admission_id
RIGHT JOIN patients p ON a.patient_id = p.patient_id
GROUP BY p.patient_id, p.name;


-- (14) Find doctors who have more than 5 appointments.
SELECT d.name AS doctor_name,COUNT(a.admission_id) AS total_appointments
FROM admissions a
RIGHT JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id, d.name
HAVING COUNT(a.admission_id) > 5;
select * from admissions;


-- (15) Get a list of all patients and their appointment status (even if they haven’t booked).
SELECT p.name AS patient_name,
       a.status AS appointment_status
FROM patients p
LEFT JOIN admissions a ON p.patient_id = a.patient_id;


-- (16) Show all doctors and the patient names they’ve treated (include doctors with no
-- patients).
SELECT d.name AS doctor_name,
       p.name AS patient_name
FROM doctors d
LEFT JOIN admissions a ON d.doctor_id = a.doctor_id
LEFT JOIN patients p ON a.patient_id = p.patient_id;


-- (17) Find average treatment cost for each diagnosis.
SELECT a.diagnosis,
AVG(t.cost) AS average_treatment_cost
FROM admissions a
LEFT JOIN treatments t ON a.admission_id = t.admission_id
GROUP BY a.diagnosis;


-- (18) Rename columns in the output (e.g., doctor_name, patient_name, total_cost).
SELECT d.name AS doctor_name,
    p.name AS patient_name,SUM(t.cost) AS total_cost
FROM doctors d
INNER JOIN admissions a ON d.doctor_id = a.doctor_id
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN treatments t ON a.admission_id = t.admission_id
GROUP BY d.name, p.name;


-- (19) Show treatment cost category as 'Low', 'Medium', or 'High' based on cost.
SELECT treatment_id, description, cost, case
WHEN cost < 2000 THEN 'Low'
WHEN cost BETWEEN 2000 AND 7000 THEN 'Medium'
WHEN cost > 7000 THEN 'High'
END AS cost_category
FROM treatments;


-- (20) List patients who have appointments with a doctor specialized in 'Neurology'.
-- LEFT JOIN part
SELECT p.name AS patient_name,
       d.name AS doctor_name,
       d.specialization
FROM patients p
LEFT JOIN admissions a ON p.patient_id = a.patient_id
LEFT JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE d.specialization = 'Neurology'
UNION 
-- RIGHT JOIN part
SELECT p.name AS patient_name,
       d.name AS doctor_name,
       d.specialization
FROM patients p
RIGHT JOIN admissions a ON p.patient_id = a.patient_id
RIGHT JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE d.specialization = 'Neurology';


-- (21) Find the average age of patients who have paid their bills.
SELECT 
AVG(p.age) AS average_age_of_paying_patients
FROM patients p
INNER JOIN admissions a ON p.patient_id = a.patient_id
INNER JOIN bills b ON a.admission_id = b.admission_id
WHERE b.paid_amount > 0;


-- (22) Find doctors who have treated at least one patient.
SELECT d.doctor_id,
       d.name AS doctor_name,
       d.specialization
FROM doctors d
INNER JOIN admissions a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name, d.specialization;


-- (23) Rank patients based on total bill amount paid (highest first).
SELECT 
p.name AS patient_name,IFNULL(SUM(b.paid_amount), 0) AS total_paid,
RANK() OVER (ORDER BY SUM(b.paid_amount) DESC) AS payment_rank
FROM bills b
RIGHT JOIN admissions a ON b.admission_id = a.admission_id
RIGHT JOIN patients p ON a.patient_id = p.patient_id
GROUP BY p.patient_id, p.name;


-- (24) Using a CTE, calculate total billing per patient and filter those over ₹50,000.
WITH patient_billing AS (SELECT p.patient_id,
                                p.name AS patient_name,SUM(b.total_amount) AS total_billed
    FROM patients p
	inner join admissions a ON p.patient_id = a.patient_id
  inner JOIN bills b ON a.admission_id = b.admission_id
    GROUP BY p.patient_id, p.name)
SELECT patient_name,total_billed
FROM patient_billing
WHERE total_billed > 50000;


-- (25) Call a stored procedure to generate monthly revenue report.
DELIMITER //
CREATE PROCEDURE MonthlyRevenueReport(IN report_month DATE)
BEGIN
    SELECT 
        DATE_FORMAT(b.payment_date, '%Y-%m') AS month,
        SUM(b.total_amount) AS total_billed,
        SUM(b.paid_amount) AS total_paid,
        SUM(b.total_amount - b.paid_amount) AS total_unpaid
    FROM bills b
    WHERE DATE_FORMAT(b.payment_date, '%Y-%m') = DATE_FORMAT(report_month, '%Y-%m')
    GROUP BY month;
END//
DELIMITER ;
CALL MonthlyRevenueReport('2025-08-01');


-- (26) Combine lists of all doctor and patient phone numbers.
DESC doctors;
DESC patients;
SELECT name AS person_name, contact AS contact, 'Doctor' AS role
FROM doctors
UNION
SELECT name AS person_name, contact AS contact, 'Patient' AS role
FROM patients;


-- (27) Get count of appointments by status ('Completed', 'Pending', 'Cancelled').
SELECT status,COUNT(*) AS appointment_count
FROM admissions
GROUP BY status;


-- (28) Create a view of current month appointments with patient and doctor names.
CREATE VIEW CurrentMonthAppointments AS
SELECT a.admission_id,
       p.name AS patient_name,
	   d.name AS doctor_name,
       a.admission_date,
	   a.status
FROM admissions a
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE MONTH(a.admission_date) = MONTH(CURDATE())
  AND YEAR(a.admission_date) = YEAR(CURDATE());
  
SELECT * FROM CurrentMonthAppointments;


-- (29) Write a trigger to auto-update payment_status to 'Paid' when full amount is inserted.
DESC bills;
ALTER TABLE bills ADD payment_status VARCHAR(20);

DELIMITER //
CREATE TRIGGER set_payment_status_after_update
BEFORE UPDATE ON bills
FOR EACH ROW
BEGIN IF NEW.paid_amount = NEW.total_amount THEN
SET NEW.payment_status = 'Paid';
ELSE
SET NEW.payment_status = 'Unpaid';
END IF;
END//
DELIMITER ;


-- (30) Assign row numbers to treatments per patient ordered by treatment date.
SELECT p.name AS patient_name,
       t.treatment_id,
       t.description,
	   t.treatment_date,
ROW_NUMBER() OVER (PARTITION BY p.patient_id
				   ORDER BY t.treatment_date) AS treatment_number
FROM treatments t
INNER JOIN admissions a ON t.admission_id = a.admission_id
INNER JOIN patients p ON a.patient_id = p.patient_id;


-- (31) Show patient names in uppercase and extract only the first 3 letters.
SELECT name AS original_name,UPPER(name) AS upper_name,
LEFT(UPPER(name), 3) AS first_3_letters
FROM patients;


-- (32) Find the number of days between appointment date and billing date for each treatment.
SELECT t.treatment_id, t.description,
	   a.admission_date AS appointment_date,
	   b.payment_date AS billing_date, DATEDIFF(b.payment_date, a.admission_date) AS days_between
FROM bills b
RIGHT JOIN admissions a ON b.admission_id = a.admission_id
RIGHT JOIN treatments t ON a.admission_id = t.admission_id;


-- (33) Show all appointments and use 'Not Updated' if the status is NULL.
SELECT admission_id,patient_id,doctor_id,admission_date, 
IFNULL(status, 'Not Updated') AS appointment_status
FROM admissions;


-- (34) List patient names, treatment description, and doctor name where appointment status is 'Completed'.
SELECT p.name AS patient_name,
       t.description AS treatment_description,
	   d.name AS doctor_name
FROM admissions a
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN doctors d ON a.doctor_id = d.doctor_id
INNER JOIN treatments t ON a.admission_id = t.admission_id
WHERE a.status = 'Completed';


-- (35) Display the patient name, doctor name, department name, and treatment cost.
SELECT p.name AS patient_name,
       d.name AS doctor_name,
       d.specialization AS department_name,
       t.cost AS treatment_cost
FROM treatments t
INNER JOIN admissions a ON t.admission_id = a.admission_id
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN doctors d ON a.doctor_id = d.doctor_id;


-- (36) Find duplicate patient records based on name and phone number.
SELECT name, contact, COUNT(contact) AS duplicate_count
FROM patients
GROUP BY name, contact
HAVING COUNT(contact) > 1;

-- (37) Delete all treatments that are not linked to any appointment.
SELECT * FROM treatments
WHERE admission_id NOT IN (
SELECT admission_id FROM admissions);


-- (38) Update the appointment status to 'Completed' where billing has been paid.
SET SQL_SAFE_UPDATES = 0;
UPDATE admissions a
JOIN bills b ON a.admission_id = b.admission_id
SET a.status = 'Completed'
WHERE b.total_amount = b.paid_amount;
SET SQL_SAFE_UPDATES = 1;


-- (39) Ensure that treatment_cost is always greater than zero.
ALTER TABLE treatments
ADD CONSTRAINT chk_treatment_cost_positive
CHECK (cost > 0);
DELIMITER //
CREATE TRIGGER trg_check_treatment_cost
BEFORE INSERT ON treatments
FOR EACH ROW
BEGIN
    IF NEW.cost <= 0 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Treatment cost must be greater than zero';
    END IF;
END//
DELIMITER ;


-- (40) Add a default value 'Pending' to appointment status if not specified.
ALTER TABLE admissions
ALTER COLUMN status SET DEFAULT 'Pending';

ALTER TABLE admissions
MODIFY status VARCHAR(20) DEFAULT 'Pending';

INSERT INTO admissions (patient_id, doctor_id, admission_date, discharge_date, diagnosis)
VALUES (1, 2, '2025-08-08', NULL, 'Test Diagnosis');
SELECT admission_id, status FROM admissions;


-- (41) Write a SQL transaction: Insert a bill, update status, and commit only if both succeed.
START TRANSACTION;
-- Step 1: Insert a new bill
INSERT INTO bills (admission_id, total_amount, paid_amount, payment_date)
VALUES (2, 10000.00, 10000.00, '2025-08-08');

-- Step 2: Update status to Completed for the same admission
UPDATE admissions
SET status = 'Completed'
WHERE admission_id = 2;

-- If both succeed, commit
COMMIT;


-- (42) Create an index on appointment_date to speed up queries.
CREATE INDEX idx_appointment_date
ON appointments (appointment_date);
SELECT * FROM appointments
WHERE appointment_date BETWEEN '2025-08-09' AND '2025-08-11';


-- (45) When might you combine the billing and treatment tables into one?
CREATE TABLE treatment_billing (
    treatment_id INT PRIMARY KEY,
    admission_id INT,
    treatment_date DATE,
    description VARCHAR(255),
    cost DECIMAL(10,2),
    paid_amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id));
    
    
-- (46) Find patients whose treatment cost is greater than the average cost of their own treatments.
SELECT p.patient_id, p.name, t.description, t.cost
FROM patients p
INNER JOIN admissions a 
ON p.patient_id = a.patient_id
INNER JOIN treatments t 
ON a.admission_id = t.admission_id
INNER JOIN (SELECT a2.patient_id, 
           AVG(t2.cost) AS avg_cost
FROM admissions a2
INNER JOIN treatments t2 
        ON a2.admission_id = t2.admission_id
GROUP BY a2.patient_id) avg_table 
    ON p.patient_id = avg_table.patient_id
WHERE t.cost > avg_table.avg_cost
ORDER BY p.patient_id;


-- (47) Find names of doctors who have not had any appointments in the last 6 months.
SELECT d.doctor_id, d.name
FROM doctors d
LEFT JOIN appointments a
    ON d.doctor_id = a.doctor_id
    AND a.appointment_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
WHERE a.appointment_id IS NULL;


-- (48) Find the top 3 most common diagnoses.
SELECT diagnosis, COUNT(diagnosis) AS diagnosis_count
FROM admissions
GROUP BY diagnosis
ORDER BY diagnosis_count DESC
LIMIT 3;


-- (49) Show total treatment cost per doctor and grand total.
SELECT d.name AS doctor_name,SUM(t.cost) AS total_treatment_cost
FROM doctors d
inner JOIN admissions a 
    ON d.doctor_id = a.doctor_id
inner JOIN treatments t 
    ON a.admission_id = t.admission_id
GROUP BY d.name WITH ROLLUP;


-- (50) Show doctor name, specialization, and a remark: 'Busy' if >10 appointments,'Available' if between 5–10, 'Free' if <5.
SELECT d.name AS doctor_name,d.specialization,COUNT(a.admission_id) AS total_appointments,
    CASE WHEN COUNT(a.admission_id) > 10 THEN 'Busy'
         WHEN COUNT(a.admission_id) BETWEEN 5 AND 10 THEN 'Available'
        ELSE 'Free'
	    END AS remark
FROM doctors d
LEFT JOIN admissions a 
    ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name, d.specialization;























































 













































    


