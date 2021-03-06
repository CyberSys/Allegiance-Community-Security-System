/*
   Tuesday, January 04, 20112:42:10 PM
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
ALTER TABLE dbo.MachineRecordType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.VirtualMachineMarker
	(
	Id int NOT NULL IDENTITY (1, 1),
	IdentifierMask nvarchar(50) NOT NULL,
	RecordTypeId int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.VirtualMachineMarker ADD CONSTRAINT
	PK_VirtualMachineMarker PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.VirtualMachineMarker ADD CONSTRAINT
	FK_VirtualMachineMarker_MachineRecordType FOREIGN KEY
	(
	RecordTypeId
	) REFERENCES dbo.MachineRecordType
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.VirtualMachineMarker SET (LOCK_ESCALATION = TABLE)
GO

insert into dbo.VirtualMachineMarker (IdentifierMask, RecordTypeId) VALUES('%|Virtual HD|%', 2)
GO

insert into dbo.VirtualMachineMarker (IdentifierMask, RecordTypeId) VALUES('%|VirtualBox %', 1)
GO

insert into dbo.VirtualMachineMarker (IdentifierMask, RecordTypeId) VALUES('%|VMware %', 1)
GO

insert into dbo.VirtualMachineMarker (IdentifierMask, RecordTypeId) VALUES('%|QEMU HARDDISK|%', 2)
GO

COMMIT


