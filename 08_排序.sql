1.【DENSE RANK() vs Rank()】

Dense Rank：的特点是排序中间没有hole，比如你看下面的结果，尽管Jim和Max2个并列第一，Henry的排序是2而不是3。
SELECT *, DENSE_RANK() OVER (ORDER BY Salary DESC) AS Rank 
FROM  Employee
+----+-------+--------+---------+
| Id | Name  | Salary | Dense   |
+----+-------+--------+---------+
| 2  | Jim   | 90000  | 1       |
| 5  | Max   | 90000  | 1       |
| 3  | Henry | 80000  | 2       |
| 1  | Joe   | 70000  | 3       |
| 4  | Sam   | 60000  | 4       |
+----+-------+--------+---------+	

Rank：中间有hole，Henry的排序这里是3。
SELECT *, RANK() OVER (ORDER BY Salary DESC) AS Rank 
FROM Employee
+----+-------+--------+------+
| Id | Name  | Salary | Rank |
+----+-------+--------+------+
| 2  | Jim   | 90000  | 1    |
| 5  | Max   | 90000  | 1    |
| 3  | Henry | 80000  | 3    |
| 1  | Joe   | 70000  | 4    |
| 4  | Sam   | 60000  | 5    |
+----+-------+--------+------+
