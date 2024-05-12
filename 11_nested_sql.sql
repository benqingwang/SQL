利用(Select….) a 作为data source: 

SELECT a.employee_id
  
FROM (
  SELECT employee_id 
  FROM Employees 
  UNION 
  SELECT employee_id 
  FROM Salaries) a

WHERE  a.employee_id NOT IN (
  SELECT Employees.employee_id 
  FROM Employees 
  INNER JOIN Salaries ON Employees.employee_id=Salaries.employee_id)	
  
  
