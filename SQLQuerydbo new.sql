USE [UNIONBANK]
GO

/****** Object:  Schema [dbo]    Script Date: 8/17/2021 6:06:01 PM ******/
CREATE SCHEMA [dbo]
GO


Create Table CalenderTable (calenderTable_calenderDate datetime null);



Create Table USZipCodesTable (UszipcodeTables_IsSurrogateKey int  not null,
Zip varchar (5) not null,
Latitude float null,
Longitude float null,
City varchar (255) null,
State_id char (2) null,
Population int null,
Density decimal (18, 0) null,
County_fips varchar (10) null,
County_name  varchar (255) null,
County_name_all varchar (255) null,
County_fips_all varchar (50) null,
Timezone varchar (255) null,
CreateDate datetime not null);



Create Table State (State_StateID char (2) not null,
StateName varchar (255)  not null,
CreateDate datetime not null);