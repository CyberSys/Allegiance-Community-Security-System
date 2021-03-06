
DELETE dbo.Ban
DELETE dbo.BanType
DELETE dbo.BanClass


INSERT [dbo].[BanClass] ([Id], [Name]) VALUES (1, N'Minor               ')
INSERT [dbo].[BanClass] ([Id], [Name]) VALUES (2, N'Major               ')
INSERT [dbo].[BanClass] ([Id], [Name]) VALUES (3, N'MinorHabitual       ')
INSERT [dbo].[BanClass] ([Id], [Name]) VALUES (4, N'MajorHabitual       ')

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
