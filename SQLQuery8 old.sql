USE [UNIONBANK]
GO

/****** Object:  Schema [Borrower]    Script Date: 8/17/2021 5:57:32 PM ******/
CREATE SCHEMA [Borrower]
GO


Create Table BorrowerTable (BorrowerID int not null,
BorrowerFirstName varchar (255) not null,
BorrowerMiddleInitial char (1) not null,
BorrowerLastName Varchar (255) not  null,
DOB datetime not null,
Gender char (1) null,
TaxPayerID_SSN varchar (9) not  null,
PhoneNumber varchar (10)  not null,
Email varchar (255)  not null,
Citizenship varchar (255) null,
BenefitiaryName varchar (255) null,
isUScitizen bit null,
CreateDate datetime not null);

Alter table BorrowerTable
Add Constraint CHK_Borrower_DOB CHECK (DOB <=DATEADD(YEAR,-18,GETDATE()));
GO

Alter table BorrowerTable
Add Constraint CHK_Borrower_Email CHECK (Email like '@');


Alter table BorrowerTable
Add Constraint CHK_Borrower_PhoneNumber CHECK (LEN(PhoneNumber)=10);
GO 

Alter table BorrowerTable
Add Constraint CHK_Borrower_TaxpayerID_SSN CHECK (LEN(TaxpayerID_SSN)=9);
GO 


Alter table BorrowerTable
Add Constraint CHK_Borrower_CreateDate Default (Getdate()) FOR CreateDate;
Go 


the unique identifier on this table is the primary key BorrowerID



Create Table BorrowerAddress (BorrowerAddress_AddressID int not null,
BorrowerID int not null,
StreetAddress varchar (255) not null,
Zip varchar (5) not null,
CreateDate datetime  not null);


Alter Table BorrowerAddress
Add Constraint CHK_BorrowerAddress_CreateDate Default (Getdate()) FOR Createdate;
GO

Alter table BorrowerAddress
Add Constraint FT_BorrowerID
FOREIGN KEY (BorrowerID) ReferenceS BorrowerTable (BorrowerID)
GO

Alter Table BorrowerAddress
Add Constraint FT_Zip
FOREIGN KEY (ZIP) References US_ZipcodesTable (ZIP);
GO


Alter Table BorrowerAddress
Add Constraint PK_Borrower_BorrowerID Primary KEY (BorrowerID);
GO