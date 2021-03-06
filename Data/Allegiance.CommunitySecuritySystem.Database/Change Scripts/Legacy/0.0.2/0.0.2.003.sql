/*
   Tuesday, February 16, 20108:40:24 AM
   User: 
   Server: localhost
   Database: CSS
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.BanType
	(
	Id int NOT NULL IDENTITY (1, 1),
	RocNumber int NULL,
	SrNumber int NULL,
	Description nvarchar(255) NOT NULL,
	BanClassId int NOT NULL,
	BaseTimeInMinutes int NOT NULL,
	InfractionsBeforePermanentBan int NULL
	)  ON [PRIMARY]
GO

ALTER TABLE dbo.BanType ADD CONSTRAINT
	PK_BanType PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.BanType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
