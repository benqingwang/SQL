1.3	Count一个item出现的频率
练习数据：https://leetcode.com/problems/classes-more-than-5-students/
+---------+------------+
| student | class      |
+---------+------------+
| A       | Math       |
| B       | English    |
| C       | Math       |
| D       | Biology    |
| E       | Math       |
| F       | Computer   |
| G       | Math       |
| H       | Math       |
| I       | Math       |
+---------+------------+

/*====================================================================================*/
1.3.1	最简单的频率Count
/*====================================================================================*/
频率的计算必然要用到Count，Count一个item频率的基本思路就是group by这个item。下面的count(*)的对象是group by之后的每个class的count，不是所有的数据的count。

select class, count(*) As Frequency
from courses
group by class
+-----------+------------+
| class     | Frequency  |
+-----------+------------+
| Biology   | 1          |
| Computer  | 1          |
| English   | 1          |
| Math      | 6          |
+-----------+------------+

/*====================================================================================*/
1.3.2	最简单的频率Count distinct
/*====================================================================================*/
如果数据中含有duplicates，我们可以通过count distinct来解决
+---------+------------+
| student | class      |
+---------+------------+
| A       | Math       |
| A       | Math       |
| C       | Math       |
| D       | Biology    |
| E       | Math       |
| F       | Computer   |
| G       | Math       |
| H       | Math       |
| I       | Math       |
+---------+------------+
select class, count (distinct student) as frequency
from courses
group by class

/*====================================================================================*/
1.3.3	对频率加上条件
/*====================================================================================*/
比如我只想知道哪些课有超过5个人参与
select class, count (distinct student) as frequency
from 	courses
group by class
having count (distinct student)>=5

有趣的是，我如果直接先把from后面的data set给distinct了速度比count discount快很多，这个是可以理解的，因为count discount等于每次count都要distinct一次，而改变from等于就一次。
select 	a.class
from 		(select distinct * from courses) a
group by 	a.class
having 	count(a.class)>=5
