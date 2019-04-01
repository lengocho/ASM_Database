create database MSSQL1
use MSSQL1;

create table Customers (
Customer_ID nvarchar(100) primary key,
Customer_name nvarchar(100),
Customer_Address nvarchar(100),
Customer_Phone varchar(100)
)

create table Products (
Product_ID nvarchar(100) primary key,
Product_name nvarchar(100),
Product_description nvarchar(100),
Product_unit nvarchar(100),
Product_price varchar(100),
)

ALTER TABLE Products
ALTER COLUMN Product_price int;

create table Orders (
Order_ID nvarchar(10) primary key,
Order_date date,
Customer_ID nvarchar(100) foreign key references Customers(Customer_ID)
)

ALTER TABLE Orders
ALTER COLUMN Order_ID int;

create table Order_detail (
Product_ID nvarchar(100) foreign key references Products(Product_ID),
Product_amount varchar(10),
Product_totalPriceByProduct varchar(100),
Order_ID nvarchar(10) foreign key references Orders(Order_ID)
)

ALTER TABLE Order_detail
ALTER COLUMN Product_totalPriceByProduct int;

drop table Order_detail


insert into Customers values 
('C002', 'Alex', 'HN', '0982701819'),
('C001', 'Le Ngoc Ho', 'HN', '0982701819')

insert into Products values 
('P001', 'Laptop', 'New', 'Peace', '1000'),
('P002', 'Nokia', 'New', 'Peace', '200'),
('P003', 'Printer', 'Old', 'Peace', '100')

insert into Orders values
('1234', '01/12/05', 'C001')

insert into Order_detail values
('P001', '1', '1000', '1234'),
('P002', '2', '400', '1234'),
('P003', '1', '100', '1234')

Select * from Order_detail

--cau 4:
--a: Liet ke danh sach khach hang da mua o cua hang
select * from Customers
--b: Liet ke danh sach san pham cua cua hang
select * from Products
--c: Liet ke danh sach cac don dat hang cua cua hang
select * from Orders

--cau 5:
--a: Liet ke danh sach khach hang theo thu tu alphabet
select * from Customers
order by Customers.Customer_name desc;

--b: Liet ke danh sach san pham cua cua hang theo thu tu gia giam dan
select * from Products
order by Products.Product_price desc;

--c: Liet ke cac san pham ma khach hang Nguyen Van An da mua

select * from Customers, Orders, Order_detail, Products
where Customers.Customer_name = 'Le Ngoc Ho'
and Orders.Order_ID = Order_detail.Order_Id
and Products.Product_ID = Order_detail.Product_ID

--cau 6:
--a So khach hang da mua o cua hang
select count(Customers.Customer_ID) as SLKH
from Customers

--b So mat hang ma cua hang ban
select count(Products.Product_ID) as SLMH
from Products

--c Tong tien cua tung don hang
select sum(Order_detail.Product_totalPriceByProduct) as TT
from Order_detail

-- cau 7: Thay doi nhung thong tin sau tu CSDL
--a : Viet cau lenh de thay doi truong gia tien cua tung mat hang la duong > 0
 ALTER TABLE Products
 ADD CHECK (Product_price > 0)

 --b : Viet cau lenh de thay doi ngay dat hang cua khach hang phai nho hon ngay hien tai
  ALTER TABLE Orders
 ADD CHECK (Orders.Order_date <=getdate())

 --c: Viet cau lenh de them truong ngay xuat hien tren thi truong cua san pham
 ALTER TABLE Products
ADD Product_ReleaseDate date

-- cau 8
--a 

CREATE INDEX ChiMuc_TenHang
ON Products (Product_name)

CREATE INDEX ChiMuc_NguoiDatHang
ON Customers (Customer_name)

--b: xay dung cac view
CREATE VIEW View_KhachHang AS
SELECT Customers.Customer_name, Customers.Customer_Address, Customers.Customer_Phone
FROM Customers

Select * from View_KhachHang

CREATE VIEW View_SanPham AS
SELECT Products.Product_name, Products.Product_price
FROM Products

Select * from View_SanPham

CREATE VIEW View_KhachHang_SanPham AS
SELECT Customers.Customer_name, Customers.Customer_Phone, Products.Product_name, Order_detail.Product_amount, Orders.Order_date
FROM Customers, Products, Orders, Order_detail
where Customers.Customer_ID = Orders.Customer_ID
and Products.Product_ID = Order_detail.Product_ID

Select * from View_KhachHang_SanPham
DROP VIEW View_KhachHang_SanPham;

--c: 
--Tim khach hang theo ma khach hang
CREATE PROCEDURE SP_TimKH_MaKH @Customer_ID nvarchar(100)
AS
select Customers.Customer_name
from Customers
where Customers.Customer_ID = @Customer_ID

EXEC SP_TimKH_MaKH @Customer_ID = 'C001'

--Tim thong tin khach hang theo ma hoa don
CREATE PROCEDURE SP_TimKH_MaHD @Order_ID nvarchar(10)
AS
select Customers.Customer_name, Customers.Customer_Address, Customers.Customer_Phone, Orders.Order_ID
from Customers, Orders
where Customers.Customer_ID = Orders.Customer_ID
and  Orders.Order_ID = @Order_ID 

EXEC SP_TimKH_MaHD @Order_ID = '1234'

DROP PROCEDURE SP_TimKH_MaHD

select * from Orders
