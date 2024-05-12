1.【找出部门最高工资者】
https://leetcode.com/problems/department-highest-salary/

我下面写的不是原答案，为了突出我们要解释的问题。下面是各个部门员工的工资table “Employee”。
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
  
请找出每个部门工资最高的人，得到下面的table。
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+


方法1【 Max() + Group By()】：用Group BY找出每个部门最高工资的值做成一个subquery。然后把subquery和原数据inner join起来。这样就自动筛选出原table中最大的value的行。
Runtime: 574 ms
SELECT  e.*
FROM    Employee e,
        (SELECT DepartmentID,MAX(Salary) AS Salary
        FROM Employee
        GROUP BY DepartmentID) h
WHERE   e.DepartmentID=h.DepartmentID AND
        e.Salary=h.Salary


方法2：【DENSE_RANK()+PARTITION】
和上面同一个问题，方法2是利用Partition对每个部门的DENSE_RANK(),然后Select出Rank为1的。
Runtime: 539 ms
SELECT  ID, Name, Salary, DepartmentID
FROM    (SELECT *, DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS Rank
        FROM    Employee) r
WHERE   Rank=1

/*============================================================================================================*/
2.【选择nth largest item】 
方法1 - 利用Row_Number()
应用：选择Nth largest item
题目：https://leetcode.com/problems/second-highest-salary/

select isnull 
(
    (SELECT Salary 
     FROM   (SELECT Row_Number() over (Order By a.Salary DESC) as rownum,* 
             FROM (SELECT DISTINCT Salary 
                   FROM Employee
                  ) as a
            )as b 
     WHERE  rownum=2)
    ,
    null
) as SecondHighestSalary

方法2：利用where subquery
Select isnull ((select distinct a.salary
from employee a
where 1=(select count(distinct b.salary)
        from employee b
        where b.salary>a.salary)),null)  AS SecondHighestSalary


/*============================================================================================================*/
3.【选出分组的top N items – 利用dense_rank和partition】
（如果有平手的人数会多于3，但是工资是3个不同的数）
https://leetcode.com/problems/department-top-three-salaries/

方法1： 先用dense_rank和partition给每个人按照其所在department进行排序
然后选出各个department的前三名。再把这个前3名table和原始table来个inner join
SELECT	b.Name AS Department,
       a.name AS Employee,
       a.salary AS Salary
FROM   department b
, 
       employee a
INNER JOIN(
       	SELECT DISTINCT salary, departmentid
        	FROM(
            		SELECT  *,DENSE_RANK() OVER (partition BY departmentid ORDER BY salary DESC) AS Rank
            		FROM    employee) cc
        	WHERE Rank<=3) c
ON      a.salary=c.salary AND a.departmentid=c.departmentid
WHERE   a.DepartmentID=b.Id    

方法2： 利用where subquery
SELECT  a.Name AS Department, 
        e1.Name AS 'Employee', 
        e1.Salary
FROM    Employee e1, 
        Department a
WHERE   3 >(SELECT  COUNT (DISTINCT e2.Salary)
            FROM    Employee e2
            WHERE   e2.Salary > e1.Salary AND e2.departmentID=e1.departmentID)
        AND e1.departmentid=a.Id

对一个salary，如果比它大的小于3个，说明它就是top 3

方法3： 定义一个可以找到Nth Highest的函数 – DENSE_RANK()
https://leetcode.com/problems/nth-highest-salary/
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
RETURN 
(
   SELECT ISNULL(
        (SELECT r.Salary
        FROM    (SELECT Salary,DENSE_RANK() OVER (ORDER BY s.SALARY DESC) AS Rank
                FROM    (SELECT DISTINCT SALARY
                        FROM Employee) s ) r
        WHERE   r.Rank=@N),Null)
)
END

方法4： 定义一个可以找到Nth Highest的函数 – ROW_NUMBER()
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
RETURN 
(
    SELECT ISNULL
    (
        (
        SELECT Salary AS getNthHighestSalary
        FROM    (
                SELECT ROW_NUMBER() OVER (ORDER BY a.Salary DESC) as rownum,* 
                FROM    (
                        SELECT DISTINCT Salary 
                        FROM Employee
                        ) a 
                )b
        WHERE rownum=@N
        )
    ,NULL)
)
END

https://leetcode.com/problems/rank-scores/

/*============================================================================================================*/
SELECT scores.score,b.Rank 
FROM Scores
LEFT JOIN (SELECT ROW_NUMBER() OVER(ORDER BY Score DESC) AS Rank,*
          FROM (SELECT DISTINCT score FROM Scores) a) b
ON scores.score=b.score
ORDER BY score DESC

1.1.10	利用DENSE_RANK()
SELECT Score AS score,
       DENSE_RANK() OVER (ORDER BY Score DESC) AS Rank
FROM Scores
