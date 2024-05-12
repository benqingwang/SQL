	1.【根据条件update table用where】
UPDATE   QW.dbo.favo_fish
SET  fish='capri'
WHERE  id=4

2.【根据多个条件update table 就要用CASE】
UPDATE  Salary
SET sex= 
  CASE WHEN sex='m' THEN 'f' ELSE 'm' END

3.【Delete (remove duplicates保留idx最小的)】
【这里我们用到一个技巧是给同一个table两个不同的代号，方便做对比】
DELETE  p1
FROM person p1, person p2
WHERE 	p1.email=p2.email AND p1.id>p2.id

4. 【找到duplicate】
SELECT DISTINCT a.email AS Email
FROM Person a, Person b
WHERE a.id>b.id AND a.email=b.email
