HR Analytics Database Project
📌 Project Overview
This project involves creating a PostgreSQL database for HR analytics using employee attrition data. The workflow includes data ingestion, schema design, cleaning, transformation, and analytical reporting.

🛠 Tasks
1️⃣ Data Ingestion & Storage
Ingest the employee dataset into PostgreSQL

Design a normalized database schema

Create reference tables for categorical columns: JobRole, Department, EducationField etc

Establish proper foreign key relationships


2️⃣ Data Cleaning
Handle missing/inconsistent data

Standardize categorical variables: Consistent capitalization, normalized naming (e.g., 'Sales Executive' → 'sales_executive')

Ensure data type consistency

Validate domain values


3️⃣ Data Transformation : Create an enriched employee view with: Employee identification (name/ID),

Employment details (Job Role, Department),Demographic info (Age), Compensation (Monthly Income), Tenure (Years at Company),

Attrition status-Yes/No (Add calculated fields:Income per Year at Company = MonthlyIncome * 12 / 
YearsAtCompany (Handle division by 0)


4️⃣ Reporting & Queries (Deliverables)

Key Analytical Queries:

SQL queries to answer:Total number of employees who left, grouped by Department.

Average monthly income by Job Role.

Percentage of employees who left grouped by Age range buckets (e.g., <30, 30-40, >40).

Number of employees with OverTime = 'Yes' who also have JobSatisfaction < 3.













