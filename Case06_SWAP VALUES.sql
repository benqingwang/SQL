Swap value的关键是用CASE定义情况。

/*=======================================================================*/
1.6.1	交换一个column中男女的value-原来的F变成M,而M变成F
/*=======================================================================*/
https://leetcode.com/problems/swap-salary/
UPDATE  salary
SET     sex= CASE sex
             WHEN 'f' THEN 'm'
             ELSE 'f'
             END
/*=======================================================================*/
1.6.2	交换位子
/*=======================================================================*/
  https://leetcode.com/problems/exchange-seats/

这个学到的是，如果我需要一个值counts，我可以在FROM里面先计算。
  SELECT 
            CASE
                WHEN id%2=0 THEN id-1
                WHEN id%2=1 AND id=counts THEN id
                ELSE id+1
            END AS id,
            student
    FROM    seat, 
            (SELECT COUNT(*) AS counts FROM seat) a
ORDER BY    id;    
/*=======================================================================*/
1.7	计算percentage
/*=======================================================================*/
  select	request_at,sum(perc)

from
		(select 	request_at, 
				status, 
				count(*)*1.0/(
					select count(*) 
					from trips t2 
					where t2.request_at=t1.request_at) as perc

		from 		trips t1
		group by 	request_at,status) a

where	status in ('cancelled_by_driver','cancelled_by_client')

group by request_at
