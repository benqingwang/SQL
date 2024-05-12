/* 最基本语法 */
--【评估顺序】 
* FROM
* WHERE
* GROUP BY
* HAVING
* SELECT
* Order by

--【Select】【Join】【AS使用Alias】【Where】
SELECT a.name AS names
FROM  a  
LEFT JOIN b  ON a.id=b. Id
WHERE b.id IS NULL

【Select Distinct】
SELECT DISTINCT Salary 
FROM Employee

【其他Join】INNER JOIN, FULL OUTER JOIN
  
【Inner Join Without Join 利用等号】
SELECT  * 
FROM   a, b  
WHERE   a.x=b.y

【Union】
SELECT employee_id FROM Employees
UNION
SELECT employee_id FROM Salaries

【用order来排序】 
SELECT Salary  
FROM Employee  
ORDER BY Salary DESC, ID ASC

【Group by & Having】
经常用于寻找某个category的max或者duplicate等：
用Group by，Select后面的column必须是：[a] Group by 的对象，比如下面的Email, or [b] 可以Aggregate的东西
SELECT Email
FROM Person
GROUP BY Email
Having  COUNT(Email)>1

或者 
SELECT a, COUNT(a) AS count_a
FROM table
WHERE …. 
GROUP BY a

【条件	】【CASE…WHEN…WHEN…ELSE…END】
  SELECT 
    CASE  
      WHEN id%2=0 THEN id-1 ELSE id+1 END AS id
  FROM  seat


