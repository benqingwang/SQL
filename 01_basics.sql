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

数学和逻辑	

【IS NULL】WHERE   referee_id IS NULL

【ISNULL( )】类似于IFERROR: 
Select ISNULL(field, 100) 
或者
Select isnull (result of a select, null) 
或者
Select isnull (result of a select, 100)

【COUNT( --- )】语法： Count(column), Count (*)
  
【COUNT (DISTINCT  --- )】
SELECT a, COUNT(DISTINCT b) FROM table GROUP BY a

【SUM】这类的函数里面还可以有运算的，比如
SELECT a, SUM(b-c) 
FROM tbl 
GROUP BY a

【求余数】employee_id % 2 = 1 判断employee_id是奇偶数

【AND/OR】WHERE   area>3 OR population >25

【NOT】【Like】【%】name NOT LIKE 'M%', %可以代表空。	

+----+-----+-----+-----+
| Id | Num | LAG | LEAD|
+----+-----+-----+-----+
| 1  | 10  |NULL | 20  |
| 2  | 20  | 10  | 30  |
| 3  | 30  | 20  | 40  |
| 4  | 40  | 30  | 50  |
| 5  | 50  | 40  |NULL |
+----+-----+-----+-----+
【计算日期：dateadd(day,1,date )】
SELECT dateadd(day,1, date) as new_date, value FROM tbl

【日期期间】
WHERE a.activity_date <='2019-07-27' AND a.activity_date > dateadd(day,-30,'2019-07-27')

【某年DATEPART( )】
where datepart(YYYY, 某time_stamp) = 2020
  
