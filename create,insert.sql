
-- creating tables

-- 1. User 
CREATE TABLE User_ (
User_ID INT PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(50),
Phone_Number VARCHAR(20)
);

-- 2. Patient (inherits User)
CREATE TABLE Patient (
Patient_ID INT PRIMARY KEY,
User_ID INT UNIQUE,
Medical_history TEXT,
Insurance_details TEXT,
FOREIGN KEY (User_ID) REFERENCES User_(User_ID)
);

-- 3. Doctor (inherits User)
CREATE TABLE Doctor (
Doctor_ID INT PRIMARY KEY,
User_ID INT UNIQUE,
Department VARCHAR(100),
Specialization VARCHAR(100),
FOREIGN KEY (User_ID) REFERENCES User_(User_ID)
);

-- 4. Nurse (inherits User)
CREATE TABLE Nurse (
Nurse_ID INT PRIMARY KEY,
User_ID INT UNIQUE,
Skills TEXT,
Shifts TEXT,
FOREIGN KEY (User_ID) REFERENCES User_(User_ID)
);

-- 5. Admin_staff (inherits User)
CREATE TABLE Admin_staff (
Staff_ID INT PRIMARY KEY,
User_ID INT UNIQUE,
Roles VARCHAR(100),
Office VARCHAR(100),
FOREIGN KEY (User_ID) REFERENCES User_(User_ID)
);

-- 6. Visit
CREATE TABLE Visit (
Visit_ID INT PRIMARY KEY,
Visit_date DATE,
Patient_ID INT,
Doctor_ID INT,
Department VARCHAR(100),
FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

-- 7. Admission
CREATE TABLE Admission (
Admission_ID INT PRIMARY KEY,
Admission_date DATE,
Ward VARCHAR(50),
Discharge_date DATE,
Bed_number VARCHAR(10),
Visit_ID INT UNIQUE,
FOREIGN KEY (Visit_ID) REFERENCES Visit(Visit_ID)
);

-- 8. Appointment
CREATE TABLE Appointment (
Appointment_ID INT PRIMARY KEY,
Date_and_time DATETIME,
Reason TEXT,
Patient_ID INT,
Doctor_ID INT,
Staff_ID INT,
FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
FOREIGN KEY (Staff_ID) REFERENCES Admin_staff(Staff_ID)
);

-- 9. Appointment_Nurse (Assists relationship)
CREATE TABLE Appointment_Nurse (
Nurse_ID INT,
Appointment_ID INT,
PRIMARY KEY (Nurse_ID, Appointment_ID),
FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID),
FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID)
);

-- 10. Bill
CREATE TABLE Bill (
Bill_ID INT PRIMARY KEY,
Amount DECIMAL(10,2),
Service_date DATE,
Service_type VARCHAR(100),
Patient_ID INT,
FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

-- 11. Payment
CREATE TABLE Payment (
Payment_ID INT PRIMARY KEY,
Payment_Date DATE,
Amount_paid DECIMAL(10,2),
Payment_method VARCHAR(50),
Bill_ID INT,
FOREIGN KEY (Bill_ID) REFERENCES Bill(Bill_ID)
);

-- 12. Surgery
CREATE TABLE Surgery (
Surgery_ID INT PRIMARY KEY,
Type VARCHAR(100),
Date DATE,
Doctor_ID INT,
Visit_ID INT,
FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
FOREIGN KEY (Visit_ID) REFERENCES Visit(Visit_ID)
);

-- 13. Diagnostics
CREATE TABLE Diagnostics (
Test_ID INT PRIMARY KEY,
Test_result TEXT,
Test_date DATE,
Test_type VARCHAR(100),
Visit_ID INT,
FOREIGN KEY (Visit_ID) REFERENCES Visit(Visit_ID)
);



--- Insert data

--1.User
INSERT INTO User_(User_ID, Name, Email, Phone_Number) VALUES(1,'Jane Smith','jane123@gmail.com','0771289345');
INSERT INTO User_ VALUES(2,'Dr Kamal Perera','kamalperera@gmail.com','0773669258');
INSERT INTO User_ VALUES(3,'Amelia fernando','amelia001@gmail.com','0778657413');
INSERT INTO User_ VALUES(4,'Jane Clark','jane456@gmail.com','0741289654');

--2.Patient 
INSERT INTO Patient VALUES(101, 1, 'Diabetes, Hypertension', 'XYZ Insurance - 123456');
INSERT INTO Patient VALUES(102, 3, 'Hypertension', 'MediCare - A12345');

--3.Doctor 
INSERT INTO Doctor VALUES(201, 2, 'Cardiology', 'Cardiologist');

--4.Nurse 
INSERT INTO Nurse VALUES(301, 3, 'IV, CPR, ECG', 'Day');
INSERT INTO Nurse VALUES(302, 3, 'IV, CPR, Wound care', 'Night');

--5.Admin_staff 
INSERT INTO Admin_staff VALUES(401, 4, 'Front Desk, Appointment Scheduling', 'Office A01');

--6.Visit
INSERT INTO Visit VALUES(501, '2025-04-20', 101, 201, 'Cardiology');

--7.Admission
INSERT INTO Admission VALUES(601, '2025-04-20', 'Ward 3B', '2025-04-25', 'B12', 501);

--8.Appointment
INSERT INTO Appointment VALUES(701, '2025-04-19 10:30:00', 'Routine Checkup', 101, 201, 401);

--9.Appointment_Nurse 
INSERT INTO Appointment_Nurse VALUES(301, 701);

--10.Bill
INSERT INTO Bill VALUES(801, 250.00, '2025-04-20', 'Consultation', 101);

--11.Payment
INSERT INTO Payment VALUES(901, '2025-04-20', 250.00, 'Credit Card', 801);


--12.Surgery
INSERT INTO Surgery VALUES(1001, 'Angioplasty', '2025-04-21', 201, 501);

--13.Diagnostics
INSERT INTO Diagnostics VALUES(1101, 'Normal ECG', '2025-04-20', 'ECG', 501);


select * from User_
select * from Patient
select * from Doctor
select * from Nurse
select * from Admin_staff
select * from Visit
select * from Admission
select * from Appointment
select * from Appointment_Nurse
select * from Bill
select * from Payment
select * from Surgery
select * from Diagnostics


