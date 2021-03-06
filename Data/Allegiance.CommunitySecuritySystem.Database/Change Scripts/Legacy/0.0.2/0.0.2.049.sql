/*
   Wednesday, November 24, 20102:13:00 PM
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
ALTER TABLE dbo.Poll ADD
	LastRecalculation datetime NOT NULL CONSTRAINT DF_Poll_LastRecalculation DEFAULT GetDate()
GO
ALTER TABLE dbo.Poll SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.PollOption ADD
	VoteCount int NOT NULL CONSTRAINT DF_PollOption_VoteCount DEFAULT 0
GO
ALTER TABLE dbo.PollOption SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
