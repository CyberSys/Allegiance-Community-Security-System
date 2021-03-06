USE CSSStats
GO

/*
   Friday, April 02, 20109:52:16 AM
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
ALTER TABLE dbo.Team
	DROP CONSTRAINT FK_Team_Game
GO
ALTER TABLE dbo.Game SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Game', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Game', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Game', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_GameTeam
	(
	GameTeamIdentID int NOT NULL IDENTITY (1, 1),
	GameTeamID int NOT NULL,
	GameID int NOT NULL,
	GameTeamNumber int NOT NULL,
	GameTeamName varchar(50) NOT NULL,
	GameTeamCommander varchar(50) NOT NULL,
	GameTeamCommanderCallsignID int NOT NULL,
	GameTeamFaction varchar(50) NOT NULL,
	GameTeamStarbase bit NOT NULL,
	GameTeamSupremacy bit NOT NULL,
	GameTeamTactical bit NOT NULL,
	GameTeamExpansion bit NOT NULL,
	GameTeamShipyard bit NOT NULL,
	GameTeamWinner bit NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_GameTeam SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_GameTeam ON
GO
IF EXISTS(SELECT * FROM dbo.Team)
	 EXEC('INSERT INTO dbo.Tmp_GameTeam (GameTeamIdentID, GameID, GameTeamNumber, GameTeamName, GameTeamCommander, GameTeamFaction, GameTeamStarbase, GameTeamSupremacy, GameTeamTactical, GameTeamExpansion, GameTeamShipyard, GameTeamWinner)
		SELECT TeamId, GameId, TeamNumber, TeamName, Commander, Faction, ResearchedStarbase, ResearchedSupremacy, ResearchedTactical, ResearchedExpansion, ResearchedShipyard, Won FROM dbo.Team WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_GameTeam OFF
GO
ALTER TABLE dbo.GameTeamMember
	DROP CONSTRAINT FK_GameTeamMember_Team
GO
DROP TABLE dbo.Team
GO
EXECUTE sp_rename N'dbo.Tmp_GameTeam', N'GameTeam', 'OBJECT' 
GO
ALTER TABLE dbo.GameTeam ADD CONSTRAINT
	PK_GameTeam PRIMARY KEY CLUSTERED 
	(
	GameTeamIdentID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.GameTeam ADD CONSTRAINT
	FK_GameTeam_Game FOREIGN KEY
	(
	GameID
	) REFERENCES dbo.Game
	(
	GameId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.GameTeam', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.GameTeam', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.GameTeam', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
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
ALTER TABLE dbo.GameTeamMember SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.GameTeamMember', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.GameTeamMember', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.GameTeamMember', 'Object', 'CONTROL') as Contr_Per 