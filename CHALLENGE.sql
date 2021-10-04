--SUBJECT(SubjCode, Description) PRIMARY KEY SubjCode
--TEACHER(StaffID, Surname, GivenName) PRIMARY KEY StaffID
--STUDENT(StudentID, Surname, GivenName, Gender) PRIMARY KEY StudentID
--SubjectOffering(Year, Semester, Fee, SubjCode, StaffID) COMPOSITE KEY(Year, Semester, Subjcode, StaffID)
--Enrolment(DateEnrolled, Grade, Studentid, Subjcode, Year, Semester) COMPOSITE KEY (Studentid,Subjcode,Year,Semester)

DROP TABLE IF EXISTS [Subject]
CREATE TABLE [Subject]
(
    SubjectCode NVARCHAR(100) PRIMARY KEY,
    Description NVARCHAR(500)
)
DROP TABLE IF EXISTS Student
CREATE TABLE Student
(
    StudentID NVARCHAR(10) PRIMARY KEY,
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(1) CHECK (GENDER IN('M','F','I',NULL))
)
DROP TABLE IF EXISTS Teacher
CREATE TABLE Teacher
(
    StaffID INT PRIMARY KEY,
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL
)
DROP TABLE IF EXISTS SubjOffering
CREATE TABLE SubjOffering
(
    SubjCode NVARCHAR(100),
    Year INT CHECK (LEN(Year) =4),
    Semester INT CHECK(Semester IN(1,2)),
    Fee MONEY NOT NULL CHECK(Fee > 0),
    StaffID INT
        CONSTRAINT CK_SubjOffering_ PRIMARY KEY(Year, Semester, Subjcode, StaffID)
        CONSTRAINT FK_StaffID_ FOREIGN KEY(StaffID) REFERENCES Teacher(StaffID)
)
DROP TABLE IF EXISTS Enrollment
CREATE TABLE Enrollment
(
    StudentID NVARCHAR(10),
    SubjCode NVARCHAR(100),
    Year INT CHECK (Len(Year) = 4),
    Semester INT Check(Semester IN(1,2)),
    GRADE NVARCHAR(2) CHECK(GRADE IN('N','P','C','D','HD',NULL)) DEFAULT NULL,
    DateEnrolled DATE,
    CONSTRAINT CK_Enrollment_ PRIMARY KEY (StudentID,Subjcode,Year,Semester,StaffID),
    CONSTRAINT FK_StudentID_ FOREIGN KEY(StudentID) REFERENCES Student(StudentID),
    CONSTRAINT FK_SubjOffering_ FOREIGN KEY(SubjCode,Year, Semester) REFERENCES SubjOffering(SubjCode,Year,Semester)
)
INSERT INTO STUDENT
VALUES(
        s12233445, Morrison, Scott, M
)
INSERT INTO STUDENT
VALUES(

        s23344556, Gillard, Julia, F

)
INSERT INTO STUDENT
VALUES(

        s34455667, Whitlam, Gough, M

)
INSERT INTO Teacher
VALUES(
        98776655, Starr, Ringo
)
INSERT INTO Teacher
VALUES(
        87665544, Lennon, John
)
INSERT INTO Teacher
VALUES(76554433, McCartney, Paul)

INSERT INTO [Subject]
VALUES(
        ICTWEB425, 'Apply SQL to extract & manipulate data'
)
INSERT INTO [Subject]
VALUES(

        ICTDBS403, 'Create Basic Databases'

)
INSERT INTO [Subject]
VALUES(

        ICTDBS502, 'Design a Database'

)
INSERT INTO SubjOffering VALUES(
ICTWEB425,2020,1,200,98776655
)
INSERT INTO SubjOffering VALUES(

ICTWEB425,2021,1,225,98776655

)
INSERT INTO SubjOffering VALUES(

ICTDBS403,2021,1,200,87665544
)
INSERT INTO SubjOffering VALUES(
ICTDBS403,2021,2,200,76554433
)
INSERT INTO SubjOffering VALUES(
ICTDBS502,2020,2,225,87665544
)

INSERT INTO Enrollment
VALUES
    (s12233445, ICTWEB425, 2020, 1, D, 25/02/2020)
INSERT INTO Enrollment
VALUES( s23344556, ICTWEB425, 2020, 1, P, 15/02/2020)
INSERT INTO Enrollment
VALUES( s12233445, ICTWEB425, 2021, 1, C, 30/01/2020)
INSERT INTO Enrollment
VALUES(s23344556, ICTWEB425, 2021, 1, HD, 26/02/2020
)
INSERT INTO Enrollment
VALUES(
        s34455667, ICTWEB425, 2020, 1, P, 28/01/2020
)
INSERT INTO Enrollment
VALUES(
        s12233445, ICTDBS403, 2021, 1, C, 8/02/2020
)
INSERT INTO Enrollment
VALUES(
        s23344556, ICTDBS403, 2021, 1, '', 28/02/2021
)
INSERT INTO Enrollment
VALUES(
        s34455667, ICTDBS403, 2021, 2, '', 3/03/2021
)
INSERT INTO Enrollment
VALUES(
        s23344556, ICTDBS502, 2020, 2, P, 1/07/2020
)
INSERT INTO Enrollment
VALUES(
        s34455667, ICTDBS502, 2020, 2, N, 13/07/2020
)

SELECT Student.GivenName, Student.Surname, Enrollment.SubjCode, Enrollment.Fee, Teacher.GivenName, Teacher.Surname
FROM(Student INNER JOIN (Enrollment INNER JOIN(SubjectOffering INNER JOIN Teacher ON SubjectOffering.StaffID = Teacher.StaffID) ON Enrollment.SubjCode = SubjectOffering.SubjCode) ON Student.StudentID = Enrollment.StudentID) 

SELECT Year, Semester
FROM Enrollment
GROUP BY Year 

