/*
   Tuesday, February 16, 20109:16:59 AM
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
ALTER TABLE dbo.BanType ADD
	IsIncremental bit NOT NULL CONSTRAINT DF_BanType_IsIncremental DEFAULT 0
GO
ALTER TABLE dbo.BanType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.BanType', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.BanType', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.BanType', 'Object', 'CONTROL') as Contr_Per 