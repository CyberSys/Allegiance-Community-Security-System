/****** Object:  Table [dbo].[Login_UnlinkedLogin]    Script Date: 02/23/2010 09:37:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Login_UnlinkedLogin]') AND type in (N'U'))
DROP TABLE [dbo].[Login_UnlinkedLogin]
GO
/****** Object:  Table [dbo].[Login_UnlinkedLogin]    Script Date: 02/23/2010 09:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Login_UnlinkedLogin]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Login_UnlinkedLogin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LoginId1] [int] NOT NULL,
	[LoginId2] [int] NOT NULL,
 CONSTRAINT [PK_Login_UnlinkedLogin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
