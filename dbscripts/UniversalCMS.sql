/****** Object:  Table [dbo].[ArticleCategories]    Script Date: 6 Aug 2024 3:08:06 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticleCategories](
	[refId] [int] IDENTITY(1,1) NOT NULL,
	[articleId] [int] NOT NULL,
	[categoryId] [int] NOT NULL,
 CONSTRAINT [PK_ArticleCategories] PRIMARY KEY CLUSTERED 
(
	[refId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Articles]    Script Date: 6 Aug 2024 3:08:06 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[articleId] [int] IDENTITY(1,1) NOT NULL,
	[articleDate] [datetime] NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[articleContent] [nvarchar](max) NOT NULL,
	[dateAdded] [datetime] NOT NULL,
	[articleCode] [uniqueidentifier] NOT NULL,
	[isActive] [bit] NOT NULL,
	[pageId] [nvarchar](250) NULL,
 CONSTRAINT [PK_Articles] PRIMARY KEY CLUSTERED 
(
	[articleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 6 Aug 2024 3:08:06 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[categoryId] [int] IDENTITY(1,1) NOT NULL,
	[category] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PageAccess]    Script Date: 6 Aug 2024 3:08:06 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageAccess](
	[paId] [int] IDENTITY(1,1) NOT NULL,
	[userType] [int] NULL,
	[pageId] [int] NULL,
 CONSTRAINT [PK_PageAccess] PRIMARY KEY CLUSTERED 
(
	[paId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pages]    Script Date: 6 Aug 2024 3:08:06 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pages](
	[pageId] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](150) NOT NULL,
	[dateAdded] [datetime] NOT NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[pageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6 Aug 2024 3:08:06 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](150) NOT NULL,
	[ecryPass] [nvarchar](150) NOT NULL,
	[dateAdded] [datetime] NOT NULL,
	[userType] [int] NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[dateModified] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTypes]    Script Date: 6 Aug 2024 3:08:06 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTypes](
	[userType] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_UserTypes] PRIMARY KEY CLUSTERED 
(
	[userType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Articles] ON 
GO
INSERT [dbo].[Articles] ([articleId], [articleDate], [title], [articleContent], [dateAdded], [articleCode], [isActive], [pageId]) VALUES (1, CAST(N'2024-08-06T00:00:00.000' AS DateTime), N'Test Title', N'<p>Test content</p>', CAST(N'2024-08-06T15:04:48.903' AS DateTime), N'26cf8d0a-5004-4093-bfe3-4b9f760a64a5', 1, N'testpageid')
GO
SET IDENTITY_INSERT [dbo].[Articles] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 
GO
INSERT [dbo].[Categories] ([categoryId], [category]) VALUES (1, N'General')
GO
INSERT [dbo].[Categories] ([categoryId], [category]) VALUES (2, N'Tech')
GO
INSERT [dbo].[Categories] ([categoryId], [category]) VALUES (3, N'Travel')
GO
INSERT [dbo].[Categories] ([categoryId], [category]) VALUES (4, N'Animals')
GO
INSERT [dbo].[Categories] ([categoryId], [category]) VALUES (7, N'Cars')
GO
INSERT [dbo].[Categories] ([categoryId], [category]) VALUES (8, N'Rants')
GO
INSERT [dbo].[Categories] ([categoryId], [category]) VALUES (9, N'Food')
GO
INSERT [dbo].[Categories] ([categoryId], [category]) VALUES (10, N'Pizza')
GO
INSERT [dbo].[Categories] ([categoryId], [category]) VALUES (11, N'DIY')
GO
INSERT [dbo].[Categories] ([categoryId], [category]) VALUES (12, N'Lockdown')
GO
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[PageAccess] ON 
GO
INSERT [dbo].[PageAccess] ([paId], [userType], [pageId]) VALUES (1, 2, 1)
GO
INSERT [dbo].[PageAccess] ([paId], [userType], [pageId]) VALUES (1005, 5, 1)
GO
SET IDENTITY_INSERT [dbo].[PageAccess] OFF
GO
SET IDENTITY_INSERT [dbo].[Pages] ON 
GO
INSERT [dbo].[Pages] ([pageId], [title], [dateAdded]) VALUES (1, N'Sample Page 1', CAST(N'2016-11-25T15:22:15.893' AS DateTime))
GO
INSERT [dbo].[Pages] ([pageId], [title], [dateAdded]) VALUES (2, N'Sample Page 2', CAST(N'2016-11-25T15:22:21.480' AS DateTime))
GO
INSERT [dbo].[Pages] ([pageId], [title], [dateAdded]) VALUES (3, N'Sample Page 3', CAST(N'2016-11-25T15:22:26.650' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Pages] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([userID], [username], [ecryPass], [dateAdded], [userType], [name], [dateModified], [isActive]) VALUES (1, N'superadmin', N'$2a$12$j4ofWdRb9B08YVJx8.dl7eidrIsUorDNfOS6ShUDoQ3T7GFmKiHU6', CAST(N'2016-11-22T15:38:11.150' AS DateTime), 1, N'Reiner Tupaz', CAST(N'2017-12-03T06:31:36.873' AS DateTime), 1)
GO
INSERT [dbo].[Users] ([userID], [username], [ecryPass], [dateAdded], [userType], [name], [dateModified], [isActive]) VALUES (1005, N'reins', N'$2a$12$j4ofWdRb9B08YVJx8.dl7eidrIsUorDNfOS6ShUDoQ3T7GFmKiHU6', CAST(N'2017-12-05T21:53:29.880' AS DateTime), 1, N'Reiner Tupaz', CAST(N'2017-12-05T21:53:29.880' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[UserTypes] ON 
GO
INSERT [dbo].[UserTypes] ([userType], [Type]) VALUES (1, N'Admin')
GO
INSERT [dbo].[UserTypes] ([userType], [Type]) VALUES (2, N'User')
GO
INSERT [dbo].[UserTypes] ([userType], [Type]) VALUES (5, N'Test')
GO
SET IDENTITY_INSERT [dbo].[UserTypes] OFF
GO
ALTER TABLE [dbo].[Articles] ADD  CONSTRAINT [DF_Articles_dateAdded]  DEFAULT (getdate()) FOR [dateAdded]
GO
ALTER TABLE [dbo].[Articles] ADD  CONSTRAINT [DF_Articles_articleCode]  DEFAULT (newid()) FOR [articleCode]
GO
ALTER TABLE [dbo].[Articles] ADD  CONSTRAINT [DF_Articles_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[Pages] ADD  CONSTRAINT [DF_Pages_dateAdded]  DEFAULT (getdate()) FOR [dateAdded]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_dateAdded]  DEFAULT (getdate()) FOR [dateAdded]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_dateModified]  DEFAULT (getdate()) FOR [dateModified]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[ArticleCategories]  WITH CHECK ADD  CONSTRAINT [FK_ArticleCategories_Articles] FOREIGN KEY([articleId])
REFERENCES [dbo].[Articles] ([articleId])
GO
ALTER TABLE [dbo].[ArticleCategories] CHECK CONSTRAINT [FK_ArticleCategories_Articles]
GO
ALTER TABLE [dbo].[ArticleCategories]  WITH CHECK ADD  CONSTRAINT [FK_ArticleCategories_Categories] FOREIGN KEY([categoryId])
REFERENCES [dbo].[Categories] ([categoryId])
GO
ALTER TABLE [dbo].[ArticleCategories] CHECK CONSTRAINT [FK_ArticleCategories_Categories]
GO
ALTER TABLE [dbo].[PageAccess]  WITH CHECK ADD  CONSTRAINT [FK_PageAccess_Pages] FOREIGN KEY([pageId])
REFERENCES [dbo].[Pages] ([pageId])
GO
ALTER TABLE [dbo].[PageAccess] CHECK CONSTRAINT [FK_PageAccess_Pages]
GO
ALTER TABLE [dbo].[PageAccess]  WITH CHECK ADD  CONSTRAINT [FK_PageAccess_UserTypes] FOREIGN KEY([userType])
REFERENCES [dbo].[UserTypes] ([userType])
GO
ALTER TABLE [dbo].[PageAccess] CHECK CONSTRAINT [FK_PageAccess_UserTypes]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserTypes] FOREIGN KEY([userType])
REFERENCES [dbo].[UserTypes] ([userType])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserTypes]
GO
