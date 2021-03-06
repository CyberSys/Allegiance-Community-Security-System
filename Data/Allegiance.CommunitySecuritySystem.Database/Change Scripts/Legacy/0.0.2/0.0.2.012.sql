/*
   Tuesday, February 23, 20109:37:48 AM
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
ALTER TABLE dbo.Login SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Login_UnlinkedLogin ADD CONSTRAINT
	FK_Login_UnlinkedLogin_Login FOREIGN KEY
	(
	LoginId1
	) REFERENCES dbo.Login
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Login_UnlinkedLogin ADD CONSTRAINT
	FK_Login_UnlinkedLogin_Login1 FOREIGN KEY
	(
	LoginId2
	) REFERENCES dbo.Login
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Login_UnlinkedLogin SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
