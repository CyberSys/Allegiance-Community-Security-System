/*
   Tuesday, July 27, 20103:53:20 PM
   User: css_server
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
CREATE TABLE dbo.Tmp_BanClass
	(
	Id int NOT NULL,
	Name nvarchar(50) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_BanClass SET (LOCK_ESCALATION = TABLE)
GO
IF EXISTS(SELECT * FROM dbo.BanClass)
	 EXEC('INSERT INTO dbo.Tmp_BanClass (Id, Name)
		SELECT Id, CONVERT(nvarchar(50), Name) FROM dbo.BanClass WITH (HOLDLOCK TABLOCKX)')
GO
ALTER TABLE dbo.BanType
	DROP CONSTRAINT FK_BanType_BanClass
GO
DROP TABLE dbo.BanClass
GO
EXECUTE sp_rename N'dbo.Tmp_BanClass', N'BanClass', 'OBJECT' 
GO
ALTER TABLE dbo.BanClass ADD CONSTRAINT
	PK_BanClass PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BanType ADD CONSTRAINT
	FK_BanType_BanClass FOREIGN KEY
	(
	BanClassId
	) REFERENCES dbo.BanClass
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BanType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
