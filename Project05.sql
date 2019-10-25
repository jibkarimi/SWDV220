/*******************************************************************/
/*	JIB Karimi													   */
/*	10/25/19													   */
/*	Project 05													   */
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
	release_date		date not null,
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
	 ,[release_date]
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
SET release_date = '7/11/2019'
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




--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--



--3. Show the disks in your database and any associated Individual artists only. Sort by Artist Last Name, First Name & Disk Name.

select disk_name as 'Disk Name', convert(varchar(10), release_date, 101) as 'Release Date', 
	fname as 'Artist First Name', lname as 'Artist last Name'
from disk
join diskHasArtist on disk.disk_id = diskHasArtist.disk_id
join artist on artist.artist_id = diskHasArtist.artist_id
where artist_type_id = 1
order by lname, fname, disk_name;


--4. Create a view called View_Individual_Artist that shows the artists’ names and not group names. Include the artist id in the view definition but do not display the id in your output.

drop view if exists View_Individual_Artist;
go 

--Create a view called View_Individual_Artist that shows the artists’ names and not group names.
create view View_Individual_Artist as
select artist_id, fname,lname
from artist
where artist_type_id = 1
go

select fname as Firstname, lname as LastName
from View_Individual_Artist;


--5. Show the disks in your database and any associated Group artists only. Use the View_Individual_Artist view. Sort by Group Name & Disk Name.

--disks in database and any associated Group artists.
select disk_name as 'Disk Name', convert(varchar(10), release_date, 101) as 'Release Date', 
	fname as 'Group Name'
from disk
join diskHasArtist on disk.disk_id = diskHasArtist.disk_id
join artist on artist.artist_id = diskHasArtist.artist_id
where artist.artist_id not in 
		(select artist_id from View_Individual_Artist)

--Sort by Group Name & Disk Name
order by fname, disk_name;


--6. Show which disks have been borrowed and who borrowed them. Sort by Borrower’s Last Name, then First Name, then Disk Name, then Borrowed Date, then Returned Date.

--disks have been borrowed and who borrowed them
select fname as Frist, lname as Last, disk_name as 'Disk Name', 
	CONVERT(varchar(10), borrowed_date, 120) as 'Borrowed Date',
	CONVERT(varchar(10), returned_date, 120) as 'Returned Date'
from borrower
join diskHasborrower on borrower.borrower_id = diskHasborrower.borrower_id
join disk on disk.disk_id = diskHasborrower.disk_id

--Sort by Borrower’s Last Name, then First Name, then Disk Name, then Borrowed Date, then Returned Date.
order by lname, fname, disk_name, borrowed_date, returned_date;




--7. n disk_id order, show the number of times each disk has been borrowed.

--number of times each disk has been borrowed
select disk.disk_id as DiskId, disk_name as 'Disk Name', count(*) as 'Times Borrowed'
from disk
join diskHasborrower on disk .disk_id = diskHasborrower.disk_id
group by disk.disk_id, disk_name
--Sort by disk_id
order by disk.disk_id;



--8. Show the disks outstanding or on-loan and who has each disk. Sort by disk name.

select disk_name as 'Disk Name', 
	CONVERT(varchar(10), borrowed_date, 120) as 'Borrowed Date',
	CONVERT(varchar(10), returned_date, 120) as 'Returned Date', lname as 'Last Name'
from disk
join diskHasborrower on disk.disk_id = diskHasborrower.disk_id
join borrower on borrower.borrower_id = diskHasborrower.borrower_id
where returned_date is null
--Sort by disk name
order by disk_name;



--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--



--Project 5

--Create Insert, Update, and Delete stored procedures for the artist table. Update procedure accepts a primary key value and the artist’s names for update. Insert accepts all columns as input parameters except for identity fields. Delete accepts a primary key value for delete.
--Script file includes all required ‘GO’ statements.
--Stored procedures/execs contain error processing (try-catch).
--Script file includes all execute statements needed to invoke each stored procedure.



USE disk_inventoryjk
GO
--Drop if sp_InsArtist exists
DROP PROC IF EXISTS sp_InsArtist;
GO

CREATE PROC sp_InsArtist
	@fname nvarchar(100),
	@artist_type_id int,
	@lname nvarchar(100) = NULL
AS
BEGIN TRY
	INSERT INTO [dbo].[artist]
           ([fname]
           ,[lname]
           ,[artist_type_id])
     VALUES
          	(@fname,
			 @lname,
			 @artist_type_id)
END TRY

BEGIN CATCH
--error message
  PRINT 'An error occurd. Row was inserted. '
  PRINT 'Error number: '+
   CONVERT(varchar(100), ERROR_NUMBER());
  PRINT 'Error number: '+
   CONVERT(varchar(100), ERROR_MESSAGE());
END CATCH

EXEC sp_InsArtist 'Bruno', 1, 'Marssssss'
EXEC sp_InsArtist 'Cherrrrrr', 1
EXEC sp_InsArtist 'Cherrrrrrr', null



select * 
from artist



--Drop if sp_UpdArtist exists
DROP PROC IF EXISTS sp_UpdArtist;
GO 

CREATE PROC sp_UpdArtist
	@artist_id int,
	@fname nvarchar(100),
	@artist_type_id int,
	@lname nvarchar(100) = NULL
AS
BEGIN TRY 
			UPDATE  [dbo].[artist]
			SET		[fname] = @fname
				   ,[artist_type_id] = @artist_type_id
				   ,[lname] = @lname
		    where   artist_id = @artist_id;
END TRY
BEGIN CATCH
--error message
	  PRINT 'An error occurd. Row was inserted.';
	  PRINT 'Error number: '+
		CONVERT(varchar(100), ERROR_NUMBER());
	  PRINT 'Error number: '+
		CONVERT(varchar(100), ERROR_MESSAGE());
END CATCH

-- Execute insert data 
EXEC sp_UpdArtist 25, 'Bruno', 1, 'Mars'
EXEC sp_UpdArtist 24, 'Cherrrrrr', 1
EXEC sp_UpdArtist 24, 'Cherrrrrrr', null


--Drop if sp_DelArtis exist
DROP PROC IF EXISTS sp_DelArtist;
GO

--Create sp_DelArtist
CREATE PROC sp_DelArtist
	@artist_id int
AS

--TRY and CATCH 
BEGIN TRY
	 DELETE FROM [dbo].[Artist]
	 WHERE artist_id = @artist_id
END TRY
BEGIN CATCH
--error message
			PRINT 'An error occurd. Row was inserted. '
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_NUMBER());
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_MESSAGE());
END CATCH
GO

EXEC sp_DelArtist 28
EXEC sp_DelArtist NULL
GO



--Drop if sp_InsBorrower exist
DROP PROC IF EXISTS sp_InsBorrower;
GO

--Create sp_InsBorrower
CREATE PROC sp_InsBorrower
	@fname nvarchar(100),
	@phone_num nvarchar(50),
	@lname nvarchar(100) 
AS
--TRY and CATCH
BEGIN TRY

INSERT INTO [dbo].[Borrower]
           ([fname]
           ,[lname]
           ,[phone_num])
     VALUES
	        (@fname,
			 @lname,
			 @phone_num)
END TRY
BEGIN CATCH
--error message
			PRINT 'An error occurd. Row was inserted. '
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_NUMBER());
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_MESSAGE());
END CATCH
GO

-- Execute insert data 
EXEC  sp_InsBorrower 'JIB', 1234567899999,  'Boise'
EXEC  sp_InsBorrower 'Karimi', 1123123, NULL 
EXEC  sp_InsBorrower '$%#', NULL
GO


SELECT * 
FROM Borrower
GO

--Drop if sp_UpdBorrower exist
DROP PROC IF EXISTS sp_UpdBorrower;
GO

--Create sp_UpdBorrower
CREATE PROC sp_UpdBorrower
--Parameters
	@borrower_id int,
	@fname nvarchar(100),
	@phone_num nvarchar(50),
	@lname nvarchar(100) 
	
AS
--TRY and CATCH
BEGIN TRY
	UPDATE [dbo].[borrower]
	   SET [fname] = @fname
		  ,[lname] = @lname
		  ,[phone_num] = @phone_num
	 WHERE borrower_id = @borrower_id

END TRY
BEGIN CATCH
--error message 
			PRINT 'An error occurd. Row was inserted. '
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_NUMBER());
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_MESSAGE());
		END CATCH
GO

--Execute update data
EXEC sp_UpdBorrower 19, 'Joe', 'Qurbanii', 123564654
EXEC sp_UpdBorrower 21, 'Jack',987654321, NULL 
EXEC sp_UpdBorrower 21, 'Robin', NULL		  
GO



--Drop if sp_DelBorrower exist
DROP PROC IF EXISTS sp_DelBorrower;
GO

--Create sp_DelBorrower
CREATE PROC sp_DelBorrower
	@borrower_id int
AS
--TRY and CATCH
 
BEGIN TRY
	DELETE FROM [dbo].[borrower]
	 WHERE borrower_id = @borrower_id

END TRY
BEGIN CATCH
--error message
			PRINT 'An error occurd. Row was inserted. '
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_NUMBER());
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_MESSAGE());
END CATCH
GO

-- Execute delete data
EXEC sp_DelBorrower 21
EXEC sp_DelBorrower NULL  
GO

--Drop if sp_InsDisk exist
DROP PROC IF EXISTS sp_InsDisk;
GO

--Create sp_InsDisk
CREATE PROC sp_InsDisk
--Parameters
			    @disk_name nvarchar(100)
			   ,@release_date date
			   ,@genre_id int
			   ,@status_id int
			   ,@disk_type_id int
AS
--TRY and CATCH 
BEGIN TRY
	INSERT INTO [dbo].[disk]
			   ([disk_name]
			   ,[release_date]
			   ,[genre_id]
			   ,[status_id]
			   ,[disk_type_id])
		 VALUES
			    (@disk_name
			   ,@release_date
			   ,@genre_id
			   ,@status_id
			   ,@disk_type_id)
END TRY
BEGIN CATCH
--error message
			PRINT 'An error occurd. Row was inserted. '
			PRINT 'Error number: '+
			--returns the number of the error
				CONVERT(varchar(100), ERROR_NUMBER());
			PRINT 'Error number: '+
			--returns the complete text of the error message
				CONVERT(varchar(100), ERROR_MESSAGE());
END CATCH
GO

--Execute insert data 
EXEC  sp_InsDisk 'disk1', '01/01/2018', 1,2,3
EXEC  sp_InsDisk 'disk4', NULL, 3,2,1 
EXEC  sp_InsDisk 'disk4', NULL		  
GO

SELECT * 
FROM Disk
GO


--Drop if sp_UpdDisk exist
DROP PROC IF EXISTS sp_UpdDisk;
GO

--Create sp_UpdDisk
CREATE PROC sp_UpdDisk
		  @disk_id int
		 ,@disk_name nvarchar(100)
		 ,@release_date date
		 ,@genre_id int
		 ,@status_id int
		 ,@disk_type_id int
AS
--TRY and CATCH
BEGIN TRY
	UPDATE [dbo].[disk]
	   SET [disk_name] = @disk_name
		  ,[release_date] = @release_date 
		  ,[genre_id] = @genre_id
		  ,[status_id] = @status_id
		  ,[disk_type_id] = @disk_type_id
	WHERE disk_id = @disk_id
END TRY
BEGIN CATCH
--error message
			PRINT 'An error occurd. Row was inserted. '
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_NUMBER());
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_MESSAGE());
END CATCH
GO

--Execute statement
EXEC sp_UpdDisk 23, 'disk4', '01/01/2015', 1,2,3
EXEC sp_UpdDisk 23, 'tim',NULL, 3,2,1			
EXEC sp_UpdDisk 23, 'sccot', '01-10-2012',2 ,2 
GO



--Drop if sp_DelDisk exist
DROP PROC IF EXISTS sp_DelDisk;
GO

--Create sp_DelDisk
CREATE PROC sp_DelDisk
	@disk_id int
AS

--TRY and CATCH
BEGIN TRY
	DELETE FROM [dbo].[disk]
	 WHERE disk_id = @disk_id

END TRY
BEGIN CATCH
--error message
			PRINT 'An error occurd. Row was inserted. '
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_NUMBER());
			PRINT 'Error number: '+
				CONVERT(varchar(100), ERROR_MESSAGE());
		END CATCH
GO

-- Execute delete data 
EXEC sp_DelDisk 19
EXEC sp_DelDisk NULL
GO

