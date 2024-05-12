Subquery	
1.【用subquery得一个数，作为condition的一部分】
SELECT 
  CASE 
    WHEN id+1>(select count(*) as counts from seat) THEN id ELSE id+1
  END AS id
FROM    seat 

2.【同样的结果，我们可以把subquery写在from里面， 注意select要refer to column不是table】
SELECT
  CASE 
    WHEN id+1>counts THEN id ELSE id+1
  END AS id
FROM   seat, (select count(*) as counts from seat) temp
  
3.【用subquery得到一个list在】
Select
  CASE
    WHEN id%2=1 AND id+1 not in (select id from seat) THEN id ELSE id+1
  END AS id 
FROM seat

4.【在where里面使用subquery】
相当于把select from中的变量当作一个常量在where中使用。这个时候通常有count(), sum()之类的
SELECT DISTINCT  (a.num) as ConsecutiveNums
FROM logs a
WHERE 3= (Select count (distinct b.id) as value from logs b where b.id>=a.id AND b.id<=a.id+2 AND b.num=a.num)

5. Subquery还可以先用with .. as ()定义。我觉得这样更清晰明确
with a as (
  SELECT
  FROM
  WHERE
  GROUP BY)

SELECT    tbl.x, a.y 
FROM tbl 
LEFT JOIN  a  ON  a.z=tbl.z
