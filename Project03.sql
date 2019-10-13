
/*******************************************************************/
/*	JIB Karimi													   */
/*	10/12/19													   */
/*	Project 03													   */
/*																   */
/*******************************************************************/


use master
go

IF DB_ID ('disk_inventoryjk') IS NOT NULL 
	DROP DATABASE disk_inventoryjk
GO

CREATE DATABASE disk_inventoryjk
go

use disk_inventoryjk
go



--create genre table
CREATE TABLE Genre (
	genre_ID int not null identity primary key,
	description varchar(255) not null 
);

--create status table
create table Status (
	status_ID int not null identity primary key,
	description varchar(255) not null 
);



--create type table
create table disk_type (
	disk_type_id int not null identity primary key,
	description varchar(255) not null 
);


--create artist type table
create table artist_type (
	artist_type_id int not null identity primary key,
	description varchar(255) not null 
);


--create borrower table
create table borrower (
	borrower_id int not null identity primary key,
	fname		nvarchar(100) not null,
	lname		nvarchar(100) not null,
	phone_num	nvarchar(50) not null
);

--create artist table
create table artist (
	artist_id int not null identity primary key,
	fname			nvarchar(100) not null,
	lname			nvarchar(100) null,
	artist_type_id 	int not null references artist_type(artist_type_id)
);

--create disk table 
create table disk (
	disk_id 		int not null identity primary key,
	disk_name		nvarchar(100) not null,
	realse_date		date not null,
	genre_id		int not null references genre(genre_id),
	status_id		int not null references status(status_id),
	disk_type_id	int not null references disk_type(disk_type_id)
);

--create diskHasBorrower table
	create table diskHasborrower (
	borrower_id		int not null references borrower(borrower_id),
	disk_id			int not null references disk(disk_id),
	borrowed_date	smalldatetime not null,
	returned_date	smalldatetime null,
	primary key (borrower_id, disk_id, borrowed_date)
	);

-- create diskHasArtist table
create table diskHasArtist (
	--diskHasArtist		int identity not null,
	disk_id				int not null references disk(disk_id),
	artist_id			int not null references artist(artist_id),
);

--create index PK_diskHasArtist on diskHasArtist2(diskHasArtist2);
create index ix_diskHasArtist on diskHasArtist(disk_id, artist_id);


--create login for disk
IF SUSER_ID('diskjk') is null
	create login diskjk WITH PASSWORD = 'MSPress#1',
	DEFAULT_DATABASE = disk_inventoryjk;
--create user for disk
if USER_ID('diskjk') is null
	create user diskjk;
--add permission to user
alter role db_datareader add member diskjk;
go

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--

-- Add INSERT Genre

INSERT INTO [dbo].[Genre]
 ([description])
 VALUES
	 ('Jazz')
	,('Pop')
	,('Rock')
	,('Metal')
	,('Country')
GO

-- Add INSERT INTO  ArtistType table

INSERT INTO [dbo].[artist_type]
 ([description])
 VALUES
	 ('Solo')
	,('Group')
GO

-- Add INSERT INTO DiskType table
INSERT INTO [dbo].[disk_type]
 ([description])
 VALUES
	 ('CD')
	,('Blu-ray')
	,('Vinyl')
	,('Cassette')
	,('DVD')
GO

-- Add INSERT INTO Status table
INSERT INTO [dbo].[Status]
 ([description])
 VALUES
	 ('Available')
	,('On loan')
	,('Damage')
	,('Missing')
GO

-- Add INSERT INTO Borrower table
INSERT INTO [dbo].[borrower]
 ([fname]
 ,[lname]
 ,[phone_num])
 VALUES
	 ('Lisa','Bass','12121212121')
	,('Kaila','Hinton','2333223222')
	,('Nabeel','Hodson','3343353363')
	,('Janae','Blair','4445474844')
	,('Murray','Bonner','55055055055')
	,('Ricky','Kennedy','6665568906')
	,('Shivani','Abbott','7076677676')
	,('Joyce','Ritter','8848484884')
	,('Aviana','Hart','91991991919')
	,('Kaelan','Parrish','1212121212')
	,('Tre Bo','Farrington','2121212121')
	,('Mehdi','Byrne','232323223')
	,('Tyra','Hughes','6363636363')
	,('Louisa','Whitley','5454545454')
	,('Gladys','Sanders','78787878')
	,('Nell','Carter','2525252525')
	,('Beau','Haynes','525252525')
	,('Layla','Steele','959595959')
	,('Sumaiya','Bennett','75757575745')
	,('Leland','Alcock','4545454545')
GO

--Add DELETE to delete the record where the borrower_id is 20
DELETE borrower
WHERE borrower_id = 20;


-- Add INSERT INTO Artist table
INSERT INTO [dbo].[artist]
 ([fname]
 ,[lname]
 ,[artist_type_id])
 VALUES
     ('Hope', 'Rowe', 1)
    ,('Louise', 'Rankin', 1)
	,('Kayne', NULL, 2)
	,('Kimora', NULL, 2)
	,('Beverly', NULL, 2)
	,('Gregor', 'Wang', 1)
	,('Shah', 'Ramos', 1)
	,('Emelie', NULL, 2)
	,('Christy', NULL, 2)
	,('Vernon', NULL, 2)
	,('Curtis', NULL, 2)
	,('Aya', 'Stephens', 1)
	,('Zuzanna', NULL, 2)
	,('Kiana', NULL, 2)
	,('Virginia', 'Banks', 1)
	,('Guto', NULL, 2)
	,('Rayyan', NULL, 1)
	,('Miles', NULL, 1)
	,('Leonard', 'Proctor', 1)
	,('Moss', NULL, 2)
GO

-- Add INSERT INTO Disk table
INSERT INTO [dbo].[disk]
	 ([disk_name]
	 ,[realse_date]
	 ,[genre_id]
	 ,[status_id]
	 ,[disk_type_id])
 VALUES
	  ('Stamp', '12/1/1998',1,2,1)
	 ,('Guerra', '9/1/2000',1,1,2)
	 ,('Yoder', '12/12/2000',2,1,3)
	 ,('Whitworth', '7/11/1998',3,1,4)
	 ,('Vaughan', '6/11/1998',1,1,4)
	 ,('Reader', '1/1/1980',3,1,5)
	 ,('Trujillo', '1/1/1981',1,1,3)
	 ,('Myers', '1/1/1982',5,1,3)
	 ,('Portillo', '1/1/1983',1,1,1)
	 ,('Bowden', '1/1/1984',1,1,1)
	 ,('Pena', '1/1/1985',1,1,1)
	 ,('Christian', '1/1/1986',1,1,3)
	 ,('Barron', '1/1/1987',1,2,1)
	 ,('Ortiz', '1/1/1988',1,1,1)
	 ,('Mcgregor', '1/1/1989',3,1,2)
	 ,('Simon', '1/1/1990',4,1,3)
	 ,('Millington', '1/1/1992',1,3,2)
	 ,('Davidson', '1/1/1993',4,1,1)
	 ,('Watts', '1/1/1998',4,3,5)
	 ,('Fitzgerald', '1/1/1997',1,4,1)
GO

-- Add UPDATE disk_release_date where the disk_id is 20
UPDATE disk
SET realse_date = '7/11/2019'
WHERE disk_id = 20


-- Add INSERT INTO diskHasBorrower table
INSERT INTO [dbo].[diskHasborrower]
	 ([borrower_id]
	 ,[disk_id]
	 ,[borrowed_date]
	 ,[returned_date])

 VALUES
	  (3,5, '1/12/2018','1/21/2018')
	 ,(2,4, '1/9/2015','1/15/2015')
	 ,(3,6, '12/7/2012', NULL)
	 ,(2,7, '7/7/2007','7/20/2007')
	 ,(5,8, '9/2/2012','9/3/2012')
	 ,(5,7, '5/2/2013','5/13/2013')
	 ,(4,8, '3/7-2014', NULL)
	 ,(11,14, '12/12/2011','12/13/2011')
	 ,(12,13, '11/11-2007',NULL)
	 ,(13,15, '10/12/2017','12/20/2018')
	 ,(14,11, '1/12/2017',NULL)
	 ,(15,10, '12/12/2018','2/22/2019')
	 ,(15,12, '5/12/2016',NULL)
	 ,(8,8, '8/25/2016','9/29/2016')
	 ,(9,4, '5/25/2016',NULL)
	 ,(10,9, '6/29/2015',NULL)
	 ,(4,3, '1/21/2011','2/27/2018')
	 ,(5,8, '8/22/2014',NULL)
	 ,(7,4, '9/1/2018',NULL)
	 ,(7,9, '2/2/2011','7/1/2011')
GO


-- Add INSERT INTO diskHasArtist table
INSERT INTO [dbo].[diskHasArtist]
 ([disk_id]
 ,[artist_id])
 VALUES
	  (1,4)
	 ,(1,1)
	 ,(7,3)
	 ,(1,4)
	 ,(5,6)
	 ,(2,4)
	 ,(6,9)
	 ,(4,8)
	 ,(1,11)
	 ,(5,2)
	 ,(7,11)
	 ,(10,12)
	 ,(11,2)
	 ,(6,12)
	 ,(9,12)
	 ,(12,14)
	 ,(9,12)
	 ,(12,4)
	 ,(18,11)
	 ,(13,15)

GO


--List NULL values from diskHasborrower
SELECT borrower_id, disk_id, borrowed_date, returned_date
FROM diskHasborrower
WHERE returned_date is NULL;