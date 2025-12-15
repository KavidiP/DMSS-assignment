# 🏥 Health Clinic Management System

## 📋 Project Overview
A comprehensive database system designed for managing healthcare clinic operations, including patient management, appointments, admissions, billing, and medical procedures. Developed as part of the **IE2042 Database Management Systems for Security** course at SLIIT.

## 🎯 Features
- **User Management**: Hierarchical user system (Patients, Doctors, Nurses, Admin Staff)
- **Appointment Scheduling**: With conflict prevention triggers
- **Patient Visits & Admissions**: Track outpatient and inpatient care
- **Medical Procedures**: Surgery and diagnostic test tracking
- **Billing & Payments**: Complete financial management
- **Security Analysis**: Database vulnerability assessment and mitigation strategies

## 🗄️ Database Design
- **ERD**: Complete entity-relationship diagram
- **Normalization**: 3NF compliant design
- **Tables**: 13 normalized tables with proper relationships
- **Inheritance**: User superclass with subclass entities

## ⚙️ Technical Implementation
### Database Objects Created:
1. **Tables**: User, Patient, Doctor, Nurse, Admin_staff, Visit, Admission, Appointment, Bill, Payment, Surgery, Diagnostics
2. **Triggers**: 
   - `before_insert_appointment_check_doctor` - Prevents double-booking
   - `after_patient_delete` - Cascading delete for data integrity
3. **Views**:
   - `Doctors_View` - Complete doctor dashboard
   - `Admin_Staff_View` - Administrative overview
4. **Indexes**: Optimized for common queries
5. **Stored Procedures**: Parameterized queries for business logic

## 🔒 Security Analysis
Detailed examination of database vulnerabilities:
- **Database Misconfiguration** risks and mitigation
- **Insecure Data Storage** prevention strategies
- **Access Control** best practices
- **Encryption** recommendations

## 👥 Team Members
| Name | Student ID | Role |
|------|------------|------|
| ATHAWUDA A.M.M.G.K.P. | IT23714120 | Database Design & Implementation |
| JAYAWEERA D. H. J. P. D. S | IT23714120 | SQL Development & Testing |
| SENANAYAKE S.M.V.K. | IT23628472 | Documentation & Security Analysis |
| GANGANATH A.N | IT23627482 | ERD Design & Normalization |

## 🛠️ Technologies Used
- **Database**: Microsoft SQL Server / MySQL compatible
- **Design Tools**: Lucidchart/Draw.io for ERD
- **Documentation**: Microsoft Word, Markdown

## 🚀 How to Use
1. Clone the repository
2. Execute `database/schema.sql` to create tables
3. Run `database/data_insert.sql` for sample data
4. Implement triggers, views, and procedures as needed

## 📚 Course Information
- **Course**: IE2042 Database Management Systems for Security
- **Program**: B.Sc. (Hons) in Information Technology - Cyber Security
- **Institution**: Sri Lanka Institute of Information Technology (SLIIT)
- **Semester**: Year 2

## 📄 License
Academic Project - For educational purposes only
