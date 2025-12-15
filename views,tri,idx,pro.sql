---view 1 - Doctors view 

CREATE VIEW Doctors_View AS
SELECT 
 d.Doctor_ID,
 u_doc.Name AS Doctor_Name,
 a.Appointment_ID,
 a.Date_and_time AS Appointment_DateTime,
 a.Reason AS Appointment_Reason,
 p.Patient_ID,
 u_pat.Name AS Patient_Name,
 v.Visit_ID,
 v.Visit_date,
 s.Surgery_ID,
 s.Type AS Surgery_Type,
 s.Date AS Surgery_Date,
 diag.Test_ID,
 diag.Test_type,
 diag.Test_date,
 diag.Test_result
 FROM Doctor d
 JOIN User_ u_doc ON d.User_ID = u_doc.User_ID
 JOIN Appointment a ON d.Doctor_ID = a.Doctor_ID
 JOIN Patient p ON a.Patient_ID = p.Patient_ID
 JOIN User_ u_pat ON p.User_ID = u_pat.User_ID
 LEFT JOIN Visit v ON v.Doctor_ID = d.Doctor_ID AND v.Patient_ID = 
p.Patient_ID
 LEFT JOIN Surgery s ON s.Doctor_ID = d.Doctor_ID AND s.Visit_ID = 
v.Visit_ID
 LEFT JOIN Diagnostics diag ON diag.Visit_ID = v.Visit_ID;

 select * from Doctor
 select * from Doctors_View

 --View 2 – Admin Staff View

 CREATE VIEW Admin_Staff_View AS
 SELECT 
a.Appointment_ID,
 a.Date_and_time,
 a.Reason,
 u_doc.Name AS Doctor_Name,
 u_pat.Name AS Patient_Name,
 ad.Admission_ID,
 ad.Admission_date,
 ad.Ward,
 ad.Discharge_date,
 ad.Bed_number
 FROM Appointment a
 JOIN Patient p ON a.Patient_ID = p.Patient_ID
 JOIN User_ u_pat ON p.User_ID = u_pat.User_ID
 JOIN Doctor d ON a.Doctor_ID = d.Doctor_ID
 JOIN User_ u_doc ON d.User_ID = u_doc.User_ID
 LEFT JOIN Visit v ON a.Patient_ID = v.Patient_ID AND a.Doctor_ID = 
v.Doctor_ID
 LEFT JOIN Admission ad ON ad.Visit_ID = v.Visit_ID;

 
 select * from Admin_staff
 select * from Admin_Staff_View


 --Indexes 
--Query 1: Appointments for a Given Patient in a Time Period

CREATE INDEX idx_patient_date ON Appointment(Patient_ID, 
Date_and_time);

--check
--all appointments for Patient 101 between March-May

SELECT * 
FROM Appointment
WHERE Patient_ID = '101' AND Date_and_time BETWEEN '2025-03-01' AND '2025-05-01';


--Query 2: Retrieve the billing details for a given patient. 

CREATE INDEX idx_patient_bill ON Bill(Patient_ID);

--check
--Show all bills for Patient 101

SELECT *
FROM Bill
WHERE patient_ID='101';



--Procedure 1: Appointments for a Given Patient in a Period

CREATE PROCEDURE GetAppointmentsByPatient
 @Patient_ID INT,
 @Start_Date DATETIME,
 @End_Date DATETIME
AS
BEGIN
 SELECT 
  a.Appointment_ID,
  a.Date_and_time,
  a.Reason,
  u.Name AS Patient_Name
 FROM Appointment a
 JOIN Patient p ON a.Patient_ID = p.Patient_ID
 JOIN User_ u ON p.User_ID = u.User_ID
 WHERE a.Patient_ID = @Patient_ID
 AND a.Date_and_time BETWEEN @Start_Date AND @End_Date;
END;

exec GetAppointmentsByPatient @Patient_ID=101,@Start_Date='2025-03-01',@End_Date='2025-05-01'


--Procedure 2: GetVisitsByDoctor

CREATE PROCEDURE GetVisitsByDoctor
 @Doctor_ID INT
 AS
 BEGIN
 SELECT 
v.Visit_ID,
 v.Visit_date,
 v.Department,
 u.Name AS Patient_Name
 FROM Visit v
 JOIN Patient p ON v.Patient_ID = p.Patient_ID
 JOIN User_ u ON p.User_ID = u.User_ID
 WHERE v.Doctor_ID = @Doctor_ID;
 END;

EXEC GetVisitsByDoctor @Doctor_ID = 201;

--Trigger 1

CREATE TRIGGER before_insert_appointment_check_doctor
ON Appointment
 INSTEAD OF INSERT
 AS
 BEGIN
 IF EXISTS (
 SELECT 1
 FROM Appointment A
 JOIN inserted I ON A.Doctor_ID = I.Doctor_ID AND 
 A.Date_and_time = I.Date_and_time
 )
 BEGIN
 RAISERROR ('Doctor is already booked at this time.', 16, 1);
 ROLLBACK TRANSACTION;
 RETURN;
 END
 -- If no conflict, proceed to insert
 INSERT INTO Appointment (Appointment_ID, Date_and_time, Reason, 
Patient_ID, Doctor_ID, Staff_ID)
 SELECT Appointment_ID, Date_and_time, Reason, Patient_ID, 
Doctor_ID, Staff_ID
 FROM inserted;
 END;

INSERT INTO Appointment (Appointment_ID, Date_and_time, Reason, Patient_ID, Doctor_ID, Staff_ID) 
VALUES (1, '2025-05-06 10:00:00', 'Routine Checkup', 101, 201, 401);


INSERT INTO Appointment (Appointment_ID, Date_and_time, Reason, Patient_ID, Doctor_ID, Staff_ID) 
VALUES (2, '2025-05-06 10:00:00', 'Follow-up', 102, 201, 402);


--AFTER DELETE Trigger

CREATE TRIGGER after_patient_delete
ON Patient
AFTER DELETE
AS
BEGIN
 DELETE FROM Appointment
 WHERE Patient_ID IN (SELECT Patient_ID FROM DELETED);
 
 DELETE FROM Visit
 WHERE Patient_ID IN (SELECT Patient_ID FROM DELETED);
 END;
