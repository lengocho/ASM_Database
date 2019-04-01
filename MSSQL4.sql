create database MSSQL4
use MSSQL4;

create table NguoiChiuTrachNhiem (
MaNguoiChiuTrachNhiem varchar(100) primary key,
Ten varchar(100),
);

create table LoaiSanPham (
MaLoaiSanPham varchar(10) primary key,
TenLoaiSanPham varchar(100),
);

create table SanPham (
MaSanPham varchar(100) primary key,
Ten varchar(100),
NSX date,
MaLoaiSanPham varchar(10) foreign key references LoaiSanPham(MaLoaiSanPham),
MaNguoiChiuTrachNhiem varchar(100) foreign key references NguoiChiuTrachNhiem(MaNguoiChiuTrachNhiem)
);

insert into NguoiChiuTrachNhiem values 
('987689', N'Nguyễn Văn Bê')

insert into LoaiSanPham values 
('Z37T', N'Máy tính xách tay'),
('Z37R', N'Máy tính để bàn')
('Z37E', N'Máy tính')

insert into SanPham values 
('Z37111114', N'Máy tính sách tay Z37R5398t', '12/12/12', 'Z37R', '987688'),
('Z37111115', N'Máy tính sách tay Z37523', '12/12/13', 'Z37R', '987688')



('Z37111113', N'Máy tính sách tay Z37R1', '12/12/09', 'Z37R', '987688')
('Z37111112', N'Máy tính sách tay Z37E1', '12/12/09', 'Z37E', '987688')
('Z37111111', N'Máy tính sách tay Z37', '12/12/09', 'Z37E', '987688')




--Cau 4:
--a: Liet ke danh sach loai san pham cua cong ty
select * from LoaiSanPham

--b: Liet ke danh sach san pham cua cong ty
select * from SanPham

--c: Liet ke danh sach nguoi chiu trach nhiem cua cong ty
select * from NguoiChiuTrachNhiem

--Cau 5:
--a: Liet ke danh sach loai san pham cua cty theo thu tu tang dan cua ten
select * from LoaiSanPham
order by TenLoaiSanPham asc

--b: Liet ke danh sach nguoi chiu trach nhiem cua cong ty theo thu tu tang dan cua ten
select * from NguoiChiuTrachNhiem
order by Ten asc

--c: Liet ke cac san pham cua loai san pham co ma so la Z37E
select SanPham.Ten, LoaiSanPham.MaLoaiSanPham from SanPham, LoaiSanPham
where SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham
and LoaiSanPham.MaLoaiSanPham = 'Z37E'

--d: Liet ke cac san pham Nguyen Van An chiu trach nhiem theo thu tu giam dan cua ma
select SanPham.Ten, SanPham.MaSanPham, NguoiChiuTrachNhiem.Ten from SanPham, NguoiChiuTrachNhiem
where SanPham.MaNguoiChiuTrachNhiem = NguoiChiuTrachNhiem.MaNguoiChiuTrachNhiem
and NguoiChiuTrachNhiem.Ten = N'Nguy?n Van An'
order by SanPham.MaSanPham desc


--Cau 6:
--a: So San Pham cua tung loai san pham

Select Count(SanPham.MaSanPham) as SoSanPham, LoaiSanPham.MaLoaiSanPham
from  LoaiSanPham, SanPham
where SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham
group by LoaiSanPham.MaLoaiSanPham

--b So Loai San Pham trung binh theo loai san pham not done
Select AVG(SanPham.MaSanPham) as TBSanPham, LoaiSanPham.MaLoaiSanPham
from  LoaiSanPham, SanPham
where SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham
group by LoaiSanPham.MaLoaiSanPham

--c Hien thi toan bo thong tin ve san pham va loai san pham
Select * from SanPham, LoaiSanPham
where SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham

--d Hien thi toan bo thong tin ve san pham va loai san pham, nguoi chiu trach nhiem

Select * from SanPham, LoaiSanPham, NguoiChiuTrachNhiem
where SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham
and SanPham.MaNguoiChiuTrachNhiem = NguoiChiuTrachNhiem.MaNguoiChiuTrachNhiem

--cau 7
--a Viet cau lenh de thay doi truong ngay san xuat la truoc hoac bang ngay hien tai
 ALTER TABLE SanPham
 ADD CHECK (NSX<=getdate())

 --b: Viet cau lenh de xac dinh cac truong khoa chinh va khoa ngoai cua bang


 --c Vuet cau lenh de them truong phien ban cua san pham
ALTER TABLE SanPham
ADD PhienBan nvarchar(20);

ALTER TABLE SanPham
DROP COLUMN PhienBan;

select * from SanPham

-- cau 8
CREATE INDEX Chimuc
ON NguoiChiuTrachNhiem (Ten);

--b: Viet view san pham hien thi thong tin Ma San Pham, NSX, Loai san Pham
CREATE VIEW View_SanPham AS
SELECT SanPham.MaSanPham, SanPham.NSX, LoaiSanPham.TenLoaiSanPham
FROM SanPham, LoaiSanPham
where SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham

Select * from View_SanPham
select * from SanPham

--Hien thi ma san pham, NSX, Nguoi chiu trach nhiem
CREATE VIEW View_SanPham_NCTN as
select SanPham.MaSanPham, SanPham.NSX, NguoiChiuTrachNhiem.Ten
from SanPham, NguoiChiuTrachNhiem
where SanPham.MaNguoiChiuTrachNhiem = NguoiChiuTrachNhiem.MaNguoiChiuTrachNhiem

Select * from View_SanPham_NCTN
Drop view View_SanPham_NCTN;

--Hien thi 5 san pham moi nhat(Ma san pham, Loai San Pham, Ngay San Xuat)
Select top 5 SanPham.MaSanPham, LoaiSanPham.TenLoaiSanPham, SanPham.NSX
from SanPham, LoaiSanPham
where SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham
order by SanPham.NSX desc

--c: Store Procedủe
-- Them moi 1 loai san pham

CREATE PROCEDURE SP_Them_LoaiSP
(@MaLoaiSanPham varchar(10), @TenloaiSanPham varchar(100))
AS
insert into LoaiSanPham(MaLoaiSanPham, TenLoaiSanPham) values (@MaLoaiSanPham, @TenloaiSanPham)

EXEC SP_Them_LoaiSP @MaLoaiSanPham = 'H37H', @TenLoaiSanPham = 'DTDD'

select * from LoaiSanPham

--Them moi nguoi chiu trach nhiem

CREATE PROCEDURE SP_Them_NCTN
(@MaNguoiChiuTrachNhiem varchar(100), @Ten varchar(100))
AS
insert into NguoiChiuTrachNhiem(MaNguoiChiuTrachNhiem, Ten) values (@MaNguoiChiuTrachNhiem, @Ten)

EXEC SP_Them_NCTN @MaNguoiChiuTrachNhiem = '987681', @Ten = 'John'

select * from NguoiChiuTrachNhiem

--Them moi mot san pham

Create Procedure SP_Them_SanPham
(@MaSanPham varchar(100), @Ten varchar(100), @NSX date, @MaLoaiSanPham varchar(10), @MaNguoiChiuTrachNhiem varchar(100))
as
insert into SanPham(MaSanPham, Ten, NSX, MaLoaiSanPham, MaNguoiChiuTrachNhiem) values (@MaSanPham, @Ten, @NSX, @MaLoaiSanPham, @MaNguoiChiuTrachNhiem)

EXEC SP_Them_SanPham @MaSanPham = 'SSGS10', @Ten = 'Samsung Galaxy S10', @NSX = '07/12/21', @MaLoaiSanPham = 'H37H', @MaNguoiChiuTrachNhiem = '987681'

Select * from SanPham


--Xoa mot san pham theo ma san pham
Create Procedure SP_Xoa_SanPham
(@MaSanPham varchar(100))
AS
delete from SanPham
where MaSanPham = @MaSanPham

EXEC SP_Xoa_SanPham @MaSanPham = 'SSGS10'

--Xoa cac san pham cua mot loai nao do
Create Procedure SP_Xoa_SanPham_TheoLoai
(@MaLoaiSanPham varchar(10))
as
delete 
from SanPham, LoaiSanPham
where SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham
and MaLoaiSanPham = @MaLoaiSanPham

EXEC SP_Xoa_SanPham_TheoLoai @MaLoaiSanPham = 'Z37E'





