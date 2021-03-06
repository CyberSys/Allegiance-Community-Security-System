USE CSSStats
GO 

/*
   Thursday, December 23, 20104:02:22 PM
   User: css_server
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

DELETE StatsLeaderboard
GO 

GO
EXECUTE sp_rename N'dbo.GameTeamMember.GameTeamMemeberCallsign', N'Tmp_GameTeamMemberCallsign_16', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.GameTeamMember.GameTeamMemeberDuration', N'Tmp_GameTeamMemberDuration_17', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.GameTeamMember.GameTeamMemeberLoginID', N'Tmp_GameTeamMemberLoginID_18', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.GameTeamMember.Tmp_GameTeamMemberCallsign_16', N'GameTeamMemberCallsign', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.GameTeamMember.Tmp_GameTeamMemberDuration_17', N'GameTeamMemberDuration', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.GameTeamMember.Tmp_GameTeamMemberLoginID_18', N'GameTeamMemberLoginID', 'COLUMN' 
GO
ALTER TABLE dbo.GameTeamMember SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.AS_GamePlayerAS
	DROP CONSTRAINT FK__AS_GamePl__Membe__66603565
GO
ALTER TABLE dbo.AS_AllegSkill
	DROP CONSTRAINT FK__AS_AllegS__Membe__52593CB8
GO
CREATE UNIQUE NONCLUSTERED INDEX IX_StatsLeaderboard ON dbo.StatsLeaderboard
	(
	LoginID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE dbo.StatsLeaderboard SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
EXECUTE sp_rename N'dbo.AS_AllegSkill.Member_ID', N'Tmp_LoginID_19', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.AS_AllegSkill.Tmp_LoginID_19', N'LoginID', 'COLUMN' 
GO
ALTER TABLE dbo.AS_AllegSkill ADD CONSTRAINT
	FK__AS_AllegS__Membe__52593CB8 FOREIGN KEY
	(
	LoginID
	) REFERENCES dbo.StatsLeaderboard
	(
	LoginID
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.AS_AllegSkill SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
EXECUTE sp_rename N'dbo.AS_GamePlayerAS.Member_ID', N'Tmp_LoginID_20', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.AS_GamePlayerAS.Tmp_LoginID_20', N'LoginID', 'COLUMN' 
GO
ALTER TABLE dbo.AS_GamePlayerAS ADD CONSTRAINT
	FK__AS_GamePl__Membe__66603565 FOREIGN KEY
	(
	LoginID
	) REFERENCES dbo.StatsLeaderboard
	(
	LoginID
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.AS_GamePlayerAS SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
