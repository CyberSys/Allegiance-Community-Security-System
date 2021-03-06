USE CSSStats
GO 

/*
   Thursday, December 23, 20103:53:21 PM
   User: 
   Server: localhost
   Database: CSSStats
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
EXECUTE sp_rename N'dbo.GameEvent.GameEventPerformerCallsignID', N'Tmp_GameEventPerformerLoginID_8', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.GameEvent.GameEventTargetMemberID', N'Tmp_GameEventTargetLoginID_9', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.GameEvent.Tmp_GameEventPerformerLoginID_8', N'GameEventPerformerLoginID', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.GameEvent.Tmp_GameEventTargetLoginID_9', N'GameEventTargetLoginID', 'COLUMN' 
GO
ALTER TABLE dbo.GameEvent SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
EXECUTE sp_rename N'dbo.GameTeam.GameTeamCommanderCallsignID', N'Tmp_GameTeamCommanderLoginID_10', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.GameTeam.Tmp_GameTeamCommanderLoginID_10', N'GameTeamCommanderLoginID', 'COLUMN' 
GO
ALTER TABLE dbo.GameTeam SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
EXECUTE sp_rename N'dbo.GameTeamMember.GameTeamMemeberID', N'Tmp_GameTeamMemeberLoginID_11', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.GameTeamMember.Tmp_GameTeamMemeberLoginID_11', N'GameTeamMemeberLoginID', 'COLUMN' 
GO
ALTER TABLE dbo.GameTeamMember SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.StatsLeaderboard
	DROP CONSTRAINT DF_StatsLeaderboard_LastUpdated
GO
CREATE TABLE dbo.Tmp_StatsLeaderboard
	(
	StatsLeaderboardId int NOT NULL IDENTITY (1, 1),
	LoginUsername nvarchar(50) NULL,
	LoginID int NOT NULL,
	Mu float(53) NOT NULL,
	Sigma float(53) NOT NULL,
	Rank float(53) NOT NULL,
	Wins int NOT NULL,
	Losses int NOT NULL,
	Draws int NOT NULL,
	Defects int NOT NULL,
	StackRating float(53) NOT NULL,
	CommandMu float(53) NOT NULL,
	CommandSigma float(53) NOT NULL,
	CommandRank float(53) NOT NULL,
	CommandWins int NOT NULL,
	CommandLosses int NOT NULL,
	CommandDraws int NOT NULL,
	Kills int NOT NULL,
	Ejects int NOT NULL,
	DroneKills int NOT NULL,
	StationKills int NOT NULL,
	StationCaptures int NOT NULL,
	HoursPlayed float(53) NOT NULL,
	DateModified datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_StatsLeaderboard SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_StatsLeaderboard ADD CONSTRAINT
	DF_StatsLeaderboard_LoginID DEFAULT 0 FOR LoginID
GO
ALTER TABLE dbo.Tmp_StatsLeaderboard ADD CONSTRAINT
	DF_StatsLeaderboard_LastUpdated DEFAULT (getdate()) FOR DateModified
GO
SET IDENTITY_INSERT dbo.Tmp_StatsLeaderboard ON
GO
IF EXISTS(SELECT * FROM dbo.StatsLeaderboard)
	 EXEC('INSERT INTO dbo.Tmp_StatsLeaderboard (StatsLeaderboardId, LoginUsername, Mu, Sigma, Rank, Wins, Losses, Draws, Defects, StackRating, CommandMu, CommandSigma, CommandRank, CommandWins, CommandLosses, CommandDraws, Kills, Ejects, DroneKills, StationKills, StationCaptures, HoursPlayed, DateModified)
		SELECT StatsLeaderboardId, LoginUsername, Mu, Sigma, Rank, Wins, Losses, Draws, Defects, StackRating, CommandMu, CommandSigma, CommandRank, CommandWins, CommandLosses, CommandDraws, Kills, Ejects, DroneKills, StationKills, StationCaptures, HoursPlayed, DateModified FROM dbo.StatsLeaderboard WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_StatsLeaderboard OFF
GO
--ALTER TABLE dbo.AS_AllegSkill
--	DROP CONSTRAINT FK__AS_AllegS__Membe__52593CB8
--GO
--ALTER TABLE dbo.AS_GamePlayerAS
--	DROP CONSTRAINT FK__AS_GamePl__Membe__66603565
--GO
DROP TABLE dbo.StatsLeaderboard
GO
EXECUTE sp_rename N'dbo.Tmp_StatsLeaderboard', N'StatsLeaderboard', 'OBJECT' 
GO
ALTER TABLE dbo.StatsLeaderboard ADD CONSTRAINT
	PK_StatsLeaderboard PRIMARY KEY CLUSTERED 
	(
	StatsLeaderboardId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.AS_GamePlayerAS ADD CONSTRAINT
	FK__AS_GamePl__Membe__66603565 FOREIGN KEY
	(
	Member_ID
	) REFERENCES dbo.StatsLeaderboard
	(
	StatsLeaderboardId
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.AS_GamePlayerAS SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.AS_AllegSkill ADD CONSTRAINT
	FK__AS_AllegS__Membe__52593CB8 FOREIGN KEY
	(
	Member_ID
	) REFERENCES dbo.StatsLeaderboard
	(
	StatsLeaderboardId
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.AS_AllegSkill SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
