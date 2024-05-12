进阶用法-SQL自定义函数	
【1】CREATE FUNCTION  是statement
【2】getNthHighestSalary( ) 是函数名字
【3】@N INT是代表函数自变量得是一个整数
【4】RETURNS INT代表函数输出也是整数
【5】BEGIN…RETURN ()…END就是函数定义	

CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN 
  
RETURN  
(SELECT field FROM table Where field=@N)

END
