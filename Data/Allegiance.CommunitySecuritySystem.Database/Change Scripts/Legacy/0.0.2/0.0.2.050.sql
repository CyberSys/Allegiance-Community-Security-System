/*
   Wednesday, November 24, 20105:02:33 PM
   User: css_server
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
ALTER TABLE dbo.GroupMessage
	DROP CONSTRAINT FK_GroupMessage_Group
GO
ALTER TABLE dbo.[Group] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.GroupMessage
	DROP CONSTRAINT FK_GroupMessage_Alias
GO
ALTER TABLE dbo.Alias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.GroupMessage
	DROP CONSTRAINT DF_GroupMessage_DateCreated
GO
ALTER TABLE dbo.GroupMessage
	DROP CONSTRAINT DF_GroupMessage_DateToSend
GO
CREATE TABLE dbo.Tmp_GroupMessage
	(
	Id int NOT NULL IDENTITY (1, 1),
	Subject nvarchar(50) NOT NULL,
	Message nvarchar(255) NOT NULL,
	GroupId int NULL,
	DateCreated datetime NOT NULL,
	DateToSend datetime NOT NULL,
	DateExpires datetime NULL,
	SenderAliasId int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_GroupMessage SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_GroupMessage ADD CONSTRAINT
	DF_GroupMessage_DateCreated DEFAULT (getdate()) FOR DateCreated
GO
ALTER TABLE dbo.Tmp_GroupMessage ADD CONSTRAINT
	DF_GroupMessage_DateToSend DEFAULT (getdate()) FOR DateToSend
GO
SET IDENTITY_INSERT dbo.Tmp_GroupMessage ON
GO
IF EXISTS(SELECT * FROM dbo.GroupMessage)
	 EXEC('INSERT INTO dbo.Tmp_GroupMessage (Id, Subject, Message, GroupId, DateCreated, DateToSend, DateExpires, SenderAliasId)
		SELECT Id, Subject, Message, GroupId, DateCreated, DateToSend, DateExpires, SenderAliasId FROM dbo.GroupMessage WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_GroupMessage OFF
GO
ALTER TABLE dbo.GroupMessage_Alias
	DROP CONSTRAINT FK_GroupMessage_Alias_GroupMessage
GO
DROP TABLE dbo.GroupMessage
GO
EXECUTE sp_rename N'dbo.Tmp_GroupMessage', N'GroupMessage', 'OBJECT' 
GO
ALTER TABLE dbo.GroupMessage ADD CONSTRAINT
	PK_GroupMessage PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.GroupMessage ADD CONSTRAINT
	FK_GroupMessage_Alias FOREIGN KEY
	(
	SenderAliasId
	) REFERENCES dbo.Alias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.GroupMessage ADD CONSTRAINT
	FK_GroupMessage_Group FOREIGN KEY
	(
	GroupId
	) REFERENCES dbo.[Group]
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.GroupMessage_Alias ADD CONSTRAINT
	FK_GroupMessage_Alias_GroupMessage FOREIGN KEY
	(
	GroupMessageId
	) REFERENCES dbo.GroupMessage
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.GroupMessage_Alias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
