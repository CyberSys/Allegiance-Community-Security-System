USE CSSStats
GO


/*
   Friday, April 02, 201010:23:23 AM
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
ALTER TABLE dbo.ChatLog
	DROP CONSTRAINT FK_ChatLog_Game1
GO
ALTER TABLE dbo.Game SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Game', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Game', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Game', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
EXECUTE sp_rename N'dbo.ChatLog', N'GameChatLog', 'OBJECT' 
GO
ALTER TABLE dbo.GameChatLog
	DROP CONSTRAINT PK_ChatLog
GO
ALTER TABLE dbo.GameChatLog ADD CONSTRAINT
	PK_GameChatLog PRIMARY KEY CLUSTERED 
	(
	GameChatLogIdentID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.GameChatLog ADD CONSTRAINT
	FK_GameChatLog_Game FOREIGN KEY
	(
	GameID
	) REFERENCES dbo.Game
	(
	GameIdentID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.GameChatLog SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.GameChatLog', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.GameChatLog', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.GameChatLog', 'Object', 'CONTROL') as Contr_Per 