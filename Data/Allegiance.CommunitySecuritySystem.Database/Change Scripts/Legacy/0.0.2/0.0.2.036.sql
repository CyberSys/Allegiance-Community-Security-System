/*
   Friday, May 21, 20104:43:04 PM
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
ALTER TABLE dbo.[Identity] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Link
	DROP CONSTRAINT FK_Link_Login
GO
ALTER TABLE dbo.Login SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
EXECUTE sp_rename N'dbo.Link.LoginId', N'Tmp_IdentityId', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.Link.Tmp_IdentityId', N'IdentityId', 'COLUMN' 
GO
ALTER TABLE dbo.Link ADD CONSTRAINT
	FK_Link_Identity FOREIGN KEY
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
