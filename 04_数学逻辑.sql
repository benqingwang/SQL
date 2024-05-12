

1. 【IS NULL】
  WHERE  referee_id IS NULL

2.【ISNULL( )】类似于IFERROR: 
       Select ISNULL(field, 100) 
或者   Select isnull (result of a select, null) 
或者   Select isnull (result of a select, 100)

3. 【COUNT( --- )】
  Count(column), Count (*)
  
4. 【COUNT (DISTINCT  --- )】
  SELECT a, COUNT(DISTINCT b) 
  FROM table 
  GROUP BY a

5. 【SUM】这类的函数里面还可以有运算的，比如
  SELECT a, SUM(b-c) 
  FROM tbl 
  GROUP BY a

6.【求余数】employee_id % 2 = 1 判断employee_id是奇偶数

7.【AND/OR】WHERE   area>3 OR population >25

8.【NOT】【Like】【%】name NOT LIKE 'M%', %可以代表空。	

9. 【计算日期：dateadd(day,1,date )】
SELECT dateadd(day,1, date) as new_date, value FROM tbl

10.【日期期间】
WHERE a.activity_date <='2019-07-27' AND a.activity_date > dateadd(day,-30,'2019-07-27')

11.【某年DATEPART( )】
where datepart(YYYY, 某time_stamp) = 2020

+----+-----+-----+-----+
| Id | Num | LAG | LEAD|
+----+-----+-----+-----+
| 1  | 10  |NULL | 20  |
| 2  | 20  | 10  | 30  |
| 3  | 30  | 20  | 40  |
| 4  | 40  | 30  | 50  |
| 5  | 50  | 40  |NULL |
+----+-----+-----+-----+

12.【LAG()和LEAD()】
  LAG(Num) OVER(ORDER BY id)
  LAG求上一个LEAD (Num) OVER(ORDER BY id )
  Lead是求下一个

13.【MAX/MIN】
  SELECT MAX(p_id)FROM Tree

14.【SELECT MAX对应的其他column 】这里关键是一定要用Group by. 
  select a, max(b) as last_b 
  from tbl 
  group by a 

14.【增加MAX信息】
SELECT a, MAX(b) OVER (PARTITION BY a) AS last_b 
FROM tbl

15.【用MAX MIN发现在一个值域内的item】
WITH a AS (
  SELECT  product_id, MAX(sale_date) AS last, MIN(sale_date) AS first 
  FROM Sales  
  GROUP BY product_id)

SELECT a.product_id, Product.product_name 
FROM a 
LEFT JOIN Product ON Product.product_id=a.product_id
WHERE a.last<='2019-03-31' AND a.first>='2019-01-01'
