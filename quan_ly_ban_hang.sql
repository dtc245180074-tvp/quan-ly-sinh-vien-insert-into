-- Tạo cơ sở dữ liệu nếu chưa có và sử dụng
CREATE DATABASE IF NOT EXISTS QuanLyBanHang;
USE QuanLyBanHang;

-- Tạo các bảng nếu chưa có
CREATE TABLE IF NOT EXISTS Customer (
    cID INT PRIMARY KEY,
    cName VARCHAR(25),
    cAge TINYINT
);

CREATE TABLE IF NOT EXISTS `Order` (
    oID INT PRIMARY KEY,
    cID INT,
    oDate DATETIME,
    oTotalPrice INT,
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);

CREATE TABLE IF NOT EXISTS Product (
    pID INT PRIMARY KEY,
    pName VARCHAR(25),
    pPrice INT
);

CREATE TABLE IF NOT EXISTS OrderDetail (
    oID INT,
    pID INT,
    odQTY INT,
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES `Order`(oID),
    FOREIGN KEY (pID) REFERENCES Product(pID)
);

-- Xóa dữ liệu cũ để tránh trùng lặp
TRUNCATE TABLE OrderDetail;
DELETE FROM `Order`;
DELETE FROM Product;
DELETE FROM Customer;

-- 1. THÊM DỮ LIỆU VÀO CÁC BẢNG

-- Bảng Customer
INSERT INTO Customer (cID, cName, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

-- Bảng Order
INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

-- Bảng Product
INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

-- Bảng OrderDetail
INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- 2. CÁC CÂU LỆNH TRUY VẤN YÊU CẦU

-- Yêu cầu 1: Hiển thị các thông tin gồm oID, oDate, oTotalPrice của tất cả các hóa đơn trong bảng Order
SELECT oID, oDate, oTotalPrice
FROM `Order`;

-- Yêu cầu 2: Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT DISTINCT c.cName AS CustomerName, p.pName AS ProductName
FROM Customer c
JOIN `Order` o ON c.cID = o.cID
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID;

-- Yêu cầu 3: Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT c.cName AS CustomerName
FROM Customer c
LEFT JOIN `Order` o ON c.cID = o.cID
WHERE o.oID IS NULL;

-- Yêu cầu 4: Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (Tổng giá = odQTY * pPrice)
SELECT o.oID, o.oDate, SUM(od.odQTY * p.pPrice) AS TotalPrice
FROM `Order` o
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;