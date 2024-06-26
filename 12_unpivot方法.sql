Unpivot的方法
Products table:
+--------+--------+-------+-------+
|product_id| store1|store2|store3 |
+--------+--------+-------+-------+
| 0      | 95     | 100   |105    |
| 1      | 70     | null  |80     |
+--------+--------+-------+-------+

Output:
+------------+--------+-------+
| product_id | store  | price |
+------------+--------+-------+
| 0          | store1 | 95    |
| 0          | store2 | 100   |
| 0          | store3 | 105   |
| 1          | store1 | 70    |
| 1          | store3 | 80    |
+------------+--------+-------+	

【方法1: CROSS】
SELECT product_id, store, price
FROM Products
CROSS APPLY
(VALUES ('store1', store1),('store2', store2), ('store2', store3)) c (store, price)
WHERE price IS NOT NUll;

【方法2: UNION】
SELECT product_id,'store1' AS store, store1 AS price FROM Products  UNION
SELECT product_id,'store2' AS store, store2 AS price FROM Products UNION
SELECT product_id,'store3' AS store, store3 AS price FROM Products
