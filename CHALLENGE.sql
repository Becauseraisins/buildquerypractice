--SUBJECT(SubjCode, Description) PRIMARY KEY SubjCode
--TEACHER(StaffID, Surname, GivenName) PRIMARY KEY StaffID
--STUDENT(StudentID, Surname, GivenName, Gender) PRIMARY KEY StudentID
--SubjOffering(Year, Semester, Fee, SubjCode, StaffID) COMPOSITE KEY(Year, Semester, Subjcode, StaffID)
--Enrolment(DateEnrolled, Grade, Studentid, Subjcode, Year, Semester) COMPOSITE KEY (Studentid,Subjcode,Year,Semester)
--CREATE DATABASE  CHALLENGE
--USE CHALLENGE
DROP TABLE IF EXISTS Enrollment
DROP TABLE IF EXISTS SubjOffering
DROP TABLE IF EXISTS Teacher
DROP TABLE IF EXISTS Student
DROP TABLE IF EXISTS [Subject]
DROP VIEW IF EXISTS [Query 1]

CREATE TABLE [Subject]
(
    SubjCode NVARCHAR(100) PRIMARY KEY,
    Description NVARCHAR(500)
)

CREATE TABLE Student
(
    StudentID NVARCHAR(10) PRIMARY KEY,
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(1) CHECK (GENDER IN('M','F','I',NULL))
)

CREATE TABLE Teacher
(
    StaffID INT PRIMARY KEY,
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL
)

CREATE TABLE SubjOffering
(
    SubjCode NVARCHAR(100),
    Year INT CHECK (LEN(Year) =4),
    Semester INT CHECK(Semester IN(1,2)),
    Fee MONEY NOT NULL CHECK(Fee > 0),
    StaffID INT NOT NULL,
    CONSTRAINT CK_SubjOffering_ PRIMARY KEY(SubjCode, Year, Semester),
    CONSTRAINT FK_StaffID_ FOREIGN KEY(StaffID) REFERENCES Teacher(StaffID),
    CONSTRAINT FK_SubjCode_ FOREIGN KEY(SubjCode) REFERENCES [Subject](SubjCode)
)

CREATE TABLE Enrollment
(
    StudentID NVARCHAR(10),
    SubjCode NVARCHAR(100),
    Year INT CHECK (LEN(Year) =4),
    Semester INT CHECK(Semester IN(1,2)),
    GRADE NVARCHAR(2) CHECK(GRADE IN('N','P','C','D','HD',NULL)) DEFAULT NULL,
    DateEnrolled DATETIME,
    CONSTRAINT CK_Enrollment_ PRIMARY KEY (StudentID,Subjcode,Year,Semester),
    CONSTRAINT FK_StudentID_ FOREIGN KEY(StudentID) REFERENCES Student(StudentID),
    CONSTRAINT FK_SubjOffering_ FOREIGN KEY(SubjCode,Year, Semester) REFERENCES SubjOffering(SubjCode,Year,Semester)
)
insert into Student values ('s12233445','Morrison','Scott','M')
insert into Student values ('s23344556','Gillard','Julia','F')
insert into Student values ('s34455667','Whitlam','Gough','M')

insert into [Subject] values ('ICTWEB425','Apply SQL to extract & manipulate data')
insert into [Subject] values ('ICTDBS403','Create Basic Databases')
insert into [Subject] values ('ICTDBS502','Design a Database')

insert into Teacher values (98776655,'Starr','Ringo')
insert into Teacher values (87665544,'Lennon','John')
insert into Teacher values (76554433,'McCartney','Paul')

insert into SubjOffering values ( 'ICTWEB425',2020,1,200,98776655)
insert into SubjOffering values ( 'ICTWEB425',2021,1,225,98776655)
insert into SubjOffering values ( 'ICTDBS403',2021,1,200,87665544)
insert into SubjOffering values ( 'ICTDBS403',2021,2,200,76554433)
insert into SubjOffering values ( 'ICTDBS502',2020,2,225,87665544)

insert into Enrollment values ('s12233445', 'ICTWEB425',2020,1,'D',43886)
insert into Enrollment values ('s23344556', 'ICTWEB425',2020,1,'P',43876)
insert into Enrollment values ('s12233445', 'ICTWEB425',2021,1,'C',43860)
insert into Enrollment values ('s23344556', 'ICTWEB425',2021,1,'HD',43887)
insert into Enrollment values ('s34455667', 'ICTWEB425',2020,1,'P',43858)
insert into Enrollment values ('s12233445', 'ICTDBS403',2021,1,'C',43869)
insert into Enrollment values ('s23344556', 'ICTDBS403',2021,1,'',44255)
insert into Enrollment values ('s34455667', 'ICTDBS403',2021,2,'',44258)
insert into Enrollment values ('s23344556', 'ICTDBS502',2020,2,'P',44013)
insert into Enrollment values ('s34455667', 'ICTDBS502',2020,2,'N',44025)





SELECT Student.GivenName, Student.Surname, SubjOffering.SubjCode, SubjOffering.Fee, Teacher.GivenName, Teacher.Surname
FROM(Student INNER JOIN (Enrollment INNER JOIN(SubjOffering INNER JOIN Teacher ON SubjOffering.StaffID = Teacher.StaffID) ON Enrollment.SubjCode = SubjOffering.SubjCode) ON Student.StudentID = Enrollment.StudentID) 

SELECT Year, Semester, Count(year+semester) as Count
FROM Enrollment
GROUP BY Year,Semester

Select * 
FROM Enrollment
INNER JOIN SubjOffering
ON (Enrollment.SubjCode = SubjOffering.SubjCode)
WHERE SubjOffering.Fee = ( Select Max(fee) from SubjOffering)

GO
CREATE VIEW [Query 1] AS 
SELECT Student.GivenName, Student.Surname, Enrollment.SubjCode, SubjOffering.Fee, Teacher.GivenName as [TeacherName], Teacher.Surname as [Teacher Surname]
FROM(Student INNER JOIN (Enrollment INNER JOIN(SubjOffering INNER JOIN Teacher ON SubjOffering.StaffID = Teacher.StaffID) ON Enrollment.SubjCode = SubjOffering.SubjCode) ON Student.StudentID = Enrollment.StudentID) 
 
GO
SELECT Count(*) FROM [Query 1]
