/*
   Friday, May 21, 20104:18:11 PM
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
CREATE TABLE dbo.LinkedItem
	(
	Id int NOT NULL IDENTITY (1, 1),
	LinkedItemTypeId int NOT NULL,
	LinkId int NOT NULL,
	TargetId int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.LinkedItem ADD CONSTRAINT
	PK_LinkedItem PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.LinkedItem SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
