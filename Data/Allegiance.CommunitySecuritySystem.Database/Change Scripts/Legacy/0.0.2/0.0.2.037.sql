/*
   Friday, May 21, 20104:47:30 PM
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
ALTER TABLE dbo.LinkedItem
	DROP CONSTRAINT FK_LinkedItem_LinkedItemType
GO
ALTER TABLE dbo.LinkedItemType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.LinkedItem
	DROP CONSTRAINT FK_LinkedItem_Link
GO
ALTER TABLE dbo.Link SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_LinkedItem
	(
	Id int NOT NULL IDENTITY (1, 1),
	LinkedItemTypeId int NOT NULL,
	LinkId int NOT NULL,
	TargetId bigint NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_LinkedItem SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_LinkedItem ON
GO
IF EXISTS(SELECT * FROM dbo.LinkedItem)
	 EXEC('INSERT INTO dbo.Tmp_LinkedItem (Id, LinkedItemTypeId, LinkId, TargetId)
		SELECT Id, LinkedItemTypeId, LinkId, CONVERT(bigint, TargetId) FROM dbo.LinkedItem WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_LinkedItem OFF
GO
DROP TABLE dbo.LinkedItem
GO
EXECUTE sp_rename N'dbo.Tmp_LinkedItem', N'LinkedItem', 'OBJECT' 
GO
ALTER TABLE dbo.LinkedItem ADD CONSTRAINT
	PK_LinkedItem PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.LinkedItem ADD CONSTRAINT
	FK_LinkedItem_Link FOREIGN KEY
	(
	LinkId
	) REFERENCES dbo.Link
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.LinkedItem ADD CONSTRAINT
	FK_LinkedItem_LinkedItemType FOREIGN KEY
	(
	LinkedItemTypeId
	) REFERENCES dbo.LinkedItemType
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
