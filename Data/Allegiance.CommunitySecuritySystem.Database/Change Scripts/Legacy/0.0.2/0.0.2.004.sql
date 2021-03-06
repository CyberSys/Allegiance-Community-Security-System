/*
   Tuesday, February 16, 20108:43:47 AM
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
GO
CREATE TABLE dbo.BanClass
	(
	Id int NOT NULL IDENTITY (1, 1),
	Name nchar(10) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.BanClass ADD CONSTRAINT
	PK_BanClass PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.BanClass SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.BanClass', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.BanClass', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.BanClass', 'Object', 'CONTROL') as Contr_Per 