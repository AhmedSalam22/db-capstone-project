use little_lemon;
-------------------------------------------------------
drop view if exists OrdersView;
create view   OrdersView as select idorders, quantity, total_cost from orders where quantity > 2;

-------------------------------------------------------
select idcustomer, FullName, idOrders, total_cost, name, CourseName, Starter
from customer 
JOIN orders
on orders.customer_idcustomer = customer.idcustomer
Join menus 
on menus.Orders_idOrders =  orders.idOrders
join menus_has_menusitems
ON menus.id = menus_has_menusitems.menus_id
join menusitems
on menusitems.idmenusItems = menus_has_menusitems.menusItems_idmenusItems;
-------------------------------------------------------
select name from menus where Orders_idOrders =  any(select idOrders from orders where  quantity> 2);

-------------------------------------------------------
create procedure GetMaxQuantity()
SELECT max(quantity)
from orders;
-------------------------------------------------------
call GetMaxQuantity();
-------------------------------------------------------
PREPARE GetOrderDetail FROM 'SELECT * from orders where idOrders = ?';
-------------------------------------------------------
set @a = 1;
execute GetOrderDetail using @a;
-------------------------------------------------------
DELIMITER   // 
create procedure CancelOrder(in id int)
BEGIN
delete from orders where idOrders = id;
select concat("deleted succesuflu: " , id);
END//
DELIMITER ;
-------------------------------------------------------
DROP PROCEDURE IF exists CheckBooking;
DELIMITER   // 
create procedure CheckBooking(in date_input date, in table_num int)
BEGIN
	SELECT 
		case
			WHEN EXISTS (select * from booking where table_num = table_num and date = date_input) 
				Then "alredy exist" 
			else  "free" 
        end as status;

END //
DELIMITER ;

call CheckBooking("2022-11-12", "30");
----------------------------------------------
-- DELIMITER //

-- CREATE procedure AddValidBooking(in date_input date, in table_num int)
-- BEGIN
-- 	START transaction
--     IF  (select * from booking where table_num = table_num and date = date_input) then
-- 		rollback;
--     END IF;
-- END //
-- DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddBooking (in bookingId int, in customerId int, in tableNum int, in date_in date)
BEGIN
	insert into booking(booking_id, customer_id, table_num, date) values (bookingId, customerId, tableNum, date_in);
END //
DELIMITER ; 

call AddBooking(9, 3, 4, "2022-01-05");

DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER //
CREATE PROCEDURE UpdateBooking(in bookingId int, in date_in date)
BEGIN
	update booking set date = date_in where booking_id = bookingId;
    select concat(bookingId, "  updated sucessfully") as message;
END//
DELIMITER ;  

call UpdateBooking(9, "2023-01-01");


DELIMITER //
CREATE PROCEDURE cancelBooking(in bookingId int)
BEGIN
	DELETE FROM booking where booking_id = bookingId;
    select concat(bookingId, "  delteed sucessfully") as message;
END//
DELIMITER ;  

call cancelBooking(9);

