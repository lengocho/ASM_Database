create database ThongTinDangKYDienThoai
use ThongTinDangKYDienThoai;

create table KhachHang (
CMT varchar(10) primary key,
Ten nvarchar(100),
Diachi nvarchar(100)
);

create table ThueBao (
SoThueBao int,
LoaiThueBao nvarchar(100),
Ngaydangky date,
CMT varchar(10) foreign key references KhachHang(CMT)
);

insert into KhachHang values
('123456790', N'Nguyễn Nguyệt Kinh', N'Hà Nội' );

insert into ThueBao values 
('0383860333', N'Trả Sau', '2018/12/02', '123456789' );
('0383860444', N'Trả Sau', '12/12/02', '123456789' );
('0383870999', N'Trả Trước', '', '123456789' );
('0383860999', N'Trả Trước', '12/12/09', '123456790' );
('0383860777', N'Trả Sau', '12/12/02', '123456789' );
('123456789', N'Trả Trước', '12/12/02', '123456789' );

select * from ThueBao

--Cau 4:
--a 
select * from KhachHang
--b 
select * from ThueBao

--Cau5:
--a: Hien thi toan bo thong tin cua thue bao co so 0123456789
select KhachHang.CMT, Diachi, Ten, SoThueBao from 
KhachHang, ThueBao
where KhachHang.CMT = ThueBao.CMT
and SothueBao = 123456789;
--b: Hien thi thong tin ve khach hang co so CMTND 123456789
select CMT, Diachi, Ten
from KhachHang
where CMT=123456789
--c: Hien thi cac so thue bao cua khach hang co so CMTND 123456789
select SoThueBao, CMT
from ThueBao
where CMT=123456789
--d: Liet ke cac thue bao dang ky vao ngay 12/12/09
select SoThueBao, Ngaydangky
from ThueBao
where Ngaydangky = '12/12/09'
--e: Liet Ke cac thue bao co dia chi tai Hanoi
select ThueBao.SoThueBao, KhachHang.Diachi
from ThueBao, KhachHang
where  KhachHang.CMT = ThueBao.CMT
and KhachHang.Diachi = N'Hà Nội';

--Cau6
--a: Tong so khach hang cua cong ty
SELECT Count(CMT) as TongSoKhachHang
FROM KhachHang
--b: Tong so thue bao cua cong ty
SELECT Count(CMT) as TongSoThueBao
FROM KhachHang
--c: Tong so thue bao dang ky ngay 12/12/09
SELECT Count(ThueBao.SoThueBao) as TongSoThueBao
FROM ThueBao
where Ngaydangky = '12/12/09'
--d: Hien thi toan bo thong tin ve khach hang va thue bao cua tat ca cac so thue bao
Select * from KhachHang, ThueBao
where KhachHang.CMT = ThueBao.CMT

--Cau7
--a: Viet cau lenh de thay doi truong ngay dang ly la not null
ALTER TABLE [ThueBao] ALTER COLUMN [Ngaydangky] date NOT NULL

select * from ThueBao

--b: Viet cau lenh de thay doi truong ngay dang ky la truoc hoac bang ngay hien tai

 ALTER TABLE ThueBao
 ADD CHECK (ngaydangky<=getdate())


--c: Viet cau lenh de thay doi so dien thoai phai bat dau = 09


 --d: Viet cau lenh de them truong so diem thuong cho moi thue bao

 ALTER TABLE ThueBao
ADD SoDiemThuong int;

--cau 8:
--a Dat chi muc Index cho cot Ten Khach hang
CREATE INDEX Index_TenKhachHang
ON KhachHang (Ten);

select Ten from KhachHang

--b:
--View_KhachHang: Hien thi cac thong tin ma khach hang, ten khach hang , dia chi
CREATE VIEW View_KhachHang AS
SELECT CMT, Ten, Diachi
FROM KhachHang;

Select * from View_KhachHang

--View_KhachHang_ThueBao: Hien thi thong tin Ma Khach Hang, Ten Khach Hang, SO thue Bao
CREATE VIEW View_KhachHang_ThueBao AS
SELECT KhachHang.CMT, Ten, SoThueBao
FROM KhachHang, ThueBao
where KhachHang.CMT = ThueBao.CMT

Select * from View_KhachHang_ThueBao

--c: Viet cac Store Procedure

CREATE PROCEDURE SP_TimKH_ThueBao @SoThueBao int
AS
select KhachHang.CMT, KhachHang.Diachi, KhachHang.Ten
from KhachHang, ThueBao
where KhachHang.CMT = ThueBao.CMT
and ThueBao.SoThueBao = @SoThueBao

DROP PROCEDURE SP_TimKH_ThueBao 

EXEC SP_TimKH_ThueBao @SoThueBao = 383860777

select * from ThueBao
select * from KhachHang

--

