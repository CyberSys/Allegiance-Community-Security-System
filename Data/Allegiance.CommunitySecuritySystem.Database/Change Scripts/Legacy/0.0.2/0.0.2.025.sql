USE CSSStats
GO

/*
   Friday, April 02, 20102:04:56 PM
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
ALTER TABLE dbo.GameServer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.GameServer', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.GameServer', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.GameServer', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.GameServerIP
	(
	GameServerID int NOT NULL,
	IPAddress varchar(20) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.GameServerIP ADD CONSTRAINT
	FK_GameServerIP_GameServer FOREIGN KEY
	(
	GameServerID
	) REFERENCES dbo.GameServer
	(
	GameServerID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.GameServerIP SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.GameServerIP', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.GameServerIP', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.GameServerIP', 'Object', 'CONTROL') as Contr_Per 