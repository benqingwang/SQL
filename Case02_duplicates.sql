/*==================================================================================*/
1.2.1	Find Duplicates – Count() Group By
/*==================================================================================*/
https://leetcode.com/problems/duplicate-emails/
Group by的思路其实相当于你创造一个Count的subquery，然后select from 这个subquery
  
SELECT		Email
FROM 		Person 
GROUP BY	Email
Having 	COUNT(Email)>1

/*==================================================================================*/
1.2.2	Find Duplicates – 对照组法
/*==================================================================================*/
https://leetcode.com/problems/duplicate-emails/
Self Join的思路的是看是否存在email相同但是ID不同的row

SELECT DISTINCT a.Email
FROM	Person a, Person b
WHERE	a.Email=b.Email AND a.ID<>b.ID

/*==================================================================================*/
1.2.3	Delete Duplicates –留最小ID – Self Join 1
/*==================================================================================*/

下面这个猫Table是有duplicate的
+----+---------+
| Id | Cat     | 
+----+---------+
| 1  | maomao  | 
| 2  | dudu    | 
| 3  | figaro  | 
| 4  | dudu    | 
+----+---------+
我可以用自我对比的方式来找到duplicates并且保留序号最小的
delete p1
from 	QW.dbo.cat_name p1, QW.dbo.cat_name p2
where 	p1.cat=p2.cat AND p1.id>p2.id

+----+---------+
| Id | Cat     | 
+----+---------+
| 1  | maomao  | 
| 2  | dudu    | 
| 3  | figaro  | 
+----+---------+

/*==================================================================================*/
1.2.4	Delete Duplicates –留最小ID – Self Join 2
/*==================================================================================*/
https://leetcode.com/problems/delete-duplicate-emails/

延续上面的思路，保留最小ID就是要delete的比对比组同一个email的ID都大的row
DELETE p1 
FROM 	person p1, person p2
WHERE 	p1.email=p2.email AND p1.id>p2.id

