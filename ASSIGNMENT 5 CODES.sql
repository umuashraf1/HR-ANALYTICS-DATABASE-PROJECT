CREATE TABLE temp_file(
Age   INT ,                      
Attrition   TEXT,                
BusinessTravel text ,           
DailyRate   INT,                 
Department text,               
DistanceFromHome   INT ,         
Education   INT  ,               
EducationField text ,      
EmployeeCount    INT ,           
EmployeeNumber   INT ,           
EnvironmentSatisfaction INT,     
Gender text ,                   
HourlyRate     INT,              
JobInvolvement  INT ,            
JobLevel   INT ,                 
JobRole text ,                 
JobSatisfaction     INT ,       
MaritalStatus text,             
MonthlyIncome   INT ,            
MonthlyRate    INT ,             
NumCompaniesWorked    INT ,      
Over18     TEXT,                 
OverTime   TEXT ,                
PercentSalaryHike  INT ,         
PerformanceRating   INT,         
RelationshipSatisfaction INT,    
StandardHours   INT ,            
StockOptionLevel   INT,          
TotalWorkingYears  INT ,         
TrainingTimesLastYear INT ,      
WorkLifeBalance    INT,          
YearsAtCompany     INT,          
YearsInCurrentRole  INT ,        
YearsSinceLastPromotion  INT,    
YearsWithCurrManager   INT      
);

--to create categorical tables
INSERT INTO department(department)
SELECT DISTINCT department FROM temp_file

INSERT INTO jobrole(job_role)
SELECT DISTINCT job_role FROM temp_file

INSERT INTO gender(gender)
SELECT DISTINCT gender FROM temp_file;

INSERT INTO maritalstatus(marital_status)
SELECT DISTINCT maritalstatus FROM temp_file;

INSERT INTO businesstravel(business_travel)
SELECT DISTINCT businesstravel FROM temp_file;

INSERT INTO educationfield(education_field)
SELECT DISTINCT educationfield FROM temp_file;


-- create employeees table
CREATE TABLE employees(
age ,                      
attrition,                
businesstravel_id integar references businesstravel(id),           
dailyrate  ,                 
department_Id integar references department(id),               ,               
distancefromhome   ,         
education   ,               
educationfield_id integar references educationfield(id) ,      
employeecount  ,           
employeenumber ,           
environmentsatisfaction,     
gender_id,                   
hourlyrate ,              
jobinvolvement,            
joblevel ,                 
jobrole_id integar references jobroles(id),                 
jobsatisfaction ,       
maritalstatus_id integar references maritalstatus(id),             
monthlyincome  ,            
monthlyrate ,             
numcompaniesworked,      
over18 ,                 
overtime,                
percentsalaryhike,         
performancerating ,         
relationshipsatisfaction,    
standardhours ,            
stockoptionlevel ,          
totalworkingyears ,         
trainingtimeslastyear ,      
worklifebalance  ,          
yearsatcompany   ,          
yearsincurrentrole ,        
yearssincelastpromotion,    
yearswithcurrmanager
)

INSERT INTO employees(
age ,                      
attrition,                
businesstravel_id ,           
dailyrate  ,                 
department_Id,               
distancefromhome   ,         
education   ,               
educationfield_id ,      
employeecount  ,           
employeenumber ,           
environmentsatisfaction,     
gender_id,                   
hourlyrate ,              
jobinvolvement,            
joblevel ,                 
jobrole_id ,                 
jobsatisfaction ,       
maritalstatus_id,             
monthlyincome  ,            
monthlyrate ,             
numcompaniesworked,      
over18 ,                 
overtime,                
percentsalaryhike,         
performancerating ,         
relationshipsatisfaction,    
standardhours ,            
stockoptionlevel ,          
totalworkingyears ,         
trainingtimeslastyear ,      
worklifebalance  ,          
yearsatcompany   ,          
yearsincurrentrole ,        
yearssincelastpromotion,    
yearswithcurrmanager
)
SELECT
t.age ,                      
t.attrition,                
b.id ,           
t.dailyrate  ,                 
d.Id,               
t.distancefromhome   ,         
t.education   ,               
e.id ,      
t.employeecount  ,           
t.employeenumber ,           
t.environmentsatisfaction,     
g.id,                   
t.hourlyrate ,              
t.jobinvolvement,            
t.joblevel ,                 
j.id ,                 
t.jobsatisfaction ,       
m.id,             
t.monthlyincome  ,            
t.monthlyrate ,             
t.numcompaniesworked,      
t.over18 ,                 
t.overtime,                
t.percentsalaryhike,         
t.performancerating ,         
t.relationshipsatisfaction,    
t.standardhours ,            
t.stockoptionlevel ,          
t.totalworkingyears ,         
t.trainingtimeslastyear ,      
t.worklifebalance  ,          
t.yearsatcompany   ,          
t.yearsincurrentrole ,        
t.yearssincelastpromotion,    
t.yearswithcurrmanager

FROM temp_file t
JOIN businesstravel b ON t.businesstravel = b.business_travel
JOIN department d ON t.department = d.department
JOIN educationfield e ON t.educationfield = e.education_field
JOIN gender g ON t.gender = g.gender
JOIN jobroles j ON t.jobrole = j.job_roles
JOIN maritalstatus m ON t.maritalstatus = m.marital_status

select * from employees

-- Data Transformation Requirements:Create an enriched view showing:Employee Name 
--(if available)Age, Job Role, Monthly Income, Years at CompanyWhether they left (Attrition = 
--Yes/No)Add calculated fields:Income per Year at Company = MonthlyIncome * 12 / 
--YearsAtCompany (Handle division by 0)

CREATE VIEW  employee_view AS
SELECT
j.id,
e.age,
j.job_roles,
e.monthlyincome,
e.yearsatcompany,
e.attrition,
CASE WHEN
e.yearsatcompany= 0 then null
ELSE ROUND(e.monthlyincome * 12/ e.yearsatcompany,2)
END AS incomeperyearatcompany
FROM employees e
JOIN jobroles j ON e.jobrole_id = j.id


--Reporting & Queries (Deliverables):SQL queries to answer:Total number of employees who left, grouped by Department.
SELECT d.department, COUNT (*) as employeeswholeft
FROM employees e
JOIN department d
ON e.department_id = d.id
where attrition = 'Yes'
GROUP BY d.department,e.attrition
ORDER BY employeeswholeft DESC

--Average monthly income by Job Role.
SELECT job_roles,ROUND(AVG(monthlyincome),2) AS avgmonthlyincome
FROM employees e
JOIN jobroles j
ON e.jobrole_id = j.id
GROUP BY job_roles

--Percentage of employees who left grouped by Age range buckets (e.g., <30, 30-40, >40).
SELECT 
CASE WHEN age <30 THEN '<30'
WHEN age between 30 and 40 THEN '30-40'
ELSE '>40'
END AS age_bracket,
COUNT(*) FILTER(
WHERE attrition ='Yes') * 100.0 / COUNT(*) AS percentageofemployeewholeft
FROM employees
GROUP BY age_bracket
ORDER BY age_bracket


--Number of employees with OverTime = 'Yes' who also have JobSatisfaction < 3
SELECT COUNT(*) AS total_employee
FROM employees
WHERE overtime = 'Yes' and jobsatisfaction < 3


