USE CSSStats
GO


/*
   Friday, April 02, 201010:22:45 AM
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
CREATE TABLE dbo.GameEventType
	(
	GameEventTypeID int NOT NULL IDENTITY (1, 1),
	GameEventID int NOT NULL,
	GameEventCode varchar(50) NOT NULL,
	GameEventDesc varchar(255) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.GameEventType ADD CONSTRAINT
	PK_GameEventType PRIMARY KEY CLUSTERED 
	(
	GameEventTypeID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.GameEventType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.GameEventType', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.GameEventType', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.GameEventType', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.GameServer
	(
	GameServerID int NOT NULL IDENTITY (1, 1),
	GameServerName varchar(255) NOT NULL,
	GameServerOwnerName varchar(255) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.GameServer ADD CONSTRAINT
	PK_GameServer PRIMARY KEY CLUSTERED 
	(
	GameServerID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.GameServer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.GameServer', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.GameServer', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.GameServer', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Game
	(
	GameIdentID int NOT NULL IDENTITY (1, 1),
	GameID int NOT NULL,
	GameServer int NOT NULL,
	GameName varchar(255) NOT NULL,
	GameCore varchar(50) NOT NULL,
	GameMap varchar(50) NOT NULL,
	GameSquadGame bit NOT NULL,
	GameConquest bit NOT NULL,
	GameDeathMatch bit NOT NULL,
	GameDeathmatchGoal int NULL,
	GameFriendlyFire bit NOT NULL,
	GameRevealMap bit NULL,
	GameDevelopments bit NOT NULL,
	GameShipyards bit NOT NULL,
	GameDefections bit NOT NULL,
	GameInvulStations bit NOT NULL,
	GameStatsCount bit NOT NULL,
	GameMaxImbalance int NOT NULL,
	GameStartingMoney float(53) NOT NULL,
	GameTotalMoney float(53) NOT NULL,
	GameResources int NOT NULL,
	GameStartTime datetime NOT NULL,
	GameEndTime datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Game SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_Game OFF
GO
IF EXISTS(SELECT * FROM dbo.Game)
	 EXEC('INSERT INTO dbo.Tmp_Game (GameID, GameName, GameCore, GameMap, GameSquadGame, GameConquest, GameDeathMatch, GameDeathmatchGoal, GameFriendlyFire, GameRevealMap, GameDevelopments, GameShipyards, GameDefections, GameInvulStations, GameStatsCount, GameMaxImbalance, GameStartingMoney, GameTotalMoney, GameResources, GameStartTime, GameEndTime)
		SELECT GameId, GameName, CoreFile, MapName, SquadGame, Conquest, DeathMatch, DeathmatchGoal, FriendlyFire, RevealMap, AllowDevelopments, AllowShipyards, AllowDefections, InvulnerableStations, StatsCount, MaxImbalance, StartingMoney, TotalMoney, Resources, StartTime, EndTime FROM dbo.Game WITH (HOLDLOCK TABLOCKX)')
GO
ALTER TABLE dbo.GameEvent
	DROP CONSTRAINT FK_GameEvent_Game
GO
ALTER TABLE dbo.ChatLog
	DROP CONSTRAINT FK_ChatLog_Game
GO
ALTER TABLE dbo.GameTeam
	DROP CONSTRAINT FK_GameTeam_Game
GO
DROP TABLE dbo.Game
GO
EXECUTE sp_rename N'dbo.Tmp_Game', N'Game', 'OBJECT' 
GO
ALTER TABLE dbo.Game ADD CONSTRAINT
	PK_Game PRIMARY KEY CLUSTERED 
	(
	GameIdentID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Game ADD CONSTRAINT
	FK_Game_GameServer FOREIGN KEY
	(
	GameServer
	) REFERENCES dbo.GameServer
	(
	GameServerID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Game', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Game', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Game', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.GameTeam ADD CONSTRAINT
	FK_GameTeam_Game FOREIGN KEY
	(
	GameID
	) REFERENCES dbo.Game
	(
	GameIdentID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.GameTeam SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.GameTeam', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.GameTeam', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.GameTeam', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_ChatLog
	(
	GameChatLogIdentID int NOT NULL IDENTITY (1, 1),
	GameID int NOT NULL,
	GameChatTime datetime NOT NULL,
	GameChatSpeakerName varchar(50) NOT NULL,
	GameChatTargetName varchar(50) NOT NULL,
	GameChatText varchar(2064) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_ChatLog SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_ChatLog OFF
GO
IF EXISTS(SELECT * FROM dbo.ChatLog)
	 EXEC('INSERT INTO dbo.Tmp_ChatLog (GameID, GameChatTime, GameChatSpeakerName, GameChatTargetName, GameChatText)
		SELECT GameId, ChatTime, SpeakerName, TargetName, Text FROM dbo.ChatLog WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.ChatLog
GO
EXECUTE sp_rename N'dbo.Tmp_ChatLog', N'ChatLog', 'OBJECT' 
GO
ALTER TABLE dbo.ChatLog ADD CONSTRAINT
	PK_ChatLog PRIMARY KEY CLUSTERED 
	(
	GameChatLogIdentID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.ChatLog ADD CONSTRAINT
	FK_ChatLog_Game1 FOREIGN KEY
	(
	GameID
	) REFERENCES dbo.Game
	(
	GameIdentID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.ChatLog', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.ChatLog', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.ChatLog', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_GameEvent
	(
	GameID int NOT NULL,
	GameEventID int NOT NULL IDENTITY (1, 1),
	EventID int NOT NULL,
	GameEventTime datetime NOT NULL,
	GameEventPerformerID int NOT NULL,
	GameEventPerformerCallsignID int NOT NULL,
	GameEventPerformerName varchar(50) NOT NULL,
	GameEventTargetID int NOT NULL,
	GameEventTargetMemberID int NOT NULL,
	GameEventTargetName varchar(50) NOT NULL,
	GameEventIndirectID int NOT NULL,
	GameEventIndirectName varchar(50) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_GameEvent SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_GameEvent ON
GO
IF EXISTS(SELECT * FROM dbo.GameEvent)
	 EXEC('INSERT INTO dbo.Tmp_GameEvent (GameID, GameEventID, GameEventTime, GameEventPerformerID, GameEventPerformerName, GameEventTargetID, GameEventTargetName, GameEventIndirectID, GameEventIndirectName)
		SELECT GameId, EventId, EventTime, PerformerId, PerformerName, TargetId, TargetName, IndirectId, IndirectName FROM dbo.GameEvent WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_GameEvent OFF
GO
DROP TABLE dbo.GameEvent
GO
EXECUTE sp_rename N'dbo.Tmp_GameEvent', N'GameEvent', 'OBJECT' 
GO
ALTER TABLE dbo.GameEvent ADD CONSTRAINT
	PK_GameEvent PRIMARY KEY CLUSTERED 
	(
	GameEventID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.GameEvent ADD CONSTRAINT
	FK_GameEvent_Game1 FOREIGN KEY
	(
	GameID
	) REFERENCES dbo.Game
	(
	GameIdentID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.GameEvent', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.GameEvent', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.GameEvent', 'Object', 'CONTROL') as Contr_Per 