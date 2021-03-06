USE CSSStats
GO


/*
   Wednesday, April 21, 201010:56:51 PM
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
CREATE TABLE dbo.StatsMetrics
	(
	StatsMetricsId int NOT NULL IDENTITY (1, 1),
	TotalGamesLogged int NOT NULL,
	LastGameProcessed int NOT NULL,
	AveragePlayerRank float(53) NOT NULL,
	AverageCommandRank float(53) NOT NULL,
	DateModified datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.StatsMetrics ADD CONSTRAINT
	DF_StatsMetrics_DateModified DEFAULT GetDate() FOR DateModified
GO
ALTER TABLE dbo.StatsMetrics ADD CONSTRAINT
	PK_StatsMetrics PRIMARY KEY CLUSTERED 
	(
	StatsMetricsId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.StatsMetrics SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO

ALTER TABLE dbo.StatsLeaderboard SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.StatsFaction ADD
	DateModified datetime NOT NULL CONSTRAINT DF_StatsFaction_DateModified DEFAULT GetDate()
GO
ALTER TABLE dbo.StatsFaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
