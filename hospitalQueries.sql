-- age
use  hospital;
select *,(year(now())-year(dob)) as 'age'
from patient;

-- dayswait 
select  patient.patientID,pFirstName,pLastName,gender,refDate,addWaitDate,datediff(Appointment.addWaitDate,Referral.refDate) 'DaysWait'
from (Appointment inner join referral on
Appointment.refID=Referral.refID) inner join patient on appointment.patientID =patient.patientID;

-- Q1
SELECT count(patientID) as 'Total referred'
FROM Patient;

-- Q2
select  depName,avg(datediff(fsaDate,refDate))as 'avg time by department'
FROM ((Appointment INNER JOIN Referral ON Appointment.refID=Referral.refID) INNER JOIN Doctor ON Appointment.empID=Doctor.empID) INNER JOIN Department ON Doctor.depID=Department.depID
group by depName;

-- Q3
select  appointment.patientID,pFirstName,pLastName,gender,HTE,datediff(fsaDate,refDate) as 'days wait',docFirstName,docLastName
FROM ((Appointment INNER JOIN patient ON Appointment.patientID=patient.patientID) INNER JOIN Doctor ON Appointment.empID=Doctor.empID) INNER JOIN Referral ON appointment.refID=Referral.refID
order by doctor.empID;

-- Q4
select  depName,appointment.patientID,pFirstName,pLastName,gender,(year(now())-year(dob)) as 'age',HTE
FROM ((Appointment INNER JOIN patient ON Appointment.patientID=patient.patientID) INNER JOIN Doctor ON Appointment.empID=Doctor.empID) INNER JOIN Department ON Doctor.depID=Department.depID
where (year(now())-year(dob))< 18 and depName like 'Pae%';


-- Q5
select  depName,count(datediff(fsaDate,refDate)<80) as 'number of whitin 80 day',count(datediff(fsaDate,refDate)<80)/(select count(datediff(fsaDate,refDate)<80) from Appointment INNER JOIN Referral ON Appointment.refID=Referral.refID) *100 as 'Percentage to total'
FROM ((Appointment INNER JOIN Referral ON Appointment.refID=Referral.refID) INNER JOIN Doctor ON Appointment.empID=Doctor.empID) INNER JOIN Department ON Doctor.depID=Department.depID
group by depName
