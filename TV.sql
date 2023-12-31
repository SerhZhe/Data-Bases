USE [master]
GO
/****** Object:  Database [TV]    Script Date: 21.05.2023 11:11:04 ******/
CREATE DATABASE [TV]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TV', FILENAME = N'C:\Data Bases\tmp\TV.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TV_log', FILENAME = N'C:\Data Bases\tmp\TV_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TV] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TV].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TV] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TV] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TV] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TV] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TV] SET ARITHABORT OFF 
GO
ALTER DATABASE [TV] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TV] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TV] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TV] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TV] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TV] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TV] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TV] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TV] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TV] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TV] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TV] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TV] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TV] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TV] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TV] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TV] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TV] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TV] SET  MULTI_USER 
GO
ALTER DATABASE [TV] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TV] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TV] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TV] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TV] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TV] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TV] SET QUERY_STORE = ON
GO
ALTER DATABASE [TV] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TV]
GO
/****** Object:  Table [dbo].[Chanel]    Script Date: 21.05.2023 11:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chanel](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[price] [money] NOT NULL,
	[category] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Chanel] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChanelPackage]    Script Date: 21.05.2023 11:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChanelPackage](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_ChanelPackage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 21.05.2023 11:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[phone] [char](13) NOT NULL,
	[account] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 21.05.2023 11:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[clientId] [bigint] NOT NULL,
	[dateInvoice] [date] NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movie]    Script Date: 21.05.2023 11:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movie](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[category] [nvarchar](100) NOT NULL,
	[rating] [numeric](3, 1) NOT NULL,
	[price] [money] NOT NULL,
	[release] [date] NOT NULL,
 CONSTRAINT [PK_Movie] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderChannel]    Script Date: 21.05.2023 11:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderChannel](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[clientId] [bigint] NOT NULL,
	[channelId] [bigint] NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NULL,
 CONSTRAINT [PK_OrderChannel] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderChannelPackage]    Script Date: 21.05.2023 11:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderChannelPackage](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[clientId] [bigint] NOT NULL,
	[chanelPackageId] [bigint] NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NULL,
 CONSTRAINT [PK_OrderChannelPackage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderMovie]    Script Date: 21.05.2023 11:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderMovie](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[movieId] [bigint] NOT NULL,
	[clientId] [bigint] NOT NULL,
	[orderDate] [date] NOT NULL,
 CONSTRAINT [PK_OrderMovie] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 21.05.2023 11:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[invoiceId] [bigint] NOT NULL,
	[payDate] [date] NOT NULL,
	[sumPay] [money] NOT NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StoragePackage]    Script Date: 21.05.2023 11:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoragePackage](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[chanelPackageId] [bigint] NOT NULL,
	[chanelId] [bigint] NOT NULL,
 CONSTRAINT [PK_StoragePackage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Chanel] ON 

INSERT [dbo].[Chanel] ([id], [name], [price], [category]) VALUES (1, N'Morning', 5.0000, N'Reality-Show')
INSERT [dbo].[Chanel] ([id], [name], [price], [category]) VALUES (2, N'SportTv', 10.0000, N'Sport')
INSERT [dbo].[Chanel] ([id], [name], [price], [category]) VALUES (3, N'Serias', 10.0000, N'TVshows')
SET IDENTITY_INSERT [dbo].[Chanel] OFF
GO
SET IDENTITY_INSERT [dbo].[ChanelPackage] ON 

INSERT [dbo].[ChanelPackage] ([id], [name], [price]) VALUES (1, N'Optimal', 13.0000)
INSERT [dbo].[ChanelPackage] ([id], [name], [price]) VALUES (2, N'LUX', 22.0000)
SET IDENTITY_INSERT [dbo].[ChanelPackage] OFF
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([id], [name], [email], [phone], [account]) VALUES (1, N'user1', N'user1@gmail.com', N'+380637788113', N'123456789')
INSERT [dbo].[Client] ([id], [name], [email], [phone], [account]) VALUES (2, N'user2', N'user2@gmail.com', N'+380639182113', N'234567890')
INSERT [dbo].[Client] ([id], [name], [email], [phone], [account]) VALUES (3, N'user3', N'user3@gmail.com', N'+380672432342', N'222456789')
SET IDENTITY_INSERT [dbo].[Client] OFF
GO
SET IDENTITY_INSERT [dbo].[Invoice] ON 

INSERT [dbo].[Invoice] ([id], [clientId], [dateInvoice], [startDate], [endDate], [price]) VALUES (2, 1, CAST(N'2023-05-14' AS Date), CAST(N'2022-01-04' AS Date), CAST(N'2023-05-30' AS Date), 110.0000)
INSERT [dbo].[Invoice] ([id], [clientId], [dateInvoice], [startDate], [endDate], [price]) VALUES (3, 2, CAST(N'2023-04-14' AS Date), CAST(N'2022-01-04' AS Date), CAST(N'2023-04-30' AS Date), 88.0000)
SET IDENTITY_INSERT [dbo].[Invoice] OFF
GO
SET IDENTITY_INSERT [dbo].[Movie] ON 

INSERT [dbo].[Movie] ([id], [name], [category], [rating], [price], [release]) VALUES (1, N'Harry Potter', N'fantesy', CAST(0.0 AS Numeric(3, 1)), 85.0000, CAST(N'2010-01-31' AS Date))
INSERT [dbo].[Movie] ([id], [name], [category], [rating], [price], [release]) VALUES (2, N'John Wick 4', N'action', CAST(0.0 AS Numeric(3, 1)), 110.0000, CAST(N'2023-03-23' AS Date))
INSERT [dbo].[Movie] ([id], [name], [category], [rating], [price], [release]) VALUES (3, N'Murder Mystery 2', N'comedy', CAST(0.0 AS Numeric(3, 1)), 89.0000, CAST(N'2023-03-31' AS Date))
SET IDENTITY_INSERT [dbo].[Movie] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderChannel] ON 

INSERT [dbo].[OrderChannel] ([id], [clientId], [channelId], [startDate], [endDate]) VALUES (1, 1, 2, CAST(N'2022-01-25' AS Date), CAST(N'2026-01-25' AS Date))
INSERT [dbo].[OrderChannel] ([id], [clientId], [channelId], [startDate], [endDate]) VALUES (2, 1, 3, CAST(N'2022-02-13' AS Date), CAST(N'2022-12-29' AS Date))
INSERT [dbo].[OrderChannel] ([id], [clientId], [channelId], [startDate], [endDate]) VALUES (3, 2, 1, CAST(N'2023-01-01' AS Date), CAST(N'2023-06-01' AS Date))
SET IDENTITY_INSERT [dbo].[OrderChannel] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderChannelPackage] ON 

INSERT [dbo].[OrderChannelPackage] ([id], [clientId], [chanelPackageId], [startDate], [endDate]) VALUES (1, 2, 2, CAST(N'2023-02-01' AS Date), CAST(N'2023-12-31' AS Date))
INSERT [dbo].[OrderChannelPackage] ([id], [clientId], [chanelPackageId], [startDate], [endDate]) VALUES (2, 1, 1, CAST(N'2023-01-01' AS Date), CAST(N'2024-01-01' AS Date))
SET IDENTITY_INSERT [dbo].[OrderChannelPackage] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderMovie] ON 

INSERT [dbo].[OrderMovie] ([id], [movieId], [clientId], [orderDate]) VALUES (1, 3, 1, CAST(N'2023-04-01' AS Date))
INSERT [dbo].[OrderMovie] ([id], [movieId], [clientId], [orderDate]) VALUES (2, 2, 1, CAST(N'2023-04-02' AS Date))
SET IDENTITY_INSERT [dbo].[OrderMovie] OFF
GO
SET IDENTITY_INSERT [dbo].[Payment] ON 

INSERT [dbo].[Payment] ([id], [invoiceId], [payDate], [sumPay]) VALUES (2, 2, CAST(N'2023-05-21' AS Date), 110.0000)
INSERT [dbo].[Payment] ([id], [invoiceId], [payDate], [sumPay]) VALUES (3, 3, CAST(N'2023-04-12' AS Date), 88.0000)
SET IDENTITY_INSERT [dbo].[Payment] OFF
GO
SET IDENTITY_INSERT [dbo].[StoragePackage] ON 

INSERT [dbo].[StoragePackage] ([id], [chanelPackageId], [chanelId]) VALUES (11, 1, 1)
INSERT [dbo].[StoragePackage] ([id], [chanelPackageId], [chanelId]) VALUES (8, 2, 1)
INSERT [dbo].[StoragePackage] ([id], [chanelPackageId], [chanelId]) VALUES (9, 2, 2)
INSERT [dbo].[StoragePackage] ([id], [chanelPackageId], [chanelId]) VALUES (12, 1, 3)
INSERT [dbo].[StoragePackage] ([id], [chanelPackageId], [chanelId]) VALUES (10, 2, 3)
SET IDENTITY_INSERT [dbo].[StoragePackage] OFF
GO
/****** Object:  Index [UNIQUE_StoragePackage_ChannelId_ChanelPackageId]    Script Date: 21.05.2023 11:11:04 ******/
ALTER TABLE [dbo].[StoragePackage] ADD  CONSTRAINT [UNIQUE_StoragePackage_ChannelId_ChanelPackageId] UNIQUE NONCLUSTERED 
(
	[chanelId] ASC,
	[chanelPackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Chanel] ADD  CONSTRAINT [DF_Chanel_price]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[ChanelPackage] ADD  CONSTRAINT [DF_ChanelPackage_price]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_dateInvoice]  DEFAULT (getdate()) FOR [dateInvoice]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_price]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[Movie] ADD  CONSTRAINT [DF_Movie_rating]  DEFAULT ((0)) FOR [rating]
GO
ALTER TABLE [dbo].[Movie] ADD  CONSTRAINT [DF_Movie_price]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[OrderChannel] ADD  CONSTRAINT [DF_OrderChannel_startDate]  DEFAULT (getdate()) FOR [startDate]
GO
ALTER TABLE [dbo].[OrderChannelPackage] ADD  CONSTRAINT [DF_OrderChannelPackage_startDate]  DEFAULT (getdate()) FOR [startDate]
GO
ALTER TABLE [dbo].[OrderMovie] ADD  CONSTRAINT [DF_OrderMovie_startDate]  DEFAULT (getdate()) FOR [orderDate]
GO
ALTER TABLE [dbo].[Payment] ADD  CONSTRAINT [DF_Payment_payDate]  DEFAULT (getdate()) FOR [payDate]
GO
ALTER TABLE [dbo].[Payment] ADD  CONSTRAINT [DF_Payment_sumPay]  DEFAULT ((0)) FOR [sumPay]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Client] FOREIGN KEY([clientId])
REFERENCES [dbo].[Client] ([id])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Client]
GO
ALTER TABLE [dbo].[OrderChannel]  WITH CHECK ADD  CONSTRAINT [FK_OrderChannel_Chanel] FOREIGN KEY([channelId])
REFERENCES [dbo].[Chanel] ([id])
GO
ALTER TABLE [dbo].[OrderChannel] CHECK CONSTRAINT [FK_OrderChannel_Chanel]
GO
ALTER TABLE [dbo].[OrderChannel]  WITH CHECK ADD  CONSTRAINT [FK_OrderChannel_Client] FOREIGN KEY([clientId])
REFERENCES [dbo].[Client] ([id])
GO
ALTER TABLE [dbo].[OrderChannel] CHECK CONSTRAINT [FK_OrderChannel_Client]
GO
ALTER TABLE [dbo].[OrderChannelPackage]  WITH CHECK ADD  CONSTRAINT [FK_OrderChannelPackage_ChanelPackage] FOREIGN KEY([chanelPackageId])
REFERENCES [dbo].[ChanelPackage] ([id])
GO
ALTER TABLE [dbo].[OrderChannelPackage] CHECK CONSTRAINT [FK_OrderChannelPackage_ChanelPackage]
GO
ALTER TABLE [dbo].[OrderChannelPackage]  WITH CHECK ADD  CONSTRAINT [FK_OrderChannelPackage_Client] FOREIGN KEY([clientId])
REFERENCES [dbo].[Client] ([id])
GO
ALTER TABLE [dbo].[OrderChannelPackage] CHECK CONSTRAINT [FK_OrderChannelPackage_Client]
GO
ALTER TABLE [dbo].[OrderMovie]  WITH CHECK ADD  CONSTRAINT [FK_OrderMovie_Client] FOREIGN KEY([clientId])
REFERENCES [dbo].[Client] ([id])
GO
ALTER TABLE [dbo].[OrderMovie] CHECK CONSTRAINT [FK_OrderMovie_Client]
GO
ALTER TABLE [dbo].[OrderMovie]  WITH CHECK ADD  CONSTRAINT [FK_OrderMovie_Movie] FOREIGN KEY([movieId])
REFERENCES [dbo].[Movie] ([id])
GO
ALTER TABLE [dbo].[OrderMovie] CHECK CONSTRAINT [FK_OrderMovie_Movie]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Invoice] FOREIGN KEY([invoiceId])
REFERENCES [dbo].[Invoice] ([id])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_Invoice]
GO
ALTER TABLE [dbo].[StoragePackage]  WITH CHECK ADD  CONSTRAINT [FK_StoragePackage_Chanel] FOREIGN KEY([chanelId])
REFERENCES [dbo].[Chanel] ([id])
GO
ALTER TABLE [dbo].[StoragePackage] CHECK CONSTRAINT [FK_StoragePackage_Chanel]
GO
ALTER TABLE [dbo].[StoragePackage]  WITH CHECK ADD  CONSTRAINT [FK_StoragePackage_ChanelPackage] FOREIGN KEY([chanelPackageId])
REFERENCES [dbo].[ChanelPackage] ([id])
GO
ALTER TABLE [dbo].[StoragePackage] CHECK CONSTRAINT [FK_StoragePackage_ChanelPackage]
GO
ALTER TABLE [dbo].[Chanel]  WITH CHECK ADD  CONSTRAINT [CK_Chanel_Price] CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[Chanel] CHECK CONSTRAINT [CK_Chanel_Price]
GO
ALTER TABLE [dbo].[ChanelPackage]  WITH CHECK ADD  CONSTRAINT [CK_ChanelPackage_Price] CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[ChanelPackage] CHECK CONSTRAINT [CK_ChanelPackage_Price]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [CK_Invoice_Price] CHECK  (([Price]>=(0)))
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [CK_Invoice_Price]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [CK_Invoice_STArtdate_less_enddate] CHECK  (([startDate]<=[endDate]))
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [CK_Invoice_STArtdate_less_enddate]
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD  CONSTRAINT [CK_Movie_Price] CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[Movie] CHECK CONSTRAINT [CK_Movie_Price]
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD  CONSTRAINT [CK_Movie_Rating] CHECK  (([rating]>=(0) AND [rating]<=(10)))
GO
ALTER TABLE [dbo].[Movie] CHECK CONSTRAINT [CK_Movie_Rating]
GO
ALTER TABLE [dbo].[OrderChannel]  WITH CHECK ADD  CONSTRAINT [CK_OrderChannel_StartDate_Less_Enddate] CHECK  (([startDate]<=[endDate]))
GO
ALTER TABLE [dbo].[OrderChannel] CHECK CONSTRAINT [CK_OrderChannel_StartDate_Less_Enddate]
GO
ALTER TABLE [dbo].[OrderChannelPackage]  WITH CHECK ADD  CONSTRAINT [CK_OrderChannelPackage_Startdate_less_enddate] CHECK  (([startDate]<=[endDAte]))
GO
ALTER TABLE [dbo].[OrderChannelPackage] CHECK CONSTRAINT [CK_OrderChannelPackage_Startdate_less_enddate]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [CK_Payment_sumPay] CHECK  (([sumPay]>=(0)))
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [CK_Payment_sumPay]
GO
USE [master]
GO
ALTER DATABASE [TV] SET  READ_WRITE 
GO
