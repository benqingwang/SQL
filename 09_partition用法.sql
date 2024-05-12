进阶用法-Partition By

Patrition by相当于打开一个小window得到一个数字然后返回给我们。我们用下面的table作为例子：
+----+-------+--------+-----+
| id | name  | salary | dId |
+----+-------+--------+-----+
| 1  | Joe   | 70000  | 1   |
| 2  | Jim   | 90000  | 1   |
| 3  | Henry | 80000  | 2   |
| 4  | Sam   | 60000  | 2   |
| 5  | Max   | 90000  | 1   |
+----+-------+--------+-----+	

【1】下面这例子里面，我们想把员工的工资排名，但是不想要大排名，我想要是他们在各自department内部的排名。
这里我们就要用到partition by. 

SELECT *, DENSE_RANK() OVER (PARTITION BY dId ORDER BY Salary DESC) AS Rank
FROM    Employee	
+----+-------+--------+-----+-----+
| id | name  | salary | dId |Rank |
+----+-------+--------+-----+-----+
| 2  | Jim   | 90000  | 1   | 1   |
| 5  | Max   | 90000  | 1   | 1   |
| 1  | Joe   | 70000  | 1   | 3   |
| 3  | Henry | 80000  | 2   | 1   |
| 4  | Sam   | 60000  | 2   | 2   |
+----+-------+--------+-----+-----+

【2】 Partition单用
下面是使用的例子
+----+-------+------+
| id | name  | order|
+----+-------+------+
| 1  | Jim   | 900  |
| 1  | Jim   | 200  |
| 2  | Joe   | 700  |
| 3  | Henry | 800  |
+----+-------+------+

注意partition是增加信息(min值)，并没有选出min的作用，所以tbl还是原来的行数。
SELECT 
  name
  , MIN(order) OVER (PARTITION BY name) AS min_order 
FROM tbl
+----+-------+------+-----------+
| id | name  | order| min_order |
+----+-------+------+-----------+
| 1  | Jim   | 900  | 200       |
| 1  | Jim   | 200  | 200       |
| 2  | Joe   | 700  | 700       |
| 3  | Henry | 800  | 800       |
+----+-------+------+-----------+

如果你的目的是选出每个name对应最小的order 应该用:
SELECT 
  name
  , MIN(order) AS min_order 
FROM tbl 
GROUP BY name	
+----+-------+-----------+
| id | name  | min_order |
+----+-------+-----------+
| 1  | Jim   | 200       |
| 2  | Joe   | 700       |
| 3  | Henry | 800       |
+----+-------+-----------+
