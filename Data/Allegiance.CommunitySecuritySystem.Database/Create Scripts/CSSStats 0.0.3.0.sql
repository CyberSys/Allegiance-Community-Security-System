
USE [CSSStats]
GO

/****** Object:  User [css_server]    Script Date: 10/21/2011 16:25:12 ******/
CREATE USER [css_server] FOR LOGIN [css_server] WITH DEFAULT_SCHEMA=[css_server]
GO
/****** Object:  Schema [css_server]    Script Date: 10/21/2011 16:25:05 ******/
CREATE SCHEMA [css_server] AUTHORIZATION [css_server]
GO
/****** Object:  Table [dbo].[AS_Q]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AS_Q](
	[EntryID] [int] IDENTITY(1,1) NOT NULL,
	[EntryIndex] [float] NOT NULL,
	[Value] [float] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[EntryIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AS_Q] ON
INSERT [dbo].[AS_Q] ([EntryID], [EntryIndex], [Value]) VALUES (1, 0, 1.2842600961449111)
INSERT [dbo].[AS_Q] ([EntryID], [EntryIndex], [Value]) VALUES (2, 1, 0.46823821248086511)
INSERT [dbo].[AS_Q] ([EntryID], [EntryIndex], [Value]) VALUES (3, 2, 0.065988137868928556)
INSERT [dbo].[AS_Q] ([EntryID], [EntryIndex], [Value]) VALUES (4, 3, 0.0037823963320275824)
INSERT [dbo].[AS_Q] ([EntryID], [EntryIndex], [Value]) VALUES (5, 4, 7.2975155508396618E-05)
SET IDENTITY_INSERT [dbo].[AS_Q] OFF
/****** Object:  Table [dbo].[AS_P]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AS_P](
	[EntryID] [int] IDENTITY(1,1) NOT NULL,
	[EntryIndex] [float] NOT NULL,
	[Value] [float] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[EntryIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AS_P] ON
INSERT [dbo].[AS_P] ([EntryID], [EntryIndex], [Value]) VALUES (1, 0, 0.215898534057957)
INSERT [dbo].[AS_P] ([EntryID], [EntryIndex], [Value]) VALUES (2, 1, 0.12740116116024736)
INSERT [dbo].[AS_P] ([EntryID], [EntryIndex], [Value]) VALUES (3, 2, 0.022235277870649807)
INSERT [dbo].[AS_P] ([EntryID], [EntryIndex], [Value]) VALUES (4, 3, 0.0014216191932278934)
INSERT [dbo].[AS_P] ([EntryID], [EntryIndex], [Value]) VALUES (5, 4, 2.9112874951168793E-05)
INSERT [dbo].[AS_P] ([EntryID], [EntryIndex], [Value]) VALUES (6, 5, 0.023073441764940174)
SET IDENTITY_INSERT [dbo].[AS_P] OFF
/****** Object:  UserDefinedFunction [dbo].[AS_GetRank]    Script Date: 10/21/2011 16:25:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tigereye
-- Create date: October 29th, 2008
-- Description:	Calculates the AllegSkill rank based on the specified Mu and Sigma values
-- =============================================
-- DROP FUNCTION [dbo].[AS_GetRank]
CREATE FUNCTION [dbo].[AS_GetRank]
(
	@Mu FLOAT,
	@Sigma FLOAT
)
RETURNS FLOAT
AS
BEGIN
	DECLARE @Result FLOAT;
		SET @Result = (@Mu - (3.0 * @Sigma)) * (3.0 / 5.0);
	
	IF (@Result < 0.0) SET @Result = 0.0
	
	RETURN @Result;
END
GO
/****** Object:  UserDefinedFunction [dbo].[AS_GetPDF]    Script Date: 10/21/2011 16:25:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tigereye
-- Create date: August 31, 2008
-- Description:	This file is transcribed by Tigereye from the AllegSkill implementation written by Sgt_Baker. 
--              This function is transcribed from CNormalDist.cs, line 201 "public double PDF(double x)
-- =============================================
CREATE FUNCTION [dbo].[AS_GetPDF] (@mean FLOAT, @variance FLOAT, @x FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @Y FLOAT;
		SET @Y = @x - @mean;

	DECLARE @Sigma FLOAT;
		SET @Sigma = SQRT(@variance);

	DECLARE @OneOverSigma FLOAT;
		SET @OneOverSigma = (1.0 / @Sigma);
	
	DECLARE @OneOverRoot2Pi FLOAT;
		SET @OneOverRoot2Pi = 1.0 / SQRT(2.0 * PI());

	DECLARE @C FLOAT;
		SET @C = @OneOverSigma * @OneOverRoot2Pi;

	DECLARE @XMinusMuSqr FLOAT;
		SET @XMinusMuSqr = @Y * @Y;

	DECLARE @PDF FLOAT;
		SET @PDF = @C * EXP(-0.5 * @XMinusMuSqr * (@OneOverSigma * @OneOverSigma));
	
	RETURN @PDF
END
GO
/****** Object:  UserDefinedFunction [dbo].[AS_GetInvErf]    Script Date: 10/21/2011 16:25:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tigereye
-- Create date: August 31, 2008
-- Description:	This file is transcribed by Tigereye from the AllegSkill implementation written by Sgt_Baker. 
--              This function is transcribed from CAllegSkill.cs, line 176 "public double InvErf(double x)
-- =============================================
CREATE FUNCTION [dbo].[AS_GetInvErf] (@x FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @Y FLOAT;
		SET @Y = @x + ((PI() * Power(@x, 3)) / 12.0) +
            ((7 * Power(PI(), 2) * Power(@x, 5)) / 480.0) +
            ((127 * Power(PI(), 3) * Power(@x, 7)) / 40320.0) +
            ((4369 * Power(PI(), 4) * Power(@x, 9)) / 5806080.0) +
            ((34807 * Power(PI(), 5) * Power(@x, 11)) / 182476800.0);
	
	RETURN 0.5 * Sqrt(PI()) * @Y;
END
GO
/****** Object:  Table [dbo].[GameServer]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameServer](
	[GameServerID] [int] IDENTITY(1,1) NOT NULL,
	[GameServerName] [varchar](255) NOT NULL,
	[GameServerOwnerName] [varchar](255) NOT NULL,
 CONSTRAINT [PK_GameServer] PRIMARY KEY CLUSTERED 
(
	[GameServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameEventType]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameEventType](
	[GameEventTypeID] [int] IDENTITY(1,1) NOT NULL,
	[GameEventID] [int] NOT NULL,
	[GameEventCode] [varchar](50) NOT NULL,
	[GameEventDesc] [varchar](255) NOT NULL,
 CONSTRAINT [PK_GameEventType] PRIMARY KEY CLUSTERED 
(
	[GameEventTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AS_D]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AS_D](
	[EntryID] [int] IDENTITY(1,1) NOT NULL,
	[EntryIndex] [float] NOT NULL,
	[Value] [float] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[EntryIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AS_D] ON
INSERT [dbo].[AS_D] ([EntryID], [EntryIndex], [Value]) VALUES (1, 0, 22.266688044328117)
INSERT [dbo].[AS_D] ([EntryID], [EntryIndex], [Value]) VALUES (2, 1, 235.387901782625)
INSERT [dbo].[AS_D] ([EntryID], [EntryIndex], [Value]) VALUES (3, 2, 1519.3775994075547)
INSERT [dbo].[AS_D] ([EntryID], [EntryIndex], [Value]) VALUES (4, 3, 6485.5582982667611)
INSERT [dbo].[AS_D] ([EntryID], [EntryIndex], [Value]) VALUES (5, 4, 18615.571640885097)
INSERT [dbo].[AS_D] ([EntryID], [EntryIndex], [Value]) VALUES (6, 5, 34900.952721145979)
INSERT [dbo].[AS_D] ([EntryID], [EntryIndex], [Value]) VALUES (7, 6, 38912.00328609327)
INSERT [dbo].[AS_D] ([EntryID], [EntryIndex], [Value]) VALUES (8, 7, 19685.429676859992)
SET IDENTITY_INSERT [dbo].[AS_D] OFF
/****** Object:  Table [dbo].[AS_C]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AS_C](
	[EntryID] [int] IDENTITY(1,1) NOT NULL,
	[EntryIndex] [float] NOT NULL,
	[Value] [float] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[EntryIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AS_C] ON
INSERT [dbo].[AS_C] ([EntryID], [EntryIndex], [Value]) VALUES (1, 0, 0.39894151208813466)
INSERT [dbo].[AS_C] ([EntryID], [EntryIndex], [Value]) VALUES (2, 1, 8.8831497943883768)
INSERT [dbo].[AS_C] ([EntryID], [EntryIndex], [Value]) VALUES (3, 2, 93.506656132177852)
INSERT [dbo].[AS_C] ([EntryID], [EntryIndex], [Value]) VALUES (4, 3, 597.27027639480025)
INSERT [dbo].[AS_C] ([EntryID], [EntryIndex], [Value]) VALUES (5, 4, 2494.5375852903726)
INSERT [dbo].[AS_C] ([EntryID], [EntryIndex], [Value]) VALUES (6, 5, 6848.1904505362827)
INSERT [dbo].[AS_C] ([EntryID], [EntryIndex], [Value]) VALUES (7, 6, 11602.65143764735)
INSERT [dbo].[AS_C] ([EntryID], [EntryIndex], [Value]) VALUES (8, 7, 9842.7148383839776)
INSERT [dbo].[AS_C] ([EntryID], [EntryIndex], [Value]) VALUES (9, 8, 1.0765576773720192E-08)
SET IDENTITY_INSERT [dbo].[AS_C] OFF
/****** Object:  Table [dbo].[AS_B]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AS_B](
	[EntryID] [int] IDENTITY(1,1) NOT NULL,
	[EntryIndex] [float] NOT NULL,
	[Value] [float] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[EntryIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AS_B] ON
INSERT [dbo].[AS_B] ([EntryID], [EntryIndex], [Value]) VALUES (1, 0, 47.202581904688245)
INSERT [dbo].[AS_B] ([EntryID], [EntryIndex], [Value]) VALUES (2, 1, 976.09855173777669)
INSERT [dbo].[AS_B] ([EntryID], [EntryIndex], [Value]) VALUES (3, 2, 10260.932208618979)
INSERT [dbo].[AS_B] ([EntryID], [EntryIndex], [Value]) VALUES (4, 3, 45507.789335026733)
SET IDENTITY_INSERT [dbo].[AS_B] OFF
/****** Object:  Table [dbo].[StatsMetrics]    Script Date: 10/21/2011 16:25:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatsMetrics](
	[StatsMetricsId] [int] IDENTITY(1,1) NOT NULL,
	[TotalGamesLogged] [int] NOT NULL,
	[LastGameProcessed] [int] NOT NULL,
	[AveragePlayerRank] [float] NOT NULL,
	[AverageCommandRank] [float] NOT NULL,
	[DateModified] [datetime] NOT NULL,
 CONSTRAINT [PK_StatsMetrics] PRIMARY KEY CLUSTERED 
(
	[StatsMetricsId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatsLeaderboard]    Script Date: 10/21/2011 16:25:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatsLeaderboard](
	[StatsLeaderboardId] [int] IDENTITY(1,1) NOT NULL,
	[LoginUsername] [nvarchar](50) NULL,
	[LoginID] [int] NOT NULL,
	[Mu] [float] NOT NULL,
	[Sigma] [float] NOT NULL,
	[Rank] [float] NOT NULL,
	[Wins] [int] NOT NULL,
	[Losses] [int] NOT NULL,
	[Draws] [int] NOT NULL,
	[Defects] [int] NOT NULL,
	[StackRating] [float] NOT NULL,
	[CommandMu] [float] NOT NULL,
	[CommandSigma] [float] NOT NULL,
	[CommandRank] [float] NOT NULL,
	[CommandWins] [int] NOT NULL,
	[CommandLosses] [int] NOT NULL,
	[CommandDraws] [int] NOT NULL,
	[Kills] [int] NOT NULL,
	[Ejects] [int] NOT NULL,
	[DroneKills] [int] NOT NULL,
	[StationKills] [int] NOT NULL,
	[StationCaptures] [int] NOT NULL,
	[HoursPlayed] [float] NOT NULL,
	[DateModified] [datetime] NOT NULL,
 CONSTRAINT [PK_StatsLeaderboard] PRIMARY KEY CLUSTERED 
(
	[StatsLeaderboardId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_StatsLeaderboard] ON [dbo].[StatsLeaderboard] 
(
	[LoginID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatsFaction]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StatsFaction](
	[StatsFactionId] [int] IDENTITY(1,1) NOT NULL,
	[WinFactionName] [varchar](50) NOT NULL,
	[WinStarbase] [bit] NOT NULL,
	[WinSupremacy] [bit] NOT NULL,
	[WinTactical] [bit] NOT NULL,
	[WinExpansion] [bit] NOT NULL,
	[WinShipyard] [bit] NOT NULL,
	[LossFactionName] [varchar](50) NOT NULL,
	[LossStarbase] [bit] NOT NULL,
	[LossSupremacy] [bit] NOT NULL,
	[LossTactical] [bit] NOT NULL,
	[LossExpansion] [bit] NOT NULL,
	[LossShipyard] [bit] NOT NULL,
	[GamesPlayed] [int] NOT NULL,
	[HoursPlayed] [float] NOT NULL,
	[DateModified] [datetime] NOT NULL,
 CONSTRAINT [PK_StatsFaction] PRIMARY KEY CLUSTERED 
(
	[StatsFactionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AS_A]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AS_A](
	[EntryID] [int] IDENTITY(1,1) NOT NULL,
	[EntryIndex] [float] NOT NULL,
	[Value] [float] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[EntryIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AS_A] ON
INSERT [dbo].[AS_A] ([EntryID], [EntryIndex], [Value]) VALUES (1, 0, 2.2352520354606837)
INSERT [dbo].[AS_A] ([EntryID], [EntryIndex], [Value]) VALUES (2, 1, 161.02823106855587)
INSERT [dbo].[AS_A] ([EntryID], [EntryIndex], [Value]) VALUES (3, 2, 1067.6894854603709)
INSERT [dbo].[AS_A] ([EntryID], [EntryIndex], [Value]) VALUES (4, 3, 18154.981253343562)
INSERT [dbo].[AS_A] ([EntryID], [EntryIndex], [Value]) VALUES (5, 4, 0.065682337918207448)
SET IDENTITY_INSERT [dbo].[AS_A] OFF
/****** Object:  Table [dbo].[GameServerIP]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameServerIP](
	[GameServerIpID] [int] IDENTITY(1,1) NOT NULL,
	[GameServerID] [int] NOT NULL,
	[IPAddress] [varchar](20) NOT NULL,
 CONSTRAINT [PK_GameServerIP] PRIMARY KEY CLUSTERED 
(
	[GameServerIpID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Game]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Game](
	[GameIdentID] [int] IDENTITY(1,1) NOT NULL,
	[GameID] [int] NOT NULL,
	[GameServer] [int] NOT NULL,
	[GameName] [varchar](255) NOT NULL,
	[GameCore] [varchar](50) NOT NULL,
	[GameMap] [varchar](50) NOT NULL,
	[GameSquadGame] [bit] NOT NULL,
	[GameConquest] [bit] NOT NULL,
	[GameDeathMatch] [bit] NOT NULL,
	[GameDeathmatchGoal] [int] NULL,
	[GameFriendlyFire] [bit] NOT NULL,
	[GameRevealMap] [bit] NULL,
	[GameDevelopments] [bit] NOT NULL,
	[GameShipyards] [bit] NOT NULL,
	[GameDefections] [bit] NOT NULL,
	[GameInvulStations] [bit] NOT NULL,
	[GameStatsCount] [bit] NOT NULL,
	[GameMaxImbalance] [int] NOT NULL,
	[GameStartingMoney] [float] NOT NULL,
	[GameTotalMoney] [float] NOT NULL,
	[GameResources] [int] NOT NULL,
	[GameStartTime] [datetime] NOT NULL,
	[GameEndTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Game] PRIMARY KEY CLUSTERED 
(
	[GameIdentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AS_AllegSkill]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AS_AllegSkill](
	[AllegSkillID] [int] IDENTITY(1,1) NOT NULL,
	[LoginID] [int] NULL,
	[Mu] [float] NOT NULL,
	[Sigma] [float] NOT NULL,
	[CommandMu] [float] NOT NULL,
	[CommandSigma] [float] NOT NULL,
	[StackRating] [float] NOT NULL,
	[Wins] [int] NOT NULL,
	[Losses] [int] NOT NULL,
	[Draws] [int] NOT NULL,
	[CommandWins] [int] NOT NULL,
	[CommandLosses] [int] NOT NULL,
	[CommandDraws] [int] NOT NULL,
	[Defections] [int] NOT NULL,
	[Kills] [int] NOT NULL,
	[Ejects] [int] NOT NULL,
	[DroneKills] [int] NOT NULL,
	[StationKills] [int] NOT NULL,
	[StationCaptures] [int] NOT NULL,
	[SecondsInGame] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[AS_GetCDF]    Script Date: 10/21/2011 16:25:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tigereye
-- Create date: August 31, 2008
-- Description:	This file is transcribed by Tigereye from the AllegSkill implementation written by Sgt_Baker. 
--              This function is transcribed from CNormalDist.cs, line 219 "public double CDF(double x)
-- =============================================
--IF OBJECT_ID('dbo.AS_GetCDF', 'U') IS NOT NULL DROP FUNCTION [dbo].[AS_GetCDF];
CREATE FUNCTION [dbo].[AS_GetCDF] (@mean FLOAT, @variance FLOAT, @x FLOAT)
RETURNS FLOAT

AS
BEGIN
	DECLARE @I INT;
	DECLARE @Del FLOAT, @Temp FLOAT, @Z FLOAT, @Y FLOAT, @Min FLOAT;
	DECLARE @Arg DECIMAL(38,20), @Ccum DECIMAL(38,20), @Xden DECIMAL(38,20), @XNum DECIMAL(38,20), @Xsq DECIMAL(38,20), @Result DECIMAL(38,20)
	
	-- Class-level Variable Declarations (at top of CNormalDist.cs)
	DECLARE @MACHINE_EPSILON FLOAT;
		SET @MACHINE_EPSILON = 1.0e-12;

	DECLARE @Thrsh FLOAT;
		SET @Thrsh = 0.66291e0;

	DECLARE @Half FLOAT;
		SET @Half = 0.5e0;
	
	DECLARE @Sixten FLOAT;
		SET @Sixten = 1.60e0;
	
	DECLARE @SqrPi FLOAT;
		SET @SqrPi = 3.9894228040143267794e-1;

	DECLARE @Root32 FLOAT;
		SET @Root32 = 5.656854248e0;

	DECLARE @Sigma FLOAT;
		SET @Sigma = SQRT(@variance);

	-- Function-level Declarations (At top of CDF. Line 228)
	SET @Arg = (@x - @mean) / @Sigma;

	SET @Min = 4.94065645841247E-304;	--4.94065645841247E-324
	SET @Z = @Arg;
	SET @Y = ABS(@Z);
	
	IF (@Y <= @Thrsh)
	BEGIN
		-- Evaluate anorm for |X| <= 0.66291
		SET @Xsq = 0.0;
		IF (@Y > @MACHINE_EPSILON) SET @Xsq = @Z * @Z;
		
		SET @Xnum = @Xsq * (SELECT Value FROM AS_A WHERE EntryIndex = 4);
		SET @Xden = @Xsq;
		
		SET @I = 0;		-- Begin FOR loop in CNormalDist.cs line 242
		WHILE (@I < 3)
		BEGIN
			SET @Xnum = (@Xnum + (SELECT Value FROM AS_A WHERE EntryIndex = @I)) * @Xsq;
			SET @Xden = (@Xden + (SELECT Value FROM AS_B WHERE EntryIndex = @I)) * @Xsq;
			SET @I = @I + 1;
		END
		SET @Result = @Z * (@Xnum + (SELECT Value FROM AS_A WHERE EntryIndex = 3)) / (@Xden + (SELECT Value FROM AS_B WHERE EntryIndex = 3))
		SET @Temp = @Result;
		SET @Result = @Half + @Temp;
		SET @Ccum = @Half - @Temp;
	END
	ELSE	-- Evaluate anorm for 0.66291 <= |X| <= sqrt(32)
	BEGIN
		IF (@Y <= @Root32)		-- CNormalDist.cs Line 256
		BEGIN
			SET @Xnum = (SELECT Value FROM AS_C WHERE EntryIndex = 8) * @Y;
			SET @Xden = @Y;
			
			SET @I = 0;
			WHILE (@I < 7) -- FOR loop at Line 260
			BEGIN
				SET @Xnum = (@XNum + (SELECT Value FROM AS_C WHERE EntryIndex = @I)) * @Y;
				SET @Xden = (@XDen + (SELECT Value FROM AS_D WHERE EntryIndex = @I)) * @Y;
				
				SET @I = @I + 1;
			END
			SET @Result = (@Xnum + (SELECT Value FROM AS_C WHERE EntryIndex = 7)) / (@Xden + (SELECT Value FROM AS_D WHERE EntryIndex = 7))
			SET @Xsq = Floor(@Y * @Sixten) / @Sixten;
			SET @Del = (@Y - @Xsq) * (@Y + @Xsq);
			SET @Result = Exp(-1.0 * @Xsq * @Xsq * @Half) * Exp(-1.0 * @Del * @Half) * @Result;
			SET @Ccum = 1.0 - @Result;
			
			IF (@Z > 0.0)
			BEGIN
				SET @Temp = @Result;
				SET @Result = @Ccum;
				SET @Ccum = @Temp;
			END
		END
		ELSE	-- CNormalDist.cs Line 281
		BEGIN
			-- Evaluate anorm for |X| > sqrt(32)
			SET @Result = 0.0;
			SET @Xsq = 1.0 / (@Z * @Z)
			SET @Xnum = (SELECT Value FROM AS_P WHERE EntryIndex = 5) * @Xsq;
			SET @Xden = @Xsq;
			
			SET @I = 0;
			WHILE (@I < 4)
			BEGIN
				SET @Xnum = (@XNum + (SELECT Value FROM AS_P WHERE EntryIndex = @I)) * @Xsq;
				SET @Xden = (@XDen + (SELECT Value FROM AS_Q WHERE EntryIndex = @I)) * @Xsq;
				
				SET @I = @I + 1;
			END
			SET @Result = @Xsq * (@Xnum + (SELECT Value FROM AS_P WHERE EntryIndex = 4)) / (@Xden + (SELECT Value FROM AS_Q WHERE EntryIndex = 4));
			SET @Result = (@SqrPi - @Result) / @Y;
			SET @Xsq = Floor(@Z * @SixTen) / @SixTen;
			SET @Del = (@Z - @Xsq) * (@Z + @Xsq);
			SET @Result = Exp(-1.0 * @Xsq * @Xsq * @Half) * Exp(-1.0 * @Del * @Half) * @Result;
			SET @Ccum = 1.0 - @Result;
			IF (@Z > 0.0)
			BEGIN
				SET @Temp = @Result;
				SET @Result = @Ccum;
				SET @Ccum = @Temp;
			END
		END
	END
	
	-- Line 306
	IF (@Result < @Min) SET @Result = 0.0;
	IF (@Ccum < @Min) SET @Ccum = 0.0;

	RETURN CAST(@RESULT AS FLOAT);
END
GO
/****** Object:  Table [dbo].[AS_GameStats]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AS_GameStats](
	[GameStatsID] [int] IDENTITY(1,1) NOT NULL,
	[GameID] [int] NULL,
	[MatchQuality] [float] NOT NULL,
	[Team1ConservativeRank] [float] NOT NULL,
	[Team2ConservativeRank] [float] NOT NULL,
	[Team3ConservativeRank] [float] NULL,
	[Team4ConservativeRank] [float] NULL,
	[Team5ConservativeRank] [float] NULL,
	[Team6ConservativeRank] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AS_GamePlayerAS]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AS_GamePlayerAS](
	[GamePlayerASID] [int] IDENTITY(1,1) NOT NULL,
	[GameID] [int] NULL,
	[LoginID] [int] NULL,
	[NewMu] [float] NOT NULL,
	[NewSigma] [float] NOT NULL,
	[NewCommandMu] [float] NOT NULL,
	[NewCommandSigma] [float] NOT NULL,
	[StackRatingChange] [float] NOT NULL,
	[Defected] [int] NOT NULL,
	[KillCount] [int] NOT NULL,
	[EjectCount] [int] NOT NULL,
	[DroneKillCount] [int] NOT NULL,
	[StationKillCount] [int] NOT NULL,
	[StationCaptureCount] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GameEvent]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameEvent](
	[GameID] [int] NOT NULL,
	[GameEventID] [int] IDENTITY(1,1) NOT NULL,
	[EventID] [int] NOT NULL,
	[GameEventTime] [datetime] NOT NULL,
	[GameEventPerformerID] [int] NOT NULL,
	[GameEventPerformerLoginID] [int] NOT NULL,
	[GameEventPerformerName] [varchar](50) NOT NULL,
	[GameEventTargetID] [int] NOT NULL,
	[GameEventTargetLoginID] [int] NOT NULL,
	[GameEventTargetName] [varchar](50) NOT NULL,
	[GameEventIndirectID] [int] NOT NULL,
	[GameEventIndirectName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_GameEvent] PRIMARY KEY CLUSTERED 
(
	[GameEventID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameChatLog]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameChatLog](
	[GameChatLogIdentID] [int] IDENTITY(1,1) NOT NULL,
	[GameID] [int] NOT NULL,
	[GameChatTime] [datetime] NOT NULL,
	[GameChatSpeakerName] [varchar](50) NOT NULL,
	[GameChatTargetName] [varchar](50) NOT NULL,
	[GameChatText] [varchar](2064) NOT NULL,
 CONSTRAINT [PK_GameChatLog] PRIMARY KEY CLUSTERED 
(
	[GameChatLogIdentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameTeam]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameTeam](
	[GameTeamIdentID] [int] IDENTITY(1,1) NOT NULL,
	[GameTeamID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[GameTeamNumber] [int] NOT NULL,
	[GameTeamName] [varchar](50) NOT NULL,
	[GameTeamCommander] [varchar](50) NOT NULL,
	[GameTeamCommanderLoginID] [int] NOT NULL,
	[GameTeamFaction] [varchar](50) NOT NULL,
	[GameTeamStarbase] [bit] NOT NULL,
	[GameTeamSupremacy] [bit] NOT NULL,
	[GameTeamTactical] [bit] NOT NULL,
	[GameTeamExpansion] [bit] NOT NULL,
	[GameTeamShipyard] [bit] NOT NULL,
	[GameTeamWinner] [bit] NOT NULL,
 CONSTRAINT [PK_GameTeam] PRIMARY KEY CLUSTERED 
(
	[GameTeamIdentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameTeamMember]    Script Date: 10/21/2011 16:25:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameTeamMember](
	[GameTeamMemberIdentID] [int] IDENTITY(1,1) NOT NULL,
	[GameTeamID] [int] NOT NULL,
	[GameTeamMemberCallsign] [varchar](50) NOT NULL,
	[GameTeamMemberDuration] [int] NOT NULL,
	[GameTeamMemberLoginID] [int] NOT NULL,
 CONSTRAINT [PK_GameTeamMember] PRIMARY KEY CLUSTERED 
(
	[GameTeamMemberIdentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[ASGSServiceUpdateASRankings]    Script Date: 10/21/2011 16:25:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tigereye, ported from sgt_baker's C# implementation
-- Create date: December 8, 2008
-- Description:	Updates the AllegSkill rankings with the stats collected in the specified GameID
-- =============================================
--IF OBJECT_ID('dbo.ASGSServiceUpdateASRankings', 'U') IS NOT NULL DROP PROCEDURE [dbo].[ASGSServiceUpdateASRankings];
CREATE PROCEDURE [dbo].[ASGSServiceUpdateASRankings] @GameID INT, @DebugMode INT = 0
AS
BEGIN
	SET NOCOUNT ON;
	
	-- DON'T UPDATE RANKINGS FOR A GAME THAT HAS ALREADY BEEN PROCESSED
	IF (((SELECT COUNT(GameID) FROM AS_GameStats WHERE GameID = @GameID) > 0) AND
		@DebugMode = 0)
	BEGIN
		RAISERROR('This game has already been processed.',16,1)
		RETURN
	END
	
	-- SET UP SOME CONSTANTS
	DECLARE @MAX_TEAMS INT
		SET @MAX_TEAMS = 2					-- Maximum 2 teams
	DECLARE @MIN_GAME_LENGTH_SECONDS INT
		SET @MIN_GAME_LENGTH_SECONDS = 300	-- 300seconds = 5mins
	DECLARE @MIN_PLAYERS_FOR_HALFGAME INT
		SET @MIN_PLAYERS_FOR_HALFGAME = 10	-- 10 players must have played > 1/2 the game 

	-- AllegSkill CONSTANTS
	DECLARE @INITIAL_MU FLOAT
		SET @INITIAL_MU = 25.0
	DECLARE @DYNAMICS_DIVISOR FLOAT
		SET @DYNAMICS_DIVISOR = 300.0
	DECLARE @PERFORMANCE_DIVISOR FLOAT
		SET @PERFORMANCE_DIVISOR = 6.0
	DECLARE @VARIANCE_DIVISOR FLOAT
		SET @VARIANCE_DIVISOR = 6.0
	DECLARE @DRAW_PERCENT FLOAT
		SET @DRAW_PERCENT = 1.101385

	DECLARE @DYNAMICS FLOAT
		SET @DYNAMICS = (@INITIAL_MU / @DYNAMICS_DIVISOR)
	DECLARE @PERFORMANCE FLOAT
		SET @PERFORMANCE = (@INITIAL_MU / @PERFORMANCE_DIVISOR)
	DECLARE @VARIANCE FLOAT
		SET @VARIANCE = (@INITIAL_MU / @VARIANCE_DIVISOR)

    DECLARE @GameDuration INT
    SET @GameDuration = (SELECT DATEDIFF(second,GameStartTime,GameEndTime) FROM Game WHERE GameIdentID = @GameID)

	-- GAME COUNTS BY DEFAULT
	DECLARE @GameCounted INT
		SET @GameCounted = 1

	-- TO BE OUTPUT VIA THE WEBSERVICE
	DECLARE @GameReason varchar(100)
		SET @GameReason = 'Game did not count.'

	-- SEE IF STATS WERE ENABLED IN GAME SETTINGS
	DECLARE @GameStatsCounted INT
		SET @GameStatsCounted = (SELECT GameStatsCount FROM Game WHERE GameIdentID = @GameID)

	-- THIS SHOULDN'T HAPPEN
	IF @GameDuration < 1 
	BEGIN
		SET @GameReason = 'Game did not count because duration was zero or negative'
		SET @GameCounted = 0
	END
	
	-- CHECK TO SEE IF GAME SHOULD COUNT

	-- GAMES WITH 'Stats Count' TURNED OFF DO NOT COUNT. 
	SET @GameStatsCounted = 1	-- Override this for now
	IF @GameStatsCounted <> 1
	BEGIN
		SET @GameReason = 'Game did not count because the Stats Count game setting was disabled.'
		SET @GameCounted = 0
	END

	-- 3+ TEAMERS DO NOT COUNT
	IF ((SELECT MAX(GameTeamNumber) FROM GameTeam WHERE GameID = @GameID) > 1)
	BEGIN
		SET @GameReason = 'Game did not count because more than two teams participated.'
		SET @GameCounted = 0
	END

	-- GAMES WITH FEWER THAN 10 PLAYERS FOR HALF THE GAME DO NOT COUNT
	IF ((SELECT COUNT(gtm.GameTeamMemberLoginID) FROM GameTeamMember gtm INNER JOIN GameTeam gt ON gt.GameTeamIdentID = gtm.GameTeamID WHERE gt.GameID = @GameID AND gtm.GameTeamMemberDuration > (@GameDuration / 2)) < @MIN_PLAYERS_FOR_HALFGAME)
	BEGIN
		SET @GameReason = 'Game did not count because less than ' + CONVERT(VARCHAR(4), @MIN_PLAYERS_FOR_HALFGAME) + ' players played for at least half of the game.'
		SET @GameCounted = 0
	END
	
	-- GAMES LESS THAN 5 MINUTES DO NOT COUNT
	IF (@GameDuration < @MIN_GAME_LENGTH_SECONDS)
	BEGIN
		SET @GameReason = 'Game did not count because it was not ' + CONVERT(VARCHAR(4), (@MIN_GAME_LENGTH_SECONDS / 60)) + 'mins long.'
		SET @GameCounted = 0
	END
	
	-- FIND OUT IF GAME WAS A DRAW
	DECLARE @GameIsDraw INT
		SET @GameIsDraw = 0
		
	-- BT 12/23/2010 - Convert from bit to int for summation.
	IF (SELECT SUM(CONVERT(INT, (CASE WHEN GameTeamWinner = 0 THEN 0 ELSE 1 END))) FROM GameTeam WHERE GameID = @GameID) = 0
		SET @GameIsDraw = 1
	
	IF @DebugMode = 1
	BEGIN
		IF @GameIsDraw = 1 PRINT 'GAME ' + CONVERT(VARCHAR(10), @GameID) + ' WAS A DRAW!' ELSE PRINT 'Game ' + CONVERT(VARCHAR(10), @GameID) + ' was won.'
	END
	
	-- DRAWS DO NOT COUNT
	IF @GameIsDraw = 1
	BEGIN
		SET @GameReason = 'Game did not count because it was a draw.'
		SET @GameCounted = 0
	END
	
	-- IF THE GAME COUNTED, CALCULATE STATS
	IF @GameCounted = 1
	BEGIN
		IF @DebugMode = 1 PRINT 'Game Counted. Processing stats...'
		
		-- GRAB THE WINNING/LOSING TEAM IDs AND INDICES.
		DECLARE @LosingTeamID INT
			SET @LosingTeamID = (SELECT TOP 1 GameTeamIdentID FROM GameTeam WHERE GameID = @GameID AND GameTeamWinner = 0)
		DECLARE @WinningTeamID INT
			SET @WinningTeamID = (SELECT TOP 1 GameTeamIdentID FROM GameTeam WHERE GameID = @GameID AND GameTeamIdentID <> @LosingTeamID)

		DECLARE @LosingTeamIndex INT
			SET @LosingTeamIndex = (SELECT GameTeamNumber FROM GameTeam WHERE GameTeamIdentID = @LosingTeamID)
		DECLARE @WinningTeamIndex INT
			SET @WinningTeamIndex = (SELECT GameTeamNumber FROM GameTeam WHERE GameTeamIdentID = @WinningTeamID)
		
		IF @DebugMode = 1
		BEGIN
			PRINT 'Winning Team Index: ' + CONVERT(VARCHAR(2), @WinningTeamIndex)
			PRINT 'Losing Team Index: ' + CONVERT(VARCHAR(2), @LosingTeamIndex)
			PRINT ''
		END

		-- CREATE A TEMPORARY TABLE TO WORK THROUGH THE STATS
		DECLARE @PlayerCount INT;
		DECLARE @Players TABLE (
			GTM_ID INT,
			LoginID INT,
			Callsign VARCHAR(50),
			Team INT,
			SecondsPlayed INT,
			FractionPlayed FLOAT,
			Mu FLOAT,
			Sigma FLOAT,
			DeltaMu FLOAT,
			DeltaSigma FLOAT,
			CommandMu FLOAT,
			CommandSigma FLOAT,
			StackRating FLOAT,
			Defector INT,
			GamePlayerKills INT,
			GameDroneKills INT,
			GameEjects INT,
			GameStationKills INT,
			GameStationCaptures INT,
			Pass INT)
		
		-- GET ALL THE CALLSIGNS FOR THIS GAME AND INSERT THEM INTO OUR TEMPORARY TABLE
		INSERT INTO @Players
			 SELECT DISTINCT 
					gtm.GameTeamMemberIdentID AS 'GTM_ID',
					gtm.GameTeamMemberLoginID AS 'LoginID',
					gtm.GameTeamMemberCallsign AS 'Callsign', 
					gt.GameTeamIdentID AS 'Team',
					gtm.GameTeamMemberDuration AS 'SecondsPlayed',
					(CONVERT(FLOAT, gtm.GameTeamMemberDuration) / CONVERT(FLOAT, @GameDuration)) AS 'FractionPlayed',
					0.0 AS 'Mu',
					0.0 AS 'Sigma',
					0.0 AS 'DeltaMu',
					0.0 AS 'DeltaSigma',
					0.0 AS 'CommandMu',
					0.0 AS 'CommandSigma',
					0.0 AS 'StackRating',
					0 AS 'GamePlayerKills',
					0 AS 'GameDroneKills',
					0 AS 'GameEjects',
					0 AS 'GameStationKills',
					0 AS 'GameStationCaptures',
					0 AS 'Defector',
					-1 AS 'Pass'
			   FROM GameTeamMember gtm
		 INNER JOIN GameTeam gt ON gt.GameTeamIdentID = gtm.GameTeamID
			  WHERE gt.GameID = @GameID
		
		IF @DebugMode = 1
		BEGIN
			SET @PlayerCount = (SELECT COUNT(*) FROM @Players);
			PRINT 'All Callsigns In Game (' + CONVERT(VARCHAR(5), @PlayerCount) + '):'
			SELECT * FROM @Players
		END
		
		IF (@DebugMode = 1)
		BEGIN
			IF ((SELECT COUNT(p.LoginID) FROM @Players p LEFT JOIN StatsLeaderboard sl ON (p.LoginID = sl.LoginID) WHERE sl.LoginID IS NULL) > 0)
			BEGIN
				PRINT 'Members that dont exist:'
				SELECT p.LoginID
				FROM @Players p LEFT JOIN StatsLeaderboard sl ON (p.LoginID = sl.LoginID)
				WHERE sl.LoginID IS NULL
			END
		END
		ELSE
		BEGIN
			-- DELETE PLAY ENTRIES FOR CALLSIGNS THAT DON'T ACTUALLY EXIST
			DELETE @Players
				WHERE LoginID IN (SELECT p.LoginID FROM @Players p LEFT JOIN StatsLeaderboard sl ON (p.LoginID = sl.LoginID) WHERE sl.LoginID IS NULL)
		END
		
		-- GRAB COMMANDER LoginIDs
		DECLARE @WinningCommLoginID INT
			SET @WinningCommLoginID = (SELECT GameTeamCommanderLoginID FROM GameTeam WHERE GameTeamIdentID = @WinningTeamID)
		DECLARE @LosingCommLoginID INT
			SET @LosingCommLoginID = (SELECT GameTeamCommanderLoginID FROM GameTeam WHERE GameTeamIdentID = @LosingTeamID)

		IF @DebugMode = 1
		BEGIN
			PRINT 'Winning Comm: ' + CONVERT(VARCHAR(10), @WinningCommLoginID);
			PRINT 'Losing Comm: ' + CONVERT(VARCHAR(10), @LosingCommLoginID);
			PRINT '';
		END
		
		-- ABORT IF COMMANDERS DO NOT EXIST
		IF (((SELECT COUNT(LoginID) FROM StatsLeaderboard WHERE LoginID IN (@WinningCommLoginID, @LosingCommLoginID)) < 2) OR (SELECT COUNT(LoginID) FROM @Players WHERE LoginID IN (@WinningCommLoginID, @LosingCommLoginID)) < 2)
		BEGIN
			RAISERROR('One or more of the commanders of this game do not exist. Game ignored.',16,1)
			RETURN
		END
		
		-- FLAG DEFECTORS, AND AGGREGATE WHORESTATS
		DECLARE @DefectCheckID INT
		DECLARE @DefectCheckLoginID INT
		DECLARE @DefectCheckTeam INT
		DECLARE @CumulativeDuration INT
		WHILE (SELECT COUNT(*) FROM @PLAYERS WHERE Pass = -1) > 0
		BEGIN
			SET @DefectCheckID = (SELECT TOP 1 GTM_ID FROM @Players WHERE Pass = -1)
			SET @DefectCheckLoginID = (SELECT TOP 1 LoginID FROM @Players WHERE GTM_ID = @DefectCheckID)
			SET @DefectCheckTeam = (SELECT Team FROM @Players WHERE GTM_ID = @DefectCheckID)
			SET @CumulativeDuration = (SELECT SUM(SecondsPlayed) FROM @Players WHERE LoginID = @DefectCheckLoginID AND Team = @DefectCheckTeam)

			-- IF THIS PLAYER DEFECTED, RECORD IT
			IF (((SELECT COUNT(DISTINCT Team) FROM @Players WHERE LoginID = @DefectCheckLoginID) > 1) AND ((SELECT Defector FROM @Players WHERE GTM_ID = @DefectCheckID) = 0))
			BEGIN
				IF @DebugMode = 1 PRINT '		FLAGGING DEFECTOR: ' + CONVERT(VARCHAR(6), @DefectCheckLoginID)
				UPDATE @Players
				SET Defector = 1,
				SecondsPlayed = @CumulativeDuration
				WHERE LoginID = @DefectCheckLoginID
			END
			
			-- COUNT THIS PLAYER AS CHECKED
			UPDATE @Players
			SET Pass = 0,
			FractionPlayed = (CONVERT(FLOAT, @CumulativeDuration) / CONVERT(FLOAT, @GameDuration)),
			GamePlayerKills = (SELECT Count(GameEventTargetLoginID) FROM GameEvent WHERE GameID = @GameID AND Team = @DefectCheckTeam AND EventID = 302 AND GameEventTargetLoginID = @DefectCheckLoginID AND GameEventPerformerName NOT LIKE '.%'),
			GameDroneKills = (SELECT Count(GameEventPerformerLoginID) FROM GameEvent WHERE GameID = @GameID AND Team = @DefectCheckTeam AND EventID = 302 AND GameEventTargetLoginID = @DefectCheckLoginID AND GameEventPerformerName LIKE '.%'),
			GameEjects = (SELECT Count(GameEventPerformerLoginID) FROM GameEvent WHERE GameID = @GameID AND Team = @DefectCheckTeam AND EventID = 302 AND GameEventPerformerLoginID = @DefectCheckLoginID),
			GameStationKills = (SELECT Count(GameEventPerformerLoginID) FROM GameEvent WHERE GameID = @GameID AND Team = @DefectCheckTeam AND EventID = 202 AND GameEventPerformerLoginID = @DefectCheckLoginID),
			GameStationCaptures = (SELECT Count(GameEventPerformerLoginID) FROM GameEvent WHERE GameID = @GameID AND Team = @DefectCheckTeam AND EventID = 203 AND GameEventPerformerLoginID = @DefectCheckLoginID)
			WHERE GTM_ID = @DefectCheckID
			
			-- REMOVE HIDERS FROM THIS SAME TEAM
			DELETE FROM @Players
			WHERE LoginID = @DefectCheckLoginID
					AND GTM_ID != @DefectCheckID
					AND Team = @DefectCheckTeam
					AND LoginID != @WinningCommLoginID
					AND LoginID != @LosingCommLoginID
		END
		-- REMOVE PLAYERS WHO PLAYED 30s OR LESS
		DELETE @Players
		WHERE SecondsPlayed < 30
			AND LoginID != @WinningCommLoginID
			AND LoginID != @LosingCommLoginID
		
		-- CREATE NEW AllegSkill ENTRIES FOR FIRST-TIME PLAYERS
		-- Don't need this, the rows are already in StatsLeaderboard
		--INSERT INTO AS_AllegSkill (LoginID)
		--	SELECT p.LoginID
		--	FROM @Players p LEFT JOIN AS_AllegSkill as_as ON (p.LoginID = as_as.LoginID)
		--	WHERE as_as.LoginID IS NULL
		
		-- UPDATE @Players WITH THEIR CURRENT MU/SIGMA VALUES
		UPDATE @Players
		SET Mu = a.Mu,
		Sigma = a.Sigma,
		CommandMu = a.CommandMu,
		CommandSigma = a.CommandSigma
		FROM @Players p, StatsLeaderboard a
		WHERE a.LoginID = p.LoginID
		
		-- ENSURE DURATIONS MAKE SENSE
		UPDATE @Players
		SET SecondsPlayed = @GameDuration
		WHERE SecondsPlayed > @GameDuration;
		
		UPDATE @Players
		SET SecondsPlayed = 0
		WHERE SecondsPlayed < 0
		
		-- CALCULATE THE TEAM MU AND SIGMA
		DECLARE @DynamicsSquared FLOAT
			SET @DynamicsSquared = @DYNAMICS * @DYNAMICS
		DECLARE @PerformanceSquared FLOAT
			SET @PerformanceSquared = @PERFORMANCE * @PERFORMANCE

		DECLARE @WinningTeamMu FLOAT
			SET @WinningTeamMu = (SELECT SUM(Mu * FractionPlayed) FROM @Players WHERE Team = @WinningTeamID)

		DECLARE @TempSigmaCalc FLOAT
			SET @TempSigmaCalc = ((SELECT SUM(((Sigma * Sigma) * FractionPlayed) + @DynamicsSquared + @PerformanceSquared)
									 FROM @Players
									 WHERE Team = @WinningTeamID) - @DynamicsSquared - @PerformanceSquared);
		
		-- Make sure we don't do a SQRT of a negative number
		IF @TempSigmaCalc < 0.0
		BEGIN
			RAISERROR('The WinningTeamSigma calculation at line 323 was about to calculate the SQRT of a negative number. Game ignored.',16,1)
			RETURN			
		END
		
		DECLARE @WinningTeamSigma FLOAT
			SET @WinningTeamSigma = (SQRT(@TempSigmaCalc))

		DECLARE @LosingTeamMu FLOAT
			SET @LosingTeamMu = (SELECT SUM(Mu * FractionPlayed) FROM @Players WHERE Team = @LosingTeamID)

		SET @TempSigmaCalc = (SELECT SUM(((Sigma * Sigma) * FractionPlayed) + @DynamicsSquared + @PerformanceSquared)
									 FROM @Players
									 WHERE Team = @LosingTeamID) - @DynamicsSquared - @PerformanceSquared;
		
		-- Make sure we don't do a SQRT of a negative number
		IF @TempSigmaCalc < 0.0
		BEGIN
			RAISERROR('The LosingTeamSigma calculation at line 338 was about to calculate the SQRT of a negative number. Game ignored.',16,1)
			RETURN			
		END
		
		DECLARE @LosingTeamSigma FLOAT
			SET @LosingTeamSigma = (SQRT(@TempSigmaCalc))
		
		IF @DebugMode = 1
		BEGIN
			PRINT 'Winning Team Mu: ' + CONVERT(VARCHAR(30), CAST(@WinningTeamMu AS DECIMAL(38, 20)))
			PRINT 'Winning Team Sigma: ' + CONVERT(VARCHAR(30), CAST(@WinningTeamSigma AS DECIMAL(38, 20)))
			PRINT 'Losing Team Mu: ' + CONVERT(VARCHAR(30), CAST(@LosingTeamMu AS DECIMAL(38, 20)))
			PRINT 'Losing Team Sigma: ' + CONVERT(VARCHAR(30), CAST(@LosingTeamSigma AS DECIMAL(38, 20)))
			PRINT ''
			SET @PlayerCount = (SELECT COUNT(*) FROM @Players);
			PRINT 'Populated players(' + CONVERT(VARCHAR(5), @PlayerCount) + '):'
			SELECT * FROM @Players;
		END
		
		-- CALCULATE EPSILON AND C
		-- Line 196 and 191
		DECLARE @NewEpsilon FLOAT
			SET @NewEpsilon = SQRT(2.0) * dbo.AS_GetInvErf(2.0 * (((@DRAW_PERCENT / 100.0) + 1.0) / 2.0) - 1.0) * SQRT(2.0) * @VARIANCE

		DECLARE @CSquared FLOAT
			SET @CSquared = (2.0 * POWER(@VARIANCE, 2) + POWER(@WinningTeamSigma, 2) + POWER(@LosingTeamSigma, 2))
		DECLARE @C FLOAT
			SET @C = SQRT(@CSquared)
		
		IF @DebugMode = 1
		BEGIN
			PRINT 'Epsilon: ' + CONVERT(VARCHAR(25), CAST(@NewEpsilon AS DECIMAL(38, 20)))
			PRINT 'CSquared: ' + CONVERT(VARCHAR(25), CAST(@CSquared AS DECIMAL(38, 20))) + '. C: ' + CONVERT(VARCHAR(25), CAST(@C AS DECIMAL(38, 20)))
			PRINT ''
		END
		
		-- CALCULATE INTERMEDIATE VALUES NEEDED FOR NEW MU AND SIGMA
		DECLARE @MuDifferenceOverC FLOAT
			SET @MuDifferenceOverC = ((@WinningTeamMu - @LosingTeamMu) / @C)
		DECLARE @T FLOAT
			SET @T = @MuDifferenceOverC
		DECLARE @E FLOAT
			SET @E = @NewEpsilon / @C
		
		DECLARE @CDF1 FLOAT
			SET @CDF1 = dbo.AS_GetCDF(0.0, 1.0, (@E - @T))
		DECLARE @CDF2 FLOAT
			SET @CDF2 = dbo.AS_GetCDF(0.0, 1.0, ((-1.0 * @E) - @T))

		DECLARE @TMinusE FLOAT
			SET @TMinusE = (@T - @E);
		DECLARE @Denominator FLOAT
			SET @Denominator = (dbo.AS_GetCDF(0.0, 1.0, (@E - @T)) - dbo.AS_GetCDF(0.0, 1.0, ((-1.0 * @E) - @T)))

		IF @DebugMode = 1
		BEGIN
			PRINT 'MuDiffOverC: ' + CONVERT(VARCHAR(30), CAST(@MuDifferenceOverC AS DECIMAL(38, 20)))
			PRINT 'T: ' + CONVERT(VARCHAR(30), CAST(@T AS DECIMAL(38, 20)))
			PRINT 'E: ' + CONVERT(VARCHAR(30), CAST(@E AS DECIMAL(38, 20)))
			PRINT 'TminusE: ' + CONVERT(VARCHAR(30), CAST(@TMinusE AS DECIMAL(38, 20)))
			PRINT 'Denominator: ' + CONVERT(VARCHAR(30), CAST(@Denominator AS DECIMAL(38, 20)))
			PRINT 'CDF1: ' + CONVERT(VARCHAR(30), CAST(@CDF1 AS decimal(38,20)))
			PRINT 'CDF2: ' + CONVERT(VARCHAR(30), CAST(@CDF2 AS decimal(38,20)))
			PRINT ''
		END
		
		DECLARE @NewWinningTeamMu FLOAT
		DECLARE @NewWinningTeamSigma FLOAT
		DECLARE @NewLosingTeamMu FLOAT
		DECLARE @NewLosingTeamSigma FLOAT
		
		-- CALCULATE THE NEW MU/SIGMAS FOR THE TEAMS
		IF (@GameIsDraw = 0)	-- If game is not draw
		BEGIN
			DECLARE @VWin FLOAT
				SET @VWin = (dbo.AS_GetPDF(0.0, 1.0, @TMinusE) / dbo.AS_GetCDF(0.0, 1.0, @TMinusE))
			DECLARE @WWin FLOAT
				SET @WWin = (@VWin * (@VWin + @TMinusE))

			SET @NewWinningTeamMu = (@WinningTeamMu + POWER(@WinningTeamSigma, 2) / @C * @VWin)
			
			SET @TempSigmaCalc = (POWER(@WinningTeamSigma, 2) * (1.0 - POWER(@WinningTeamSigma, 2) / @CSquared * @WWin) + @DynamicsSquared)
			IF @TempSigmaCalc < 0.0
			BEGIN
				RAISERROR('The WinningTeamSigma calculation at line 411 was about to calculate the SQRT of a negative number. Game ignored.',16,1)
				RETURN			
			END
			SET @NewWinningTeamSigma = (SQRT(@TempSigmaCalc))
			SET @NewLosingTeamMu = (@LosingTeamMu - POWER(@LosingTeamSigma, 2) / @C * @VWin)
			
			SET @TempSigmaCalc = (POWER(@LosingTeamSigma, 2) * (1.0 - POWER(@LosingTeamSigma, 2) / @CSquared * @WWin) + @DynamicsSquared)
			IF @TempSigmaCalc < 0.0
			BEGIN
				RAISERROR('The LosingTeamSigma calculation at line 420 was about to calculate the SQRT of a negative number. Game ignored.',16,1)
				RETURN			
			END
			SET @NewLosingTeamSigma = (SQRT(@TempSigmaCalc))
		
			IF @DebugMode = 1
			BEGIN
				PRINT 'VWin: ' + CONVERT(VARCHAR(15), @VWin)
				PRINT 'WWin: ' + CONVERT(VARCHAR(15), @WWin)
				PRINT ''
			END
		END
		ELSE
		BEGIN	-- Game is draw
			DECLARE @VDraw FLOAT
				SET @VDraw = ((dbo.AS_GetPDF(0.0, 1.0, (-1.0 * @E) - @T) - dbo.AS_GetPDF(0.0, 1.0, @E - @T)) / @Denominator)
			DECLARE @WDraw FLOAT
				SET @WDraw = (POWER(@VDraw, 2) + ((((@E - @T) * dbo.AS_GetPDF(0.0, 1.0, (@E - @T))) + (@E + @T) * dbo.AS_GetPDF(0.0, 1.0, (@E + @T)))) / @Denominator)

			IF @DebugMode = 1
			BEGIN
				PRINT 'VDraw: ' + CONVERT(VARCHAR(25), CAST(@VDraw AS DECIMAL(38, 20)))
				PRINT 'WDraw: ' + CONVERT(VARCHAR(25), CAST(@WDraw AS DECIMAL(38, 20)))
				PRINT 'E: ' + CONVERT(VARCHAR(25), CAST(@E AS DECIMAL(38, 20)))
				PRINT 'T: ' + CONVERT(VARCHAR(25), CAST(@T AS DECIMAL(38, 20)))
				PRINT 'Denominator: ' + CONVERT(VARCHAR(25), CAST(@Denominator AS DECIMAL(38, 20)))
				PRINT ''
			END

			SET @NewWinningTeamMu = (@WinningTeamMu + POWER(@WinningTeamSigma, 2) / @C * @VDraw)
			
			SET @TempSigmaCalc = (POWER(@WinningTeamSigma, 2) * (1.0 - POWER(@WinningTeamSigma, 2) / @CSquared * @WDraw) + @DynamicsSquared)
			IF @TempSigmaCalc < 0.0
			BEGIN
				RAISERROR('The WinningTeamSigma calculation at line 454 was about to calculate the SQRT of a negative number. Game ignored.',16,1)
				RETURN			
			END
			SET @NewWinningTeamSigma = (SQRT(@TempSigmaCalc))
			SET @NewLosingTeamMu = (@LosingTeamMu - POWER(@LosingTeamSigma, 2) / @C * @VDraw)
			
			SET @TempSigmaCalc = (POWER(@LosingTeamSigma, 2) * (1.0 - POWER(@LosingTeamSigma, 2) / @CSquared * @WDraw) + @DynamicsSquared)
			IF @TempSigmaCalc < 0.0
			BEGIN
				RAISERROR('The LosingTeamSigma calculation at line 463 was about to calculate the SQRT of a negative number. Game ignored.',16,1)
				RETURN			
			END
			SET @NewLosingTeamSigma = (SQRT(@TempSigmaCalc))
		END
		
		-- CALCULATE THE TOTAL VARIANCE
		DECLARE @TotalVariance FLOAT
			SET @TotalVariance = (SELECT SUM(((POWER(Sigma, 2) * FractionPlayed) + @DynamicsSquared + @PerformanceSquared)) FROM @Players)
		
		IF @DebugMode = 1
		BEGIN
			PRINT 'New WinningTeamMu: ' + CONVERT(VARCHAR(10), @NewWinningTeamMu)
			PRINT 'New WinningTeamSigma: ' + CONVERT(VARCHAR(10), @NewWinningTeamSigma)
			PRINT 'New LosingTeamMu: ' + CONVERT(VARCHAR(10), @NewLosingTeamMu)
			PRINT 'New LosingTeamSigma: ' + CONVERT(VARCHAR(10), @NewLosingTeamSigma)
			PRINT 'Total Variance: ' + CONVERT(VARCHAR(10), @TotalVariance)
			PRINT ''
		END

		-- Intermediate values for the V/W Win/Loser calcs
		DECLARE @WinningTeamTotalSigmaPlusDyn FLOAT
			SET @WinningTeamTotalSigmaPlusDyn = (((SELECT SUM((POWER(Sigma, 2) * FractionPlayed) + @DynamicsSquared + @PerformanceSquared) FROM @Players WHERE Team = @WinningTeamID) - @DynamicsSquared - @PerformanceSquared) + @DynamicsSquared)
		DECLARE @LosingTeamTotalSigmaPlusDyn FLOAT
			SET @LosingTeamTotalSigmaPlusDyn = (((SELECT SUM((POWER(Sigma, 2) * FractionPlayed) + @DynamicsSquared + @PerformanceSquared) FROM @Players WHERE Team = @LosingTeamID) - @DynamicsSquared - @PerformanceSquared) + @DynamicsSquared)
		
		-- CALCULATE V/W WINNER/LOSER VALUES
		DECLARE @VWinner FLOAT
			SET @VWinner = ((@NewWinningTeamMu - @WinningTeamMu) * SQRT(@TotalVariance) / @WinningTeamTotalSigmaPlusDyn)
		DECLARE @VLoser FLOAT
			SET @VLoser = ((@NewLosingTeamMu - @LosingTeamMu) * SQRT(@TotalVariance) / @LosingTeamTotalSigmaPlusDyn)
		DECLARE @WWinner FLOAT
			SET @WWinner = ((1.0 - (POWER(@NewWinningTeamSigma, 2) / POWER(@WinningTeamSigma, 2))) * @TotalVariance / @WinningTeamTotalSigmaPlusDyn)
		DECLARE @WLoser FLOAT
			SET @WLoser = ((1.0 - (POWER(@NewLosingTeamSigma, 2) / POWER(@LosingTeamSigma, 2))) * @TotalVariance / @LosingTeamTotalSigmaPlusDyn)

		IF @DebugMode = 1
		BEGIN
			PRINT 'VWinner: ' + CONVERT(VARCHAR(20), @VWinner)
			PRINT 'VLoser: ' + CONVERT(VARCHAR(20), @VLoser)
			PRINT 'WWinner: ' + CONVERT(VARCHAR(20), @WWinner)
			PRINT 'WLoser: ' + CONVERT(VARCHAR(20), @WLoser)
			PRINT ''
		END

		-- CALCULATE StackRatings
		DECLARE @WinnerStack FLOAT
			SET @WinnerStack = ((@WinningTeamMu - (3.0 * @WinningTeamSigma)) - (@LosingTeamMu - (3.0 * @LosingTeamSigma)))
		DECLARE @LoserStack FLOAT
			SET @LoserStack = ((@LosingTeamMu - (3.0 * @LosingTeamSigma)) - (@WinningTeamMu - (3.0 * @WinningTeamSigma)))
		
		-- UPDATE STACK RATINGS
		UPDATE @Players
		SET StackRating = @WinnerStack
		WHERE Team = @WinningTeamID

		UPDATE @Players
		SET StackRating = @LoserStack
		WHERE Team = @LosingTeamID

		IF @DebugMode = 1
		BEGIN
			PRINT 'WinnerStack: ' + CONVERT(VARCHAR(10), @WinnerStack)
			PRINT 'LoserStack: ' + CONVERT(VARCHAR(10), @LoserStack)
			PRINT ''
		END
		
		-- CALCULATE WINNER MU AND SIGMA VALUES FOR ALL PLAYERS ON WINNING TEAM
		UPDATE @Players
		SET DeltaMu = (((POWER(Sigma, 2) + @DynamicsSquared) / SQRT(@TotalVariance)) * @VWinner * FractionPlayed),
		DeltaSigma = (((Sigma * SQRT(1.0 - ((POWER(Sigma, 2) + @DynamicsSquared) / @TotalVariance) * @WWinner))) - Sigma) * FractionPlayed
		WHERE Team = @WinningTeamID

		-- CALCULATE LOSER MU AND SIGMA VALUES FOR ALL PLAYERS ON LOSING TEAM
		UPDATE @Players
		SET DeltaMu = (((POWER(Sigma, 2) + @DynamicsSquared) / SQRT(@TotalVariance)) * @VLoser * FractionPlayed),
		DeltaSigma = (((Sigma * SQRT(1.0 - ((POWER(Sigma, 2) + @DynamicsSquared) / @TotalVariance) * @WLoser))) - Sigma) * FractionPlayed
		WHERE Team = @LosingTeamID
		
		-- APPLY MU AND SIGMA UPDATES
		UPDATE @Players
		SET Mu = Mu + DeltaMu,
		Sigma = Sigma + DeltaSigma
		
		-- CALCULATE COMMANDER MU/SIGMA
		-- Grab their current mu/sigmas
		DECLARE @WinningCommMu FLOAT
			SET @WinningCommMu = (SELECT TOP 1 CommandMu FROM @Players WHERE LoginID = @WinningCommLoginID)
		DECLARE @WinningCommSigma FLOAT
			SET @WinningCommSigma = (SELECT TOP 1 CommandSigma FROM @Players WHERE LoginID = @WinningCommLoginID)
		DECLARE @LosingCommMu FLOAT
			SET @LosingCommMu = (SELECT TOP 1 CommandMu FROM @Players WHERE LoginID = @LosingCommLoginID)
		DECLARE @LosingCommSigma FLOAT
			SET @LosingCommSigma = (SELECT TOP 1 CommandSigma FROM @Players WHERE LoginID = @LosingCommLoginID)

		IF @DebugMode = 1
		BEGIN
			PRINT 'Winning Comm Mu: ' + CONVERT(VARCHAR(10), @WinningCommMu) + '. Sigma: ' + CONVERT(VARCHAR(10), @WinningCommSigma);
			PRINT 'Losing Comm Mu: ' + CONVERT(VARCHAR(10), @LosingCommMu) + '. Sigma: ' + CONVERT(VARCHAR(10), @LosingCommSigma);
		END
		
		-- Calculate comm C values
		DECLARE @CommCSquared FLOAT
			SET @CommCSquared = (2 * POWER(@VARIANCE, 2) + POWER(@WinningCommSigma, 2) + POWER(@LosingCommSigma, 2));
		DECLARE @CommC FLOAT
			SET @CommC = SQRT(@CommCSquared);
		
		IF (@DebugMode = 1)
		BEGIN
			PRINT 'Epsilon: ' + CONVERT(VARCHAR(10), @NewEpsilon);
			PRINT 'CommCSquared: ' + CONVERT(VARCHAR(10), @CommCSquared) + '. CommC: ' + CONVERT(VARCHAR(10), @CommC);
			PRINT ''
		END
		
		-- CALCULATE INTERMEDIATE VALUES NEEDED FOR NEW COMM MU AND SIGMA
		DECLARE @CommMuDifferenceOverC FLOAT
			SET @CommMuDifferenceOverC = ((@WinningCommMu - @LosingCommMu) / @CommC)
		DECLARE @CommT FLOAT
			SET @CommT = @CommMuDifferenceOverC
		DECLARE @CommE FLOAT
			SET @CommE = @NewEpsilon / @CommC

		DECLARE @CommTMinusE FLOAT
			SET @CommTMinusE = (@CommT - @CommE);
		DECLARE @CommDenominator FLOAT
			SET @CommDenominator = (dbo.AS_GetCDF(0.0, 1.0, (@CommE - @CommT)) - dbo.AS_GetCDF(0.0, 1.0, ((-1.0 * @CommE) - @CommT)))

		DECLARE @NewWinningCommMu FLOAT
		DECLARE @NewWinningCommSigma FLOAT
		DECLARE @NewLosingCommMu FLOAT
		DECLARE @NewLosingCommSigma FLOAT
		
		-- CALCULATE THE NEW MU/SIGMAS FOR THE COMMS
		IF (@GameIsDraw = 0)	-- If game is not draw
		BEGIN
			DECLARE @CommVWin FLOAT
				SET @CommVWin = (dbo.AS_GetPDF(0.0, 1.0, @CommTMinusE) / dbo.AS_GetCDF(0.0, 1.0, @CommTMinusE))
			DECLARE @CommWWin FLOAT
				SET @CommWWin = (@CommVWin * (@CommVWin + @CommTMinusE))

			SET @NewWinningCommMu = (@WinningCommMu + POWER(@WinningCommSigma, 2) / @CommC * @CommVWin)
			SET @NewWinningCommSigma = (SQRT(POWER(@WinningCommSigma, 2) * (1.0 - POWER(@WinningCommSigma, 2) / @CommCSquared * @CommWWin) + @DynamicsSquared))
			SET @NewLosingCommMu = (@LosingCommMu - POWER(@LosingCommSigma, 2) / @CommC * @CommVWin)
			SET @NewLosingCommSigma = (SQRT(POWER(@LosingCommSigma, 2) * (1.0 - POWER(@LosingCommSigma, 2) / @CommCSquared * @CommWWin) + @DynamicsSquared))
		
			IF @DebugMode = 1
			BEGIN
				PRINT 'CommVWin: ' + CONVERT(VARCHAR(10), @CommVWin)
				PRINT 'CommWWin: ' + CONVERT(VARCHAR(10), @CommWWin)
				PRINT ''
			END
		END
		ELSE
		BEGIN	-- Game is draw
			DECLARE @CommVDraw FLOAT
				SET @CommVDraw = ((dbo.AS_GetPDF(0.0, 1.0, (-1.0 * @CommE) - @CommT) - dbo.AS_GetPDF(0.0, 1.0, @CommE - @CommT)) / @CommDenominator)
			DECLARE @CommWDraw FLOAT
				SET @CommWDraw = (POWER(@CommVDraw, 2) + ((@CommE - @CommT) * dbo.AS_GetPDF(0.0, 1.0, (@CommE - @CommT)) + (@CommE + @CommT) * dbo.AS_GetPDF(0.0, 1.0, (@CommE + @CommT))) / @CommDenominator)
			
			IF @DebugMode = 1
			BEGIN
				PRINT 'CommVDraw: ' + CONVERT(VARCHAR(10), @CommVDraw)
				PRINT 'CommWDraw: ' + CONVERT(VARCHAR(10), @CommWDraw)
				PRINT ''
			END
			
			SET @NewWinningCommMu = (@WinningCommMu + POWER(@WinningCommSigma, 2) / @CommC * @CommVDraw)
			SET @NewWinningCommSigma = (SQRT(POWER(@WinningCommSigma, 2) * (1.0 - POWER(@WinningCommSigma, 2) / @CommCSquared * @CommWDraw) + @DynamicsSquared))
			SET @NewLosingCommMu = (@LosingCommMu - POWER(@LosingCommSigma, 2) / @CommC * @CommVDraw)
			SET @NewLosingCommSigma = (SQRT(POWER(@LosingCommSigma, 2) * (1.0 - POWER(@LosingCommSigma, 2) / @CommCSquared * @CommWDraw) + @DynamicsSquared))
		END
		
		IF @DebugMode = 1
		BEGIN
			PRINT 'New WinningCommMu: ' + CONVERT(VARCHAR(10), @NewWinningCommMu)
			PRINT 'New WinningCommSigma: ' + CONVERT(VARCHAR(10), @NewWinningCommSigma)
			PRINT 'New LosingCommMu: ' + CONVERT(VARCHAR(10), @NewLosingCommMu)
			PRINT 'New LosingCommSigma: ' + CONVERT(VARCHAR(10), @NewLosingCommSigma)
			PRINT ''
		END
		
		-- APPLY THE UPDATES TO OUR TEMPORARY TABLE
		UPDATE @Players
		SET CommandMu = @NewWinningCommMu,
		CommandSigma = @NewWinningCommSigma
		WHERE LoginID = @WinningCommLoginID
		
		UPDATE @Players
		SET CommandMu = @NewLosingCommMu,
		CommandSigma = @NewLosingCommSigma
		WHERE LoginID = @LosingCommLoginID
		-- COMMANDER CALCS END
		
		-- MAKE SURE MU AND SIGMA VALUES ARE SANE
		UPDATE @Players
		SET Mu = 50
		WHERE Mu > 50

		UPDATE @Players
		SET Mu = 0
		WHERE Mu < 0

		UPDATE @Players
		SET Sigma = 0
		WHERE Sigma < 0
		
		-- CALCULATE MATCH QUALITY
		DECLARE @VarianceSquared FLOAT
			SET @VarianceSquared = POWER(@Variance, 2)
		
		DECLARE @MatchQuality FLOAT
			SET @MatchQuality = (EXP(-1.0 * (POWER(@WinningTeamMu - @LosingTeamMu, 2) / (2.0 * @CSquared))) * SQRT((2.0 * @VarianceSquared) / @CSquared))
		
		IF @DebugMode = 1 PRINT 'MatchQuality: ' + CONVERT(VARCHAR(15), @MatchQuality)
		
		-- CALCULATE CONSERVATIVE RANKS
		DECLARE @WinningTeamConservativeRank FLOAT
			SET @WinningTeamConservativeRank = (@WinningTeamMu - (3.0 * @WinningTeamSigma))
		DECLARE @LosingTeamConservativeRank FLOAT
			SET @LosingTeamConservativeRank = (@LosingTeamMu - (3.0 * @LosingTeamSigma))
		
		DECLARE @Team1ConservativeRank FLOAT
		DECLARE @Team2ConservativeRank FLOAT

		IF @WinningTeamIndex = 0
		BEGIN
			SET @Team1ConservativeRank = @WinningTeamConservativeRank
			SET @Team2ConservativeRank = @LosingTeamConservativeRank
		END
		ELSE
		BEGIN
			SET @Team1ConservativeRank = @LosingTeamConservativeRank
			SET @Team2ConservativeRank = @WinningTeamConservativeRank
		END
		
		IF @DebugMode = 1
		BEGIN
			PRINT 'Team1ConservativeRank: ' + CONVERT(VARCHAR(10), @Team1ConservativeRank)
			PRINT 'Team2ConservativeRank: ' + CONVERT(VARCHAR(10), @Team2ConservativeRank)
			PRINT ''
		END

		-- HANDLE THE FINAL RESULTS (Print or save)
		IF @DebugMode = 0
		BEGIN
			-- SAVE GAME STATS
			INSERT INTO AS_GameStats (GameID, MatchQuality, Team1ConservativeRank, Team2ConservativeRank)
			VALUES (@GameID, @MatchQuality, @Team1ConservativeRank, @Team2ConservativeRank)
			
			-- SAVE THIS GAME'S UPDATES TO PLAYERSTATS
			INSERT INTO AS_GamePlayerAS (GameID, LoginID, NewMu, NewSigma, NewCommandMu, NewCommandSigma, StackRatingChange, Defected, KillCount, EjectCount, DroneKillCount, StationKillCount, StationCaptureCount)
				SELECT @GameID AS 'GameID',
					LoginID AS 'LoginID',
					Mu AS 'NewMu',
					Sigma AS 'NewSigma',
					CommandMu AS 'NewCommandMu',
					CommandSigma AS 'NewCommandSigma',
					StackRating AS 'StackRatingChange',
					Defector AS 'Defected',
					GamePlayerKills AS 'KillCount',
					GameEjects AS 'EjectCount',
					GameDroneKills AS 'DroneKillCount',
					GameStationKills AS 'StationKillCount',
					GameStationCaptures AS 'StationCaptureCount'
				FROM @Players
			
			-- UPDATE PLAYERS' ACTUAL STATS WITH CHANGES FROM THIS GAME
			DECLARE @UpdatingID INT;
			DECLARE @UpdatingLoginID INT;
			DECLARE @PlayedForWinningTeam INT;
			DECLARE @WinningCommander INT;
			DECLARE @LosingCommander INT;
			WHILE (SELECT COUNT(*) FROM @Players WHERE Pass < 1) > 0
			BEGIN
				-- Grab a row from our temporary table
				SET @UpdatingID = (SELECT TOP 1 GTM_ID FROM @Players WHERE PASS < 1);
				SET @UpdatingLoginID = (SELECT LoginID FROM @Players WHERE GTM_ID = @UpdatingID)
				
				-- Did they win?
				IF (SELECT Team FROM @Players WHERE GTM_ID = @UpdatingID) = @WinningTeamID
					SET @PlayedForWinningTeam = 1
				ELSE
					SET @PlayedForWinningTeam = 0
				
				-- Were they the winning comm?
				IF @UpdatingLoginID = @WinningCommLoginID
					SET @WinningCommander = 1
				ELSE
					SET @WinningCommander = 0
				
				-- Were they the losing comm?
				IF @UpdatingLoginID = @LosingCommLoginID
					SET @LosingCommander = 1
				ELSE
					SET @LosingCommander = 0
				
				-- Update this player's stats
				UPDATE StatsLeaderboard 
				SET Mu = p.Mu,
				Sigma = p.Sigma,
				Rank = dbo.AS_GetRank(p.Mu, p.Sigma),
				CommandMu = p.CommandMu,
				CommandSigma = p.CommandSigma,
				CommandRank = dbo.AS_GetRank(p.CommandMu, p.CommandSigma),
				StackRating = a.StackRating + (p.StackRating * p.FractionPlayed),
				Wins = a.Wins + @PlayedForWinningTeam,
				Losses = a.Losses + (@PlayedForWinningTeam ^ 1),
				Draws = a.Draws + @GameIsDraw,
				CommandWins = a.CommandWins + @WinningCommander,
				CommandLosses = a.CommandLosses + @LosingCommander,
				CommandDraws = a.CommandDraws + (@GameIsDraw & (@WinningCommander | @LosingCommander)),
				Defects = a.Defects + p.Defector,
				Kills = a.Kills + p.GamePlayerKills,
				Ejects = a.Ejects + p.GameEjects,
				DroneKills = a.DroneKills + p.GameDroneKills,
				StationKills = a.StationKills + p.GameStationKills,
				StationCaptures = a.StationCaptures + p.GameStationCaptures,
				HoursPlayed = a.HoursPlayed + (p.SecondsPlayed / 3600)
				FROM StatsLeaderboard a, @Players p
				WHERE (a.LoginID = @UpdatingLoginID AND p.GTM_ID = @UpdatingID)
				
				-- Flag this player as updated
				UPDATE @Players
				SET Pass = 1
				WHERE GTM_ID = @UpdatingID
			END
		END
		ELSE
		BEGIN
			PRINT 'Printing final values...'
			SELECT * FROM @Players
		END
	END
	ELSE
	BEGIN
		-- Game didn't count!
		IF @DebugMode = 1 PRINT @GameReason
	END
END
GO
/****** Object:  Default [DF__AS_AllegSkil__Mu__5629CD9C]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((25.0)) FOR [Mu]
GO
/****** Object:  Default [DF__AS_AllegS__Sigma__571DF1D5]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((8.3333333333333333333333333333333333333)) FOR [Sigma]
GO
/****** Object:  Default [DF__AS_AllegS__Comma__5812160E]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((25.0)) FOR [CommandMu]
GO
/****** Object:  Default [DF__AS_AllegS__Comma__59063A47]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((8.3333333333333333333333333333333333333)) FOR [CommandSigma]
GO
/****** Object:  Default [DF__AS_AllegS__Stack__59FA5E80]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0.0)) FOR [StackRating]
GO
/****** Object:  Default [DF__AS_AllegSk__Wins__5AEE82B9]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [Wins]
GO
/****** Object:  Default [DF__AS_AllegS__Losse__5BE2A6F2]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [Losses]
GO
/****** Object:  Default [DF__AS_AllegS__Draws__5CD6CB2B]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [Draws]
GO
/****** Object:  Default [DF__AS_AllegS__Comma__5DCAEF64]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [CommandWins]
GO
/****** Object:  Default [DF__AS_AllegS__Comma__5EBF139D]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [CommandLosses]
GO
/****** Object:  Default [DF__AS_AllegS__Comma__5FB337D6]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [CommandDraws]
GO
/****** Object:  Default [DF__AS_AllegS__Defec__60A75C0F]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [Defections]
GO
/****** Object:  Default [DF__AS_AllegS__Kills__619B8048]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [Kills]
GO
/****** Object:  Default [DF__AS_AllegS__Eject__628FA481]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [Ejects]
GO
/****** Object:  Default [DF__AS_AllegS__Drone__6383C8BA]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [DroneKills]
GO
/****** Object:  Default [DF__AS_AllegS__Stati__6477ECF3]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [StationKills]
GO
/****** Object:  Default [DF__AS_AllegS__Stati__656C112C]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [StationCaptures]
GO
/****** Object:  Default [DF__AS_AllegS__Secon__66603565]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill] ADD  DEFAULT ((0)) FOR [SecondsInGame]
GO
/****** Object:  Default [DF__AS_GamePl__NewMu__693CA210]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS] ADD  DEFAULT ((0.0)) FOR [NewMu]
GO
/****** Object:  Default [DF__AS_GamePl__NewSi__6A30C649]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS] ADD  DEFAULT ((0.0)) FOR [NewSigma]
GO
/****** Object:  Default [DF__AS_GamePl__NewCo__6B24EA82]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS] ADD  DEFAULT ((0.0)) FOR [NewCommandMu]
GO
/****** Object:  Default [DF__AS_GamePl__NewCo__6C190EBB]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS] ADD  DEFAULT ((0.0)) FOR [NewCommandSigma]
GO
/****** Object:  Default [DF__AS_GamePl__Stack__6D0D32F4]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS] ADD  DEFAULT ((0.0)) FOR [StackRatingChange]
GO
/****** Object:  Default [DF__AS_GamePl__Defec__6E01572D]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS] ADD  DEFAULT ((0)) FOR [Defected]
GO
/****** Object:  Default [DF__AS_GamePl__KillC__6EF57B66]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS] ADD  DEFAULT ((0)) FOR [KillCount]
GO
/****** Object:  Default [DF__AS_GamePl__Eject__6FE99F9F]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS] ADD  DEFAULT ((0)) FOR [EjectCount]
GO
/****** Object:  Default [DF__AS_GamePl__Drone__70DDC3D8]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS] ADD  DEFAULT ((0)) FOR [DroneKillCount]
GO
/****** Object:  Default [DF__AS_GamePl__Stati__71D1E811]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS] ADD  DEFAULT ((0)) FOR [StationKillCount]
GO
/****** Object:  Default [DF__AS_GamePl__Stati__72C60C4A]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS] ADD  DEFAULT ((0)) FOR [StationCaptureCount]
GO
/****** Object:  Default [DF__AS_GameSt__Match__4E88ABD4]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GameStats] ADD  DEFAULT ((0.0)) FOR [MatchQuality]
GO
/****** Object:  Default [DF__AS_GameSt__Team1__4F7CD00D]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GameStats] ADD  DEFAULT ((0.0)) FOR [Team1ConservativeRank]
GO
/****** Object:  Default [DF__AS_GameSt__Team2__5070F446]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GameStats] ADD  DEFAULT ((0.0)) FOR [Team2ConservativeRank]
GO
/****** Object:  Default [DF__AS_GameSt__Team3__5165187F]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GameStats] ADD  DEFAULT (NULL) FOR [Team3ConservativeRank]
GO
/****** Object:  Default [DF__AS_GameSt__Team4__52593CB8]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GameStats] ADD  DEFAULT (NULL) FOR [Team4ConservativeRank]
GO
/****** Object:  Default [DF__AS_GameSt__Team5__534D60F1]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GameStats] ADD  DEFAULT (NULL) FOR [Team5ConservativeRank]
GO
/****** Object:  Default [DF__AS_GameSt__Team6__5441852A]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GameStats] ADD  DEFAULT (NULL) FOR [Team6ConservativeRank]
GO
/****** Object:  Default [DF_StatsFaction_DateModified]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[StatsFaction] ADD  CONSTRAINT [DF_StatsFaction_DateModified]  DEFAULT (getdate()) FOR [DateModified]
GO
/****** Object:  Default [DF_StatsLeaderboard_LoginID]    Script Date: 10/21/2011 16:25:11 ******/
ALTER TABLE [dbo].[StatsLeaderboard] ADD  CONSTRAINT [DF_StatsLeaderboard_LoginID]  DEFAULT ((0)) FOR [LoginID]
GO
/****** Object:  Default [DF_StatsLeaderboard_LastUpdated]    Script Date: 10/21/2011 16:25:11 ******/
ALTER TABLE [dbo].[StatsLeaderboard] ADD  CONSTRAINT [DF_StatsLeaderboard_LastUpdated]  DEFAULT (getdate()) FOR [DateModified]
GO
/****** Object:  Default [DF_StatsMetrics_DateModified]    Script Date: 10/21/2011 16:25:11 ******/
ALTER TABLE [dbo].[StatsMetrics] ADD  CONSTRAINT [DF_StatsMetrics_DateModified]  DEFAULT (getdate()) FOR [DateModified]
GO
/****** Object:  ForeignKey [FK__AS_AllegS__Membe__52593CB8]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_AllegSkill]  WITH CHECK ADD  CONSTRAINT [FK__AS_AllegS__Membe__52593CB8] FOREIGN KEY([LoginID])
REFERENCES [dbo].[StatsLeaderboard] ([LoginID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AS_AllegSkill] CHECK CONSTRAINT [FK__AS_AllegS__Membe__52593CB8]
GO
/****** Object:  ForeignKey [FK__AS_GamePl__GameI__68487DD7]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS]  WITH CHECK ADD FOREIGN KEY([GameID])
REFERENCES [dbo].[Game] ([GameIdentID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
/****** Object:  ForeignKey [FK__AS_GamePl__Membe__66603565]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GamePlayerAS]  WITH CHECK ADD  CONSTRAINT [FK__AS_GamePl__Membe__66603565] FOREIGN KEY([LoginID])
REFERENCES [dbo].[StatsLeaderboard] ([LoginID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AS_GamePlayerAS] CHECK CONSTRAINT [FK__AS_GamePl__Membe__66603565]
GO
/****** Object:  ForeignKey [FK__AS_GameSt__GameI__4D94879B]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[AS_GameStats]  WITH CHECK ADD FOREIGN KEY([GameID])
REFERENCES [dbo].[Game] ([GameIdentID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
/****** Object:  ForeignKey [FK_Game_GameServer]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[Game]  WITH CHECK ADD  CONSTRAINT [FK_Game_GameServer] FOREIGN KEY([GameServer])
REFERENCES [dbo].[GameServer] ([GameServerID])
GO
ALTER TABLE [dbo].[Game] CHECK CONSTRAINT [FK_Game_GameServer]
GO
/****** Object:  ForeignKey [FK_GameChatLog_Game]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[GameChatLog]  WITH CHECK ADD  CONSTRAINT [FK_GameChatLog_Game] FOREIGN KEY([GameID])
REFERENCES [dbo].[Game] ([GameIdentID])
GO
ALTER TABLE [dbo].[GameChatLog] CHECK CONSTRAINT [FK_GameChatLog_Game]
GO
/****** Object:  ForeignKey [FK_GameEvent_Game1]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[GameEvent]  WITH CHECK ADD  CONSTRAINT [FK_GameEvent_Game1] FOREIGN KEY([GameID])
REFERENCES [dbo].[Game] ([GameIdentID])
GO
ALTER TABLE [dbo].[GameEvent] CHECK CONSTRAINT [FK_GameEvent_Game1]
GO
/****** Object:  ForeignKey [FK_GameServerIP_GameServer]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[GameServerIP]  WITH CHECK ADD  CONSTRAINT [FK_GameServerIP_GameServer] FOREIGN KEY([GameServerID])
REFERENCES [dbo].[GameServer] ([GameServerID])
GO
ALTER TABLE [dbo].[GameServerIP] CHECK CONSTRAINT [FK_GameServerIP_GameServer]
GO
/****** Object:  ForeignKey [FK_GameTeam_Game]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[GameTeam]  WITH CHECK ADD  CONSTRAINT [FK_GameTeam_Game] FOREIGN KEY([GameID])
REFERENCES [dbo].[Game] ([GameIdentID])
GO
ALTER TABLE [dbo].[GameTeam] CHECK CONSTRAINT [FK_GameTeam_Game]
GO
/****** Object:  ForeignKey [FK_GameTeamMember_GameTeam]    Script Date: 10/21/2011 16:25:10 ******/
ALTER TABLE [dbo].[GameTeamMember]  WITH CHECK ADD  CONSTRAINT [FK_GameTeamMember_GameTeam] FOREIGN KEY([GameTeamID])
REFERENCES [dbo].[GameTeam] ([GameTeamIdentID])
GO
ALTER TABLE [dbo].[GameTeamMember] CHECK CONSTRAINT [FK_GameTeamMember_GameTeam]
GO
GRANT EXECUTE ON [dbo].[ASGSServiceUpdateASRankings] TO [css_server] AS [dbo]
GO
