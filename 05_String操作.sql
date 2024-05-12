操作String	

  1. 把query出来的结果作为一个string输出  
【STRING_AGG… WITHIN GROUP (ORDER BY …)】
SELECT  sell_date, STRING_AGG(a.product, ',') WITHIN GROUP (ORDER BY product) 
FROM  Activities 
GROUP BY a.sell_date

  2. 截取string的一部分
【LEFT, RIGHT, LEN, UPPER LOWER】
SELECT user_id,UPPER(LEFT(name, 1))+LOWER(RIGHT(name, LEN(name)-1)) as name 
FROM Users 
ORDER BY user_id


