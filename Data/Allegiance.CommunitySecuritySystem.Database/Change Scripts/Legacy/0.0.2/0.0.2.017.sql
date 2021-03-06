/*
   Thursday, March 25, 20102:45:28 PM
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
ALTER TABLE dbo.Motd
	DROP CONSTRAINT FK_Motd_Lobby
GO
ALTER TABLE dbo.Lobby SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Motd
	DROP CONSTRAINT DF_Motd_LastUpdated
GO
CREATE TABLE dbo.Tmp_Motd
	(
	Id int NOT NULL IDENTITY (1, 1),
	Logo varchar(50) NOT NULL,
	Banner varchar(50) NOT NULL,
	PrimaryHeading varchar(255) NOT NULL,
	PrimaryText text NOT NULL,
	SecondaryHeading varchar(255) NOT NULL,
	SecondaryText text NOT NULL,
	Details text NOT NULL,
	PaddingCrCount int NOT NULL,
	LastUpdated datetime NOT NULL,
	LobbyId int NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Motd SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_Motd ADD CONSTRAINT
	DF_Motd_LastUpdated DEFAULT (getdate()) FOR LastUpdated
GO
SET IDENTITY_INSERT dbo.Tmp_Motd OFF
GO
IF EXISTS(SELECT * FROM dbo.Motd)
	 EXEC('INSERT INTO dbo.Tmp_Motd (Logo, Banner, PrimaryHeading, PrimaryText, SecondaryHeading, SecondaryText, Details, PaddingCrCount, LastUpdated, LobbyId)
		SELECT Logo, Banner, PrimaryHeading, PrimaryText, SecondaryHeading, SecondaryText, Details, PaddingCrCount, LastUpdated, LobbyId FROM dbo.Motd WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.Motd
GO
EXECUTE sp_rename N'dbo.Tmp_Motd', N'Motd', 'OBJECT' 
GO
ALTER TABLE dbo.Motd ADD CONSTRAINT
	PK_Motd PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Motd ADD CONSTRAINT
	FK_Motd_Lobby FOREIGN KEY
	(
	LobbyId
	) REFERENCES dbo.Lobby
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
