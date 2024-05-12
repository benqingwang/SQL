诸如find top, find duplicates之类的问题，其实都是一个table的row和这个table自己比较。这种问题的解决方法是给这个table2个alias，变成相同的2个table,然后进行比较

/*=========================================================================================*/
1.4.1	找出比自己老板工资高的员工
/*=========================================================================================*/
应用：用table自己来enrich自己。比如利用from-to table画lineage，比如下面的寻找老板工资的题
https://leetcode.com/problems/employees-earning-more-than-their-managers/

Solution
SELECT  a.Name AS Employee
FROM    Employee a, Employee b
WHERE   a.ManagerID=b.ID AND a.Salary>b .Salary

强化solution: 先排除掉了没有用的null，这样能加快速度
SELECT  ee.Name AS Employee
FROM    (SELECT * FROM Employee WHERE ManagerID IS NOT Null) ee, Employee
WHERE   ee.ManagerID=Employee.ID AND ee.Salary>Employee.Salary

/*=========================================================================================*/
1.4.2	自我比较之 - 温度比昨天高
/*=========================================================================================*/
https://leetcode.com/problems/rising-temperature/

SELECT  a.id
FROM    Weather a,
        (SELECT dateadd(day,1,recordDate) as previousdate, Temperature
         FROM   Weather) b
WHERE   a.recordDate=b.previousdate AND a.Temperature>b.Temperature

/*=========================================================================================*/
1.4.3	找出至少连续3次出现的值 – 对照组法
/*=========================================================================================*/
练习数据：https://leetcode.com/problems/consecutive-numbers/
这种题明显又是自我比较型。我创造2个对照组一个是id差1，一个id差2,然后看同一个id对应的Num是不是一样

select distinct	a.Num as ConsecutiveNums
from	Logs a,
		(select id-1 as id,Num from Logs) b,
		(select id-2 as id, NUM from Logs) c
where a.id=b.id AND a.Num=b.Num AND a.id=c.id AND a.Num=c.Num

但是其实我们根本不用创建subquery，只要利用Number差
select distinct	a.Num as ConsecutiveNums
from			Logs a, Logs b, Logs c
where 		a.id=b.id+1 AND a.Num=b.Num AND a.id=c.id+2 AND a.Num=c.Num

/*=========================================================================================*/
1.4.4	找出至少连续3次出现的值 – LEAD()和LAG()
/*=========================================================================================*/
利用analytical function得到向上向下的数值
SELECT DISTINCT num AS ConsecutiveNums
           FROM (SELECT num,
                        LEAD(num) OVER(ORDER BY id) AS lead, 
                        LAG(num) OVER (ORDER BY id) AS lag
                   FROM logs) t
           WHERE num=lead AND num=lag

/*=========================================================================================*/
1.4.5	找出至少连续3次出现的值 – 在where使用subquery
/*=========================================================================================*/
select distinct (a.num) as ConsecutiveNums
from	logs a
where	3=	(Select count (distinct b.id) as value
          from logs b
		      where b.id>=a.id AND b.id<=a.id+2 AND b.num=a.num)
