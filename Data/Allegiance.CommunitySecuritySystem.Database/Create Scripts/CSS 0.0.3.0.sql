USE [CSS]
GO
/****** Object:  User [css_server]    Script Date: 10/21/2011 16:29:43 ******/
CREATE USER [css_server] FOR LOGIN [css_server] WITH DEFAULT_SCHEMA=[css_server]
GO
/****** Object:  Schema [css_server]    Script Date: 10/21/2011 16:29:43 ******/
CREATE SCHEMA [css_server] AUTHORIZATION [css_server]
GO
/****** Object:  Table [dbo].[Lobby]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lobby](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Host] [nvarchar](50) NOT NULL,
	[BasePath] [nvarchar](255) NOT NULL,
	[IsRestrictive] [bit] NOT NULL,
	[IsEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_Lobby] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Lobby] ON
INSERT [dbo].[Lobby] ([Id], [Name], [Host], [BasePath], [IsRestrictive], [IsEnabled]) VALUES (1, N'Production', N'localhost', N'.\', 0, 1)
INSERT [dbo].[Lobby] ([Id], [Name], [Host], [BasePath], [IsRestrictive], [IsEnabled]) VALUES (2, N'Beta', N'localhost', N'.\Dev', 0, 1)
SET IDENTITY_INSERT [dbo].[Lobby] OFF
/****** Object:  Table [dbo].[IPConverge]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IPConverge](
	[ApiCode] [varchar](32) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Added] [datetime] NOT NULL,
	[IpAddress] [varchar](16) NOT NULL,
	[Url] [varchar](255) NOT NULL,
	[Active] [bit] NOT NULL,
	[HttpUser] [varchar](255) NOT NULL,
	[HttpPassword] [varchar](255) NOT NULL,
 CONSTRAINT [PK_IPConverge] PRIMARY KEY CLUSTERED 
(
	[ApiCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_IPConverge] ON [dbo].[IPConverge] 
(
	[Active] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Identity]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Identity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateLastLogin] [datetime] NOT NULL,
	[LastGlobalMessageDelivery] [datetime] NOT NULL,
 CONSTRAINT [PK_Identity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupRole]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Token] [nchar](1) NULL,
 CONSTRAINT [PK_GroupRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupRequestType]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupRequestType](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
 CONSTRAINT [PK_GroupRequestType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Tag] [nvarchar](5) NOT NULL,
	[IsSquad] [bit] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Captcha]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Captcha](
	[Id] [uniqueidentifier] NOT NULL,
	[Answer] [nvarchar](10) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[IpAddress] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Captcha] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AutoUpdateFile]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AutoUpdateFile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Filename] [nvarchar](100) NOT NULL,
	[IsProtected] [bit] NOT NULL,
 CONSTRAINT [PK_AutoUpdateFile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BanClass]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BanClass](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BanClass] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BanClass] ([Id], [Name]) VALUES (1, N'Minor               ')
INSERT [dbo].[BanClass] ([Id], [Name]) VALUES (2, N'Major               ')
INSERT [dbo].[BanClass] ([Id], [Name]) VALUES (3, N'MinorHabitual       ')
INSERT [dbo].[BanClass] ([Id], [Name]) VALUES (4, N'MajorHabitual       ')
/****** Object:  Table [dbo].[MachineRecordType]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MachineRecordType](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_MachineRecordType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[MachineRecordType] ([Id], [Name]) VALUES (1, N'Network')
INSERT [dbo].[MachineRecordType] ([Id], [Name]) VALUES (2, N'HardDisk')
INSERT [dbo].[MachineRecordType] ([Id], [Name]) VALUES (3, N'EDID')
INSERT [dbo].[MachineRecordType] ([Id], [Name]) VALUES (4, N'Serial')
INSERT [dbo].[MachineRecordType] ([Id], [Name]) VALUES (5, N'Misc')
/****** Object:  Table [dbo].[Error]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Error](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ExceptionType] [nvarchar](100) NOT NULL,
	[Message] [nvarchar](255) NOT NULL,
	[StackTrace] [ntext] NOT NULL,
	[InnerMessage] [nvarchar](255) NULL,
	[DateOccurred] [datetime] NOT NULL,
 CONSTRAINT [PK_Error] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Poll]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Poll](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Question] [nvarchar](255) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateExpires] [datetime] NOT NULL,
	[LastRecalculation] [datetime] NOT NULL,
 CONSTRAINT [PK_Poll] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](20) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Message] [nvarchar](255) NOT NULL,
	[DateOccurred] [datetime] NOT NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransformMethod]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransformMethod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Text] [ntext] NOT NULL,
 CONSTRAINT [PK_TransformMethod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TransformMethod] ON
INSERT [dbo].[TransformMethod] ([Id], [Text]) VALUES (1, N'int len = rand.Next(189, 350); for (int i = rand.Next(15, 35); i < len; i += 2) sb.Append((char)rand.Next(48, 122));')
SET IDENTITY_INSERT [dbo].[TransformMethod] OFF
/****** Object:  Table [dbo].[SessionStatus]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SessionStatus](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_SessionStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[SessionStatus] ([Id], [Name]) VALUES (1, N'PendingVerification')
INSERT [dbo].[SessionStatus] ([Id], [Name]) VALUES (2, N'Active')
INSERT [dbo].[SessionStatus] ([Id], [Name]) VALUES (3, N'Closed')
/****** Object:  Table [dbo].[Motd]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Motd](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Logo] [varchar](50) NOT NULL,
	[Banner] [varchar](50) NOT NULL,
	[PrimaryHeading] [varchar](255) NOT NULL,
	[PrimaryText] [text] NOT NULL,
	[SecondaryHeading] [varchar](255) NOT NULL,
	[SecondaryText] [text] NOT NULL,
	[Details] [text] NOT NULL,
	[PaddingCrCount] [int] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[LobbyId] [int] NULL,
 CONSTRAINT [PK_Motd] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VirtualMachineMarker]    Script Date: 10/21/2011 16:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VirtualMachineMarker](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdentifierMask] [nvarchar](50) NOT NULL,
	[RecordTypeId] [int] NOT NULL,
 CONSTRAINT [PK_VirtualMachineMarker] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[VirtualMachineMarker] ON
INSERT [dbo].[VirtualMachineMarker] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (1, N'%|Virtual HD|%', 2)
INSERT [dbo].[VirtualMachineMarker] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (2, N'%|VirtualBox %', 1)
INSERT [dbo].[VirtualMachineMarker] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (3, N'%|VMware %', 1)
INSERT [dbo].[VirtualMachineMarker] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (4, N'%|QEMU HARDDISK|%', 2)
SET IDENTITY_INSERT [dbo].[VirtualMachineMarker] OFF
/****** Object:  Table [dbo].[PollOption]    Script Date: 10/21/2011 16:29:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PollOption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PollId] [int] NOT NULL,
	[Option] [nvarchar](255) NOT NULL,
	[VoteCount] [int] NOT NULL,
 CONSTRAINT [PK_PollOption] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Login]    Script Date: 10/21/2011 16:29:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[IdentityId] [int] NOT NULL,
	[AllowVirtualMachineLogin] [bit] NOT NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Login_UniqueUsername] ON [dbo].[Login] 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MachineRecordExclusions]    Script Date: 10/21/2011 16:29:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MachineRecordExclusions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdentifierMask] [nvarchar](50) NOT NULL,
	[RecordTypeId] [int] NOT NULL,
 CONSTRAINT [PK_MachineRecordExclusions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[MachineRecordExclusions] ON
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (1, N'%0000000%', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (2, N'592843238', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (3, N'839718926', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (4, N'4SUBSYS2', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (5, N'2633124372', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (6, N'0BROKER0', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (7, N'982452547', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (8, N'576117690', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (9, N'120276828', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (10, N'1122570335', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (11, N'2292584050', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (12, N'1380278024', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (13, N'1414806718', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (14, N'10ECDEV0', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (15, N'742876493', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (16, N'814567584', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (17, N'992807681', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (18, N'3894360729', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (19, N'604936657', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (20, N'2625493935', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (21, N'3700979340', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (22, N'515406229', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (23, N'1302358256', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (24, N'1859848970', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (25, N'2896432619', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (26, N'312976832', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (27, N'%USB%', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (28, N'%GENERIC%', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (29, N'2020202057202d4443574e', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (30, N'Volume0', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (31, N'Volume1', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (32, N'2685867626', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (33, N'STRIPE', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (34, N'738623858', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (35, N'3840450990', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (36, N'RAID0', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (37, N'Set001Con', 2)
INSERT [dbo].[MachineRecordExclusions] ([Id], [IdentifierMask], [RecordTypeId]) VALUES (38, N'ILES%', 2)
SET IDENTITY_INSERT [dbo].[MachineRecordExclusions] OFF
/****** Object:  Table [dbo].[ActiveKey]    Script Date: 10/21/2011 16:29:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActiveKey](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Token] [nvarchar](95) NOT NULL,
	[Filename] [nvarchar](50) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[RSACspBlob] [image] NOT NULL,
	[TransformMethodId] [int] NOT NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_ActiveKey] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BanType]    Script Date: 10/21/2011 16:29:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BanType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RocNumber] [int] NULL,
	[SrNumber] [int] NULL,
	[Description] [nvarchar](255) NOT NULL,
	[BanClassId] [int] NOT NULL,
	[BaseTimeInMinutes] [int] NOT NULL,
	[InfractionsBeforePermanentBan] [int] NULL,
	[IsIncremental] [bit] NOT NULL,
 CONSTRAINT [PK_BanType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BanType] ON
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (1, 1, 2, N'Harassment / Threats', 1, 30, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (2, 2, 1, N'Language', 1, 30, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (3, NULL, 7, N'Newbie Hostility', 1, 120, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (4, NULL, 8, N'Newbie boots ', 1, 120, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (5, NULL, 6, N'Vet on Newbie Server ', 1, 1440, NULL, 0)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (6, 7, NULL, N'Disobeying Admin', 1, 60, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (7, NULL, 11, N'Randomize button', 1, 30, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (8, NULL, 12, N'Spamming', 1, 15, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (11, NULL, 5, N'Server Hostaging', 1, 60, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (12, NULL, 4, N'Admin abuse/impersonation', 2, 2880, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (13, 3, NULL, N'Impersonation of a player', 2, 1440, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (15, 6, NULL, N'Illegal software sharing', 2, 21600, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (16, 4, NULL, N'Law violations', 2, 2880, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (17, 8, NULL, N'Illegal groups', 2, 86400, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (18, NULL, 9, N'Boot Resign', 2, 4320, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (19, NULL, 10, N'Retaliatory Boot', 2, 4320, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (20, 9, NULL, N'Circumvention of ban', 2, 2147483640, 0, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (21, 10, NULL, N'Copyright infringement ', 2, 14400, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (23, NULL, 13, N'In game cheating', 2, 259200, 1, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (25, 5, NULL, N'Modification of client / server', 2, 259200, 1, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (28, 11, NULL, N'Hacking', 2, 2147483640, 0, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (29, NULL, NULL, N'Habitual Offender (Minor)', 3, 14400, NULL, 1)
INSERT [dbo].[BanType] ([Id], [RocNumber], [SrNumber], [Description], [BanClassId], [BaseTimeInMinutes], [InfractionsBeforePermanentBan], [IsIncremental]) VALUES (30, NULL, NULL, N'Habitual Offender (Major)', 4, 43200, 2, 1)
SET IDENTITY_INSERT [dbo].[BanType] OFF
/****** Object:  Table [dbo].[AutoUpdateFile_Lobby]    Script Date: 10/21/2011 16:29:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AutoUpdateFile_Lobby](
	[AutoUpdateFileId] [int] NOT NULL,
	[LobbyId] [int] NOT NULL,
	[ValidChecksum] [nchar](28) NULL,
	[CurrentVersion] [nvarchar](15) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NOT NULL,
 CONSTRAINT [PK_AutoUpdateFile_Lobby] PRIMARY KEY NONCLUSTERED 
(
	[AutoUpdateFileId] ASC,
	[LobbyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_AutoUpdateFile_Lobby] ON [dbo].[AutoUpdateFile_Lobby] 
(
	[AutoUpdateFileId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_AutoUpdateFile_Lobby_1] ON [dbo].[AutoUpdateFile_Lobby] 
(
	[LobbyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[FindAutoUpdateFiles]    Script Date: 10/21/2011 16:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FindAutoUpdateFiles] 
(	
	@LobbyId int
)
RETURNS TABLE 
AS
RETURN 
(

	SELECT AL.*, AO.Filename, AO.IsProtected
	FROM AutoUpdateFile AO
		INNER JOIN AutoUpdateFile_Lobby AL ON AL.AutoUpdateFileId = AO.Id
	INNER JOIN 
	(
		SELECT MAX(AL.LobbyId) as LobbyId, AF.[Filename]
		FROM AutoUpdateFile AF
			LEFT JOIN AutoUpdateFile_Lobby AL ON AL.AutoUpdateFileId = AF.Id
		WHERE LobbyId IS NULL OR LobbyId = @LobbyId
		GROUP BY [Filename]
	) AD ON AD.[Filename] = AO.[Filename] AND (AL.LobbyId = AD.Lobbyid OR AD.Lobbyid IS NULL)

)
GO
/****** Object:  Table [dbo].[Alias]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alias](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LoginId] [int] NOT NULL,
	[Callsign] [nvarchar](20) NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Alias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Alias] UNIQUE NONCLUSTERED 
(
	[Callsign] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ban]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ban](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LoginId] [int] NOT NULL,
	[BannedByLoginId] [int] NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateExpires] [datetime] NULL,
	[InEffect] [bit] NOT NULL,
	[BanTypeId] [int] NULL,
 CONSTRAINT [PK_Ban] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MachineRecord]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MachineRecord](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RecordTypeId] [int] NOT NULL,
	[Identifier] [nvarchar](1024) NOT NULL,
	[LoginId] [int] NOT NULL,
 CONSTRAINT [PK_MachineRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Login_UnlinkedLogin]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login_UnlinkedLogin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LoginId1] [int] NOT NULL,
	[LoginId2] [int] NOT NULL,
 CONSTRAINT [PK_Login_UnlinkedLogin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Login_Role]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login_Role](
	[LoginId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_Login_Role] PRIMARY KEY CLUSTERED 
(
	[LoginId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PollVote]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PollVote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PollOptionId] [int] NOT NULL,
	[LoginId] [int] NOT NULL,
 CONSTRAINT [PK_PollVote] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lobby_Login]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lobby_Login](
	[LobbyId] [int] NOT NULL,
	[LoginId] [int] NOT NULL,
 CONSTRAINT [PK_Lobby_Login] PRIMARY KEY CLUSTERED 
(
	[LobbyId] ASC,
	[LoginId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsedKey]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsedKey](
	[LoginId] [int] NOT NULL,
	[ActiveKeyId] [int] NOT NULL,
	[DateUsed] [datetime] NOT NULL,
 CONSTRAINT [PK_UsedKey] PRIMARY KEY CLUSTERED 
(
	[LoginId] ASC,
	[ActiveKeyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Session]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Session](
	[Id] [uniqueidentifier] NOT NULL,
	[LoginId] [int] NOT NULL,
	[ActiveKeyId] [int] NOT NULL,
	[SessionStatusId] [int] NOT NULL,
	[DateLastCheckIn] [datetime] NOT NULL,
	[IPAddress] [varchar](40) NOT NULL,
	[AliasId] [int] NOT NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[LoginId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonalMessage]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonalMessage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](50) NOT NULL,
	[Message] [nvarchar](255) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateToSend] [datetime] NOT NULL,
	[DateExpires] [datetime] NULL,
	[LoginId] [int] NOT NULL,
	[DateViewed] [datetime] NULL,
	[SenderAliasId] [int] NOT NULL,
 CONSTRAINT [PK_PersonalMessage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupMessage]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupMessage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](50) NOT NULL,
	[Message] [nvarchar](255) NOT NULL,
	[GroupId] [int] NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateToSend] [datetime] NOT NULL,
	[DateExpires] [datetime] NULL,
	[SenderAliasId] [int] NOT NULL,
 CONSTRAINT [PK_GroupMessage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group_Alias_GroupRole]    Script Date: 10/21/2011 16:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group_Alias_GroupRole](
	[GroupId] [int] NOT NULL,
	[AliasId] [int] NOT NULL,
	[GroupRoleId] [int] NOT NULL,
 CONSTRAINT [PK_Group_Alias_GroupRole] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC,
	[AliasId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DuplicateVote]    Script Date: 10/21/2011 16:29:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DuplicateVote]
AS
SELECT P.Id as PollId, PV.Id as PollVoteId, PV.IdentityId
FROM PollVote PV
	INNER JOIN PollOption PO ON PV.PollOptionId = PO.Id
	INNER JOIN Poll P ON PO.PollId = P.Id
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PV"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 110
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PO"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 110
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "P"
            Begin Extent = 
               Top = 6
               Left = 434
               Bottom = 125
               Right = 594
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DuplicateVote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DuplicateVote'
GO
/****** Object:  UserDefinedFunction [dbo].[AvailableKey]    Script Date: 10/21/2011 16:29:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE FUNCTION [dbo].[AvailableKey]
(	
	@LoginId int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT K.Id, K.Token, K.[Filename], K.DateCreated, K.TransformMethodId, K.IsValid
	FROM ActiveKey K
		LEFT OUTER JOIN UsedKey UK ON K.Id = UK.ActiveKeyId AND UK.LoginId = @LoginId
	GROUP BY K.Id, K.Token, K.[Filename], K.DateCreated, K.TransformMethodId, K.IsValid
	HAVING COUNT(UK.ActiveKeyId) = 0
)
GO
/****** Object:  Table [dbo].[GroupRequest]    Script Date: 10/21/2011 16:29:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RequestTypeId] [int] NOT NULL,
	[AliasId] [int] NOT NULL,
	[GroupId] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_GroupRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupMessage_Alias]    Script Date: 10/21/2011 16:29:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupMessage_Alias](
	[GroupMessageId] [int] NOT NULL,
	[AliasId] [int] NOT NULL,
	[DateViewed] [datetime] NULL,
 CONSTRAINT [PK_GroupMessage_Alias] PRIMARY KEY CLUSTERED 
(
	[GroupMessageId] ASC,
	[AliasId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [DF_Lobby_IsRestrictive]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Lobby] ADD  CONSTRAINT [DF_Lobby_IsRestrictive]  DEFAULT ((0)) FOR [IsRestrictive]
GO
/****** Object:  Default [DF_Lobby_IsEnabled]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Lobby] ADD  CONSTRAINT [DF_Lobby_IsEnabled]  DEFAULT ((1)) FOR [IsEnabled]
GO
/****** Object:  Default [DF_Identity_DateLastLogin]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Identity] ADD  CONSTRAINT [DF_Identity_DateLastLogin]  DEFAULT (getdate()) FOR [DateLastLogin]
GO
/****** Object:  Default [DF_Identity_LastGlobalMessageDelivery]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Identity] ADD  CONSTRAINT [DF_Identity_LastGlobalMessageDelivery]  DEFAULT (getdate()) FOR [LastGlobalMessageDelivery]
GO
/****** Object:  Default [DF_Group_IsSquad]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Group] ADD  CONSTRAINT [DF_Group_IsSquad]  DEFAULT ((0)) FOR [IsSquad]
GO
/****** Object:  Default [DF_Group_DateCreated]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Group] ADD  CONSTRAINT [DF_Group_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_Captcha_Id]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Captcha] ADD  CONSTRAINT [DF_Captcha_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Captcha_DateCreated]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Captcha] ADD  CONSTRAINT [DF_Captcha_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_AutoUpdateFile_IsProtected]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[AutoUpdateFile] ADD  CONSTRAINT [DF_AutoUpdateFile_IsProtected]  DEFAULT ((0)) FOR [IsProtected]
GO
/****** Object:  Default [DF_Error_DateOccurred]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Error] ADD  CONSTRAINT [DF_Error_DateOccurred]  DEFAULT (getdate()) FOR [DateOccurred]
GO
/****** Object:  Default [DF_Poll_DateCreated]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Poll] ADD  CONSTRAINT [DF_Poll_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_Poll_LastRecalculation]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Poll] ADD  CONSTRAINT [DF_Poll_LastRecalculation]  DEFAULT (getdate()) FOR [LastRecalculation]
GO
/****** Object:  Default [DF_Log_DateOccurred]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Log] ADD  CONSTRAINT [DF_Log_DateOccurred]  DEFAULT (getdate()) FOR [DateOccurred]
GO
/****** Object:  Default [DF_Motd_LastUpdated]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Motd] ADD  CONSTRAINT [DF_Motd_LastUpdated]  DEFAULT (getdate()) FOR [LastUpdated]
GO
/****** Object:  Default [DF_PollOption_VoteCount]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[PollOption] ADD  CONSTRAINT [DF_PollOption_VoteCount]  DEFAULT ((0)) FOR [VoteCount]
GO
/****** Object:  Default [DF_Login_DateCreated]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[Login] ADD  CONSTRAINT [DF_Login_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_Login_AllowVirtualMachineLogin]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[Login] ADD  CONSTRAINT [DF_Login_AllowVirtualMachineLogin]  DEFAULT ((0)) FOR [AllowVirtualMachineLogin]
GO
/****** Object:  Default [DF_ActiveKey_DateCreated]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[ActiveKey] ADD  CONSTRAINT [DF_ActiveKey_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_ActiveKey_IsValid]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[ActiveKey] ADD  CONSTRAINT [DF_ActiveKey_IsValid]  DEFAULT ((1)) FOR [IsValid]
GO
/****** Object:  Default [DF_BanType_IsIncremental]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[BanType] ADD  CONSTRAINT [DF_BanType_IsIncremental]  DEFAULT ((0)) FOR [IsIncremental]
GO
/****** Object:  Default [DF_AutoUpdateFile_Lobby_DateCreated]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[AutoUpdateFile_Lobby] ADD  CONSTRAINT [DF_AutoUpdateFile_Lobby_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_AutoUpdateFile_Lobby_DateModified]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[AutoUpdateFile_Lobby] ADD  CONSTRAINT [DF_AutoUpdateFile_Lobby_DateModified]  DEFAULT (getdate()) FOR [DateModified]
GO
/****** Object:  Default [DF_Alias_IsDefault]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Alias] ADD  CONSTRAINT [DF_Alias_IsDefault]  DEFAULT ((0)) FOR [IsDefault]
GO
/****** Object:  Default [DF_Alias_IsActive]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Alias] ADD  CONSTRAINT [DF_Alias_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  Default [DF_Alias_DateCreated]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Alias] ADD  CONSTRAINT [DF_Alias_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_Ban_DateCreated]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Ban] ADD  CONSTRAINT [DF_Ban_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_Ban_InEffect]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Ban] ADD  CONSTRAINT [DF_Ban_InEffect]  DEFAULT ((1)) FOR [InEffect]
GO
/****** Object:  Default [DF_Ban_InfractionCode]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Ban] ADD  CONSTRAINT [DF_Ban_InfractionCode]  DEFAULT ((0)) FOR [BanTypeId]
GO
/****** Object:  Default [DF_UsedKey_DateUsed]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[UsedKey] ADD  CONSTRAINT [DF_UsedKey_DateUsed]  DEFAULT (getdate()) FOR [DateUsed]
GO
/****** Object:  Default [DF_Session_Id]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Session] ADD  CONSTRAINT [DF_Session_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Session_DateLastCheckIn]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Session] ADD  CONSTRAINT [DF_Session_DateLastCheckIn]  DEFAULT (getdate()) FOR [DateLastCheckIn]
GO
/****** Object:  Default [DF_Session_IPAddress]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Session] ADD  CONSTRAINT [DF_Session_IPAddress]  DEFAULT ('') FOR [IPAddress]
GO
/****** Object:  Default [DF_PersonalMessage_DateCreated]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[PersonalMessage] ADD  CONSTRAINT [DF_PersonalMessage_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_PersonalMessage_DateToSend]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[PersonalMessage] ADD  CONSTRAINT [DF_PersonalMessage_DateToSend]  DEFAULT (getdate()) FOR [DateToSend]
GO
/****** Object:  Default [DF_GroupMessage_DateCreated]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[GroupMessage] ADD  CONSTRAINT [DF_GroupMessage_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_GroupMessage_DateToSend]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[GroupMessage] ADD  CONSTRAINT [DF_GroupMessage_DateToSend]  DEFAULT (getdate()) FOR [DateToSend]
GO
/****** Object:  Default [DF_GroupRequest_DateCreated]    Script Date: 10/21/2011 16:29:49 ******/
ALTER TABLE [dbo].[GroupRequest] ADD  CONSTRAINT [DF_GroupRequest_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_GroupMessage_Alias_DateViewed]    Script Date: 10/21/2011 16:29:49 ******/
ALTER TABLE [dbo].[GroupMessage_Alias] ADD  CONSTRAINT [DF_GroupMessage_Alias_DateViewed]  DEFAULT (getdate()) FOR [DateViewed]
GO
/****** Object:  ForeignKey [FK_Motd_Lobby]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[Motd]  WITH CHECK ADD  CONSTRAINT [FK_Motd_Lobby] FOREIGN KEY([LobbyId])
REFERENCES [dbo].[Lobby] ([Id])
GO
ALTER TABLE [dbo].[Motd] CHECK CONSTRAINT [FK_Motd_Lobby]
GO
/****** Object:  ForeignKey [FK_VirtualMachineMarker_MachineRecordType]    Script Date: 10/21/2011 16:29:45 ******/
ALTER TABLE [dbo].[VirtualMachineMarker]  WITH CHECK ADD  CONSTRAINT [FK_VirtualMachineMarker_MachineRecordType] FOREIGN KEY([RecordTypeId])
REFERENCES [dbo].[MachineRecordType] ([Id])
GO
ALTER TABLE [dbo].[VirtualMachineMarker] CHECK CONSTRAINT [FK_VirtualMachineMarker_MachineRecordType]
GO
/****** Object:  ForeignKey [FK_PollOption_Poll]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[PollOption]  WITH CHECK ADD  CONSTRAINT [FK_PollOption_Poll] FOREIGN KEY([PollId])
REFERENCES [dbo].[Poll] ([Id])
GO
ALTER TABLE [dbo].[PollOption] CHECK CONSTRAINT [FK_PollOption_Poll]
GO
/****** Object:  ForeignKey [FK_Login_Identity]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[Login]  WITH CHECK ADD  CONSTRAINT [FK_Login_Identity] FOREIGN KEY([IdentityId])
REFERENCES [dbo].[Identity] ([Id])
GO
ALTER TABLE [dbo].[Login] CHECK CONSTRAINT [FK_Login_Identity]
GO
/****** Object:  ForeignKey [FK_MachineRecordExclusions_MachineRecordType]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[MachineRecordExclusions]  WITH CHECK ADD  CONSTRAINT [FK_MachineRecordExclusions_MachineRecordType] FOREIGN KEY([RecordTypeId])
REFERENCES [dbo].[MachineRecordType] ([Id])
GO
ALTER TABLE [dbo].[MachineRecordExclusions] CHECK CONSTRAINT [FK_MachineRecordExclusions_MachineRecordType]
GO
/****** Object:  ForeignKey [FK_ActiveKey_TransformMethod]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[ActiveKey]  WITH CHECK ADD  CONSTRAINT [FK_ActiveKey_TransformMethod] FOREIGN KEY([TransformMethodId])
REFERENCES [dbo].[TransformMethod] ([Id])
GO
ALTER TABLE [dbo].[ActiveKey] CHECK CONSTRAINT [FK_ActiveKey_TransformMethod]
GO
/****** Object:  ForeignKey [FK_BanType_BanClass]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[BanType]  WITH CHECK ADD  CONSTRAINT [FK_BanType_BanClass] FOREIGN KEY([BanClassId])
REFERENCES [dbo].[BanClass] ([Id])
GO
ALTER TABLE [dbo].[BanType] CHECK CONSTRAINT [FK_BanType_BanClass]
GO
/****** Object:  ForeignKey [FK_AutoUpdateFile_Lobby_AutoUpdateFile]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[AutoUpdateFile_Lobby]  WITH CHECK ADD  CONSTRAINT [FK_AutoUpdateFile_Lobby_AutoUpdateFile] FOREIGN KEY([AutoUpdateFileId])
REFERENCES [dbo].[AutoUpdateFile] ([Id])
GO
ALTER TABLE [dbo].[AutoUpdateFile_Lobby] CHECK CONSTRAINT [FK_AutoUpdateFile_Lobby_AutoUpdateFile]
GO
/****** Object:  ForeignKey [FK_AutoUpdateFile_Lobby_Lobby]    Script Date: 10/21/2011 16:29:46 ******/
ALTER TABLE [dbo].[AutoUpdateFile_Lobby]  WITH CHECK ADD  CONSTRAINT [FK_AutoUpdateFile_Lobby_Lobby] FOREIGN KEY([LobbyId])
REFERENCES [dbo].[Lobby] ([Id])
GO
ALTER TABLE [dbo].[AutoUpdateFile_Lobby] CHECK CONSTRAINT [FK_AutoUpdateFile_Lobby_Lobby]
GO
/****** Object:  ForeignKey [FK_Alias_Login]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Alias]  WITH CHECK ADD  CONSTRAINT [FK_Alias_Login] FOREIGN KEY([LoginId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[Alias] CHECK CONSTRAINT [FK_Alias_Login]
GO
/****** Object:  ForeignKey [FK_Ban_BanType]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Ban]  WITH CHECK ADD  CONSTRAINT [FK_Ban_BanType] FOREIGN KEY([BanTypeId])
REFERENCES [dbo].[BanType] ([Id])
GO
ALTER TABLE [dbo].[Ban] CHECK CONSTRAINT [FK_Ban_BanType]
GO
/****** Object:  ForeignKey [FK_Ban_Login]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Ban]  WITH CHECK ADD  CONSTRAINT [FK_Ban_Login] FOREIGN KEY([BannedByLoginId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[Ban] CHECK CONSTRAINT [FK_Ban_Login]
GO
/****** Object:  ForeignKey [FK_Ban_Login1]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Ban]  WITH CHECK ADD  CONSTRAINT [FK_Ban_Login1] FOREIGN KEY([LoginId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[Ban] CHECK CONSTRAINT [FK_Ban_Login1]
GO
/****** Object:  ForeignKey [FK_MachineRecord_Login]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[MachineRecord]  WITH CHECK ADD  CONSTRAINT [FK_MachineRecord_Login] FOREIGN KEY([LoginId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[MachineRecord] CHECK CONSTRAINT [FK_MachineRecord_Login]
GO
/****** Object:  ForeignKey [FK_MachineRecord_MachineRecordType]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[MachineRecord]  WITH CHECK ADD  CONSTRAINT [FK_MachineRecord_MachineRecordType] FOREIGN KEY([RecordTypeId])
REFERENCES [dbo].[MachineRecordType] ([Id])
GO
ALTER TABLE [dbo].[MachineRecord] CHECK CONSTRAINT [FK_MachineRecord_MachineRecordType]
GO
/****** Object:  ForeignKey [FK_Login_UnlinkedLogin_Login]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Login_UnlinkedLogin]  WITH CHECK ADD  CONSTRAINT [FK_Login_UnlinkedLogin_Login] FOREIGN KEY([LoginId1])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[Login_UnlinkedLogin] CHECK CONSTRAINT [FK_Login_UnlinkedLogin_Login]
GO
/****** Object:  ForeignKey [FK_Login_UnlinkedLogin_Login1]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Login_UnlinkedLogin]  WITH CHECK ADD  CONSTRAINT [FK_Login_UnlinkedLogin_Login1] FOREIGN KEY([LoginId2])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[Login_UnlinkedLogin] CHECK CONSTRAINT [FK_Login_UnlinkedLogin_Login1]
GO
/****** Object:  ForeignKey [FK_Login_Role_Login]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Login_Role]  WITH CHECK ADD  CONSTRAINT [FK_Login_Role_Login] FOREIGN KEY([LoginId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[Login_Role] CHECK CONSTRAINT [FK_Login_Role_Login]
GO
/****** Object:  ForeignKey [FK_Login_Role_Role]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Login_Role]  WITH CHECK ADD  CONSTRAINT [FK_Login_Role_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[Login_Role] CHECK CONSTRAINT [FK_Login_Role_Role]
GO
/****** Object:  ForeignKey [FK_PollVote_Login]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[PollVote]  WITH CHECK ADD  CONSTRAINT [FK_PollVote_Login] FOREIGN KEY([LoginId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[PollVote] CHECK CONSTRAINT [FK_PollVote_Login]
GO
/****** Object:  ForeignKey [FK_PollVote_PollOption]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[PollVote]  WITH CHECK ADD  CONSTRAINT [FK_PollVote_PollOption] FOREIGN KEY([PollOptionId])
REFERENCES [dbo].[PollOption] ([Id])
GO
ALTER TABLE [dbo].[PollVote] CHECK CONSTRAINT [FK_PollVote_PollOption]
GO
/****** Object:  ForeignKey [FK_Lobby_Login_Lobby]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Lobby_Login]  WITH CHECK ADD  CONSTRAINT [FK_Lobby_Login_Lobby] FOREIGN KEY([LobbyId])
REFERENCES [dbo].[Lobby] ([Id])
GO
ALTER TABLE [dbo].[Lobby_Login] CHECK CONSTRAINT [FK_Lobby_Login_Lobby]
GO
/****** Object:  ForeignKey [FK_Lobby_Login_Login]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Lobby_Login]  WITH CHECK ADD  CONSTRAINT [FK_Lobby_Login_Login] FOREIGN KEY([LoginId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[Lobby_Login] CHECK CONSTRAINT [FK_Lobby_Login_Login]
GO
/****** Object:  ForeignKey [FK_UsedKey_ActiveKey]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[UsedKey]  WITH CHECK ADD  CONSTRAINT [FK_UsedKey_ActiveKey] FOREIGN KEY([ActiveKeyId])
REFERENCES [dbo].[ActiveKey] ([Id])
GO
ALTER TABLE [dbo].[UsedKey] CHECK CONSTRAINT [FK_UsedKey_ActiveKey]
GO
/****** Object:  ForeignKey [FK_UsedKey_Login]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[UsedKey]  WITH CHECK ADD  CONSTRAINT [FK_UsedKey_Login] FOREIGN KEY([LoginId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[UsedKey] CHECK CONSTRAINT [FK_UsedKey_Login]
GO
/****** Object:  ForeignKey [FK_Session_ActiveKey]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_ActiveKey] FOREIGN KEY([ActiveKeyId])
REFERENCES [dbo].[ActiveKey] ([Id])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_ActiveKey]
GO
/****** Object:  ForeignKey [FK_Session_Alias]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Alias] FOREIGN KEY([AliasId])
REFERENCES [dbo].[Alias] ([Id])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Alias]
GO
/****** Object:  ForeignKey [FK_Session_Login]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Login] FOREIGN KEY([LoginId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Login]
GO
/****** Object:  ForeignKey [FK_Session_SessionStatus]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_SessionStatus] FOREIGN KEY([SessionStatusId])
REFERENCES [dbo].[SessionStatus] ([Id])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_SessionStatus]
GO
/****** Object:  ForeignKey [FK_PersonalMessage_Alias]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[PersonalMessage]  WITH CHECK ADD  CONSTRAINT [FK_PersonalMessage_Alias] FOREIGN KEY([SenderAliasId])
REFERENCES [dbo].[Alias] ([Id])
GO
ALTER TABLE [dbo].[PersonalMessage] CHECK CONSTRAINT [FK_PersonalMessage_Alias]
GO
/****** Object:  ForeignKey [FK_PersonalMessage_Login]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[PersonalMessage]  WITH CHECK ADD  CONSTRAINT [FK_PersonalMessage_Login] FOREIGN KEY([LoginId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[PersonalMessage] CHECK CONSTRAINT [FK_PersonalMessage_Login]
GO
/****** Object:  ForeignKey [FK_GroupMessage_Alias]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[GroupMessage]  WITH CHECK ADD  CONSTRAINT [FK_GroupMessage_Alias] FOREIGN KEY([SenderAliasId])
REFERENCES [dbo].[Alias] ([Id])
GO
ALTER TABLE [dbo].[GroupMessage] CHECK CONSTRAINT [FK_GroupMessage_Alias]
GO
/****** Object:  ForeignKey [FK_GroupMessage_Group]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[GroupMessage]  WITH CHECK ADD  CONSTRAINT [FK_GroupMessage_Group] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Group] ([Id])
GO
ALTER TABLE [dbo].[GroupMessage] CHECK CONSTRAINT [FK_GroupMessage_Group]
GO
/****** Object:  ForeignKey [FK_Group_Alias_GroupRole_Alias]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Group_Alias_GroupRole]  WITH CHECK ADD  CONSTRAINT [FK_Group_Alias_GroupRole_Alias] FOREIGN KEY([AliasId])
REFERENCES [dbo].[Alias] ([Id])
GO
ALTER TABLE [dbo].[Group_Alias_GroupRole] CHECK CONSTRAINT [FK_Group_Alias_GroupRole_Alias]
GO
/****** Object:  ForeignKey [FK_Group_Alias_GroupRole_Group]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Group_Alias_GroupRole]  WITH CHECK ADD  CONSTRAINT [FK_Group_Alias_GroupRole_Group] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Group] ([Id])
GO
ALTER TABLE [dbo].[Group_Alias_GroupRole] CHECK CONSTRAINT [FK_Group_Alias_GroupRole_Group]
GO
/****** Object:  ForeignKey [FK_Group_Alias_GroupRole_GroupRole]    Script Date: 10/21/2011 16:29:48 ******/
ALTER TABLE [dbo].[Group_Alias_GroupRole]  WITH CHECK ADD  CONSTRAINT [FK_Group_Alias_GroupRole_GroupRole] FOREIGN KEY([GroupRoleId])
REFERENCES [dbo].[GroupRole] ([Id])
GO
ALTER TABLE [dbo].[Group_Alias_GroupRole] CHECK CONSTRAINT [FK_Group_Alias_GroupRole_GroupRole]
GO
/****** Object:  ForeignKey [FK_GroupRequest_Alias]    Script Date: 10/21/2011 16:29:49 ******/
ALTER TABLE [dbo].[GroupRequest]  WITH CHECK ADD  CONSTRAINT [FK_GroupRequest_Alias] FOREIGN KEY([AliasId])
REFERENCES [dbo].[Alias] ([Id])
GO
ALTER TABLE [dbo].[GroupRequest] CHECK CONSTRAINT [FK_GroupRequest_Alias]
GO
/****** Object:  ForeignKey [FK_GroupRequest_GroupRequestType]    Script Date: 10/21/2011 16:29:49 ******/
ALTER TABLE [dbo].[GroupRequest]  WITH CHECK ADD  CONSTRAINT [FK_GroupRequest_GroupRequestType] FOREIGN KEY([RequestTypeId])
REFERENCES [dbo].[GroupRequestType] ([Id])
GO
ALTER TABLE [dbo].[GroupRequest] CHECK CONSTRAINT [FK_GroupRequest_GroupRequestType]
GO
/****** Object:  ForeignKey [FK_GroupMessage_Alias_Alias]    Script Date: 10/21/2011 16:29:49 ******/
ALTER TABLE [dbo].[GroupMessage_Alias]  WITH CHECK ADD  CONSTRAINT [FK_GroupMessage_Alias_Alias] FOREIGN KEY([AliasId])
REFERENCES [dbo].[Alias] ([Id])
GO
ALTER TABLE [dbo].[GroupMessage_Alias] CHECK CONSTRAINT [FK_GroupMessage_Alias_Alias]
GO
/****** Object:  ForeignKey [FK_GroupMessage_Alias_GroupMessage]    Script Date: 10/21/2011 16:29:49 ******/
ALTER TABLE [dbo].[GroupMessage_Alias]  WITH CHECK ADD  CONSTRAINT [FK_GroupMessage_Alias_GroupMessage] FOREIGN KEY([GroupMessageId])
REFERENCES [dbo].[GroupMessage] ([Id])
GO
ALTER TABLE [dbo].[GroupMessage_Alias] CHECK CONSTRAINT [FK_GroupMessage_Alias_GroupMessage]
GO
EXEC dbo.sp_addrolemember @rolename=N'db_datareader', @membername=N'css_server'
GO
EXEC dbo.sp_addrolemember @rolename=N'db_datawriter', @membername=N'css_server'
GO


--Create Roles
INSERT INTO Role (Id, Name) VALUES(1, 'SuperAdministrator')
INSERT INTO Role (Id, Name) VALUES(2, 'Administrator')
INSERT INTO Role (Id, Name) VALUES(3, 'Moderator')
INSERT INTO Role (Id, Name) VALUES(4, 'ZoneLeader')
INSERT INTO Role (Id, Name) VALUES(5, 'User')

-- Create Group Roles
INSERT INTO GroupRole (Name, Token) VALUES('Squad Leader', '*')
INSERT INTO GroupRole (Name, Token) VALUES('Assistant Squad Leader', '^')
INSERT INTO GroupRole (Name, Token) VALUES('Zone Lead', '+')
INSERT INTO GroupRole (Name, Token) VALUES('Developer', '$')
INSERT INTO GroupRole (Name, Token) VALUES('Help Desk', '?')
INSERT INTO GroupRole (Name, Token) VALUES('Pilot', null)
