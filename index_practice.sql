-- 1. Chọn cơ sở dữ liệu mẫu classicmodels
USE classicmodels;

-- 2. Kiểm tra truy vấn khi chưa tạo chỉ mục (Index)
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- 3. Thêm chỉ mục đơn cho cột customerName
ALTER TABLE customers ADD INDEX idx_customerName(customerName);

-- 4. Kiểm tra lại truy vấn sau khi đã có chỉ mục idx_customerName
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- 5. Thêm chỉ mục phức hợp (Composite Index) cho hai cột contactFirstName và contactLastName
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- 6. Kiểm tra hiệu năng khi sử dụng chỉ mục phức hợp
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';

-- 7. Xóa chỉ mục phức hợp nếu không cần sử dụng nữa
ALTER TABLE customers DROP INDEX idx_full_name;