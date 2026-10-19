-- Sử dụng cơ sở dữ liệu classicmodels
USE classicmodels;

-- =============================================
-- 1. THAM SỐ LOẠI IN (Input Parameter)
-- Lấy thông tin khách hàng theo customerNumber
-- =============================================
DROP PROCEDURE IF EXISTS getCusById;

DELIMITER //
CREATE PROCEDURE getCusById(IN cusNum INT)
BEGIN
    SELECT * FROM customers WHERE customerNumber = cusNum;
END //
DELIMITER ;

-- Gọi Stored Procedure loại IN
CALL getCusById(175);


-- =============================================
-- 2. THAM SỐ LOẠI OUT (Output Parameter)
-- Đếm số lượng khách hàng theo thành phố
-- =============================================
DROP PROCEDURE IF EXISTS GetCustomersCountByCity;

DELIMITER //
CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //
DELIMITER ;

-- Gọi Stored Procedure loại OUT
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total AS total_customers;


-- =============================================
-- 3. THAM SỐ LOẠI INOUT (Input/Output Parameter)
-- Tăng giá trị biến đếm lên một khoảng (inc)
-- =============================================
DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER //
CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //
DELIMITER ;

-- Gọi Stored Procedure loại INOUT
SET @counter = 1;

CALL SetCounter(@counter, 1); -- @counter = 1 + 1 = 2
CALL SetCounter(@counter, 1); -- @counter = 2 + 1 = 3
CALL SetCounter(@counter, 5); -- @counter = 3 + 5 = 8

SELECT @counter AS final_counter;