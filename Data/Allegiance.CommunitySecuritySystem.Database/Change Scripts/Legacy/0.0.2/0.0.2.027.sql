USE CSSStats
GO


/*
   Friday, April 02, 20104:06:43 PM
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
ALTER TABLE dbo.GameTeamMember
	DROP CONSTRAINT FK_GameTeamMember_GameTeam
GO
ALTER TABLE dbo.GameTeam SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.GameTeam', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.GameTeam', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.GameTeam', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_GameTeamMember
	(
	GameTeamMemberIdentID int NOT NULL IDENTITY (1, 1),
	GameTeamID int NOT NULL,
	GameTeamMemeberCallsign varchar(50) NOT NULL,
	GameTeamMemeberDuration int NOT NULL,
	GameTeamMemeberID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_GameTeamMember SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_GameTeamMember OFF
GO
IF EXISTS(SELECT * FROM dbo.GameTeamMember)
	 EXEC('INSERT INTO dbo.Tmp_GameTeamMember (GameTeamID, GameTeamMemeberCallsign, GameTeamMemeberDuration, GameTeamMemeberID)
		SELECT GameTeamID, GameTeamMemeberCallsign, GameTeamMemeberDuration, GameTeamMemeberID FROM dbo.GameTeamMember WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.GameTeamMember
GO
EXECUTE sp_rename N'dbo.Tmp_GameTeamMember', N'GameTeamMember', 'OBJECT' 
GO
ALTER TABLE dbo.GameTeamMember ADD CONSTRAINT
	PK_GameTeamMember PRIMARY KEY CLUSTERED 
	(
	GameTeamMemberIdentID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.GameTeamMember ADD CONSTRAINT
	FK_GameTeamMember_GameTeam FOREIGN KEY
	(
	GameTeamID
	) REFERENCES dbo.GameTeam
	(
	GameTeamIdentID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.GameTeamMember', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.GameTeamMember', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.GameTeamMember', 'Object', 'CONTROL') as Contr_Per 