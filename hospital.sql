create database hospital ;

use hospital;

create table  Department
(
depID int primary key,
depName varchar(30)

)engine = innodb;

-- Load external file
load data infile 'H:\\Department.csv'
into table Department
fields terminated by ','
lines terminated by '\n'
(depID, depName);
  
select * from Department;

create table Patient
(
patientID int primary key,
NHI char(7) ,
pFirstName varchar(25),
pLastName varchar(35),
dob date,
gender varchar(10)
)engine = innodb;

-- Load external file
load data infile 'H:\\Patient.csv'
into table Patient
fields terminated by ','
lines terminated by '\n'
(patientID,NHI,pFirstName,pLastName,dob,gender);
  
  select * from Patient;
  
create table  Doctor
(
empID int primary key,
docFirstName varchar(25),
docLastName varchar(35),
depID int,
FOREIGN KEY (depID) REFERENCES Department(depID)
)engine = innodb;

-- Load external file
load data infile 'H:\\Doctor.csv'
into table Doctor
fields terminated by ','
lines terminated by '\n'
(empID, docFirstName,docLastName,depID);
  
  select * from Doctor;
  
 
create table  Referral
(
refID int primary key,
refDate date,
refForm varchar(20),
refFirstName varchar(25),
refLastName varchar(35),
patientID int,
FOREIGN KEY (patientID) REFERENCES Patient(patientID)
)engine = innodb;

-- Load external file
load data infile 'H:\\Refer.csv'
into table Referral
fields terminated by ','
lines terminated by '\n'
(refID,refDate,refForm,refFirstName,refLastName,patientID);
  
  select * from Referral;


create table  Appointment
(
refID int,
patientID int ,
empID int,
addWaitDate date,
fsaDate date,
HTE varchar(3),
primary key (refID,patientID,empID),
FOREIGN KEY (refID) REFERENCES Referral(refID),
FOREIGN KEY (patientID) REFERENCES Patient(patientID),
FOREIGN KEY (empID) REFERENCES Doctor(empID)
)engine = innodb;
-- Load external file

load data infile 'H:\\Appointment.csv'
into table Appointment
fields terminated by ','
lines terminated by '\n'
(refID,patientID,empID,addWaitDate,fsaDate,HTE);
  
  select * from Appointment;

