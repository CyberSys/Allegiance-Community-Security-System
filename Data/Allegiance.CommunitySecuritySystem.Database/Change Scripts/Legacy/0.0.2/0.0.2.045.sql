/*
   Tuesday, September 21, 201010:55:55 AM
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
CREATE TABLE dbo.Captcha
	(
	Id uniqueidentifier NOT NULL,
	Answer nvarchar(10) NOT NULL,
	DateCreated datetime NOT NULL,
	IpAddress nvarchar(50) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Captcha ADD CONSTRAINT
	DF_Captcha_Id DEFAULT NewID() FOR Id
GO
ALTER TABLE dbo.Captcha ADD CONSTRAINT
	DF_Captcha_DateCreated DEFAULT GetDate() FOR DateCreated
GO
ALTER TABLE dbo.Captcha ADD CONSTRAINT
	PK_Captcha PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Captcha SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
