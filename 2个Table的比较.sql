
/*===============================================================*/
1.5.1	利用NOT IN a list来找到no overlap
/*===============================================================*/
https://leetcode.com/problems/customers-who-never-order/

先把order里面的customer id做成一个subquery的结果，然后就像其他语言一样用not in a list来筛选。
SELECT	customers.name AS Customers 
FROM 	customers 
WHERE 	customers.id NOT IN	(SELECT orders.customerid FROM orders)
(run time 884 ms)


/*===============================================================*/
1.5.2	利用join发现不了就返回null这点来找到no overlap
/*===============================================================*/
  https://leetcode.com/problems/customers-who-never-order/

SELECT 	customers.name AS Customers 
FROM 		customers 
LEFT JOIN 	orders ON 		customers.id=orders.customerid 
WHERE 		customerid IS NULL
(run time 1085 ms)
