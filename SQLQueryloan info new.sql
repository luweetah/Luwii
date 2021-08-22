USE [UNIONBANK]
GO

/****** Object:  Schema [Loan]    Script Date: 8/17/2021 6:01:48 PM ******/
CREATE SCHEMA [Loan]
GO


create table Loansetupinformation (Loansetupinformation_isSurrogatekey int not null,
LoanNumber varchar (10)  not null,
PurchaseAmount numeric (18, 2) not null,
PurchaseDate datetime not null,
LoanTerm int not  null,
BorrowerID int not  null,
UnderwriterID int not null,
ProductID char (2) not null,
interestRate decimal (3, 2)  not null,
PaymentFrequency Int  not null,
AppraisalValue numeric (18, 2) not null,
CreateDate datetime  not null,
LTV decimal (4, 2)not null,
FirstInterestPaymentDate datetime null,
MaturityDate datetime  not null);

Alter Table Loansetupinformation
Add Constraint CHK_Loansetupinformation_LoanTerm CHECK ((LoanTerm =35) or (LoanTerm =30) or( LoanTerm =15) or LoanTerm =10));
GO

Alter Table Loansetupinformation
Add Constraint CHK_Loansetupinformation_InterestRate CHECK (InterestRate BETWEEN 0.01 AND 0.30);


Alter Table Loansetupinformation
Add constraint Loansetupinformation_CreateDate Default (GetDate()) FOR Createdate;
Go

Alter Table Loansetupinformation
Add Constraint FT_BorrowerID
FOREIGN KEY (BorrowerID) REFERENCES BorrowerTable (BorrowerID);


Alter Table Loansetupinformation
Add Constraint FT_PaymentFrequency
FOREIGN KEY (PaymentFrequency) references LU_PaymentFrequency (PaymentFrequency);

Alter Table Loansetupinformation
Add Constraint FT_UnderwriterID
FOREIGN KEY (UnderwriterID) references Underwriter (UnderwriterID);


Alter Table Loansetupinformation
Add constraint PK_Loansetupinformation_LoanNumber PRIMARY KEY (LoanNumber);



create table Loanperiodic (LoanperiodicTable_isSurrogatekey int not null,
LoanNumber varchar (10)  not null,
Cycledate datetime not  null,
Extramonthlypayment numeric (18, 2) not null,
Unpaidprincipalbalance numeric (18, 2) not null,
Beginningschedulebalance numeric (18, 2) not null,
Paidinstallment numeric (18, 2) not null,
Interestportion numeric (18, 2)  not null,
Principalportion numeric (18, 2) not null,
Endschedulebalance numeric (18, 2) not null,
Actualendschedule numeric (18, 2) not null,
Totalintrestaccured numeric (18, 2) not null,
Totalprincipalaccured numeric (18, 2) not null,
Defaultpenalty numeric (18, 2) not null,
Delinquencycode int  not null,
Createdate datetime not  null);


Alter table Loanperiodic
Add Constraint CHK_Loanperiodic_Interestportion_Principalportion CHECK (PaidInstallment = (Interestportion+Principalportion));

Alter Table LoanPeriodic
Add Constraint CHK_LoanPeriodic_CreateDate Default (Getdate()) FOR CreateDate
GO

Alter Table Loanperiodic 
Add Constraint CHK_LoanPeriodic_Extramountpayment Default (0) FOR Extramonthlypayment;
GO 

Alter Table Loanperiodic
Add constraint FK_LoanNumber
FOREIGN KEY (Loannumber) References LoanSetupinformation (LoanNumber);
Go


Alter Table  Loanperiodic
Add Constraint FK_DelinquencyCode
FOREIGN KEY (DelinquencyCode) References LU_Delinquencycode ( LU_Delinquency_DelinquencyCode);
Go

Alter Table Loanperiodic
Add Constraint PK_Loanperiodic_LoanNumber_Cycledate PRIMARY KEY(LoanNumber, Cycledate);


Create table  LU_Delinquencycode (LU_Delinquency_DelinquencyCode int not null,
Delinquency varchar (255)  not null);

 
Alter Table LU_Delinquencycode
Add Constraint PK_LU_Deliquency_Deliquencycode PRIMARY KEY (Deliquencycode);
GO


Create table LU_PaymentFrequency (LU_PaymentFrequency_PaymentFrequency int not null,
 PaymentIsMadeEvery int  not null,
 PaymentFrequency_Description varchar (255) null);


Alter Table LU_PaymentFrequency
Add Constraint PK_LU_PaymentFrequency_PaymentFrequency PRIMARY KEY(PaymentFrequency);
GO

Create Table Underwriter (Underwriter_UnderwriterID int not null,
 UnderwriterFirstName varchar (255)  null,
 UnderwriterMiddleInitial char (1)  null,
 UnderwriterLastName varchar (255) not null,
 PhoneNumber varchar (14)  null,
 Email varchar (255) not null,
 CreateDate datetime not null);


 Alter table Underwriter
 Add Constraint CHK_Underwiter_Email CHECK (Email like '@');
 GO


Alter table Underwriter
Add Constraint CHK_UnderwriterID_CreateDate Default (Getdate()) For CreateDate;
GO


Alter Table Underwriter
Add Constraint PK_Underwriter_UnderwriterID PRIMARY KEY(UnderwriterID);
GO