/*
   Wednesday, May 26, 20102:07:31 PM
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
ALTER TABLE dbo.Link
	DROP CONSTRAINT FK_Link_Identity
GO
ALTER TABLE dbo.[Identity] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Link ADD CONSTRAINT
	FK_Link_Identity1 FOREIGN KEY
	(
	IdentityId
	) REFERENCES dbo.[Identity]
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Link SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
