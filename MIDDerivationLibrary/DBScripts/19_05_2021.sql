/****** Object:  Database [midderivationlibrarycodes]    Script Date: 19-05-2021 12:47:06 ******/
CREATE DATABASE [midderivationlibrarycodes]  (EDITION = 'GeneralPurpose', SERVICE_OBJECTIVE = 'GP_S_Gen5_1', MAXSIZE = 1 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS;
GO
ALTER DATABASE [midderivationlibrarycodes] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [midderivationlibrarycodes] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET ARITHABORT OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [midderivationlibrarycodes] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [midderivationlibrarycodes] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [midderivationlibrarycodes] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [midderivationlibrarycodes] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [midderivationlibrarycodes] SET  MULTI_USER 
GO
ALTER DATABASE [midderivationlibrarycodes] SET ENCRYPTION ON
GO
ALTER DATABASE [midderivationlibrarycodes] SET QUERY_STORE = ON
GO
ALTER DATABASE [midderivationlibrarycodes] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  Schema [master]    Script Date: 19-05-2021 12:47:07 ******/
CREATE SCHEMA [master]
GO
/****** Object:  UserDefinedFunction [dbo].[funGetPickupCodeDetails]    Script Date: 19-05-2021 12:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[funGetPickupCodeDetails]
(
@componentType varchar(50),
@drivencomponentType varchar(50),
@intercomponentType varchar(50),
@c2componentType varchar(50),
@c1componentType varchar(50),
@locations int,
@driverLocationNDE bit,
@driverLocationDE bit,
@interlocations int,
@intermediatePresent bit,
@drivenlocations int,
@drivenLocationNDE bit,
@drivenLocationDE bit
)
RETURNS @PickupCodeTable  TABLE
(
	driverPickupCode varchar(50),drivenPickupCode varchar(50),intermediatePickupCode varchar(50),
   coupling1PickupCode varchar(50),coupling2PickupCode varchar(50)
)
AS
	Begin

--Declare @componentType varchar(50) = 'driver'
--Declare @drivencomponentType varchar(50) = 'driven'
--Declare @intercomponentType varchar(50) 
--Declare @c2componentType varchar(50) 
--Declare @c1componentType varchar(50) = 'coupling'

--Declare @locations int = 2
--Declare @driverLocationNDE bit = 1
--Declare @driverLocationDE bit = 1
--Declare @interlocations int = 0
--Declare @intermediatePresent bit = 0
--Declare @drivenlocations int = 0
--Declare @drivenLocationNDE bit = 0
--Declare @drivenLocationDE bit = 0

		Declare @driverPickupCode varchar(50),@drivenPickupCode varchar(50),@intermediatePickupCode varchar(50),
		@coupling1PickupCode varchar(50),@coupling2PickupCode varchar(50)
		
		--select *
		--from master.tblPickupCodeDetails 
		--where driverLocations = @locations and 
		--driverLocationNDE = @driverLocationNDE and
		--driverLocationDE = @driverLocationDE and
		--intermediateLocations = @interlocations and
		--intermediatePresent = @intermediatePresent and
		--drivenlocations = @drivenlocations and
		--drivenLocationDE = @drivenLocationDE and
		--drivenLocationNDE = @drivenLocationNDE

		select @driverPickupCode = driverPickupCode,
		@drivenPickupCode = drivenPickupCode,
		@intermediatePickupCode = intermediatePickupCode,
		@coupling1PickupCode = coupling1PickupCode,
		@coupling2PickupCode = coupling2PickupCode 
		from master.tblPickupCodeDetails 
		where driverLocations = @locations and 
		driverLocationNDE = @driverLocationNDE and
		driverLocationDE = @driverLocationDE and
		intermediateLocations = @interlocations and
		intermediatePresent = @intermediatePresent and
		drivenlocations = @drivenlocations and
		drivenLocationDE = @drivenLocationDE and
		drivenLocationNDE = @drivenLocationNDE

		if(@componentType IS NULL)
			Begin
				set @driverPickupCode = null
			End

		if(@drivencomponentType IS NULL)
			Begin
				set @drivenPickupCode = null
			End
		
		if(@intercomponentType IS NULL)
			Begin
				set @intermediatePickupCode = null
			End

		if(@c1componentType IS NULL)
			Begin
				set @coupling1PickupCode = null
			End

		if(@c2componentType IS NULL)
			Begin
				set @coupling2PickupCode = null
			End

		insert into @PickupCodeTable  
		select @driverPickupCode,@drivenPickupCode,@intermediatePickupCode,
		@coupling1PickupCode,@coupling2PickupCode

	Return 
End
GO
/****** Object:  Table [dbo].[Bkp]    Script Date: 19-05-2021 12:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bkp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[componentType] [varchar](100) NULL,
	[intermediateType] [varchar](100) NULL,
	[locations] [int] NULL,
	[drivenBy] [varchar](100) NULL,
	[speedChangesMax] [int] NULL,
	[componentCode] [decimal](18, 2) NULL,
	[isDeleted] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [master].[tblCoupling1Details]    Script Date: 19-05-2021 12:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [master].[tblCoupling1Details](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[componentType] [varchar](100) NULL,
	[couplingPosition] [int] NULL,
	[couplingType] [varchar](100) NULL,
	[locations] [int] NULL,
	[coupledComponentType1] [varchar](100) NULL,
	[coupledComponentType2] [varchar](100) NULL,
	[componentCode] [decimal](18, 2) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK__tblCoupl__3213E83F86600997] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [master].[tblCoupling2Details]    Script Date: 19-05-2021 12:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [master].[tblCoupling2Details](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[componentType] [varchar](100) NULL,
	[couplingPosition] [int] NULL,
	[couplingType] [varchar](100) NULL,
	[locations] [int] NULL,
	[coupledComponentType1] [varchar](100) NULL,
	[coupledComponentType2] [varchar](100) NULL,
	[componentCode] [decimal](18, 2) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK__tblCoupl__3213E83FFD9F2402] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [master].[tblCSDMdefsDetails]    Script Date: 19-05-2021 12:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [master].[tblCSDMdefsDetails](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[CSDMfile] [varchar](100) NULL,
	[componentcoderangestart] [decimal](18, 2) NULL,
	[componentcoderangeend] [decimal](18, 2) NULL,
	[CSDMsize] [int] NULL,
	[CSDMrelative] [bit] NULL,
	[defaultshaftlabel] [varchar](50) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK__tblCSDMd__3213E83F95DEAFE7] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [master].[tblDrivenDetails]    Script Date: 19-05-2021 12:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [master].[tblDrivenDetails](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[componentType] [varchar](50) NULL,
	[drivenType] [varchar](50) NULL,
	[locations] [int] NULL,
	[pumpType] [varchar](50) NULL,
	[compressorType] [varchar](50) NULL,
	[fan_or_blowerType] [varchar](50) NULL,
	[purifierDrivenBy] [varchar](50) NULL,
	[bearingType] [varchar](50) NULL,
	[vacuumPumpType] [varchar](50) NULL,
	[rotorOverhung] [bit] NULL,
	[attachedOilPump] [bit] NULL,
	[impellerOnMainShaft] [bit] NULL,
	[crankHasIntermediateBearing] [bit] NULL,
	[fanStages] [bit] NULL,
	[exciter] [bit] NULL,
	[centrifugalPumpHasBallBearings] [bit] NULL,
	[propellerpumpHasBallBearings] [bit] NULL,
	[rotaryThreadPumpHasBallBearings] [bit] NULL,
	[gearPumpHasBallBearings] [bit] NULL,
	[screwPumpHasBallBearings] [bit] NULL,
	[slidingVanePumpHasBallBearings] [bit] NULL,
	[axialRecipPumpHasBallBearings] [bit] NULL,
	[centrifugalCompressorHasBallBearings] [bit] NULL,
	[reciprocatingCompressorHasBallBearings] [bit] NULL,
	[screwCompressorHasBallBearings] [bit] NULL,
	[screwTwinCompressorHasBallBearingsOnHPSide] [bit] NULL,
	[lobedFanOrBlowerHasBallBearings] [bit] NULL,
	[overhungRotorFanOrBlowerHasBearings] [bit] NULL,
	[supportedRotorFanOrBlowerHasBearings] [bit] NULL,
	[exciterOverhungOrSupported] [varchar](50) NULL,
	[bearingsType] [varchar](50) NULL,
	[thrustBearing] [varchar](50) NULL,
	[drivenBy] [varchar](50) NULL,
	[componentCode] [decimal](18, 2) NULL,
	[isDeleted] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [master].[tblDriverDetails]    Script Date: 19-05-2021 12:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [master].[tblDriverDetails](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[componentType] [varchar](100) NULL,
	[locations] [int] NULL,
	[driverType] [varchar](100) NULL,
	[cylinders] [int] NULL,
	[motorDrive] [varchar](100) NULL,
	[motorFan] [bit] NULL,
	[motorBallBearings] [bit] NULL,
	[drivenBallBearings] [bit] NULL,
	[drivenBalanceable] [bit] NULL,
	[motorPoles] [int] NULL,
	[turbineReductionGear] [bit] NULL,
	[turbineRotorSupported] [bit] NULL,
	[turbineBallBearing] [bit] NULL,
	[turbineThrustBearing] [bit] NULL,
	[turbineThrustBearingIsBall] [bit] NULL,
	[componentCode] [decimal](18, 2) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK__tblDrive__3213E83F01706ADD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [master].[tblIntermediateDetails]    Script Date: 19-05-2021 12:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [master].[tblIntermediateDetails](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[componentType] [varchar](100) NULL,
	[intermediateType] [varchar](100) NULL,
	[locations] [int] NULL,
	[drivenBy] [varchar](100) NULL,
	[speedChangesMax] [int] NULL,
	[componentCode] [decimal](18, 2) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK__tblInter__3213E83F73606679] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [master].[tblPickupCodeDetails]    Script Date: 19-05-2021 12:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [master].[tblPickupCodeDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[driverLocations] [int] NULL,
	[driverLocationNDE] [bit] NOT NULL,
	[driverLocationDE] [bit] NOT NULL,
	[intermediateLocations] [int] NOT NULL,
	[intermediatepresent] [bit] NOT NULL,
	[drivenLocations] [int] NOT NULL,
	[drivenLocationDE] [bit] NOT NULL,
	[drivenLocationNDE] [bit] NOT NULL,
	[driverPickupCode] [varchar](50) NULL,
	[coupling1PickupCode] [varchar](50) NULL,
	[intermediatePickupCode] [varchar](50) NULL,
	[coupling2PickupCode] [varchar](50) NULL,
	[drivenPickupCode] [varchar](50) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK__tblPicku__3213E83F7423A78E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [master].[tblSpecialFaultCodesDetails]    Script Date: 19-05-2021 12:47:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [master].[tblSpecialFaultCodesDetails](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[specialfaultcodetype] [varchar](50) NULL,
	[specialmultiple] [int] NULL,
	[specialcode] [varchar](50) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK__tblSpeci__3213E83F3C85724C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bkp] ON 
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (1, N'Intermediate', N'none_rigid', NULL, NULL, NULL, NULL, 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (2, N'Intermediate', N'gearbox', 1, NULL, 1, CAST(13.01 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (3, N'Intermediate', N'gearbox', 2, NULL, 1, CAST(13.05 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (4, N'Intermediate', N'gearbox', 3, NULL, 1, CAST(13.09 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (5, N'Intermediate', N'gearbox', 4, NULL, 1, CAST(13.13 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (6, N'Intermediate', N'gearbox', 1, NULL, 2, CAST(13.31 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (7, N'Intermediate', N'gearbox', 2, NULL, 2, CAST(13.41 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (8, N'Intermediate', N'gearbox', 3, NULL, 2, CAST(13.51 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (9, N'Intermediate', N'gearbox', 4, NULL, 2, CAST(13.61 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (10, N'Intermediate', N'gearbox', 1, NULL, 3, CAST(33.01 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (11, N'Intermediate', N'gearbox', 2, NULL, 3, CAST(33.02 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (12, N'Intermediate', N'gearbox', 3, NULL, 3, CAST(33.03 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (13, N'Intermediate', N'gearbox', 4, NULL, 3, CAST(33.04 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (14, N'Intermediate', N'AOP', 1, N'inputshaft', NULL, CAST(13.71 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (15, N'Intermediate', N'AOP', 1, N'intermediateshaft', NULL, CAST(13.72 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (16, N'Intermediate', N'AOP', 1, N'outputshaft', NULL, CAST(13.73 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (17, N'Intermediate', N'AccDrGr', 1, N'inputshaft', NULL, CAST(13.76 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (18, N'Intermediate', N'AccDrGr', 1, N'intermediateshaft', NULL, CAST(13.77 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (19, N'Intermediate', N'AccDrGr', 1, N'outputshaft', NULL, CAST(13.78 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (21, N'vishal0335', NULL, NULL, NULL, 0, CAST(0.00 AS Decimal(18, 2)), 0)
GO
INSERT [dbo].[Bkp] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (23, N'Test', N'Gr', NULL, NULL, 2, CAST(0.00 AS Decimal(18, 2)), 1)
GO
SET IDENTITY_INSERT [dbo].[Bkp] OFF
GO
SET IDENTITY_INSERT [master].[tblCoupling1Details] ON 
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (1, N'Coupling', 1, N'none_rigid', NULL, NULL, NULL, NULL, 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (2, N'Coupling', 1, N'beltdrive', NULL, NULL, NULL, CAST(4.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (3, N'Coupling', 1, N'chaindrive', NULL, NULL, NULL, CAST(4.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (4, N'Coupling', 1, N'magnetic', NULL, NULL, NULL, CAST(4.13 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (5, N'Coupling', 1, N'flexible', NULL, N'motor', N'gearbox', CAST(10.31 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (6, N'Coupling', 1, N'flexible', NULL, N'motor', N'centrifugalpump', CAST(10.32 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (7, N'Coupling', 1, N'flexible', NULL, N'motor', N'rotarythreadpump', CAST(10.33 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (8, N'Coupling', 1, N'flexible', NULL, N'motor', N'rotarygearpump', CAST(10.34 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (9, N'Coupling', 1, N'flexible', NULL, N'motor', N'rotaryscrewpump', CAST(10.34 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (10, N'Coupling', 1, N'flexible', NULL, N'motor', N'rotaryslidingvanepump', CAST(10.34 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (11, N'Coupling', 1, N'flexible', NULL, N'motor', N'pistonpump', CAST(10.35 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (12, N'Coupling', 1, N'flexible', NULL, N'motor', N'pistoncompressor', CAST(10.36 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (13, N'Coupling', 1, N'flexible', NULL, N'motor', N'fan', CAST(10.37 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (14, N'Coupling', 1, N'flexible', NULL, N'motor', N'centrifugalcompressor', CAST(10.38 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (15, N'Coupling', 1, N'flexible', NULL, N'motor', N'generator', CAST(10.39 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (16, N'Coupling', 1, N'flexible', NULL, N'motor', N'screwcompressor', CAST(10.41 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (17, N'Coupling', 1, N'flexible', NULL, N'motor', N'lobedblower', CAST(10.42 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (18, N'Coupling', 1, N'flexible', NULL, N'motor', N'spindle', CAST(10.82 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (19, N'Coupling', 1, N'flexible', NULL, N'diesel', N'centrifugalpump', CAST(10.61 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (20, N'Coupling', 1, N'flexible', NULL, N'diesel', N'rotarythreadpump', CAST(10.62 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (21, N'Coupling', 1, N'flexible', NULL, N'diesel', N'rotaryslidingvanepump', CAST(10.63 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (22, N'Coupling', 1, N'flexible', NULL, N'diesel', N'pistoncompressor', CAST(10.64 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (23, N'Coupling', 1, N'flexible', NULL, N'diesel', N'pistonpump', CAST(10.65 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (24, N'Coupling', 1, N'flexible', NULL, N'diesel', N'generator', CAST(10.66 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (25, N'Coupling', 1, N'flexible', NULL, N'diesel', N'gearbox', CAST(10.67 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (26, N'Coupling', 1, N'flexible', NULL, N'diesel', N'centrifugalcompressor', CAST(10.68 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (27, N'Coupling', 1, N'flexible', NULL, N'diesel', N'fan', CAST(10.69 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (28, N'Coupling', 1, N'flexible', NULL, N'turbine', N'gearbox', CAST(10.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (29, N'Coupling', 1, N'flexible', NULL, N'turbine', N'centrifugalpump', CAST(10.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (30, N'Coupling', 1, N'flexible', NULL, N'turbine', N'generator', CAST(10.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (31, N'Coupling', 1, N'flexible', NULL, N'turbine', N'fan', CAST(10.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (32, N'Coupling', 1, N'flexible', NULL, N'turbine', N'compressor', CAST(10.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (33, N'Coupling', 1, N'fluid', 1, N'motor', N'fluidcoupling', CAST(10.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (34, N'Coupling', 1, N'fluid', 1, N'turbine', N'fluidcoupling', CAST(10.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (35, N'Coupling0335', NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [master].[tblCoupling1Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (36, N'Test22', NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [master].[tblCoupling1Details] OFF
GO
SET IDENTITY_INSERT [master].[tblCoupling2Details] ON 
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (1, N'coupling', 2, N'none_rigid', NULL, NULL, NULL, NULL, 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (2, N'coupling', 2, N'beltdrive', NULL, NULL, NULL, CAST(4.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (3, N'coupling', 2, N'chaindrive', NULL, NULL, NULL, CAST(4.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (4, N'coupling', 2, N'magnetic', NULL, NULL, NULL, CAST(4.13 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (5, N'coupling', 2, N'flexible', NULL, N'gearbox', N'spindle', CAST(10.49 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (6, N'coupling', 2, N'flexible', NULL, N'gearbox', N'centrifugalpump', CAST(10.51 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (7, N'coupling', 2, N'flexible', NULL, N'gearbox', N'propellerpump', CAST(10.51 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (8, N'coupling', 2, N'flexible', NULL, N'gearbox', N'rotarythreadpump', CAST(10.52 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (9, N'coupling', 2, N'flexible', NULL, N'gearbox', N'rotaryslidingvanepump', CAST(10.53 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (10, N'coupling', 2, N'flexible', NULL, N'gearbox', N'pistonpump', CAST(10.54 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (11, N'coupling', 2, N'flexible', NULL, N'gearbox', N'centrifugalcompressor', CAST(10.55 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (12, N'coupling', 2, N'flexible', NULL, N'gearbox', N'generator', CAST(10.56 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (13, N'coupling', 2, N'flexible', NULL, N'gearbox', N'screwcompressor', CAST(10.58 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (14, N'coupling', 2, N'flexible', NULL, N'gearbox', N'lobedblower', CAST(10.59 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (15, N'coupling', 2, N'flexible', NULL, N'gearbox', N'fan', CAST(10.60 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblCoupling2Details] ([id], [componentType], [couplingPosition], [couplingType], [locations], [coupledComponentType1], [coupledComponentType2], [componentCode], [isDeleted]) VALUES (16, N'Test123', NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [master].[tblCoupling2Details] OFF
GO
SET IDENTITY_INSERT [master].[tblCSDMdefsDetails] ON 
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (1, N'ONECLSTR', CAST(0.01 AS Decimal(18, 2)), CAST(0.99 AS Decimal(18, 2)), 1, 0, NULL, 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (2, N'TURBINES', CAST(1.00 AS Decimal(18, 2)), CAST(1.99 AS Decimal(18, 2)), 2, 0, N'T', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (3, N'MOTORS', CAST(5.00 AS Decimal(18, 2)), CAST(5.50 AS Decimal(18, 2)), 2, 0, N'M', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (4, N'GEARS2', CAST(3.05 AS Decimal(18, 2)), CAST(3.99 AS Decimal(18, 2)), 4, 0, NULL, 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (5, N'LINKEDDR', CAST(4.00 AS Decimal(18, 2)), CAST(4.99 AS Decimal(18, 2)), 2, 0, NULL, 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (6, N'PUMPS', CAST(2.00 AS Decimal(18, 2)), CAST(2.19 AS Decimal(18, 2)), 2, 0, N'P', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (7, N'ROTARYTH', CAST(2.20 AS Decimal(18, 2)), CAST(2.29 AS Decimal(18, 2)), 2, 0, N'P', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (8, N'SVPUMPS', CAST(2.30 AS Decimal(18, 2)), CAST(2.39 AS Decimal(18, 2)), 2, 0, N'P', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (9, N'AXIALPP', CAST(2.40 AS Decimal(18, 2)), CAST(2.49 AS Decimal(18, 2)), 2, 0, N'P', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (10, N'FANS', CAST(6.00 AS Decimal(18, 2)), CAST(6.99 AS Decimal(18, 2)), 2, 0, N'F', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (11, N'CENTCPRS', CAST(7.00 AS Decimal(18, 2)), CAST(7.19 AS Decimal(18, 2)), 2, 0, N'C', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (12, N'PISTNCPR', CAST(7.20 AS Decimal(18, 2)), CAST(7.29 AS Decimal(18, 2)), 2, 0, N'C', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (13, N'GENERATO', CAST(8.00 AS Decimal(18, 2)), CAST(8.99 AS Decimal(18, 2)), 2, 0, N'G', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (14, N'PURIFS', CAST(9.00 AS Decimal(18, 2)), CAST(9.99 AS Decimal(18, 2)), 2, 0, N'B', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (15, N'FLEXCPLG', CAST(10.00 AS Decimal(18, 2)), CAST(10.99 AS Decimal(18, 2)), 2, 1, NULL, 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (16, N'MNREDGRS', CAST(3.00 AS Decimal(18, 2)), CAST(3.04 AS Decimal(18, 2)), 4, 0, N'L', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (17, N'TURBINE2', CAST(11.00 AS Decimal(18, 2)), CAST(11.99 AS Decimal(18, 2)), 3, 0, N'T', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (18, N'MOTORS2', CAST(15.00 AS Decimal(18, 2)), CAST(15.50 AS Decimal(18, 2)), 3, 0, N'M', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (19, N'PUMPS2', CAST(12.00 AS Decimal(18, 2)), CAST(12.19 AS Decimal(18, 2)), 3, 0, N'P', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (20, N'ROTARYT2', CAST(12.20 AS Decimal(18, 2)), CAST(12.29 AS Decimal(18, 2)), 3, 0, N'P', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (21, N'SVPUMPS2', CAST(12.30 AS Decimal(18, 2)), CAST(12.39 AS Decimal(18, 2)), 3, 0, N'P', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (22, N'AXIALPP2', CAST(12.40 AS Decimal(18, 2)), CAST(12.49 AS Decimal(18, 2)), 3, 0, N'P', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (23, N'FANS2', CAST(16.00 AS Decimal(18, 2)), CAST(16.99 AS Decimal(18, 2)), 3, 0, N'F', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (24, N'CENTCPR2', CAST(17.00 AS Decimal(18, 2)), CAST(17.19 AS Decimal(18, 2)), 3, 0, N'C', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (25, N'PISTNCP2', CAST(17.20 AS Decimal(18, 2)), CAST(17.29 AS Decimal(18, 2)), 3, 0, N'C', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (26, N'GENERAT2', CAST(18.00 AS Decimal(18, 2)), CAST(18.99 AS Decimal(18, 2)), 3, 0, N'G', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (27, N'SCREWCPR', CAST(7.30 AS Decimal(18, 2)), CAST(7.39 AS Decimal(18, 2)), 2, 0, N'C', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (28, N'TRBOCHRG', CAST(20.00 AS Decimal(18, 2)), CAST(20.09 AS Decimal(18, 2)), 1, 0, N'T', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (29, N'DIESELS2', CAST(29.00 AS Decimal(18, 2)), CAST(29.99 AS Decimal(18, 2)), 3, 0, N'D', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (30, N'DIESELS', CAST(30.00 AS Decimal(18, 2)), CAST(30.99 AS Decimal(18, 2)), 2, 0, N'D', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (31, N'DIESELS3', CAST(31.00 AS Decimal(18, 2)), CAST(31.99 AS Decimal(18, 2)), 4, 0, N'D', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (32, N'TRBCHRG2', CAST(20.11 AS Decimal(18, 2)), CAST(20.19 AS Decimal(18, 2)), 2, 0, N'T', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (33, N'CALBLOCK', CAST(99.01 AS Decimal(18, 2)), CAST(99.10 AS Decimal(18, 2)), 1, 0, NULL, 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (34, N'DSLREDGR', CAST(32.00 AS Decimal(18, 2)), CAST(32.99 AS Decimal(18, 2)), 4, 0, N'D', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (35, N'GEARS', CAST(13.00 AS Decimal(18, 2)), CAST(13.70 AS Decimal(18, 2)), 4, 0, NULL, 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (36, N'PURIFS2', CAST(19.00 AS Decimal(18, 2)), CAST(19.99 AS Decimal(18, 2)), 3, 0, N'B', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (37, N'TWOCLSTR', CAST(14.00 AS Decimal(18, 2)), CAST(14.99 AS Decimal(18, 2)), 2, 0, NULL, 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (38, N'SCRWCPR2', CAST(17.30 AS Decimal(18, 2)), CAST(17.39 AS Decimal(18, 2)), 3, 0, N'C', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (39, N'LOBBLWR', CAST(7.50 AS Decimal(18, 2)), CAST(7.59 AS Decimal(18, 2)), 2, 0, N'W', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (40, N'LOBBLWR2', CAST(17.50 AS Decimal(18, 2)), CAST(17.59 AS Decimal(18, 2)), 3, 0, N'W', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (41, N'SPINDLES', CAST(34.00 AS Decimal(18, 2)), CAST(34.99 AS Decimal(18, 2)), 2, 0, N'N', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (42, N'MLTIGEAR', CAST(33.00 AS Decimal(18, 2)), CAST(33.99 AS Decimal(18, 2)), 4, 0, NULL, 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (43, N'FLUID', CAST(35.00 AS Decimal(18, 2)), CAST(35.99 AS Decimal(18, 2)), 4, 0, NULL, 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (44, N'NOTUSED', CAST(36.00 AS Decimal(18, 2)), CAST(36.99 AS Decimal(18, 2)), 2, 0, NULL, 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (45, N'PROX_2', CAST(22.00 AS Decimal(18, 2)), CAST(22.99 AS Decimal(18, 2)), 4, 0, N'T', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (46, N'OPG_AG', CAST(13.71 AS Decimal(18, 2)), CAST(13.79 AS Decimal(18, 2)), 1, 0, NULL, 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (47, N'DECANTER', CAST(47.00 AS Decimal(18, 2)), CAST(47.99 AS Decimal(18, 2)), 3, 0, N'B', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (48, N'DCMOTOR', CAST(5.51 AS Decimal(18, 2)), CAST(5.99 AS Decimal(18, 2)), 2, 0, N'M', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (49, N'DCMOTOR2', CAST(15.51 AS Decimal(18, 2)), CAST(15.99 AS Decimal(18, 2)), 3, 0, N'M', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (50, N'PROX_1', CAST(21.00 AS Decimal(18, 2)), CAST(21.99 AS Decimal(18, 2)), 3, 0, N'T', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (51, N'VFDMOTR1', CAST(45.00 AS Decimal(18, 2)), CAST(45.99 AS Decimal(18, 2)), 2, 0, N'M', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (52, N'VFDMOTR2', CAST(46.01 AS Decimal(18, 2)), CAST(46.99 AS Decimal(18, 2)), 3, 0, N'M', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (53, N'asdasd', CAST(10.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), 1, 1, N'Na', 0)
GO
INSERT [master].[tblCSDMdefsDetails] ([id], [CSDMfile], [componentcoderangestart], [componentcoderangeend], [CSDMsize], [CSDMrelative], [defaultshaftlabel], [isDeleted]) VALUES (54, N'Test1', CAST(10.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), 1, 1, N'Na', 1)
GO
SET IDENTITY_INSERT [master].[tblCSDMdefsDetails] OFF
GO
SET IDENTITY_INSERT [master].[tblDrivenDetails] ON 
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (1, N'driven', N'pump', 1, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', NULL, CAST(2.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (2, N'driven', N'pump', 2, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', NULL, CAST(12.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (3, N'driven', N'pump', 1, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ball', NULL, CAST(2.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (4, N'driven', N'pump', 2, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ball', NULL, CAST(12.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (5, N'driven', N'pump', 1, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ball', NULL, CAST(2.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (6, N'driven', N'pump', 2, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ball', NULL, CAST(12.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (7, N'driven', N'pump', 1, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'no', NULL, CAST(2.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (8, N'driven', N'pump', 2, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'no', NULL, CAST(12.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (9, N'driven', N'pump', 1, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', NULL, CAST(2.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (10, N'driven', N'pump', 2, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', NULL, CAST(12.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (11, N'driven', N'pump', 1, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ball', NULL, CAST(2.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (12, N'driven', N'pump', 2, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ball', NULL, CAST(12.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (13, N'driven', N'pump', 1, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'no', NULL, CAST(2.09 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (14, N'driven', N'pump', 2, N'centrifugal', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'no', NULL, CAST(12.09 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (15, N'driven', N'pump', 1, N'propeller', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (16, N'driven', N'pump', 2, N'propeller', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (17, N'driven', N'pump', 1, N'propeller', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (18, N'driven', N'pump', 2, N'propeller', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (19, N'driven', N'pump', 1, N'rotarythread', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (20, N'driven', N'pump', 2, N'rotarythread', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (21, N'driven', N'pump', 1, N'rotarythread', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.22 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (22, N'driven', N'pump', 2, N'rotarythread', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.22 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (23, N'driven', N'pump', 1, N'gear', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.24 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (24, N'driven', N'pump', 2, N'gear', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.24 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (25, N'driven', N'pump', 1, N'gear', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.25 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (26, N'driven', N'pump', 2, N'gear', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.25 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (27, N'driven', N'pump', 1, N'screw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.26 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (28, N'driven', N'pump', 2, N'screw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.26 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (29, N'driven', N'pump', 1, N'slidingvane', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.31 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (30, N'driven', N'pump', 2, N'slidingvane', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.31 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (31, N'driven', N'pump', 1, N'slidingvane', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.35 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (32, N'driven', N'pump', 2, N'slidingvane', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.35 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (33, N'driven', N'pump', 1, N'slidingvane', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.36 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (34, N'driven', N'pump', 2, N'slidingvane', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.36 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (35, N'driven', N'pump', 1, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.41 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (36, N'driven', N'pump', 2, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.41 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (37, N'driven', N'pump', 1, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', NULL, CAST(2.42 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (38, N'driven', N'pump', 2, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', NULL, CAST(12.42 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (39, N'driven', N'pump', 1, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.43 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (40, N'driven', N'pump', 2, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(12.43 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (41, N'driven', N'pump', 1, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ball', NULL, CAST(2.44 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (42, N'driven', N'pump', 2, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ball', NULL, CAST(12.44 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (43, N'driven', N'pump', 1, N'radialrecip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.45 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (44, N'driven', N'pump', 1, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', NULL, CAST(2.46 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (45, N'driven', N'compressor', 1, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'yes', NULL, CAST(7.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (46, N'driven', N'compressor', 2, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'yes', NULL, CAST(17.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (47, N'driven', N'compressor', 1, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'no', NULL, CAST(7.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (48, N'driven', N'compressor', 2, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'no', NULL, CAST(17.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (49, N'driven', N'compressor', 1, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'no', NULL, CAST(7.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (50, N'driven', N'compressor', 2, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'no', NULL, CAST(17.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (51, N'driven', N'compressor', 1, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'yes', NULL, CAST(7.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (52, N'driven', N'compressor', 2, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'yes', NULL, CAST(17.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (53, N'driven', N'compressor', 1, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(7.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (54, N'driven', N'compressor', 2, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(17.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (55, N'driven', N'compressor', 1, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(7.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (56, N'driven', N'compressor', 2, NULL, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(17.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (57, N'driven', N'compressor', 1, NULL, N'reciprocating', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(7.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (58, N'driven', N'compressor', 2, NULL, N'reciprocating', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(17.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (59, N'driven', N'compressor', 1, NULL, N'reciprocating', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(7.22 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (60, N'driven', N'compressor', 2, NULL, N'reciprocating', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(17.22 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (61, N'driven', N'compressor', 1, NULL, N'reciprocating', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(7.23 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (62, N'driven', N'compressor', 2, NULL, N'reciprocating', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(17.23 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (63, N'driven', N'compressor', 1, NULL, N'screw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(7.31 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (64, N'driven', N'compressor', 2, NULL, N'screw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(17.31 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (65, N'driven', N'compressor', 1, NULL, N'screw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(7.32 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (66, N'driven', N'compressor', 2, NULL, N'screw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(17.32 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (67, N'driven', N'compressor', 1, NULL, N'screwtwin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(7.36 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (68, N'driven', N'compressor', 2, NULL, N'screwtwin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(17.36 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (69, N'driven', N'fan_or_blower', 1, NULL, NULL, N'lobed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(7.51 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (70, N'driven', N'fan_or_blower', 2, NULL, NULL, N'lobed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(17.51 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (71, N'driven', N'fan_or_blower', 1, NULL, NULL, N'lobed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(7.52 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (72, N'driven', N'fan_or_blower', 2, NULL, NULL, N'lobed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(17.52 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (73, N'driven', N'fan_or_blower', 1, NULL, NULL, N'overhungrotor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, CAST(6.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (74, N'driven', N'fan_or_blower', 2, NULL, NULL, N'overhungrotor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, CAST(16.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (75, N'driven', N'fan_or_blower', 1, NULL, NULL, N'overhungrotor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, CAST(6.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (76, N'driven', N'fan_or_blower', 2, NULL, NULL, N'overhungrotor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, CAST(16.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (77, N'driven', N'fan_or_blower', 1, NULL, NULL, N'supportedrotor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(6.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (78, N'driven', N'fan_or_blower', 2, NULL, NULL, N'supportedrotor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(16.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (79, N'driven', N'fan_or_blower', 1, NULL, NULL, N'supportedrotor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, CAST(6.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (80, N'driven', N'fan_or_blower', 2, NULL, NULL, N'supportedrotor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, CAST(16.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (81, N'driven', N'purifier_centrifuge', 1, NULL, NULL, NULL, N'gearedwithclutch', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(9.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (82, N'driven', N'purifier_centrifuge', 2, NULL, NULL, NULL, N'gearedwithclutch', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(19.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (83, N'driven', N'purifier_centrifuge', 1, NULL, NULL, NULL, N'beltdrive', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(9.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (84, N'driven', N'purifier_centrifuge', 2, NULL, NULL, NULL, N'beltdrive', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(19.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (85, N'driven', N'decanter', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (86, N'driven', N'decanter', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(47.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (87, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'NDE_Journal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'NOTdieselengine', CAST(8.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (88, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'NDE_Journal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'NOTdieselengine', CAST(18.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (89, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'supported', NULL, NULL, N'NOTdieselengine', CAST(8.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (90, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'supported', NULL, NULL, N'NOTdieselengine', CAST(18.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (91, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'NOTdieselengine', CAST(8.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (92, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'NOTdieselengine', CAST(18.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (93, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'ballbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'NOTdieselengine', CAST(8.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (94, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'ballbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'NOTdieselengine', CAST(18.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (95, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'NOTdieselengine', CAST(8.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (96, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'NOTdieselengine', CAST(18.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (97, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'NDE_Journal', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'NOTdieselengine', CAST(8.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (98, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'NDE_Journal', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'NOTdieselengine', CAST(18.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (99, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'NOTdieselengine', CAST(8.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (100, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'NOTdieselengine', CAST(18.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (101, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'NOTdieselengine', CAST(8.08 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (102, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'NOTdieselengine', CAST(18.08 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (103, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'supported', NULL, NULL, N'NOTdieselengine', CAST(8.09 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (104, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'supported', NULL, NULL, N'NOTdieselengine', CAST(18.09 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (105, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'NDE_Journal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'dieselengine', CAST(8.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (106, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'NDE_Journal', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'dieselengine', CAST(18.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (107, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'supported', NULL, NULL, N'dieselengine', CAST(8.22 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (108, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'supported', NULL, NULL, N'dieselengine', CAST(18.22 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (109, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'dieselengine', CAST(8.23 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (110, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'dieselengine', CAST(18.23 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (111, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'ballbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'dieselengine', CAST(8.24 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (112, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'ballbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'dieselengine', CAST(18.24 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (113, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'dieselengine', CAST(8.25 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (114, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'dieselengine', CAST(18.25 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (115, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'NDE_Journal', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'dieselengine', CAST(8.26 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (116, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'NDE_Journal', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'dieselengine', CAST(18.26 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (117, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'dieselengine', CAST(8.27 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (118, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'dieselengine', CAST(18.27 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (119, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'dieselengine', CAST(8.28 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (120, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'NDE_Ball', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'overhung', NULL, NULL, N'dieselengine', CAST(18.28 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (121, N'driven', N'generator', 1, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'supported', NULL, NULL, N'dieselengine', CAST(8.29 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (122, N'driven', N'generator', 2, NULL, NULL, NULL, NULL, N'journalbearingsbothends', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'supported', NULL, NULL, N'dieselengine', CAST(18.29 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (123, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'journalthrust', NULL, CAST(2.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (124, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'journalthrust', NULL, CAST(12.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (125, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', N'ballthrustbearing', NULL, CAST(2.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (126, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', N'ballthrustbearing', NULL, CAST(12.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (127, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', N'ballthrustbearing', NULL, CAST(2.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (128, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', N'ballthrustbearing', NULL, CAST(12.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (129, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'no', NULL, CAST(2.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (130, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'no', NULL, CAST(12.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (131, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'journalthrust', NULL, CAST(2.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (132, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'journalthrust', NULL, CAST(12.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (133, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'ballthrustbearing', NULL, CAST(2.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (134, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'ballthrustbearing', NULL, CAST(12.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (135, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'no', NULL, CAST(2.09 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (136, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'no', NULL, CAST(12.09 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (137, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'axialrecip', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', NULL, NULL, CAST(2.41 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (138, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'axialrecip', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', NULL, NULL, CAST(12.41 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (139, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'journalthrust', NULL, CAST(2.42 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (140, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'journalthrust', NULL, CAST(12.42 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (141, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'axialrecip', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', NULL, NULL, CAST(2.43 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (142, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'axialrecip', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', NULL, NULL, CAST(12.43 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (143, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'ballthrustbearingplate', NULL, CAST(2.44 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (144, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'ballthrustbearingplate', NULL, CAST(12.44 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (145, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'radialrecip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.45 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (146, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'axialrecip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.46 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (147, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'yes', NULL, CAST(7.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (148, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'yes', NULL, CAST(17.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (149, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'no', NULL, CAST(7.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (150, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', N'no', NULL, CAST(17.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (151, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', N'no', NULL, CAST(7.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (152, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', N'no', NULL, CAST(17.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (153, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', N'yes', NULL, CAST(7.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (154, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', N'yes', NULL, CAST(17.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (155, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journalbearingsonmain', NULL, NULL, CAST(7.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (156, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journalbearingsonmain', NULL, NULL, CAST(17.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (157, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearingsonmain', NULL, NULL, CAST(7.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (158, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'centrifugal', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearingsonmain', NULL, NULL, CAST(17.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (159, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'reciprocating', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'crankshaftjournalbearingsatendonly', NULL, NULL, CAST(7.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (160, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'reciprocating', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'crankshaftjournalbearingsatendonly', NULL, NULL, CAST(17.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (161, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'reciprocating', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'allballbearings', NULL, NULL, CAST(7.23 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (162, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'reciprocating', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'allballbearings', NULL, NULL, CAST(17.23 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (163, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'lobed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', NULL, NULL, CAST(7.51 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (164, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'lobed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ballbearings', NULL, NULL, CAST(17.51 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (165, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'lobed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', NULL, NULL, CAST(7.52 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (166, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'lobed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journal', NULL, NULL, CAST(17.52 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (167, N'driven', N'vacuumpump', 1, NULL, NULL, NULL, NULL, NULL, N'lobed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journalandballbearings', NULL, NULL, CAST(7.53 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (168, N'driven', N'vacuumpump', 2, NULL, NULL, NULL, NULL, NULL, N'lobed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'journalandballbearings', NULL, NULL, CAST(17.53 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (169, N'driven', N'spindle_or_shaft_or_bearing', 1, NULL, NULL, NULL, NULL, NULL, N'spindle', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(34.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (170, N'driven', N'spindle_or_shaft_or_bearing', 2, NULL, NULL, NULL, NULL, NULL, N'spindle', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(34.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (171, N'driven', N'spindle_or_shaft_or_bearing', 1, NULL, NULL, NULL, NULL, NULL, N'shaft', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(34.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (172, N'driven', N'spindle_or_shaft_or_bearing', 2, NULL, NULL, NULL, NULL, NULL, N'shaft', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(34.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (173, N'Vishal1111', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [master].[tblDrivenDetails] ([id], [componentType], [drivenType], [locations], [pumpType], [compressorType], [fan_or_blowerType], [purifierDrivenBy], [bearingType], [vacuumPumpType], [rotorOverhung], [attachedOilPump], [impellerOnMainShaft], [crankHasIntermediateBearing], [fanStages], [exciter], [centrifugalPumpHasBallBearings], [propellerpumpHasBallBearings], [rotaryThreadPumpHasBallBearings], [gearPumpHasBallBearings], [screwPumpHasBallBearings], [slidingVanePumpHasBallBearings], [axialRecipPumpHasBallBearings], [centrifugalCompressorHasBallBearings], [reciprocatingCompressorHasBallBearings], [screwCompressorHasBallBearings], [screwTwinCompressorHasBallBearingsOnHPSide], [lobedFanOrBlowerHasBallBearings], [overhungRotorFanOrBlowerHasBearings], [supportedRotorFanOrBlowerHasBearings], [exciterOverhungOrSupported], [bearingsType], [thrustBearing], [drivenBy], [componentCode], [isDeleted]) VALUES (181, N'TestDriven', N'spindle_or_shaft_or_bearing', 3, N'centrifugal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0)
GO
SET IDENTITY_INSERT [master].[tblDrivenDetails] OFF
GO
SET IDENTITY_INSERT [master].[tblDriverDetails] ON 
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (1, N'driver', 1, N'diesel', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(30.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (2, N'driver', 2, N'diesel', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(29.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (3, N'driver', 1, N'diesel', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(30.13 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (4, N'driver', 2, N'diesel', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(29.13 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (5, N'driver', 1, N'diesel', 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(30.14 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (6, N'driver', 2, N'diesel', 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(29.14 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (7, N'driver', 1, N'diesel', 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(30.15 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (8, N'driver', 2, N'diesel', 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(29.15 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (9, N'driver', 1, N'diesel', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(30.16 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (10, N'driver', 2, N'diesel', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(29.16 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (11, N'driver', 1, N'diesel', 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(30.17 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (12, N'driver', 2, N'diesel', 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(29.17 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (13, N'driver', 1, N'diesel', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(30.18 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (14, N'driver', 2, N'diesel', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(29.18 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (15, N'driver', 1, N'diesel', 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(30.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (16, N'driver', 2, N'diesel', 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(29.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (17, N'driver', 1, N'diesel', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(30.19 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (18, N'driver', 2, N'diesel', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(29.19 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (19, N'driver', 1, N'motor', NULL, N'AC', 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (20, N'driver', 2, N'motor', NULL, N'AC', 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (21, N'driver', 1, N'motor', NULL, N'AC', 1, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (22, N'driver', 2, N'motor', NULL, N'AC', 1, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (23, N'driver', 1, N'motor', NULL, N'AC', 1, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (24, N'driver', 2, N'motor', NULL, N'AC', 1, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (25, N'driver', 1, N'motor', NULL, N'AC', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.31 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (26, N'driver', 2, N'motor', NULL, N'AC', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.31 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (27, N'driver', 1, N'motor', NULL, N'AC', 1, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (28, N'driver', 2, N'motor', NULL, N'AC', 1, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (29, N'driver', 1, N'motor', NULL, N'AC', 1, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (30, N'driver', 2, N'motor', NULL, N'AC', 1, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (31, N'driver', 1, N'motor', NULL, N'AC', 1, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.22 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (32, N'driver', 2, N'motor', NULL, N'AC', 1, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.22 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (33, N'driver', 1, N'motor', NULL, N'AC', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.32 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (34, N'driver', 2, N'motor', NULL, N'AC', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.32 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (35, N'driver', 1, N'motor', NULL, N'AC', 0, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (36, N'driver', 2, N'motor', NULL, N'AC', 0, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (37, N'driver', 1, N'motor', NULL, N'AC', 0, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.16 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (38, N'driver', 2, N'motor', NULL, N'AC', 0, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.16 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (39, N'driver', 1, N'motor', NULL, N'AC', 0, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.26 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (40, N'driver', 2, N'motor', NULL, N'AC', 0, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.26 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (41, N'driver', 1, N'motor', NULL, N'AC', 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.36 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (42, N'driver', 2, N'motor', NULL, N'AC', 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.36 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (43, N'driver', 1, N'motor', NULL, N'AC', 0, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (44, N'driver', 2, N'motor', NULL, N'AC', 0, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (45, N'driver', 1, N'motor', NULL, N'AC', 0, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.17 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (46, N'driver', 2, N'motor', NULL, N'AC', 0, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.17 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (47, N'driver', 1, N'motor', NULL, N'AC', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.27 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (48, N'driver', 2, N'motor', NULL, N'AC', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.27 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (49, N'driver', 1, N'motor', NULL, N'AC', 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.37 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (50, N'driver', 2, N'motor', NULL, N'AC', 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.37 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (51, N'driver', 1, N'motor', NULL, N'DC', 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.61 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (52, N'driver', 2, N'motor', NULL, N'DC', 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.61 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (53, N'driver', 1, N'motor', NULL, N'DC', 1, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.71 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (54, N'driver', 2, N'motor', NULL, N'DC', 1, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(16.71 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (55, N'driver', 1, N'motor', NULL, N'DC', 1, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.81 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (56, N'driver', 2, N'motor', NULL, N'DC', 1, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.81 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (57, N'driver', 1, N'motor', NULL, N'DC', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.91 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (58, N'driver', 2, N'motor', NULL, N'DC', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.91 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (59, N'driver', 1, N'motor', NULL, N'DC', 1, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.62 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (60, N'driver', 2, N'motor', NULL, N'DC', 1, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.62 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (61, N'driver', 1, N'motor', NULL, N'DC', 1, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.72 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (62, N'driver', 2, N'motor', NULL, N'DC', 1, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.72 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (63, N'driver', 1, N'motor', NULL, N'DC', 1, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.82 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (64, N'driver', 2, N'motor', NULL, N'DC', 1, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.82 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (65, N'driver', 1, N'motor', NULL, N'DC', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.92 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (66, N'driver', 2, N'motor', NULL, N'DC', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.92 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (67, N'driver', 1, N'motor', NULL, N'DC', 0, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.66 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (68, N'driver', 2, N'motor', NULL, N'DC', 0, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.66 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (69, N'driver', 1, N'motor', NULL, N'DC', 0, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.76 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (70, N'driver', 2, N'motor', NULL, N'DC', 0, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.76 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (71, N'driver', 1, N'motor', NULL, N'DC', 0, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.86 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (72, N'driver', 2, N'motor', NULL, N'DC', 0, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.86 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (73, N'driver', 1, N'motor', NULL, N'DC', 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.96 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (74, N'driver', 2, N'motor', NULL, N'DC', 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.96 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (75, N'driver', 1, N'motor', NULL, N'DC', 0, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.67 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (76, N'driver', 2, N'motor', NULL, N'DC', 0, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(16.67 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (77, N'driver', 1, N'motor', NULL, N'DC', 0, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.77 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (78, N'driver', 2, N'motor', NULL, N'DC', 0, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.77 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (79, N'driver', 1, N'motor', NULL, N'DC', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.87 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (80, N'driver', 2, N'motor', NULL, N'DC', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.87 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (81, N'driver', 1, N'motor', NULL, N'DC', 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.97 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (82, N'driver', 2, N'motor', NULL, N'DC', 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.97 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (83, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 1, 1, 10, NULL, NULL, NULL, NULL, NULL, CAST(45.15 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (84, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 1, 1, 10, NULL, NULL, NULL, NULL, NULL, CAST(46.15 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (85, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 1, 0, 10, NULL, NULL, NULL, NULL, NULL, CAST(45.25 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (86, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 1, 0, 10, NULL, NULL, NULL, NULL, NULL, CAST(46.25 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (87, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 0, 1, 10, NULL, NULL, NULL, NULL, NULL, CAST(45.35 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (88, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 0, 1, 10, NULL, NULL, NULL, NULL, NULL, CAST(46.35 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (89, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 0, 0, 10, NULL, NULL, NULL, NULL, NULL, CAST(45.45 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (90, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 0, 0, 10, NULL, NULL, NULL, NULL, NULL, CAST(46.45 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (91, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 1, 1, 10, NULL, NULL, NULL, NULL, NULL, CAST(45.55 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (92, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 1, 1, 10, NULL, NULL, NULL, NULL, NULL, CAST(46.55 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (93, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 1, 0, 10, NULL, NULL, NULL, NULL, NULL, CAST(45.65 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (94, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 1, 0, 10, NULL, NULL, NULL, NULL, NULL, CAST(46.65 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (95, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 0, 1, 10, NULL, NULL, NULL, NULL, NULL, CAST(45.75 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (96, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 0, 1, 10, NULL, NULL, NULL, NULL, NULL, CAST(46.75 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (97, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 0, 0, 10, NULL, NULL, NULL, NULL, NULL, CAST(45.85 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (98, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 0, 0, 10, NULL, NULL, NULL, NULL, NULL, CAST(46.85 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (99, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 1, 1, 2, NULL, NULL, NULL, NULL, NULL, CAST(45.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (100, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 1, 1, 2, NULL, NULL, NULL, NULL, NULL, CAST(46.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (101, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 1, 0, 2, NULL, NULL, NULL, NULL, NULL, CAST(45.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (102, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 1, 0, 2, NULL, NULL, NULL, NULL, NULL, CAST(46.21 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (103, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 0, 1, 2, NULL, NULL, NULL, NULL, NULL, CAST(45.31 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (104, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 0, 1, 2, NULL, NULL, NULL, NULL, NULL, CAST(46.31 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (105, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, CAST(45.41 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (106, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, CAST(46.41 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (107, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 1, 1, 2, NULL, NULL, NULL, NULL, NULL, CAST(45.51 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (108, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 1, 1, 2, NULL, NULL, NULL, NULL, NULL, CAST(46.51 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (109, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 1, 0, 2, NULL, NULL, NULL, NULL, NULL, CAST(45.61 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (110, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 1, 0, 2, NULL, NULL, NULL, NULL, NULL, CAST(46.61 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (111, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 0, 1, 2, NULL, NULL, NULL, NULL, NULL, CAST(45.71 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (112, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 0, 1, 2, NULL, NULL, NULL, NULL, NULL, CAST(46.71 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (113, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, CAST(45.81 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (114, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, CAST(46.81 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (115, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 1, 1, 4, NULL, NULL, NULL, NULL, NULL, CAST(45.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (116, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 1, 1, 4, NULL, NULL, NULL, NULL, NULL, CAST(46.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (117, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 1, 0, 4, NULL, NULL, NULL, NULL, NULL, CAST(45.22 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (118, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 1, 0, 4, NULL, NULL, NULL, NULL, NULL, CAST(46.22 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (119, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 0, 1, 4, NULL, NULL, NULL, NULL, NULL, CAST(45.32 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (120, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 0, 1, 4, NULL, NULL, NULL, NULL, NULL, CAST(46.32 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (121, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, CAST(45.42 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (122, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, CAST(46.42 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (123, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 1, 1, 4, NULL, NULL, NULL, NULL, NULL, CAST(45.52 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (124, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 1, 1, 4, NULL, NULL, NULL, NULL, NULL, CAST(46.52 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (125, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 1, 0, 4, NULL, NULL, NULL, NULL, NULL, CAST(45.62 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (126, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 1, 0, 4, NULL, NULL, NULL, NULL, NULL, CAST(46.62 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (127, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 0, 1, 4, NULL, NULL, NULL, NULL, NULL, CAST(45.72 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (128, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 0, 1, 4, NULL, NULL, NULL, NULL, NULL, CAST(46.72 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (129, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, CAST(45.82 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (130, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, CAST(46.82 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (131, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 1, 1, 6, NULL, NULL, NULL, NULL, NULL, CAST(45.13 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (132, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 1, 1, 6, NULL, NULL, NULL, NULL, NULL, CAST(46.13 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (133, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 1, 0, 6, NULL, NULL, NULL, NULL, NULL, CAST(45.23 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (134, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 1, 0, 6, NULL, NULL, NULL, NULL, NULL, CAST(46.23 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (135, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 0, 1, 6, NULL, NULL, NULL, NULL, NULL, CAST(45.33 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (136, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 0, 1, 6, NULL, NULL, NULL, NULL, NULL, CAST(46.33 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (137, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 0, 0, 6, NULL, NULL, NULL, NULL, NULL, CAST(45.43 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (138, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 0, 0, 6, NULL, NULL, NULL, NULL, NULL, CAST(46.43 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (139, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 1, 1, 6, NULL, NULL, NULL, NULL, NULL, CAST(45.53 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (140, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 1, 1, 6, NULL, NULL, NULL, NULL, NULL, CAST(46.53 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (141, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 1, 0, 6, NULL, NULL, NULL, NULL, NULL, CAST(45.63 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (142, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 1, 0, 6, NULL, NULL, NULL, NULL, NULL, CAST(46.63 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (143, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 0, 1, 6, NULL, NULL, NULL, NULL, NULL, CAST(45.73 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (144, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 0, 1, 6, NULL, NULL, NULL, NULL, NULL, CAST(46.73 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (145, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 0, 0, 6, NULL, NULL, NULL, NULL, NULL, CAST(45.83 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (146, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 0, 0, 6, NULL, NULL, NULL, NULL, NULL, CAST(46.83 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (147, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 1, 1, 8, NULL, NULL, NULL, NULL, NULL, CAST(45.14 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (148, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 1, 1, 8, NULL, NULL, NULL, NULL, NULL, CAST(46.14 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (149, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 1, 0, 8, NULL, NULL, NULL, NULL, NULL, CAST(45.24 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (150, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 1, 0, 8, NULL, NULL, NULL, NULL, NULL, CAST(46.24 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (151, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 0, 1, 8, NULL, NULL, NULL, NULL, NULL, CAST(45.34 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (152, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 0, 1, 8, NULL, NULL, NULL, NULL, NULL, CAST(46.34 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (153, N'driver', 1, N'motor', NULL, N'VFD', 0, 1, 0, 0, 8, NULL, NULL, NULL, NULL, NULL, CAST(45.44 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (154, N'driver', 2, N'motor', NULL, N'VFD', 0, 1, 0, 0, 8, NULL, NULL, NULL, NULL, NULL, CAST(46.44 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (155, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 1, 1, 8, NULL, NULL, NULL, NULL, NULL, CAST(45.54 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (156, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 1, 1, 8, NULL, NULL, NULL, NULL, NULL, CAST(46.54 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (157, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 1, 0, 8, NULL, NULL, NULL, NULL, NULL, CAST(45.64 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (158, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 1, 0, 8, NULL, NULL, NULL, NULL, NULL, CAST(46.64 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (159, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 0, 1, 8, NULL, NULL, NULL, NULL, NULL, CAST(45.74 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (160, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 0, 1, 8, NULL, NULL, NULL, NULL, NULL, CAST(46.74 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (161, N'driver', 1, N'motor', NULL, N'VFD', 0, 0, 0, 0, 8, NULL, NULL, NULL, NULL, NULL, CAST(45.84 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (162, N'driver', 2, N'motor', NULL, N'VFD', 0, 0, 0, 0, 8, NULL, NULL, NULL, NULL, NULL, CAST(46.84 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (163, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.15 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (164, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 0, NULL, CAST(11.15 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (165, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 1, CAST(1.16 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (166, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 1, CAST(11.16 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (167, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, CAST(1.17 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (168, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, CAST(11.17 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (169, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, 0, NULL, CAST(1.19 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (170, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, 0, NULL, CAST(11.19 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (171, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, NULL, CAST(1.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (172, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, NULL, CAST(11.12 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (173, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 1, 1, CAST(1.14 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (174, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 1, 1, CAST(11.14 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (175, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 1, 0, CAST(1.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (176, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 1, 0, CAST(11.11 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (177, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 0, NULL, CAST(1.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (178, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 0, NULL, CAST(11.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (179, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, NULL, CAST(1.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (180, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, NULL, CAST(11.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (181, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 1, CAST(1.08 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (182, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 1, CAST(11.08 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (183, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, CAST(1.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (184, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, CAST(11.06 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (185, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, 1, 1, CAST(1.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (186, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, 1, 1, CAST(11.07 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (187, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, NULL, CAST(1.09 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (188, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, NULL, CAST(11.09 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (189, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 1, 1, CAST(1.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (190, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 1, 1, CAST(11.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (191, N'driver', 1, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 1, 0, CAST(1.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (192, N'driver', 2, N'turbine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 1, 0, CAST(11.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblDriverDetails] ([id], [componentType], [locations], [driverType], [cylinders], [motorDrive], [motorFan], [motorBallBearings], [drivenBallBearings], [drivenBalanceable], [motorPoles], [turbineReductionGear], [turbineRotorSupported], [turbineBallBearing], [turbineThrustBearing], [turbineThrustBearingIsBall], [componentCode], [isDeleted]) VALUES (193, N'driverTest123', 1, N'diesel', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0)
GO
SET IDENTITY_INSERT [master].[tblDriverDetails] OFF
GO
SET IDENTITY_INSERT [master].[tblIntermediateDetails] ON 
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (1, N'Intermediate', N'none_rigid', NULL, NULL, NULL, NULL, 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (2, N'Intermediate', N'gearbox', 1, NULL, 1, CAST(13.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (3, N'Intermediate', N'gearbox', 2, NULL, 1, CAST(13.05 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (4, N'Intermediate', N'gearbox', 3, NULL, 1, CAST(13.09 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (5, N'Intermediate', N'gearbox', 4, NULL, 1, CAST(13.13 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (6, N'Intermediate', N'gearbox', 1, NULL, 2, CAST(13.31 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (7, N'Intermediate', N'gearbox', 2, NULL, 2, CAST(13.41 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (8, N'Intermediate', N'gearbox', 3, NULL, 2, CAST(13.51 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (9, N'Intermediate', N'gearbox', 4, NULL, 2, CAST(13.61 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (10, N'Intermediate', N'gearbox', 1, NULL, 3, CAST(33.01 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (11, N'Intermediate', N'gearbox', 2, NULL, 3, CAST(33.02 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (12, N'Intermediate', N'gearbox', 3, NULL, 3, CAST(33.03 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (13, N'Intermediate', N'gearbox', 4, NULL, 3, CAST(33.04 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (14, N'Intermediate', N'AOP', 1, N'inputshaft', NULL, CAST(13.71 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (15, N'Intermediate', N'AOP', 1, N'intermediateshaft', NULL, CAST(13.72 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (16, N'Intermediate', N'AOP', 1, N'outputshaft', NULL, CAST(13.73 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (17, N'Intermediate', N'AccDrGr', 1, N'inputshaft', NULL, CAST(13.76 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (18, N'Intermediate', N'AccDrGr', 1, N'intermediateshaft', NULL, CAST(13.77 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (19, N'Intermediate', N'AccDrGr', 1, N'outputshaft', NULL, CAST(13.78 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (21, N'vishal0335', NULL, NULL, NULL, 0, CAST(0.00 AS Decimal(18, 2)), 0)
GO
INSERT [master].[tblIntermediateDetails] ([id], [componentType], [intermediateType], [locations], [drivenBy], [speedChangesMax], [componentCode], [isDeleted]) VALUES (23, N'Test', N'Gr', NULL, NULL, 2, CAST(0.00 AS Decimal(18, 2)), 1)
GO
SET IDENTITY_INSERT [master].[tblIntermediateDetails] OFF
GO
SET IDENTITY_INSERT [master].[tblPickupCodeDetails] ON 
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (1, 1, 1, 0, 0, 0, 0, 0, 0, N'1,0', N'1,0', NULL, NULL, NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (2, 1, 1, 0, 0, 0, 1, 0, 1, N'1,8', N'1,8', NULL, NULL, N'8,1', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (3, 1, 1, 0, 0, 0, 1, 1, 0, N'1,7', N'1,7', NULL, NULL, N'7,1', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (4, 1, 1, 0, 0, 0, 2, 1, 1, N'1,7', N'1,7', NULL, NULL, N'8,7,1', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (5, 2, 1, 1, 0, 0, 0, 0, 0, N'1,2,0', N'2,0', NULL, NULL, NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (6, 2, 1, 1, 0, 0, 1, 0, 1, N'1,2,8', N'2,8', NULL, NULL, N'8,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (7, 2, 1, 1, 0, 0, 1, 1, 0, N'1,2,7', N'2,7', NULL, NULL, N'7,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (8, 2, 1, 1, 0, 0, 2, 1, 1, N'1,2,7', N'2,7', NULL, NULL, N'8,7,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (9, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (10, 0, 0, 0, 0, 0, 1, 0, 1, NULL, N'0,8', NULL, NULL, N'8,0', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (11, 0, 0, 0, 0, 0, 1, 1, 0, NULL, N'0,7', NULL, NULL, N'7,0', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (12, 0, 0, 0, 0, 0, 2, 1, 1, NULL, N'0,7', NULL, NULL, N'8,7,0', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (13, 1, 0, 1, 0, 0, 0, 0, 0, N'2,0', N'2,0', NULL, NULL, NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (14, 1, 0, 1, 0, 0, 1, 0, 1, N'2,8', N'2,8', NULL, NULL, N'8,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (15, 1, 0, 1, 0, 0, 1, 1, 0, N'2,7', N'2,7', NULL, NULL, N'7,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (16, 1, 0, 1, 0, 0, 2, 1, 1, N'2,7', N'2,7', NULL, NULL, N'8,7,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (17, 1, 1, 0, 0, 1, 0, 0, 0, N'1,0', N'1,0', NULL, N'1,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (18, 1, 1, 0, 0, 1, 1, 0, 1, N'1,8', N'1,8', NULL, N'1,8', N'8,1', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (19, 1, 1, 0, 0, 1, 1, 1, 0, N'1,7', N'1,7', NULL, N'1,7', N'7,1', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (20, 1, 1, 0, 0, 1, 2, 1, 1, N'1,7', N'1,7', NULL, N'1,7', N'8,7,1', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (21, 2, 1, 1, 0, 1, 0, 0, 0, N'1,2,0', N'2,0', NULL, N'2,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (22, 2, 1, 1, 0, 1, 1, 0, 1, N'1,2,8', N'2,8', NULL, N'2,8', N'8,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (23, 2, 1, 1, 0, 1, 1, 1, 0, N'1,2,7', N'2,7', NULL, N'2,7', N'7,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (24, 2, 1, 1, 0, 1, 2, 1, 1, N'1,2,7', N'2,7', NULL, N'2,7', N'8,7,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (25, 0, 0, 0, 0, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (26, 0, 0, 0, 0, 1, 1, 0, 1, NULL, N'0,8', NULL, N'0,8', N'8,0', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (27, 0, 0, 0, 0, 1, 1, 1, 0, NULL, N'0,7', NULL, N'0,7', N'7,0', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (28, 0, 0, 0, 0, 1, 2, 1, 1, NULL, N'0,7', NULL, N'0,7', N'8,7,0', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (29, 1, 0, 1, 0, 1, 0, 0, 0, N'2,0', N'2,0', NULL, N'2,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (30, 1, 0, 1, 0, 1, 1, 0, 1, N'2,8', N'2,8', NULL, N'2,8', N'8,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (31, 1, 0, 1, 0, 1, 1, 1, 0, N'2,7', N'2,7', NULL, N'2,7', N'7,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (32, 1, 0, 1, 0, 1, 2, 1, 1, N'2,7', N'2,7', NULL, N'2,7', N'8,7,2', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (33, 1, 1, 0, 1, 1, 0, 0, 0, N'1,0', N'1,3', N'1,3,0,0', N'3,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (34, 1, 1, 0, 1, 1, 1, 0, 1, N'1,8', N'1,3', N'1,3,8,8', N'3,8', N'8,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (35, 1, 1, 0, 1, 1, 1, 1, 0, N'1,7', N'1,3', N'1,3,7,7', N'3,7', N'7,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (36, 1, 1, 0, 1, 1, 2, 1, 1, N'1,7', N'1,3', N'1,3,7,7', N'3,7', N'8,7,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (37, 2, 1, 1, 1, 1, 0, 0, 0, N'1,2,0', N'2,3', N'2,3,0,0', N'3,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (38, 2, 1, 1, 1, 1, 1, 0, 1, N'1,2,8', N'2,3', N'2,3,8,8', N'3,8', N'8,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (39, 2, 1, 1, 1, 1, 1, 1, 0, N'1,2,7', N'2,3', N'2,3,7,7', N'3,7', N'7,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (40, 2, 1, 1, 1, 1, 2, 1, 1, N'1,2,7', N'2,3', N'2,3,7,7', N'3,7', N'8,7,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (41, 0, 0, 0, 1, 1, 0, 0, 0, NULL, N'0,3', N'0,3,0,0', N'3,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (42, 0, 0, 0, 1, 1, 1, 0, 1, NULL, N'0,3', N'0,3,8,8', N'3,8', N'8,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (43, 0, 0, 0, 1, 1, 1, 1, 0, NULL, N'0,3', N'0,3,7,7', N'3,7', N'7,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (44, 0, 0, 0, 1, 1, 2, 1, 1, NULL, N'0,3', N'0,3,7,7', N'3,7', N'8,7,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (45, 1, 0, 1, 1, 1, 0, 0, 0, N'2,0', N'2,3', N'2,3,0,0', N'3,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (46, 1, 0, 1, 1, 1, 1, 0, 1, N'2,8', N'2,3', N'2,3,8,8', N'3,8', N'8,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (47, 1, 0, 1, 1, 1, 1, 1, 0, N'2,7', N'2,3', N'2,3,7,7', N'3,7', N'7,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (48, 1, 0, 1, 1, 1, 2, 1, 1, N'2,7', N'2,3', N'2,3,7,7', N'3,7', N'8,7,3', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (49, 1, 1, 0, 2, 1, 0, 0, 0, N'1,0', N'1,3', N'1,3,4,0', N'4,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (50, 1, 1, 0, 2, 1, 1, 0, 1, N'1,8', N'1,3', N'1,3,4,8', N'4,8', N'8,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (51, 1, 1, 0, 2, 1, 1, 1, 0, N'1,7', N'1,3', N'1,3,4,7', N'4,7', N'7,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (52, 1, 1, 0, 2, 1, 2, 1, 1, N'1,7', N'1,3', N'1,3,4,7', N'4,7', N'8,7,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (53, 2, 1, 1, 2, 1, 0, 0, 0, N'1,2,0', N'2,3', N'2,3,4,0', N'4,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (54, 2, 1, 1, 2, 1, 1, 0, 1, N'1,2,8', N'2,3', N'2,3,4,8', N'4,8', N'8,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (55, 2, 1, 1, 2, 1, 1, 1, 0, N'1,2,7', N'2,3', N'2,3,4,7', N'4,7', N'7,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (56, 2, 1, 1, 2, 1, 2, 1, 1, N'1,2,7', N'2,3', N'2,3,4,7', N'4,7', N'8,7,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (57, 0, 0, 0, 2, 1, 0, 0, 0, NULL, N'0,3', N'0,3,4,0', N'4,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (58, 0, 0, 0, 2, 1, 1, 0, 1, NULL, N'0,3', N'0,3,4,8', N'4,8', N'8,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (59, 0, 0, 0, 2, 1, 1, 1, 0, NULL, N'0,3', N'0,3,4,7', N'4,7', N'7,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (60, 0, 0, 0, 2, 1, 2, 1, 1, NULL, N'0,3', N'0,3,4,7', N'4,7', N'8,7,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (61, 1, 0, 1, 2, 1, 0, 0, 0, N'2,0', N'2,3', N'2,3,4,0', N'4,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (62, 1, 0, 1, 2, 1, 1, 0, 1, N'2,8', N'2,3', N'2,3,4,8', N'4,8', N'8,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (63, 1, 0, 1, 2, 1, 1, 1, 0, N'2,7', N'2,3', N'2,3,4,7', N'4,7', N'7,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (64, 1, 0, 1, 2, 1, 2, 1, 1, N'2,7', N'2,3', N'2,3,4,7', N'4,7', N'8,7,4', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (65, 1, 1, 0, 3, 1, 0, 0, 0, N'1,0', N'1,3', N'1,3,4,5', N'5,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (66, 1, 1, 0, 3, 1, 1, 0, 1, N'1,8', N'1,3', N'1,3,4,5', N'5,8', N'8,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (67, 1, 1, 0, 3, 1, 1, 1, 0, N'1,7', N'1,3', N'1,3,4,5', N'5,7', N'7,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (68, 1, 1, 0, 3, 1, 2, 1, 1, N'1,7', N'1,3', N'1,3,4,5', N'5,7', N'8,7,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (69, 2, 1, 1, 3, 1, 0, 0, 0, N'1,2,0', N'2,3', N'2,3,4,5', N'5,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (70, 2, 1, 1, 3, 1, 1, 0, 1, N'1,2,8', N'2,3', N'2,3,4,5', N'5,8', N'8,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (71, 2, 1, 1, 3, 1, 1, 1, 0, N'1,2,7', N'2,3', N'2,3,4,5', N'5,7', N'7,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (72, 2, 1, 1, 3, 1, 2, 1, 1, N'1,2,7', N'2,3', N'2,3,4,5', N'5,7', N'8,7,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (73, 0, 0, 0, 3, 1, 0, 0, 0, NULL, N'0,3', N'0,3,4,5', N'5,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (74, 0, 0, 0, 3, 1, 1, 0, 1, NULL, N'0,3', N'0,3,4,5', N'5,8', N'8,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (75, 0, 0, 0, 3, 1, 1, 1, 0, NULL, N'0,3', N'0,3,4,5', N'5,7', N'7,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (76, 0, 0, 0, 3, 1, 2, 1, 1, NULL, N'0,3', N'0,3,4,5', N'5,7', N'8,7,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (77, 1, 0, 1, 3, 1, 0, 0, 0, N'2,0', N'2,3', N'2,3,4,5', N'5,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (78, 1, 0, 1, 3, 1, 1, 0, 1, N'2,8', N'2,3', N'2,3,4,5', N'5,8', N'8,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (79, 1, 0, 1, 3, 1, 1, 1, 0, N'2,7', N'2,3', N'2,3,4,5', N'5,7', N'7,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (80, 1, 0, 1, 3, 1, 2, 1, 1, N'2,7', N'2,3', N'2,3,4,5', N'5,7', N'8,7,5', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (81, 1, 1, 0, 4, 1, 0, 0, 0, N'1,0', N'1,3', N'3,4,5,6', N'6,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (82, 1, 1, 0, 4, 1, 1, 0, 1, N'1,8', N'1,3', N'3,4,5,6', N'6,8', N'8,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (83, 1, 1, 0, 4, 1, 1, 1, 0, N'1,7', N'1,3', N'3,4,5,6', N'6,7', N'7,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (84, 1, 1, 0, 4, 1, 2, 1, 1, N'1,7', N'1,3', N'3,4,5,6', N'6,7', N'8,7,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (85, 2, 1, 1, 4, 1, 0, 0, 0, N'1,2,0', N'2,3', N'3,4,5,6', N'6,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (86, 2, 1, 1, 4, 1, 1, 0, 1, N'1,2,8', N'2,3', N'3,4,5,6', N'6,8', N'8,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (87, 2, 1, 1, 4, 1, 1, 1, 0, N'1,2,7', N'2,3', N'3,4,5,6', N'6,7', N'7,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (88, 2, 1, 1, 4, 1, 2, 1, 1, N'1,2,7', N'2,3', N'3,4,5,6', N'6,7', N'8,7,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (89, 0, 0, 0, 4, 1, 0, 0, 0, NULL, N'0,3', N'3,4,5,6', N'6,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (90, 0, 0, 0, 4, 1, 1, 0, 1, NULL, N'0,3', N'3,4,5,6', N'6,8', N'8,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (91, 0, 0, 0, 4, 1, 1, 1, 0, NULL, N'0,3', N'3,4,5,6', N'6,7', N'7,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (92, 0, 0, 0, 4, 1, 2, 1, 1, NULL, N'0,3', N'3,4,5,6', N'6,7', N'8,7,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (93, 1, 0, 1, 4, 1, 0, 0, 0, N'2,0', N'2,3', N'3,4,5,6', N'6,0', NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (94, 1, 0, 1, 4, 1, 1, 0, 1, N'2,8', N'2,3', N'3,4,5,6', N'6,8', N'8,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (95, 1, 0, 1, 4, 1, 1, 1, 0, N'2,7', N'2,3', N'3,4,5,6', N'6,7', N'7,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (96, 1, 0, 1, 4, 1, 2, 1, 1, N'2,7', N'2,3', N'3,4,5,6', N'6,7', N'8,7,6', 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (99, 12, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0)
GO
INSERT [master].[tblPickupCodeDetails] ([id], [driverLocations], [driverLocationNDE], [driverLocationDE], [intermediateLocations], [intermediatepresent], [drivenLocations], [drivenLocationDE], [drivenLocationNDE], [driverPickupCode], [coupling1PickupCode], [intermediatePickupCode], [coupling2PickupCode], [drivenPickupCode], [isDeleted]) VALUES (100, 11, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [master].[tblPickupCodeDetails] OFF
GO
SET IDENTITY_INSERT [master].[tblSpecialFaultCodesDetails] ON 
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (1, N'vanes', 3, N'PV', 0)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (2, N'driven_threads', 3, N'PT', 0)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (3, N'idler_threads', 1, N'1XR', 0)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (4, N'teeth', 3, N'PT', 0)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (5, N'pistons', 3, N'PP', 0)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (6, N'input_lobes', 3, N'BL', 0)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (7, N'idler_lobes', 1, N'1XR', 0)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (8, N'stage1_fan_blades', 3, N'FB1', 0)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (9, N'stage2_fan_blades', 3, N'FB2', 0)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (10, N'fan_blades', 3, N'FB', 0)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (11, N'cylinders', 1, N'EP', 0)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (12, N'Test123', 4, N'1XR', 1)
GO
INSERT [master].[tblSpecialFaultCodesDetails] ([id], [specialfaultcodetype], [specialmultiple], [specialcode], [isDeleted]) VALUES (13, N'Test1', 1, N'EP', 1)
GO
SET IDENTITY_INSERT [master].[tblSpecialFaultCodesDetails] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Coupling1_Details]    Script Date: 19-05-2021 12:47:26 ******/
ALTER TABLE [master].[tblCoupling1Details] ADD  CONSTRAINT [Coupling1_Details] UNIQUE NONCLUSTERED 
(
	[componentType] ASC,
	[couplingPosition] ASC,
	[couplingType] ASC,
	[locations] ASC,
	[coupledComponentType1] ASC,
	[coupledComponentType2] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Coupling2_Details]    Script Date: 19-05-2021 12:47:26 ******/
ALTER TABLE [master].[tblCoupling2Details] ADD  CONSTRAINT [Coupling2_Details] UNIQUE NONCLUSTERED 
(
	[componentType] ASC,
	[couplingPosition] ASC,
	[couplingType] ASC,
	[locations] ASC,
	[coupledComponentType1] ASC,
	[coupledComponentType2] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CSDMdefsDetails]    Script Date: 19-05-2021 12:47:26 ******/
ALTER TABLE [master].[tblCSDMdefsDetails] ADD  CONSTRAINT [CSDMdefsDetails] UNIQUE NONCLUSTERED 
(
	[CSDMfile] ASC,
	[componentcoderangestart] ASC,
	[componentcoderangeend] ASC,
	[CSDMsize] ASC,
	[CSDMrelative] ASC,
	[defaultshaftlabel] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Driven_Detail]    Script Date: 19-05-2021 12:47:26 ******/
ALTER TABLE [master].[tblDrivenDetails] ADD  CONSTRAINT [Driven_Detail] UNIQUE NONCLUSTERED 
(
	[drivenType] ASC,
	[locations] ASC,
	[pumpType] ASC,
	[compressorType] ASC,
	[fan_or_blowerType] ASC,
	[purifierDrivenBy] ASC,
	[bearingType] ASC,
	[vacuumPumpType] ASC,
	[rotorOverhung] ASC,
	[attachedOilPump] ASC,
	[impellerOnMainShaft] ASC,
	[crankHasIntermediateBearing] ASC,
	[fanStages] ASC,
	[exciter] ASC,
	[centrifugalPumpHasBallBearings] ASC,
	[propellerpumpHasBallBearings] ASC,
	[rotaryThreadPumpHasBallBearings] ASC,
	[gearPumpHasBallBearings] ASC,
	[screwPumpHasBallBearings] ASC,
	[slidingVanePumpHasBallBearings] ASC,
	[axialRecipPumpHasBallBearings] ASC,
	[centrifugalCompressorHasBallBearings] ASC,
	[reciprocatingCompressorHasBallBearings] ASC,
	[screwCompressorHasBallBearings] ASC,
	[screwTwinCompressorHasBallBearingsOnHPSide] ASC,
	[lobedFanOrBlowerHasBallBearings] ASC,
	[overhungRotorFanOrBlowerHasBearings] ASC,
	[supportedRotorFanOrBlowerHasBearings] ASC,
	[exciterOverhungOrSupported] ASC,
	[bearingsType] ASC,
	[thrustBearing] ASC,
	[drivenBy] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Driver_Details]    Script Date: 19-05-2021 12:47:26 ******/
ALTER TABLE [master].[tblDriverDetails] ADD  CONSTRAINT [Driver_Details] UNIQUE NONCLUSTERED 
(
	[componentType] ASC,
	[locations] ASC,
	[driverType] ASC,
	[cylinders] ASC,
	[motorDrive] ASC,
	[motorFan] ASC,
	[motorBallBearings] ASC,
	[drivenBallBearings] ASC,
	[drivenBalanceable] ASC,
	[motorPoles] ASC,
	[turbineReductionGear] ASC,
	[turbineRotorSupported] ASC,
	[turbineBallBearing] ASC,
	[turbineThrustBearing] ASC,
	[turbineThrustBearingIsBall] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Intermediate_Details]    Script Date: 19-05-2021 12:47:26 ******/
ALTER TABLE [master].[tblIntermediateDetails] ADD  CONSTRAINT [Intermediate_Details] UNIQUE NONCLUSTERED 
(
	[componentType] ASC,
	[intermediateType] ASC,
	[locations] ASC,
	[drivenBy] ASC,
	[speedChangesMax] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [tblPickup_CodeDetails]    Script Date: 19-05-2021 12:47:26 ******/
ALTER TABLE [master].[tblPickupCodeDetails] ADD  CONSTRAINT [tblPickup_CodeDetails] UNIQUE NONCLUSTERED 
(
	[driverLocations] ASC,
	[driverLocationNDE] ASC,
	[driverLocationDE] ASC,
	[intermediateLocations] ASC,
	[intermediatepresent] ASC,
	[drivenLocations] ASC,
	[drivenLocationDE] ASC,
	[drivenLocationNDE] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [specialFaultCodesDetails]    Script Date: 19-05-2021 12:47:26 ******/
ALTER TABLE [master].[tblSpecialFaultCodesDetails] ADD  CONSTRAINT [specialFaultCodesDetails] UNIQUE NONCLUSTERED 
(
	[specialfaultcodetype] ASC,
	[specialmultiple] ASC,
	[specialcode] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [master].[tblCoupling1Details] ADD  CONSTRAINT [DF_tblCoupling1Details_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [master].[tblCoupling2Details] ADD  CONSTRAINT [DF_tblCoupling2Details_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [master].[tblCSDMdefsDetails] ADD  CONSTRAINT [DF_tblCSDMdefsDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [master].[tblDrivenDetails] ADD  CONSTRAINT [DF_tblDrivenDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [master].[tblDriverDetails] ADD  CONSTRAINT [DF_tblDriverDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [master].[tblIntermediateDetails] ADD  CONSTRAINT [DF_tblIntermediateDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [master].[tblPickupCodeDetails] ADD  CONSTRAINT [DF__tblPickup__isDel__4F47C5E3]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [master].[tblSpecialFaultCodesDetails] ADD  CONSTRAINT [DF_tblSpecialFaultCodesDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
/****** Object:  StoredProcedure [dbo].[spAddOrUpdateCoupling1Details]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <28/04/2021>
-- Description: <SP used for save coupling1 component data>
-- =============================================
CREATE PROCEDURE [dbo].[spAddOrUpdateCoupling1Details]
(
   @xmlInput xml = ''
)
AS
BEGIN

	Declare @Id bigint
	BEGIN TRY  
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		Declare @DetailsTable table (id bigint,componentType varchar(100),couplingPosition int,
		couplingType varchar(100),locations int,coupledComponentType1 varchar(100),
		coupledComponentType2 varchar(100),componentCode decimal(18,2))
		
		insert into @DetailsTable
		select id,
		Case when componentType = '' then null else componentType end as componentType,
		Case when couplingPosition = '' then null else couplingPosition end as couplingPosition,
		Case when couplingType = '' then null else couplingType end as couplingType,
		Case when locations = '' then null else locations end as locations,
		Case when coupledComponentType1 = '' then null else coupledComponentType1 end as coupledComponentType1,
		Case when coupledComponentType2 = '' then null else coupledComponentType2 end as coupledComponentType2,
		Case when componentCode = '' then null else componentCode end as componentCode
		FROM OPENXML (@xmlDocumentHandle, 'Coupling1Details',2)
		WITH (id bigint,componentType varchar(100),couplingPosition int,
		couplingType varchar(100),locations int,coupledComponentType1 varchar(100),
		coupledComponentType2 varchar(100),componentCode varchar(10)
		)	

		select @Id = id from @DetailsTable
		if(@Id = 0)
			Begin
				insert into master.tblCoupling1Details
				(componentType,couplingPosition,couplingType,locations,coupledComponentType1,
				coupledComponentType2,componentCode)
				select componentType,couplingPosition,couplingType,locations,coupledComponentType1,
				coupledComponentType2,componentCode from @DetailsTable
				
				set @Id = SCOPE_IDENTITY()

			End
		Else
			Begin
				Update master.tblCoupling1Details set 
				componentType = d.componentType,
				couplingPosition = d.couplingPosition,
				couplingType = d.couplingType,
				locations = d.locations,
				coupledComponentType1 = d.coupledComponentType1,
				coupledComponentType2 = d.coupledComponentType2,
				componentCode = d.componentCode
				from master.tblCoupling1Details a
				inner join @DetailsTable d on a.id = d.id
				where a.id = @Id

			End
	END TRY  
	BEGIN CATCH  
			set @Id = 0
			--SELECT
   -- ERROR_NUMBER() AS ErrorNumber,
   -- ERROR_STATE() AS ErrorState,
   -- ERROR_SEVERITY() AS ErrorSeverity,
   -- ERROR_PROCEDURE() AS ErrorProcedure,
   -- ERROR_LINE() AS ErrorLine,
   -- ERROR_MESSAGE() AS ErrorMessage;
	END CATCH

	select @Id
END
GO
/****** Object:  StoredProcedure [dbo].[spAddOrUpdateCoupling2Details]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <04/05/2021>
-- Description: <SP used for save coupling2 component data>
-- =============================================
CREATE PROCEDURE [dbo].[spAddOrUpdateCoupling2Details]
(
   @xmlInput xml = ''
)
AS
BEGIN

--	Declare  @xmlInput xml = ''
--	set @xmlInput = '
--<Coupling2Details xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>35</id>
--  <componentType>Coupling21</componentType>
--  <couplingPosition xsi:nil="true" />
--  <locations xsi:nil="true" />
--  <componentCode xsi:nil="true" />
--</Coupling2Details>'
	
	Declare @Id bigint
	BEGIN TRY  
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		Declare @DetailsTable table (id bigint,componentType varchar(100),couplingPosition int,
		couplingType varchar(100),locations int,coupledComponentType1 varchar(100),
		coupledComponentType2 varchar(100),componentCode decimal(18,2))
		
		insert into @DetailsTable
		select id,
		Case when componentType = '' then null else componentType end as componentType,
		Case when couplingPosition = '' then null else couplingPosition end as couplingPosition,
		Case when couplingType = '' then null else couplingType end as couplingType,
		Case when locations = '' then null else locations end as locations,
		Case when coupledComponentType1 = '' then null else coupledComponentType1 end as coupledComponentType1,
		Case when coupledComponentType2 = '' then null else coupledComponentType2 end as coupledComponentType2,
		Case when componentCode = '' then null else componentCode end as componentCode
		FROM OPENXML (@xmlDocumentHandle, 'Coupling2Details',2)
		WITH (id bigint,componentType varchar(100),couplingPosition int,
		couplingType varchar(100),locations int,coupledComponentType1 varchar(100),
		coupledComponentType2 varchar(100),componentCode varchar(10)
		)	

		select @Id = id from @DetailsTable
		if(@Id = 0)
			Begin
				insert into master.tblCoupling2Details
				(componentType,couplingPosition,couplingType,locations,coupledComponentType1,
				coupledComponentType2,componentCode)
				select componentType,couplingPosition,couplingType,locations,coupledComponentType1,
				coupledComponentType2,componentCode from @DetailsTable
				
				set @Id = SCOPE_IDENTITY()

			End
		Else
			Begin
				Update master.tblCoupling2Details set 
				componentType = d.componentType,
				couplingPosition = d.couplingPosition,
				couplingType = d.couplingType,
				locations = d.locations,
				coupledComponentType1 = d.coupledComponentType1,
				coupledComponentType2 = d.coupledComponentType2,
				componentCode = d.componentCode
				from master.tblCoupling2Details a
				inner join @DetailsTable d on a.id = d.id
				where a.id = @Id

			End
	END TRY  
	BEGIN CATCH  
			set @Id = 0
			--SELECT
   -- ERROR_NUMBER() AS ErrorNumber,
   -- ERROR_STATE() AS ErrorState,
   -- ERROR_SEVERITY() AS ErrorSeverity,
   -- ERROR_PROCEDURE() AS ErrorProcedure,
   -- ERROR_LINE() AS ErrorLine,
   -- ERROR_MESSAGE() AS ErrorMessage;
	END CATCH

	select @Id
END

--truncate table master.tblIntermediateDetails
GO
/****** Object:  StoredProcedure [dbo].[spAddOrUpdateCSDMdefsDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <06/05/2021>
-- Description: <SP used for save CSDMdefs data>
-- =============================================
CREATE PROCEDURE [dbo].[spAddOrUpdateCSDMdefsDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN

--Declare  @xmlInput xml = '<CSDMdefsDetails xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>0</id>
--  <csdmfile>asdasd</csdmfile>
--  <componentCodeRangeStart>10.0</componentCodeRangeStart>
--  <componentCodeRangeEnd>10.0</componentCodeRangeEnd>
--  <csdmSize>1</csdmSize>
--  <csdmRelative>true</csdmRelative>
--  <defaultShaftLabel>Na</defaultShaftLabel>
--</CSDMdefsDetails>'

	
	Declare @Id bigint
	BEGIN TRY  
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		Declare @DetailsTable table (id bigint,CSDMfile varchar(50),componentcoderangestart decimal(18,2),
		componentcoderangeend decimal(18,2),CSDMsize int,CSDMrelative bit,defaultshaftlabel varchar(50))
				
			insert into @DetailsTable
			select id,Case when csdmfile = '' then null else csdmfile end,
			Convert(decimal(18,2),Case when  componentcoderangestart = '' then null else componentcoderangestart end),
			Convert(decimal(18,2),case when componentCodeRangeEnd = '' then null else  componentCodeRangeEnd end),
			case when CSDMsize = '' then null else CSDMsize end ,
			case when CSDMrelative = '' then null else CSDMrelative end,
			Case when defaultshaftlabel = '' then null else defaultshaftlabel end  
			FROM OPENXML (@xmlDocumentHandle, 'CSDMdefsDetails',2)
			WITH (id bigint,csdmfile varchar(50),componentCodeRangeStart varchar(20),
			componentCodeRangeEnd varchar(20),csdmSize int,csdmRelative bit,defaultShaftLabel varchar(50))

			select @Id = id from @DetailsTable

		if(@Id = 0)
			Begin
				insert into master.tblCSDMdefsDetails (CSDMfile,componentcoderangestart,componentcoderangeend,CSDMsize,
				CSDMrelative,defaultshaftlabel)
				select CSDMfile,componentcoderangestart,componentcoderangeend,CSDMsize,
				CSDMrelative,defaultshaftlabel FROM @DetailsTable
				
				set @Id = SCOPE_IDENTITY()

			End
		Else
			Begin
				
				Update master.tblCSDMdefsDetails set 
				CSDMfile = d.CSDMfile,
				componentcoderangestart = d.componentcoderangestart,
				componentcoderangeend = d.componentcoderangeend,
				CSDMsize = d.CSDMsize,
				CSDMrelative = d.CSDMrelative,
				defaultshaftlabel = d.defaultshaftlabel
				from master.tblCSDMdefsDetails a
				inner join @DetailsTable d on a.id = d.id
				where a.id = @Id

			End
	END TRY  
	BEGIN CATCH  
			set @Id = 0
			--SELECT
   -- ERROR_NUMBER() AS ErrorNumber,
   -- ERROR_STATE() AS ErrorState,
   -- ERROR_SEVERITY() AS ErrorSeverity,
   -- ERROR_PROCEDURE() AS ErrorProcedure,
   -- ERROR_LINE() AS ErrorLine,
   -- ERROR_MESSAGE() AS ErrorMessage;
	END CATCH

	select @Id
END
GO
/****** Object:  StoredProcedure [dbo].[spAddOrUpdateDrivenDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <27/04/2021>
-- Description: <SP used for save driven component data>
-- =============================================
CREATE PROCEDURE [dbo].[spAddOrUpdateDrivenDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN

--	Declare  @xmlInput xml = ''

--	set @xmlInput = '<DrivenDetails xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>173</id>
--  <componentType>Vishal123</componentType>
--  <locations xsi:nil="true" />
--  <rotorOverhung xsi:nil="true" />
--  <attachedOilPump xsi:nil="true" />
--  <impellerOnMainShaft xsi:nil="true" />
--  <crankHasIntermediateBearing xsi:nil="true" />
--  <fanStages xsi:nil="true" />
--  <exciter xsi:nil="true" />
--  <centrifugalPumpHasBallBearings xsi:nil="true" />
--  <propellerpumpHasBallBearings xsi:nil="true" />
--  <rotaryThreadPumpHasBallBearings xsi:nil="true" />
--  <gearPumpHasBallBearings xsi:nil="true" />
--  <screwPumpHasBallBearings xsi:nil="true" />
--  <slidingVanePumpHasBallBearings xsi:nil="true" />
--  <axialRecipPumpHasBallBearings xsi:nil="true" />
--  <centrifugalCompressorHasBallBearings xsi:nil="true" />
--  <reciprocatingCompressorHasBallBearings xsi:nil="true" />
--  <screwCompressorHasBallBearings xsi:nil="true" />
--  <screwTwinCompressorHasBallBearingsOnHPSide xsi:nil="true" />
--  <lobedFanOrBlowerHasBallBearings xsi:nil="true" />
--  <overhungRotorFanOrBlowerHasBearings xsi:nil="true" />
--  <supportedRotorFanOrBlowerHasBearings xsi:nil="true" />
--  <componentCode xsi:nil="true" />
--</DrivenDetails>'
	
	Declare @Id bigint
	BEGIN TRY  
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		Declare @DetailsTable table (id bigint,
		componentType varchar(50),
		drivenType varchar(50),
		locations int,
		pumpType varchar(50),
		compressorType varchar(50),
		fan_or_blowerType varchar(50),
		purifierDrivenBy varchar(50),
		bearingType varchar(50),
		--col_cType varchar(50),
		vacuumPumpType varchar(50),
		rotorOverhung bit,
		attachedOilPump bit,
		impellerOnMainShaft bit,
		crankHasIntermediateBearing bit,
		fanStages bit,
		exciter bit,
		centrifugalPumpHasBallBearings bit,
		propellerpumpHasBallBearings bit,
		rotaryThreadPumpHasBallBearings bit,
		gearPumpHasBallBearings bit,
		screwPumpHasBallBearings bit,
		slidingVanePumpHasBallBearings bit,
		axialRecipPumpHasBallBearings bit,
		centrifugalCompressorHasBallBearings bit,
		reciprocatingCompressorHasBallBearings bit,
		screwCompressorHasBallBearings bit,
		screwTwinCompressorHasBallBearingsOnHPSide bit,
		lobedFanOrBlowerHasBallBearings bit,
		overhungRotorFanOrBlowerHasBearings bit,
		supportedRotorFanOrBlowerHasBearings bit,
		exciterOverhungOrSupported varchar(50),
		bearingsType varchar(50),
		thrustBearing varchar(50),
		drivenBy varchar(50),
		componentCode decimal(18,2))
				
		insert into @DetailsTable
		select id,
		Case when componentType = '' then null else componentType end as componentType,
		Case when drivenType = '' then null else drivenType end as drivenType,
		Case when locations = ''  then null else locations end as locations,
		Case when pumpType = ''  then null else pumpType end as pumpType,
		Case when compressorType = ''  then null else compressorType end as compressorType,
		Case when fan_or_blowerType = ''  then null else fan_or_blowerType end as fan_or_blowerType,
		Case when purifierDrivenBy = ''  then null else purifierDrivenBy end as purifierDrivenBy,
		Case when bearingType = ''  then null else bearingType end as bearingType,
		Case when vacuumpumptype = ''  then null else vacuumpumptype end as vacuumpumptype,
		Case when rotorOverhung = '' then null else rotorOverhung end ,
		Case when attachedOilPump = '' then null else attachedOilPump end ,
		Case when impellerOnMainShaft = '' then null else impellerOnMainShaft end  ,
		Case when crankHasIntermediateBearing = '' then null else crankHasIntermediateBearing end ,
		Case when fanStages = '' then null else fanStages end ,
		Case when exciter = '' then null else exciter end  ,
		Case when centrifugalPumpHasBallBearings = '' then null else centrifugalPumpHasBallBearings end  ,
		Case when propellerpumpHasBallBearings = '' then null else propellerpumpHasBallBearings end ,
		Case when rotaryThreadPumpHasBallBearings = '' then null else rotaryThreadPumpHasBallBearings end  , 
		Case when gearPumpHasBallBearings = '' then null else gearPumpHasBallBearings end ,
		Case when screwPumpHasBallBearings = '' then null else screwPumpHasBallBearings end ,
		Case when slidingVanePumpHasBallBearings = '' then null else slidingVanePumpHasBallBearings end , 
		Case when axialRecipPumpHasBallBearings = '' then null else axialRecipPumpHasBallBearings end ,
		Case when centrifugalCompressorHasBallBearings = '' then null else centrifugalCompressorHasBallBearings end ,
		Case when reciprocatingCompressorHasBallBearings = '' then null else reciprocatingCompressorHasBallBearings end ,
		Case when screwCompressorHasBallBearings = '' then null else screwCompressorHasBallBearings end ,
		Case when screwTwinCompressorHasBallBearingsOnHPSide = '' then null else screwTwinCompressorHasBallBearingsOnHPSide end  ,
		Case when lobedFanOrBlowerHasBallBearings = '' then null else lobedFanOrBlowerHasBallBearings end ,
		Case when overhungRotorFanOrBlowerHasBearings = '' then null else overhungRotorFanOrBlowerHasBearings end  ,
		Case when supportedRotorFanOrBlowerHasBearings = '' then null else supportedRotorFanOrBlowerHasBearings end  ,
		Case when exciterOverhungOrSupported = '' then null else exciterOverhungOrSupported end as exciterOverhungOrSupported ,
		Case when bearingsType = '' then null else bearingsType end as bearingsType ,
		Case when thrustBearing = '' then null else thrustBearing end as thrustBearing ,
		Case when drivenBy = '' then null else drivenBy end as drivenBy ,
		Case when componentCode = '' then null else componentCode end as componentCode
		FROM OPENXML (@xmlDocumentHandle, 'DrivenDetails',2)
		WITH (id bigint,componentType varchar(100),drivenType varchar(100),pumpType varchar(100),compressorType varchar(1000),
		fan_or_blowerType varchar(1000),purifierDrivenBy varchar(100),bearingType varchar(100),vacuumpumptype varchar(100),
		exciterOverhungOrSupported varchar(100),bearingsType varchar(100),thrustBearing varchar(100),drivenBy varchar(100),
		locations int,rotorOverhung  varchar(10),attachedOilPump  varchar(10),impellerOnMainShaft  varchar(10),crankHasIntermediateBearing  varchar(10),
		fanStages  varchar(10),exciter  varchar(10),centrifugalPumpHasBallBearings  varchar(10),propellerpumpHasBallBearings  varchar(10),
		rotaryThreadPumpHasBallBearings  varchar(10), gearPumpHasBallBearings  varchar(10),screwPumpHasBallBearings  varchar(10),
		slidingVanePumpHasBallBearings  varchar(10), axialRecipPumpHasBallBearings  varchar(10),centrifugalCompressorHasBallBearings  varchar(10),
		reciprocatingCompressorHasBallBearings  varchar(10),screwCompressorHasBallBearings  varchar(10),screwTwinCompressorHasBallBearingsOnHPSide  varchar(10),
		lobedFanOrBlowerHasBallBearings  varchar(10),overhungRotorFanOrBlowerHasBearings  varchar(10), supportedRotorFanOrBlowerHasBearings  varchar(10),
		componentCode varchar(10))

		select @Id = id from @DetailsTable
		if(@Id = 0)
			Begin
				insert into master.tblDrivenDetails (componentType,drivenType,
				locations,pumpType,compressorType,fan_or_blowerType,
				purifierDrivenBy,bearingType,vacuumPumpType,
				rotorOverhung,attachedOilPump,
				impellerOnMainShaft,crankHasIntermediateBearing,fanStages,exciter,
				centrifugalPumpHasBallBearings,propellerpumpHasBallBearings,
				rotaryThreadPumpHasBallBearings,gearPumpHasBallBearings,
				screwPumpHasBallBearings,slidingVanePumpHasBallBearings,
				axialRecipPumpHasBallBearings,centrifugalCompressorHasBallBearings,
				reciprocatingCompressorHasBallBearings,
				screwCompressorHasBallBearings,screwTwinCompressorHasBallBearingsOnHPSide,lobedFanOrBlowerHasBallBearings,
				overhungRotorFanOrBlowerHasBearings,supportedRotorFanOrBlowerHasBearings,exciterOverhungOrSupported,
				bearingsType,thrustBearing,drivenBy,componentCode)
				select componentType,drivenType,
				locations,pumpType,compressorType,fan_or_blowerType,
				purifierDrivenBy,bearingType,vacuumPumpType,
				rotorOverhung,attachedOilPump,
				impellerOnMainShaft,crankHasIntermediateBearing,fanStages,exciter,
				centrifugalPumpHasBallBearings,propellerpumpHasBallBearings,
				rotaryThreadPumpHasBallBearings,gearPumpHasBallBearings,
				screwPumpHasBallBearings,slidingVanePumpHasBallBearings,
				axialRecipPumpHasBallBearings,centrifugalCompressorHasBallBearings,
				reciprocatingCompressorHasBallBearings,
				screwCompressorHasBallBearings,screwTwinCompressorHasBallBearingsOnHPSide,lobedFanOrBlowerHasBallBearings,
				overhungRotorFanOrBlowerHasBearings,supportedRotorFanOrBlowerHasBearings,exciterOverhungOrSupported,
				bearingsType,thrustBearing,drivenBy,componentCode FROM @DetailsTable
				
				set @Id = SCOPE_IDENTITY()

			End
		Else
			Begin
			--select @Id
			--select * from @DetailsTable
				Update master.tblDrivenDetails set 
				componentType = d.componentType,
				drivenType = d.drivenType,
				locations = d.locations,
				pumpType = d.pumpType,
				compressorType = d.compressorType,
				fan_or_blowerType = d.fan_or_blowerType,
				purifierDrivenBy = d.purifierDrivenBy,
				bearingType = d.bearingType,
				vacuumPumpType = d.vacuumPumpType,
				rotorOverhung = d.rotorOverhung,
				attachedOilPump = d.attachedOilPump,
				impellerOnMainShaft = d.impellerOnMainShaft,
				crankHasIntermediateBearing = d.crankHasIntermediateBearing,
				fanStages = d.fanStages,
				exciter = d.exciter,
				centrifugalPumpHasBallBearings = d.centrifugalPumpHasBallBearings,
				propellerpumpHasBallBearings = d.propellerpumpHasBallBearings,
				rotaryThreadPumpHasBallBearings = d.rotaryThreadPumpHasBallBearings,
				gearPumpHasBallBearings = d.gearPumpHasBallBearings,
				screwPumpHasBallBearings = d.screwPumpHasBallBearings,
				slidingVanePumpHasBallBearings = d.slidingVanePumpHasBallBearings,
				axialRecipPumpHasBallBearings = d.axialRecipPumpHasBallBearings,
				centrifugalCompressorHasBallBearings = d.centrifugalCompressorHasBallBearings,
				reciprocatingCompressorHasBallBearings = d.reciprocatingCompressorHasBallBearings,
				screwCompressorHasBallBearings = d.screwCompressorHasBallBearings,
				screwTwinCompressorHasBallBearingsOnHPSide = d.screwTwinCompressorHasBallBearingsOnHPSide,
				lobedFanOrBlowerHasBallBearings = d.lobedFanOrBlowerHasBallBearings,
				overhungRotorFanOrBlowerHasBearings = d.overhungRotorFanOrBlowerHasBearings,
				supportedRotorFanOrBlowerHasBearings = d.supportedRotorFanOrBlowerHasBearings,
				exciterOverhungOrSupported = d.exciterOverhungOrSupported,
				bearingsType = d.bearingsType,
				thrustBearing = d.thrustBearing,
				drivenBy = d.drivenBy,
				componentCode = d.componentCode
				from master.tblDrivenDetails a
				inner join @DetailsTable d on a.id = d.id
				where a.id = @Id

			End
	END TRY  
	BEGIN CATCH  
			set @Id = 0
			--SELECT
   -- ERROR_NUMBER() AS ErrorNumber,
   -- ERROR_STATE() AS ErrorState,
   -- ERROR_SEVERITY() AS ErrorSeverity,
   -- ERROR_PROCEDURE() AS ErrorProcedure,
   -- ERROR_LINE() AS ErrorLine,
   -- ERROR_MESSAGE() AS ErrorMessage;
	END CATCH

	select @Id
END
GO
/****** Object:  StoredProcedure [dbo].[spAddOrUpdateDriverDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <27/04/2021>
-- Description: <SP used for save driver component data>
-- =============================================
CREATE PROCEDURE [dbo].[spAddOrUpdateDriverDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN

--	Declare  @xmlInput xml = ''

--	set @xmlInput = '<DriverDetails xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>211</id>
--  <componentType>driver42427777</componentType>
--  <locations>1</locations>
--  <driverType>diesel</driverType>
--  <cylinders>2</cylinders>
--  <motorFan xsi:nil="true" />
--  <motorBallBearings xsi:nil="true" />
--  <drivenBallBearings xsi:nil="true" />
--  <drivenBalanceable xsi:nil="true" />
--  <motorPoles xsi:nil="true" />
--  <turbineReductionGear xsi:nil="true" />
--  <turbineRotorSupported xsi:nil="true" />
--  <turbineBallBearing xsi:nil="true" />
--  <turbineThrustBearing xsi:nil="true" />
--  <turbineThrustBearingIsBall xsi:nil="true" />
--  <componentCode xsi:nil="true" />
--</DriverDetails>'
	
	Declare @Id bigint
	BEGIN TRY  
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		

		Declare @DetailsTable table (id bigint,componentType varchar(50),driverType varchar(50),motorDrive varchar(50),locations int,		
		cylinders int,motorPoles int,motorFan bit, motorBallBearings bit,drivenBallBearings bit,drivenBalanceable bit,
		turbineReductionGear bit,turbineRotorSupported bit,turbineBallBearing bit,turbineThrustBearing bit,
		turbineThrustBearingIsBall bit, componentCode decimal(18,2))
				
				insert into @DetailsTable
				select id as RecordId,componentType,driverType,motorDrive,locations,
				Case when cylinders = '' then null else cylinders end  as cylinders,
				Case when motorPoles = '' then null else motorPoles end  as motorPoles,
				Case when motorFan = '' then null else motorFan end  as motorFan,
				Case when motorBallBearings = '' then null else motorBallBearings end  as motorBallBearings,
				Case when drivenBallBearings = '' then null else drivenBallBearings end as drivenBallBearings,
				Case when drivenBalanceable = '' then null else drivenBalanceable end  as drivenBalanceable,
				Case when turbineReductionGear = '' then null else turbineReductionGear end  as turbineReductionGear,
				Case when turbineRotorSupported = '' then null else turbineRotorSupported end  as turbineRotorSupported,
				Case when turbineBallBearing = '' then null else turbineBallBearing end  as turbineBallBearing,
				Case when turbineThrustBearing = '' then null else turbineThrustBearing end  as turbineThrustBearing, 
				Case when turbineThrustBearingIsBall = '' then null else turbineThrustBearingIsBall end  as turbineThrustBearingIsBall,
				Case when componentCode = '' then null else componentCode end as componentCode
				--into #DetailsTable 
				FROM OPENXML (@xmlDocumentHandle, 'DriverDetails',2)
				WITH (id bigint,componentType varchar(100),locations int,driverType varchar(100),cylinders varchar(10),motorDrive varchar(100),motorFan varchar(10),
				motorBallBearings  varchar(10),drivenBallBearings  varchar(10),drivenBalanceable  varchar(10),motorPoles varchar(10),turbineReductionGear  varchar(10),
				turbineRotorSupported  varchar(10),turbineBallBearing  varchar(10),turbineThrustBearing  varchar(10),turbineThrustBearingIsBall  varchar(10),
				componentCode varchar(10))

				select @Id = id from @DetailsTable

		if(@Id = 0)
			Begin
				insert into master.tblDriverDetails (componentType,driverType,motorDrive,locations,cylinders,motorPoles,
				motorFan,motorBallBearings,drivenBallBearings,drivenBalanceable,turbineReductionGear,turbineRotorSupported,
				turbineBallBearing,turbineThrustBearing,turbineThrustBearingIsBall,componentCode)
				select componentType,driverType,motorDrive,locations,cylinders,motorPoles,
				motorFan,motorBallBearings,drivenBallBearings,drivenBalanceable,turbineReductionGear,turbineRotorSupported,
				turbineBallBearing,turbineThrustBearing,turbineThrustBearingIsBall,componentCode FROM @DetailsTable
				
				set @Id = SCOPE_IDENTITY()

			End
		Else
			Begin
				
				Update master.tblDriverDetails set 
				componentType = d.componentType,
				driverType = d.driverType,
				motorDrive = d.motorDrive,
				locations = d.locations,
				cylinders = d.cylinders,
				motorPoles = d.motorPoles,
				motorFan = d.motorFan,
				motorBallBearings = d.motorBallBearings,
				drivenBallBearings = d.drivenBallBearings,
				drivenBalanceable = d.drivenBalanceable,
				turbineReductionGear = d.turbineReductionGear,
				turbineRotorSupported = d.turbineRotorSupported,
				turbineBallBearing = d.turbineBallBearing,
				turbineThrustBearing = d.turbineThrustBearing,
				turbineThrustBearingIsBall = d.turbineThrustBearingIsBall,
				componentCode = d.componentCode
				from master.tblDriverDetails a
				inner join @DetailsTable d on a.id = d.id
				where a.id = @Id

			End
	END TRY  
	BEGIN CATCH  
			set @Id = 0
			--SELECT
   -- ERROR_NUMBER() AS ErrorNumber,
   -- ERROR_STATE() AS ErrorState,
   -- ERROR_SEVERITY() AS ErrorSeverity,
   -- ERROR_PROCEDURE() AS ErrorProcedure,
   -- ERROR_LINE() AS ErrorLine,
   -- ERROR_MESSAGE() AS ErrorMessage;
	END CATCH

	select @Id
END
GO
/****** Object:  StoredProcedure [dbo].[spAddOrUpdateIntermediateDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <28/04/2021>
-- Description: <SP used for save driver component data>
-- =============================================
CREATE PROCEDURE [dbo].[spAddOrUpdateIntermediateDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN

--	Declare  @xmlInput xml = ''
--	set @xmlInput = '<IntermediateDetails xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>0</id>
--  <componentType>vishal0335</componentType>
--  <locations xsi:nil="true" />
--  <speedChangesMax xsi:nil="true" />
--  <componentCode>0.0</componentCode>
--</IntermediateDetails>'
	
	Declare @Id bigint
	BEGIN TRY  
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		Declare @DetailsTable table (id bigint,componentType varchar(100),intermediateType varchar(100),
		locations int,drivenBy varchar(100),speedChangesMax int,
		--gearBoxLocations int,
		inputBearing int ,intermediateBearing1st varchar(1000),intermediateBearing2nd varchar(1000),
		outputBearing varchar(1000),componentCode decimal(18,2))
				
		insert into @DetailsTable
		select id,componentType,intermediateType, 
		Case when locations = '' then null else locations end,drivenBy,speedChangesMax,
		--gearBoxLocations,
		Case when inputBearing = '' then null else inputBearing end,
		intermediateBearing1st,intermediateBearing2nd,outputBearing,componentCode
		FROM OPENXML (@xmlDocumentHandle, 'IntermediateDetails',2)
		WITH (id bigint,componentType varchar(100),intermediateType varchar(100), 
		drivenBy varchar(100),inputBearing varchar(10) ,intermediateBearing1st varchar(1000),
		intermediateBearing2nd varchar(1000),outputBearing varchar(1000),speedChangesMax int,
		locations varchar(10), --gearBoxLocations int,
		componentCode decimal(18,2))

		select @Id = id from @DetailsTable
		if(@Id = 0)
			Begin
				insert into master.tblIntermediateDetails (componentType,intermediateType, locations,drivenBy,speedChangesMax,componentCode)
				select componentType,intermediateType, locations,drivenBy,speedChangesMax,componentCode from @DetailsTable
				
				set @Id = SCOPE_IDENTITY()

			End
		Else
			Begin
				Update master.tblIntermediateDetails set 
				componentType = d.componentType,
				intermediateType = d.intermediateType,
				locations = d.locations,
				drivenBy = d.drivenBy,
				speedChangesMax = d.speedChangesMax,
				componentCode = d.componentCode
				from master.tblIntermediateDetails a
				inner join @DetailsTable d on a.id = d.id
				where a.id = @Id

			End
	END TRY  
	BEGIN CATCH  
			set @Id = 0
			--SELECT
   -- ERROR_NUMBER() AS ErrorNumber,
   -- ERROR_STATE() AS ErrorState,
   -- ERROR_SEVERITY() AS ErrorSeverity,
   -- ERROR_PROCEDURE() AS ErrorProcedure,
   -- ERROR_LINE() AS ErrorLine,
   -- ERROR_MESSAGE() AS ErrorMessage;
	END CATCH

	select @Id
END

--select * from master.tblIntermediateDetails
GO
/****** Object:  StoredProcedure [dbo].[spAddOrUpdatePickupCodeDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <11/05/2021>
-- Description: <SP used for save PickupCode component data>
-- =============================================
CREATE PROCEDURE [dbo].[spAddOrUpdatePickupCodeDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN
	
--	Declare @xmlInput xml = '<PickupCodeDetails xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>0</id>
--  <driverLocations>10</driverLocations>
--  <driverLocationNDE>false</driverLocationNDE>
--  <driverLocationDE>false</driverLocationDE>
--  <intermediateLocations>0</intermediateLocations>
--  <intermediatepresent>false</intermediatepresent>
--  <drivenLocations>0</drivenLocations>
--  <drivenLocationDE>false</drivenLocationDE>
--  <drivenLocationNDE>false</drivenLocationNDE>
--</PickupCodeDetails>'
	
	Declare @Id bigint
	BEGIN TRY  
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		Declare @DetailsTable table (id int,driverLocations int,driverLocationNDE bit,driverLocationDE bit,
	    intermediateLocations int,intermediatepresent bit,drivenLocations int,drivenLocationDE bit,
		drivenLocationNDE bit,driverPickupCode varchar(50),coupling1PickupCode varchar(50),intermediatePickupCode varchar(50),
	    coupling2PickupCode varchar(50),drivenPickupCode varchar(50))
		
		insert into @DetailsTable
		select id,
		driverLocations,
		driverLocationNDE,
		driverLocationDE,
		intermediateLocations,
		intermediatepresent,
		drivenLocations,
		drivenLocationDE,
		drivenLocationNDE,
		Case when driverPickupCode = '' then null else driverPickupCode end as driverPickupCode,
		Case when coupling1PickupCode = '' then null else coupling1PickupCode end as coupling1PickupCode,
		Case when intermediatePickupCode = '' then null else intermediatePickupCode end as intermediatePickupCode,
		Case when coupling2PickupCode = '' then null else coupling2PickupCode end as coupling2PickupCode,
		Case when drivenPickupCode = '' then null else drivenPickupCode end as drivenPickupCode
		FROM OPENXML (@xmlDocumentHandle, 'PickupCodeDetails',2)
		WITH (id int,driverLocations int,driverLocationNDE bit,driverLocationDE bit,
	    intermediateLocations int,intermediatepresent bit,drivenLocations int,drivenLocationDE bit,
		drivenLocationNDE bit,driverPickupCode varchar(50),coupling1PickupCode varchar(50),intermediatePickupCode varchar(50),
	    coupling2PickupCode varchar(50),drivenPickupCode varchar(50))	
		
		--select * from @DetailsTable

		select @Id = id from @DetailsTable
		if(@Id = 0)
			Begin
				insert into master.tblPickupCodeDetails
				(driverLocations,driverLocationNDE,driverLocationDE,intermediateLocations,intermediatepresent,
				 drivenLocations,drivenLocationDE,drivenLocationNDE,
				 driverPickupCode,coupling1PickupCode,intermediatePickupCode,coupling2PickupCode,drivenPickupCode)
				 select driverLocations,driverLocationNDE,driverLocationDE,intermediateLocations,intermediatepresent,
				 drivenLocations,drivenLocationDE,drivenLocationNDE,
				 driverPickupCode,coupling1PickupCode,intermediatePickupCode,coupling2PickupCode,drivenPickupCode from @DetailsTable
				
				set @Id = SCOPE_IDENTITY()

			End
		Else
			Begin
				Update master.tblPickupCodeDetails set 
				driverLocations = d.driverLocations,
				driverLocationNDE = d.driverLocationNDE,
				driverLocationDE = d.driverLocationDE,
				intermediateLocations = d.intermediateLocations,
				intermediatepresent = d.intermediatepresent,
				drivenLocations = d.drivenLocations,
				drivenLocationDE = d.drivenLocationDE,
				drivenLocationNDE = d.drivenLocationNDE,
				driverPickupCode = d.driverPickupCode,
				coupling1PickupCode = d.coupling1PickupCode,
				intermediatePickupCode = d.intermediatePickupCode,
				coupling2PickupCode = d.coupling2PickupCode,
				drivenPickupCode = d.drivenPickupCode
				from master.tblPickupCodeDetails a
				inner join @DetailsTable d on a.id = d.id
				where a.id = @Id

			End
	END TRY  
	BEGIN CATCH  
			set @Id = 0
			--SELECT
   -- ERROR_NUMBER() AS ErrorNumber,
   -- ERROR_STATE() AS ErrorState,
   -- ERROR_SEVERITY() AS ErrorSeverity,
   -- ERROR_PROCEDURE() AS ErrorProcedure,
   -- ERROR_LINE() AS ErrorLine,
   -- ERROR_MESSAGE() AS ErrorMessage;
	END CATCH

	select @Id
END
GO
/****** Object:  StoredProcedure [dbo].[spAddOrUpdateSpecialFaultCodesDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <05/05/2021>
-- Description: <SP used for save Special Fault Codes Detail>
-- =============================================
Create PROCEDURE [dbo].[spAddOrUpdateSpecialFaultCodesDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN

--	Declare  @xmlInput xml = ''

--	set @xmlInput = '<SpecialFaultCodesDetails xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>211</id>
--  <componentType>driver42427777</componentType>
--  <locations>1</locations>
--  <driverType>diesel</driverType>
--  <cylinders>2</cylinders>
--  <motorFan xsi:nil="true" />
--  <motorBallBearings xsi:nil="true" />
--  <drivenBallBearings xsi:nil="true" />
--  <drivenBalanceable xsi:nil="true" />
--  <mortorPoles xsi:nil="true" />
--  <turbineReductionGear xsi:nil="true" />
--  <turbineRotorSupported xsi:nil="true" />
--  <turbineBallBearing xsi:nil="true" />
--  <turbineThrustBearing xsi:nil="true" />
--  <turbineThrustBearingIsBall xsi:nil="true" />
--  <componentCode xsi:nil="true" />
--</SpecialFaultCodesDetails>'
	
	Declare @Id bigint
	BEGIN TRY  
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;

		Declare @DetailsTable table (id bigint,specialfaultcodetype varchar(50),specialmultiple int,specialcode varchar(50))
				
		insert into @DetailsTable
		select id,specialfaultcodetype,specialmultiple,specialcode
		FROM OPENXML (@xmlDocumentHandle, 'SpecialFaultCodesDetails',2)
		WITH (id bigint,specialfaultcodetype varchar(50),specialmultiple int,specialcode varchar(50))

		select @Id = id from @DetailsTable

		if(@Id = 0)
			Begin
				insert into master.tblSpecialFaultCodesDetails (specialfaultcodetype,specialmultiple,specialcode)
				select specialfaultcodetype,specialmultiple,specialcode FROM @DetailsTable
				set @Id = SCOPE_IDENTITY()
			End
		Else
			Begin
				
				Update master.tblSpecialFaultCodesDetails set 
				specialfaultcodetype = d.specialfaultcodetype,
				specialmultiple = d.specialmultiple,
				specialcode = d.specialcode
				from master.tblSpecialFaultCodesDetails a
				inner join @DetailsTable d on a.id = d.id
				where a.id = @Id

			End
	END TRY  
	BEGIN CATCH  
			set @Id = 0
			--SELECT
   -- ERROR_NUMBER() AS ErrorNumber,
   -- ERROR_STATE() AS ErrorState,
   -- ERROR_SEVERITY() AS ErrorSeverity,
   -- ERROR_PROCEDURE() AS ErrorProcedure,
   -- ERROR_LINE() AS ErrorLine,
   -- ERROR_MESSAGE() AS ErrorMessage;
	END CATCH

	select @Id
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteCoupling1DetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <27/04/2021>
-- Description: <SP used for delete coupling1 component data by id>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteCoupling1DetailsById]
(
   @id bigint
)
AS
BEGIN
	Update master.tblCoupling1Details set isDeleted = 1 where Id = @id
	select @id
END


GO
/****** Object:  StoredProcedure [dbo].[spDeleteCoupling2DetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <04/05/2021>
-- Description: <SP used for delete coupling2 component data by id>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteCoupling2DetailsById]
(
   @id bigint
)
AS
BEGIN
	Update master.tblCoupling2Details set isDeleted = 1 where Id = @id
	select @id
END


GO
/****** Object:  StoredProcedure [dbo].[spDeleteCSDMdefsDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <06/05/2021>
-- Description: <SP used for delete CSDMdefs component data by id>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteCSDMdefsDetailsById]
(
   @id bigint
)
AS
BEGIN
	Update master.tblCSDMdefsDetails set isDeleted = 1 where Id = @id
	select @id
END


GO
/****** Object:  StoredProcedure [dbo].[spDeleteDrivenDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <28/04/2021>
-- Description: <SP used for delete driven component data by id>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteDrivenDetailsById]
(
   @id bigint
)
AS
BEGIN
	Update master.tblDrivenDetails set isDeleted = 1 where Id = @id
	select @id
END

--Update master.tblDrivenDetails set isDeleted = 0
GO
/****** Object:  StoredProcedure [dbo].[spDeleteDriverDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <27/04/2021>
-- Description: <SP used for delete driver component data by id>
-- =============================================
Create PROCEDURE [dbo].[spDeleteDriverDetailsById]
(
   @id bigint
)
AS
BEGIN
	Update master.tblDriverDetails set isDeleted = 1 where Id = @id
	select @id
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteIntermediateDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <28/04/2021>
-- Description: <SP used for delete intermediate component data by id>
-- =============================================
Create PROCEDURE [dbo].[spDeleteIntermediateDetailsById]
(
   @id bigint
)
AS
BEGIN
	Update master.tblIntermediateDetails set isDeleted = 1 where Id = @id
	select @id
END

GO
/****** Object:  StoredProcedure [dbo].[spDeletePickupCodeDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <11/05/2021>
-- Description: <SP used for delete coupling1 component data by id>
-- =============================================
Create PROCEDURE [dbo].[spDeletePickupCodeDetailsById]
(
   @id bigint
)
AS
BEGIN
	Update master.tblPickupCodeDetails set isDeleted = 1 where Id = @id
	select @id
END


GO
/****** Object:  StoredProcedure [dbo].[spDeleteSpecialFaultCodesDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <05/05/2021>
-- Description: <SP used for delete SpecialFaultCodes component data by id>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteSpecialFaultCodesDetailsById]
(
   @id bigint
)
AS
BEGIN
	Update master.tblSpecialFaultCodesDetails set isDeleted = 1 where Id = @id
	select @id
END
GO
/****** Object:  StoredProcedure [dbo].[spGenerateMIDDerivation]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGenerateMIDDerivation]
@xmlInput xml = ''
As
Begin

--Declare @xmlInput xml  = '<MIDCodeCreatorRequest xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <machineComponentsForMIDgeneration>
--    <driver>
--      <componentType>driver</componentType>
--      <locations>1</locations>
--      <rpm xsi:nil="true" />
--      <driverLocationNDE>false</driverLocationNDE>
--      <driverLocationDE>true</driverLocationDE>
--      <driverType>motor</driverType>
--      <drivers>
--        <motor>
--          <motorDrive>AC</motorDrive>
--          <motorFan>true</motorFan>
--          <motorBallBearings>true</motorBallBearings>
--          <drivenBallBearings>true</drivenBallBearings>
--          <drivenBalanceable>true</drivenBalanceable>
--        </motor>
--      </drivers>
--      <specialFaultCodesInput>
--        <SpecialFaultCodesInput>
--          <specialFaultCodeType>pistons</specialFaultCodeType>
--          <specialFaultCodeCount>6</specialFaultCodeCount>
--        </SpecialFaultCodesInput>
--      </specialFaultCodesInput>
--    </driver>
--    <coupling1>
--      <id>0</id>
--      <componentType>coupling</componentType>
--      <couplingPosition>1</couplingPosition>
--      <couplingType>beltdrive</couplingType>
--      <locations xsi:nil="true" />
--      <speedratio>1</speedratio>
--    </coupling1>
--    <intermediate>
--      <componentType>Intermediate</componentType>
--      <intermediateType>AOP</intermediateType>
--      <locations>1</locations>
--      <inputBearing xsi:nil="true" />
--      <speedratio>1.0000</speedratio>
--      <intermediates>
--        <gearbox>
--          <speedChangesMax>1</speedChangesMax>
--        </gearbox>
--        <AOP>
--          <drivenBy>inputshaft</drivenBy>
--        </AOP>
--        <AccDrGr>
--          <drivenBy>intermediateshaft</drivenBy>
--        </AccDrGr>
--      </intermediates>
--    </intermediate>
--    <coupling2>
--      <componentType>coupling</componentType>
--      <couplingPosition>2</couplingPosition>
--      <couplingType>beltdrive</couplingType>
--      <locations xsi:nil="true" />
--      <speedratio>1</speedratio>
--    </coupling2>
--    <driven>
--      <componentType>driven</componentType>
--      <drivenType>pump</drivenType>
--      <locations>2</locations>
--      <pumpType>centrifugal</pumpType>
--      <rotorOverhung>false</rotorOverhung>
--      <attachedOilPump xsi:nil="true" />
--      <impellerOnMainShaft xsi:nil="true" />
--      <crankHasIntermediateBearing xsi:nil="true" />
--      <fanStages xsi:nil="true" />
--      <exciter xsi:nil="true" />
--      <centrifugalPumpHasBallBearings>false</centrifugalPumpHasBallBearings>
--      <propellerpumpHasBallBearings xsi:nil="true" />
--      <rotaryThreadPumpHasBallBearings xsi:nil="true" />
--      <gearPumpHasBallBearings xsi:nil="true" />
--      <screwPumpHasBallBearings xsi:nil="true" />
--      <slidingVanePumpHasBallBearings xsi:nil="true" />
--      <axialRecipPumpHasBallBearings xsi:nil="true" />
--      <centrifugalCompressorHasBallBearings xsi:nil="true" />
--      <reciprocatingCompressorHasBallBearings xsi:nil="true" />
--      <screwCompressorHasBallBearings xsi:nil="true" />
--      <screwTwinCompressorHasBallBearingsOnHPSide xsi:nil="true" />
--      <lobedFanOrBlowerHasBallBearings xsi:nil="true" />
--      <overhungRotorFanOrBlowerHasBearings xsi:nil="true" />
--      <supportedRotorFanOrBlowerHasBearings xsi:nil="true" />
--      <thrustBearing>journal</thrustBearing>
--      <rpm>1</rpm>
--      <specialFaultCodesInput>
--        <SpecialFaultCodesInput>
--          <specialFaultCodeType>fan_blades</specialFaultCodeType>
--          <specialFaultCodeCount>13</specialFaultCodeCount>
--        </SpecialFaultCodesInput>
--      </specialFaultCodesInput>
--      <drivenLocationNDE>true</drivenLocationNDE>
--      <drivenLocationDE>false</drivenLocationDE>
--    </driven>
--  </machineComponentsForMIDgeneration>
--</MIDCodeCreatorRequest>'

Declare @xmlDocumentHandle int
EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;

Declare  @SpecialFaultCodesInputTable table (SpecialFaultCodeType varchar(50),SpecialFaultCodeCount int)
Declare @driverPickupCode varchar(50),@drivenPickupCode varchar(50),@intermediatePickupCode varchar(50),
@coupling1PickupCode varchar(50),@coupling2PickupCode varchar(50)

--Declare variable for driver component --
Declare @componentType varchar(100),@driverType varchar(100),@motorDrive varchar(100),@locations int,@cylinders int,@motorPoles int,@motorFan varchar(10),@motorBallBearings  varchar(10),@drivenBallBearings  varchar(10),@drivenBalanceable  varchar(10),
@turbineReductionGear  varchar(10),@turbineRotorSupported  varchar(10),@turbineBallBearing  varchar(10),@turbineThrustBearing  varchar(10),
@turbineThrustBearingIsBall  varchar(10),@driverLocationNDE bit,@driverLocationDE bit,@driverRPM decimal(18,2) = null
--Declare variable for driver component --

--Declare variable for coupling1 component --
Declare @c1componentType varchar(100),@c1couplingType varchar(100), @c1coupledComponentType1 varchar(100),@c1coupledComponentType2 varchar(100)
Declare @c1couplingPosition int, @c1locations int, @c1SpeedRatio decimal(18,4)
--Declare variable for coupling1 component --

--Declare variable for coupling2 component --
Declare @c2componentType varchar(100),@c2couplingType varchar(100), @c2coupledComponentType1 varchar(100),
@c2coupledComponentType2 varchar(100) Declare @c2couplingPosition int, @c2locations int,@c2SpeedRatio decimal(18,4)
--Declare variable for coupling2 component --

--Declare variable for intermediate component --
Declare @intercomponentType varchar(100),@intermediateType varchar(100),@drivenBy varchar(100),@speedChangesMax int,@interlocations int, @intermediateSpeedRatio decimal(18,4),@intermediatePresent bit
--Declare variable for intermediate component --

--Declare variable for driven component --
Declare @drivencomponentType varchar(100),@drivenType varchar(100), 
@pumpType varchar(100),@compressorType varchar(1000) ,@fan_or_blowerType varchar(1000),
@purifierDrivenBy varchar(100),@bearingType varchar(100),@vacuumPumpType varchar(100),
@exciterOverhungOrSupported varchar(100),@bearingsType varchar(100),@thrustBearing varchar(100),
@drivenBy1 varchar(100) = null,@drivenRPM decimal(18,2),@drivenlocations int,@rotorOverhung  varchar(10),
@attachedOilPump  varchar(10),@impellerOnMainShaft  varchar(10),@crankHasIntermediateBearing  varchar(10),
@fanStages  varchar(10),@exciter  varchar(10),@centrifugalPumpHasBallBearings  varchar(10),@propellerpumpHasBallBearings  varchar(10),
@rotaryThreadPumpHasBallBearings  varchar(10), @gearPumpHasBallBearings  varchar(10),@screwPumpHasBallBearings  varchar(10),
@slidingVanePumpHasBallBearings  varchar(10), @axialRecipPumpHasBallBearings  varchar(10),@centrifugalCompressorHasBallBearings  varchar(10),
@reciprocatingCompressorHasBallBearings  varchar(10),@screwCompressorHasBallBearings  varchar(10),@screwTwinCompressorHasBallBearingsOnHPSide  varchar(10),
@lobedFanOrBlowerHasBallBearings  varchar(10),@overhungRotorFanOrBlowerHasBearings  varchar(10), @supportedRotorFanOrBlowerHasBearings  varchar(10),
@drivenLocationNDE bit,@drivenLocationDE bit
--Declare variable for driven component --

--- Read xml for driver component --

select @componentType = case when componentType = '' then null else componentType end,
@locations = locations,
@driverRPM = Convert(decimal(18,2),Case when rpm = '' then null else rpm end ),
@driverLocationNDE  = Case when driverLocationNDE  = '' then null else driverLocationNDE end ,
@driverLocationDE  = Case when driverLocationDE  = '' then null else driverLocationDE end ,
@driverType = case when driverType = '' then null else driverType end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver',2)
WITH (componentType varchar(100),locations int,rpm  varchar(10),driverLocationNDE varchar(10),driverLocationDE varchar(10),
driverType varchar(100))

select @cylinders = cylinders
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/drivers/disel',2)
WITH (cylinders int)

select @motorDrive =  Case when motorDrive = '' then null else motorDrive end,
@motorFan = Case when motorFan = '' then null else motorFan end ,
@motorBallBearings = Case when motorBallBearings = '' then null else motorBallBearings end ,
@drivenBallBearings = Case when drivenBallBearings = '' then null else drivenBallBearings end,
@drivenBalanceable = Case when drivenBalanceable = '' then null else drivenBalanceable end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/drivers/motor',2)
WITH (motorDrive varchar(100),motorFan varchar(10),motorBallBearings  varchar(10),drivenBallBearings  varchar(10),drivenBalanceable  varchar(10))

select @motorPoles = motorPoles 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/drivers/motor/VFD',2)
WITH (motorPoles int)

select @turbineReductionGear = Case when turbineReductionGear = '' then null else turbineReductionGear end ,
@turbineRotorSupported = Case when turbineRotorSupported = '' then null else turbineRotorSupported end ,
@turbineBallBearing = Case when turbineBallBearing = '' then null else turbineBallBearing end ,
@turbineThrustBearing = Case when turbineThrustBearing = '' then null else turbineThrustBearing end , 
@turbineThrustBearingIsBall = Case when turbineThrustBearingIsBall = '' then null else turbineThrustBearingIsBall end  
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/drivers/turbine',2)
WITH (turbineReductionGear  varchar(10),
turbineRotorSupported  varchar(10),turbineBallBearing  varchar(10),turbineThrustBearing  varchar(10),turbineThrustBearingIsBall  varchar(10))

--- Read xml for driver component --


--- Read xml for coupling1 component --
select @c1componentType = case when componentType = '' then null else componentType end,@c1couplingType = couplingType,@c1coupledComponentType1 = coupledComponentType1,
@c1coupledComponentType2 = coupledComponentType2,@c1couplingPosition = couplingPosition,@c1locations = locations,
@c1SpeedRatio = ISNULL(Convert(decimal(18,4),Case when speedratio = '' then null else speedratio end ),0) 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/coupling1',2)
WITH (componentType varchar(100),couplingType varchar(100),coupledComponentType1 varchar(100),coupledComponentType2 varchar(100),
couplingPosition int,locations int,speedratio varchar(20))

--"coupledComponentType1" : [Derive Logic: if couplingType is "none_rigid", " "beltdrive", "chaindrive", "magnetic", then use NULL 
--else use driver componentType]
if(UPPER(RTRIM(LTRIM(@c1couplingType))) = UPPER(RTRIM(LTRIM('none_rigid'))) or UPPER(RTRIM(LTRIM(@c1couplingType))) = UPPER(RTRIM(LTRIM('beltdrive'))) 
or UPPER(RTRIM(LTRIM(@c1couplingType))) = UPPER(RTRIM(LTRIM('chaindrive'))) or UPPER(RTRIM(LTRIM(@c1couplingType))) = UPPER(RTRIM(LTRIM('magnetic'))))
	Begin
		set @c1coupledComponentType1 = null
	End
else
	Begin
		set @c1coupledComponentType1 = @componentType
	End

--"coupledComponentType2": [Derive Logic: if couplingType is "none_rigid", " "beltdrive", "chaindrive", "magnetic", 
--then use NULL else use intermediate componentType if present, else use driven componentType]
if(UPPER(RTRIM(LTRIM(@c2couplingType))) = UPPER(RTRIM(LTRIM('none_rigid'))) or UPPER(RTRIM(LTRIM(@c2couplingType))) = UPPER(RTRIM(LTRIM('beltdrive')))
or UPPER(RTRIM(LTRIM(@c2couplingType))) = UPPER(RTRIM(LTRIM('chaindrive'))) or UPPER(RTRIM(LTRIM(@c2couplingType))) = UPPER(RTRIM(LTRIM('magnetic'))))
	Begin
		set @c2coupledComponentType1 = null
	End
else
	Begin
		if(@intercomponentType <> '' and @intercomponentType IS NOT NULL )
			Begin
				set @c2coupledComponentType1 = @intercomponentType
			End
		else
			Begin
				set @c2coupledComponentType1 = @drivencomponentType
			End
	End

--- Read xml for coupling1 component --

--- Read xml for coupling2 component --
select @c2componentType = case when componentType = '' then null else componentType end ,@c2couplingType = couplingType,@c2coupledComponentType1 = coupledComponentType1,
@c2coupledComponentType2 = coupledComponentType2,@c2couplingPosition = couplingPosition,@c2locations = locations,
@c2SpeedRatio = ISNULL(Convert(decimal(18,4),Case when speedratio = '' then null else speedratio end ),1) 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/coupling2',2)
WITH (componentType varchar(100),couplingType varchar(100),coupledComponentType1 varchar(100),coupledComponentType2 varchar(100),couplingPosition int,locations int,speedratio varchar(20))
--- Read xml for coupling2 component --

--- Read xml for intermediate component --
select @intercomponentType = case when componentType = '' then null else componentType end,
@intermediateType = case when intermediateType = '' then null else intermediateType end, 
@interlocations = locations, 
@intermediateSpeedRatio = ISNULL(Convert(decimal(18,4),Case when speedratio = '' then null else speedratio end ),1) 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/intermediate',2)
WITH (componentType varchar(100),intermediateType varchar(100),locations int,speedratio varchar(20))

select @speedChangesMax = case when speedChangesMax = '' then null else speedChangesMax end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/intermediate/intermediates/gearbox',2)
WITH (speedChangesMax int)

if(UPPER(RTRIM(LTRIM(@intermediateType))) = 'AOP')
	Begin
		select @drivenBy = case when drivenBy = '' then null else drivenBy end
		FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/intermediate/intermediates/AOP',2)
		WITH (drivenBy varchar(50))
		set @speedChangesMax = null;
	End
else if(UPPER(RTRIM(LTRIM(@intermediateType))) = 'ACCDRGR')
	Begin
		select @drivenBy = case when drivenBy = '' then null else drivenBy end
		FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/intermediate/intermediates/AccDrGr',2)
		WITH (drivenBy varchar(50))
		set @speedChangesMax = null;
	End


--- Read xml for intermediate component --

--- Read xml for driven component --
select @drivencomponentType = Case when componentType = '' then null else componentType end,@drivenType = drivenType, 
@pumpType = pumpType,@compressorType = compressorType,@fan_or_blowerType = fan_or_blowerType,
@purifierDrivenBy = purifierDrivenBy,@bearingType = bearingType,@vacuumPumpType = vacuumpumptype,
@exciterOverhungOrSupported = exciterOverhungOrSupported,@bearingsType = bearingsType,
@thrustBearing = thrustBearing,@drivenBy1 = drivenBy,@drivenlocations = locations,
@rotorOverhung = Case when rotorOverhung = '' then null else rotorOverhung end ,
@attachedOilPump = Case when attachedOilPump = '' then null else attachedOilPump end ,
@impellerOnMainShaft = Case when impellerOnMainShaft = '' then null else impellerOnMainShaft end  ,
@crankHasIntermediateBearing = Case when crankHasIntermediateBearing = '' then null else crankHasIntermediateBearing end ,
@fanStages = Case when fanStages = '' then null else fanStages end ,
@exciter = Case when exciter = '' then null else exciter end  ,
@centrifugalPumpHasBallBearings = Case when centrifugalPumpHasBallBearings = '' then null else centrifugalPumpHasBallBearings end  ,
@propellerpumpHasBallBearings = Case when propellerpumpHasBallBearings = '' then null else propellerpumpHasBallBearings end ,
@rotaryThreadPumpHasBallBearings = Case when rotaryThreadPumpHasBallBearings = '' then null else rotaryThreadPumpHasBallBearings end  , 
@gearPumpHasBallBearings = Case when gearPumpHasBallBearings = '' then null else gearPumpHasBallBearings end ,
@screwPumpHasBallBearings = Case when screwPumpHasBallBearings = '' then null else screwPumpHasBallBearings end ,
@slidingVanePumpHasBallBearings = Case when slidingVanePumpHasBallBearings = '' then null else slidingVanePumpHasBallBearings end , 
@axialRecipPumpHasBallBearings = Case when axialRecipPumpHasBallBearings = '' then null else axialRecipPumpHasBallBearings end ,
@centrifugalCompressorHasBallBearings = Case when centrifugalCompressorHasBallBearings = '' then null else centrifugalCompressorHasBallBearings end ,
@reciprocatingCompressorHasBallBearings = Case when reciprocatingCompressorHasBallBearings = '' then null else reciprocatingCompressorHasBallBearings end ,
@screwCompressorHasBallBearings = Case when screwCompressorHasBallBearings = '' then null else screwCompressorHasBallBearings end ,
@screwTwinCompressorHasBallBearingsOnHPSide = Case when screwTwinCompressorHasBallBearingsOnHPSide = '' then null else screwTwinCompressorHasBallBearingsOnHPSide end  ,
@lobedFanOrBlowerHasBallBearings = Case when lobedFanOrBlowerHasBallBearings = '' then null else lobedFanOrBlowerHasBallBearings end ,
@overhungRotorFanOrBlowerHasBearings = Case when overhungRotorFanOrBlowerHasBearings = '' then null else overhungRotorFanOrBlowerHasBearings end  ,
@supportedRotorFanOrBlowerHasBearings = Case when supportedRotorFanOrBlowerHasBearings = '' then null else supportedRotorFanOrBlowerHasBearings end  ,
@drivenRPM = Convert(decimal(18,2),Case when rpm = '' then null else rpm end ),
@drivenLocationNDE  = Case when drivenLocationNDE  = '' then null else drivenLocationNDE end  ,
@drivenLocationDE  = Case when drivenLocationDE  = '' then null else drivenLocationDE end  
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven',2)
WITH (componentType varchar(100),drivenType varchar(100),pumpType varchar(100),compressorType varchar(1000),
fan_or_blowerType varchar(1000),purifierDrivenBy varchar(100),bearingType varchar(100),vacuumpumptype varchar(100),
exciterOverhungOrSupported varchar(100),bearingsType varchar(100),thrustBearing varchar(100),drivenBy varchar(100),
locations int,rotorOverhung  varchar(10),attachedOilPump  varchar(10),impellerOnMainShaft  varchar(10),crankHasIntermediateBearing  varchar(10),
fanStages  varchar(10),exciter  varchar(10),centrifugalPumpHasBallBearings  varchar(10),propellerpumpHasBallBearings  varchar(10),
rotaryThreadPumpHasBallBearings  varchar(10), gearPumpHasBallBearings  varchar(10),screwPumpHasBallBearings  varchar(10),
slidingVanePumpHasBallBearings  varchar(10), axialRecipPumpHasBallBearings  varchar(10),centrifugalCompressorHasBallBearings  varchar(10),
reciprocatingCompressorHasBallBearings  varchar(10),screwCompressorHasBallBearings  varchar(10),screwTwinCompressorHasBallBearingsOnHPSide  varchar(10),
lobedFanOrBlowerHasBallBearings  varchar(10),overhungRotorFanOrBlowerHasBearings  varchar(10), supportedRotorFanOrBlowerHasBearings  varchar(10),
rpm varchar(10),drivenLocationDE varchar(10),drivenLocationNDE varchar(10))
--- Read xml for driven component --

--- Read xml for driver special code and insert into SpecialFaultCodesInputTable --
insert into @SpecialFaultCodesInputTable select specialFaultCodeType,specialFaultCodeCount
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/specialFaultCodesInput/SpecialFaultCodesInput',2)
WITH (specialFaultCodeType varchar(100),specialFaultCodeCount int)
--- Read xml for driver special code and insert into SpecialFaultCodesInputTable --

--- Read xml for driven special code and insert into SpecialFaultCodesInputTable --
insert into @SpecialFaultCodesInputTable select specialFaultCodeType,specialFaultCodeCount
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/specialFaultCodesInput/SpecialFaultCodesInput',2)
WITH (specialFaultCodeType varchar(100),specialFaultCodeCount int)
--- Read xml for driven special code and insert into SpecialFaultCodesInputTable --

select @intermediatePresent = case when @intercomponentType IS NOT NULL and @intercomponentType <> '' then convert(bit,1) else convert(bit,0) end 

select @driverPickupCode = driverPickupCode,@drivenPickupCode = drivenPickupCode,@intermediatePickupCode = intermediatePickupCode,
@coupling1PickupCode = coupling1PickupCode,@coupling2PickupCode = coupling2PickupCode from funGetPickupCodeDetails (@componentType,@drivencomponentType,@intercomponentType,@c2componentType,@c1componentType, ISNULL(@locations,0),ISNULL(@driverLocationNDE,convert(bit,0)),ISNULL(@driverLocationDE,convert(bit,0)),
ISNULL(@interlocations,0),@intermediatePresent, ISNULL(@drivenlocations,0),ISNULL(@drivenLocationNDE,convert(bit,0)),ISNULL(@drivenLocationDE,convert(bit,0)))


select 'Driver' as Component, ComponentCode, 
@driverPickupCode as PickupCode
into #ComponentCodeDetails from master.tblDriverDetails 
WHERE isDeleted = 0 and
ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
	Case when @componentType = '' Or @componentType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@componentType))) end 
and
ISNULL(locations,0) = 
	Case when @locations = '' Or @locations IS NULL then 0
	else @locations end
and
ISNULL(UPPER(RTRIM(LTRIM(driverType))),'X') = 
	Case when @driverType = '' Or @driverType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@driverType))) end 
and
ISNULL(cylinders,0) = 
	Case when @cylinders = '' Or @cylinders IS NULL then 0
	else @cylinders end 
and
ISNULL(UPPER(RTRIM(LTRIM(motorDrive))),'X') = 
	Case when @motorDrive = '' Or @motorDrive IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@motorDrive))) end 
and
ISNULL(Convert(varchar(10),motorFan),'X') = 
	Case when @motorFan IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@motorFan)) end 
and
ISNULL(Convert(varchar(10),motorBallBearings),'X') = 
	Case when @motorBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@motorBallBearings)) end 
and
ISNULL(Convert(varchar(10),drivenBallBearings),'X') = 
	Case when @drivenBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@drivenBallBearings)) end 
and 
ISNULL(Convert(varchar(10),drivenBalanceable),'X') = 
	Case when @drivenBalanceable IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@drivenBalanceable)) end 
and
ISNULL(motorPoles,0) = 
	Case when @motorPoles = '' Or @motorPoles IS NULL then 0
	else @motorPoles end
and
ISNULL(Convert(varchar(10),turbineReductionGear),'X') = 
	Case when @turbineReductionGear IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@turbineReductionGear)) end 
and
ISNULL(Convert(varchar(10),turbineRotorSupported),'X') = 
	Case when @turbineRotorSupported IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@turbineRotorSupported)) end 
and
ISNULL(Convert(varchar(10),turbineBallBearing),'X') = 
	Case when @turbineBallBearing IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@turbineBallBearing)) end 
and
ISNULL(Convert(varchar(10),turbineThrustBearing),'X') = 
	Case when @turbineThrustBearing IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@turbineThrustBearing)) end 
and
ISNULL(Convert(varchar(10),turbineThrustBearingIsBall),'X') = 
	Case when @turbineThrustBearingIsBall IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@turbineThrustBearingIsBall)) end 
 
 union all

select 'Coupling1' as Component, ComponentCode, 
@coupling1PickupCode as PickupCode
from master.tblCoupling1Details 
WHERE 
ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
	Case when @c1componentType = '' Or @c1componentType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@c1componentType))) end 
and
ISNULL(UPPER(RTRIM(LTRIM(couplingType))),'X') = 
	Case when @c1couplingType = '' Or @c1couplingType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@c1couplingType))) end 
and
ISNULL(UPPER(RTRIM(LTRIM(coupledComponentType1))),'X') = 
	Case when @c1coupledComponentType1 = '' Or @c1coupledComponentType1 IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@c1coupledComponentType1))) end 
and
ISNULL(UPPER(RTRIM(LTRIM(coupledComponentType2))),'X') = 
	Case when @c1coupledComponentType2 = '' Or @c1coupledComponentType2 IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@c1coupledComponentType2))) end 
and
ISNULL(Convert(varchar(10),couplingPosition),'X') = 
	Case when @c1couplingPosition = '' Or @c1couplingPosition IS NULL then 'X'
	else convert(varchar(10),@c1couplingPosition) end 
and 
ISNULL(Convert(varchar(10),locations),'X') = 
	Case when @c1locations = '' Or @c1locations IS NULL then 'X'
	else convert(varchar(10),@c1locations) end 

union all

select 'Coupling2' as Component, Isnull(componentCode,null) as ComponentCode, 
@coupling2PickupCode as pickupCode 
from master.tblCoupling2Details 
WHERE 
ISNULL(componentType,'X') = 
	Case when @c2componentType = '' Or @c2componentType IS NULL then 'X'
	else @c2componentType end 
and
ISNULL(couplingType,'X') = 
	Case when @c2couplingType = '' Or @c2couplingType IS NULL then 'X'
	else @c2couplingType end 
and
ISNULL(coupledComponentType1,'X') = 
	Case when @c2coupledComponentType1 = '' Or @c2coupledComponentType1 IS NULL then 'X'
	else @c2coupledComponentType1 end 
and
ISNULL(coupledComponentType2,'X') = 
	Case when @c2coupledComponentType2 = '' Or @c2coupledComponentType2 IS NULL then 'X'
	else @c2coupledComponentType2 end 
and
ISNULL(Convert(varchar(10),couplingPosition),'X') = 
	Case when @c2couplingPosition = '' Or @c2couplingPosition IS NULL then 'X'
	else convert(varchar(10),@c2couplingPosition) end 
and 
ISNULL(Convert(varchar(10),locations),'X') = 
	Case when @c2locations = '' Or @c2locations IS NULL then 'X'
	else convert(varchar(10),@c2locations) end 

union all

select 'Intermediate' as Component, componentCode, 
@intermediatePickupCode as pickupCode
from master.tblIntermediateDetails 
WHERE 
ISNULL(componentType,'X') = 
	Case when @intercomponentType = '' Or @intercomponentType IS NULL then 'X'
	else @intercomponentType end 
and
ISNULL(intermediateType,'X') = 
	Case when @intermediateType = '' Or @intermediateType IS NULL then 'X'
	else @intermediateType end 
and
ISNULL(drivenBy,'X') = 
	Case when @drivenBy = '' Or @drivenBy IS NULL then 'X'
	else @drivenBy end 
and
ISNULL(Convert(varchar(10),speedChangesMax),'X') = 
	Case when @speedChangesMax = '' Or @speedChangesMax IS NULL then 'X'
	else convert(varchar(10),@speedChangesMax) end 
and 
ISNULL(Convert(varchar(10),locations),'X') = 
	Case when @interlocations = '' Or @interlocations IS NULL then 'X'
	else convert(varchar(10),@interlocations) end 


union all

select 'Driven' as Component, componentCode, 
@drivenPickupCode as pickupCode
from master.tblDrivenDetails 
WHERE 
ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
	Case when @drivencomponentType = '' Or @drivencomponentType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@drivencomponentType))) end 
and
ISNULL(UPPER(RTRIM(LTRIM(drivenType))),'X') = 
	Case when @drivenType = '' Or @drivenType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@drivenType))) end 
and
ISNULL(UPPER(RTRIM(LTRIM(pumpType))),'X') = 
	Case when @pumpType = '' Or @pumpType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@pumpType))) end 
and
ISNULL(UPPER(RTRIM(LTRIM(compressorType))),'X') = 
	Case when @compressorType = '' Or @compressorType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@compressorType))) end 
and
ISNULL(UPPER(RTRIM(LTRIM(fan_or_blowerType))),'X') = 
	Case when @fan_or_blowerType = '' Or @fan_or_blowerType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@fan_or_blowerType))) end 
and
ISNULL(UPPER(RTRIM(LTRIM(purifierDrivenBy))),'X') = 
	Case when @purifierDrivenBy = '' Or @purifierDrivenBy IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@purifierDrivenBy))) end 
and
ISNULL(UPPER(RTRIM(LTRIM(bearingType))),'X') = 
	Case when @bearingType = '' Or @bearingType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@bearingType))) end
and
ISNULL(UPPER(RTRIM(LTRIM(vacuumPumpType))),'X') = 
	Case when @vacuumPumpType = '' Or @vacuumPumpType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@vacuumPumpType))) end
and
ISNULL(UPPER(RTRIM(LTRIM(exciterOverhungOrSupported))),'X') = 
	Case when @exciterOverhungOrSupported = '' Or @exciterOverhungOrSupported IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@exciterOverhungOrSupported))) end
and
ISNULL(UPPER(RTRIM(LTRIM(bearingsType))),'X') = 
	Case when @bearingsType = '' Or @bearingsType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@bearingsType))) end
and
ISNULL(UPPER(RTRIM(LTRIM(thrustBearing))),'X') = 
	Case when @thrustBearing = '' Or @thrustBearing IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@thrustBearing))) end
and
ISNULL(locations,0) = 
	Case when @drivenlocations = '' Or @drivenlocations IS NULL then 0
	else @drivenlocations end 
and
ISNULL(UPPER(RTRIM(LTRIM(drivenBy))),'X') = 
	Case when @drivenBy1 = '' Or @drivenBy1 IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@drivenBy1))) end
and
ISNULL(Convert(varchar(10),rotorOverhung),'X') = 
	Case when @rotorOverhung IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@rotorOverhung)) end 
and
ISNULL(Convert(varchar(10),attachedOilPump),'X') = 
	Case when @attachedOilPump IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@attachedOilPump)) end 
and
ISNULL(Convert(varchar(10),impellerOnMainShaft),'X') = 
	Case when @impellerOnMainShaft IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@impellerOnMainShaft)) end 
and
ISNULL(Convert(varchar(10),crankHasIntermediateBearing),'X') = 
	Case when @crankHasIntermediateBearing IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@crankHasIntermediateBearing)) end 
and
ISNULL(Convert(varchar(10),fanStages),'X') = 
	Case when @fanStages IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@fanStages)) end
and
ISNULL(Convert(varchar(10),exciter),'X') = 
	Case when @exciter IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@exciter)) end
and
ISNULL(Convert(varchar(10),centrifugalPumpHasBallBearings),'X') = 
	Case when @centrifugalPumpHasBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@centrifugalPumpHasBallBearings)) end 
and
ISNULL(Convert(varchar(10),propellerpumpHasBallBearings),'X') = 
	Case when @propellerpumpHasBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@propellerpumpHasBallBearings)) end
and
ISNULL(Convert(varchar(10),rotaryThreadPumpHasBallBearings),'X') = 
	Case when @rotaryThreadPumpHasBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@rotaryThreadPumpHasBallBearings)) end
and
ISNULL(Convert(varchar(10),gearPumpHasBallBearings),'X') = 
	Case when @gearPumpHasBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@gearPumpHasBallBearings)) end
and
ISNULL(Convert(varchar(10),screwPumpHasBallBearings),'X') = 
	Case when @screwPumpHasBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@screwPumpHasBallBearings)) end
and
ISNULL(Convert(varchar(10),slidingVanePumpHasBallBearings),'X') = 
	Case when @slidingVanePumpHasBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@slidingVanePumpHasBallBearings)) end
and
ISNULL(Convert(varchar(10),axialRecipPumpHasBallBearings),'X') = 
	Case when @axialRecipPumpHasBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@axialRecipPumpHasBallBearings)) end
and
ISNULL(Convert(varchar(10),centrifugalCompressorHasBallBearings),'X') = 
	Case when @centrifugalCompressorHasBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@centrifugalCompressorHasBallBearings)) end
and
ISNULL(Convert(varchar(10),reciprocatingCompressorHasBallBearings),'X') = 
	Case when @reciprocatingCompressorHasBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@reciprocatingCompressorHasBallBearings)) end
and
ISNULL(Convert(varchar(10),screwCompressorHasBallBearings),'X') = 
	Case when @screwCompressorHasBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@screwCompressorHasBallBearings)) end
and
ISNULL(Convert(varchar(10),screwTwinCompressorHasBallBearingsOnHPSide),'X') = 
	Case when @screwTwinCompressorHasBallBearingsOnHPSide IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@screwTwinCompressorHasBallBearingsOnHPSide)) end
and
ISNULL(Convert(varchar(10),lobedFanOrBlowerHasBallBearings),'X') = 
	Case when @lobedFanOrBlowerHasBallBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@lobedFanOrBlowerHasBallBearings)) end
and
ISNULL(Convert(varchar(10),overhungRotorFanOrBlowerHasBearings),'X') = 
	Case when @overhungRotorFanOrBlowerHasBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@overhungRotorFanOrBlowerHasBearings)) end
and
ISNULL(Convert(varchar(10),supportedRotorFanOrBlowerHasBearings),'X') = 
	Case when @supportedRotorFanOrBlowerHasBearings IS NULL then 'X'
	else convert(varchar(10),Convert(bit,@supportedRotorFanOrBlowerHasBearings)) end
	

	Declare @DriverComponentCode decimal(18,2),@DrivenComponentCode decimal(18,2)
	Declare @FaultCodeMatrixJson nvarchar(max) = '';
	Declare @MachineSpeedRatio decimal(18,4) = null

	select @DriverComponentCode = componentCode from #ComponentCodeDetails where Component = 'Driver'
	select @DrivenComponentCode = componentCode from #ComponentCodeDetails where Component = 'Driven'
	
	set @MachineSpeedRatio =  @c1SpeedRatio * @c2SpeedRatio * @intermediateSpeedRatio

	--select @xmlInput,@DriverComponentCode,@DrivenComponentCode,@MachineSpeedRatio

	Exec dbo.spGenerateMIDDerivation1 @xmlInput,@DriverComponentCode,@DrivenComponentCode,@MachineSpeedRatio,@FaultCodeMatrixJson output
	
	select Component,ComponentCode,PickupCode,null as FaultCodeMatrixJson from #ComponentCodeDetails
	Union all
	select  'FaultCodeMatrix' as Component,null,null,@FaultCodeMatrixJson as FaultCodeMatrixJson
	
	drop table #ComponentCodeDetails
End
GO
/****** Object:  StoredProcedure [dbo].[spGenerateMIDDerivation1]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGenerateMIDDerivation1]
@xmlInput xml = '',
@driverComponentCode decimal(18,4),
@drivenComponentCode decimal(18,4),
@machineSpeedRatio decimal(18,4),
@FaultCodeMatrixJson nvarchar(max) output
As
Begin

--Declare @machineSpeedRatio decimal(18,4) = 0.1750
--Declare @driverComponentCode decimal(18,4) = 29.15
--Declare @drivenComponentCode decimal(18,4) = 17.21
--Declare @xmlInput xml = ''
--Declare @FaultCodeMatrixJson nvarchar(max) --output

--set @xmlInput = '<MIDCodeCreatorRequest xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <machineComponentsForMIDgeneration>
--    <driver>
--      <componentType>driver</componentType>
--      <locations>2</locations>
--      <driverType>diesel</driverType>
--      <cylinders>8</cylinders>
--      <motorFan xsi:nil="true" />
--      <motorBallBearings xsi:nil="true" />
--      <drivenBallBearings xsi:nil="true" />
--      <drivenBalanceable xsi:nil="true" />
--      <motorPoles xsi:nil="true" />
--      <turbineReductionGear xsi:nil="true" />
--      <turbineRotorSupported xsi:nil="true" />
--      <turbineBallBearing xsi:nil="true" />
--      <turbineThrustBearing xsi:nil="true" />
--      <turbineThrustBearingIsBall xsi:nil="true" />
--      <rpm>1</rpm>
--      <specialFaultCodesInput>
--        <SpecialFaultCodesInput>
--          <specialFaultCodeType>cylinders</specialFaultCodeType>
--          <specialFaultCodeCount>8</specialFaultCodeCount>
--        </SpecialFaultCodesInput>
--      </specialFaultCodesInput>
--      <driverLocationNDE>true</driverLocationNDE>
--      <driverLocationDE>true</driverLocationDE>
--    </driver>
--    <coupling1>
--      <id>0</id>
--      <componentType>coupling</componentType>
--      <couplingPosition>1</couplingPosition>
--      <couplingType>beltdrive</couplingType>
--      <locations xsi:nil="true" />
--      <speedratio>0.175</speedratio>
--    </coupling1>
--    <intermediate>
--      <locations xsi:nil="true" />
--      <speedChangesMax xsi:nil="true" />
--      <inputBearing xsi:nil="true" />
--      <speedratio>1</speedratio>
--    </intermediate>
--    <coupling2>
--      <couplingPosition xsi:nil="true" />
--      <locations xsi:nil="true" />
--      <speedratio>1</speedratio>
--    </coupling2>
--    <driven>
--      <componentType>driven</componentType>
--      <drivenType>compressor</drivenType>
--      <locations>2</locations>
--      <compressorType>reciprocating</compressorType>
--      <rotorOverhung xsi:nil="true" />
--      <attachedOilPump xsi:nil="true" />
--      <impellerOnMainShaft xsi:nil="true" />
--      <crankHasIntermediateBearing>false</crankHasIntermediateBearing>
--      <fanStages xsi:nil="true" />
--      <exciter xsi:nil="true" />
--      <centrifugalPumpHasBallBearings xsi:nil="true" />
--      <propellerpumpHasBallBearings xsi:nil="true" />
--      <rotaryThreadPumpHasBallBearings xsi:nil="true" />
--      <gearPumpHasBallBearings xsi:nil="true" />
--      <screwPumpHasBallBearings xsi:nil="true" />
--      <slidingVanePumpHasBallBearings xsi:nil="true" />
--      <axialRecipPumpHasBallBearings xsi:nil="true" />
--      <centrifugalCompressorHasBallBearings xsi:nil="true" />
--      <reciprocatingCompressorHasBallBearings>false</reciprocatingCompressorHasBallBearings>
--      <screwCompressorHasBallBearings xsi:nil="true" />
--      <screwTwinCompressorHasBallBearingsOnHPSide xsi:nil="true" />
--      <lobedFanOrBlowerHasBallBearings xsi:nil="true" />
--      <overhungRotorFanOrBlowerHasBearings xsi:nil="true" />
--      <supportedRotorFanOrBlowerHasBearings xsi:nil="true" />
--      <rpm>1</rpm>
--      <specialFaultCodesInput>
--        <SpecialFaultCodesInput>
--          <specialFaultCodeCount xsi:nil="true" />
--        </SpecialFaultCodesInput>
--      </specialFaultCodesInput>
--      <drivenLocationNDE>true</drivenLocationNDE>
--      <drivenLocationDE>true</drivenLocationDE>
--    </driven>
--  </machineComponentsForMIDgeneration>
--</MIDCodeCreatorRequest>'

Declare @xmlDocumentHandle int
EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
Declare  @SpecialFaultCodesInputTable table (SpecialFaultCodeType varchar(50),SpecialFaultCodeCount int,ComponentName varchar(50))
Declare @componentType varchar(100)
Declare @driverRPM decimal(18,4) = null
Declare @c1componentType varchar(100), @c1SpeedRatio decimal(18,4)
Declare @c2componentType varchar(100),@c2SpeedRatio decimal(18,4)
Declare @intercomponentType varchar(100)
Declare @drivencomponentType varchar(100)
Declare @drivenRPM decimal(18,4)

--- Read xml for driver component --
select @componentType = componentType,
@driverRPM = Convert(decimal(18,4),Case when rpm = '' then null else rpm end )
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver',2)
WITH (componentType varchar(100),rpm  varchar(10))
--- Read xml for driver component --

--- Read xml for coupling1 component --
select @c1componentType = componentType,
@c1SpeedRatio = speedratio
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/coupling1',2)
WITH (componentType varchar(100),speedratio decimal(18,4))
--- Read xml for coupling1 component --

--- Read xml for coupling2 component --
select @c2componentType = componentType,@c2SpeedRatio = speedratio
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/coupling2',2)
WITH (componentType varchar(100),speedratio decimal(18,4))
--- Read xml for coupling2 component --

select @intercomponentType = componentType FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/intermediate',2)
WITH (componentType varchar(100))

--- Read xml for driven component --
select @drivencomponentType = componentType,
@drivenRPM = Convert(decimal(18,4),Case when rpm = '' then null else rpm end )
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven',2)
WITH (componentType varchar(100),rpm varchar(10))
--- Read xml for driven component --

--- Read xml for driver special code and insert into SpecialFaultCodesInputTable --
insert into @SpecialFaultCodesInputTable
select specialFaultCodeType,specialFaultCodeCount,'Driver'
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/specialFaultCodesInput/SpecialFaultCodesInput',2)
WITH (specialFaultCodeType varchar(100),specialFaultCodeCount int)
--- Read xml for driver special code and insert into SpecialFaultCodesInputTable --

--- Read xml for driven special code and insert into SpecialFaultCodesInputTable --
insert into @SpecialFaultCodesInputTable
select specialFaultCodeType,specialFaultCodeCount,'Driven'
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/specialFaultCodesInput/SpecialFaultCodesInput',2)
WITH (specialFaultCodeType varchar(100),specialFaultCodeCount int)
--- Read xml for driven special code and insert into SpecialFaultCodesInputTable --
	
	
	Declare @DriverShaftLabel varchar(10),@DrivenShaftLabel varchar(10)

	--Get defaultshaft label for driver
	select @DriverShaftLabel = defaultshaftlabel from master.tblCSDMdefsDetails 
	where @driverComponentCode between componentcoderangestart and componentcoderangeend

	--Get defaultshaft label for driven
	select @DrivenShaftLabel = defaultshaftlabel from master.tblCSDMdefsDetails 
	where @drivenComponentCode between componentcoderangestart and componentcoderangeend

	; with CTE as  
	(  
	 select 1 RowId  
	 union all  
	 select RowId +1 from CTE where RowId<10  
	) 
	select * into #RowTable from CTE

	--Declare @FaultCodeMatrixJson nvarchar(max) = '';

	DECLARE @SpecialFaultCodesDetails TABLE(Id INT,RowCode VARCHAR(30),SpecialMultiple int, SpecialFaultCodeCount int,ComponentName varchar(50));
			
	DECLARE @SpecialFaultCodeTable TABLE(RowId int primary key identity(1,1),RowCode VARCHAR(30),RowOrder decimal(18,4));

	DECLARE @NonSpecialFaultCodeTable TABLE(Id int primary key identity(1,1),RowId int,RowCode VARCHAR(30),RowOrder decimal(18,4),IsUpdate bit);

	DECLARE @CombineSpecialAndNonSpecialFaultCodeTable TABLE(RowId int,RowCode VARCHAR(30),RowOrder decimal(18,4));
	
	
	if(@machineSpeedRatio <> 1)
		Begin
			insert into @NonSpecialFaultCodeTable
			select RowId,FrequencyCode,FaultCode,0 from (
			select RowId,Convert(varchar(20),RowId) + 'X' +  @DriverShaftLabel  as FrequencyCode,
			convert(decimal(18,4),RowId) as FaultCode
			from #RowTable where RowId <=5
			Union all 
			select RowId,Convert(varchar(20),RowId) + 'X' + @DrivenShaftLabel as FrequencyCode,
			convert(decimal(18,4),convert(decimal(18,4),RowId) * convert(decimal(18,4),@machineSpeedRatio)) as FaultCode
			from #RowTable where RowId <=5 ) as T
		
			--select * from @NonSpecialFaultCodeTable

			if exists(select * from @SpecialFaultCodesInputTable)
				Begin
				
					insert into @SpecialFaultCodesDetails
					select ROW_NUMBER() over(order by (select 1)) as Id,B.specialcode as RowCode,B.specialmultiple as SpecialMultiple,A.SpecialFaultCodeCount,A.ComponentName  from @SpecialFaultCodesInputTable A
					inner join master.tblSpecialFaultCodesDetails B on A.SpecialFaultCodeType = B.specialfaultcodetype
					
					--select * from @SpecialFaultCodesDetails

					DECLARE @RowCounter INT 
					SET @RowCounter=1
					WHILE ( @RowCounter <= (select count(*) from @SpecialFaultCodesDetails))
					BEGIN
						Declare @RowCode varchar(50)= ''
						Declare @SpecialMultiple int,@SpecialFaultCodeCount int,@ComponentName varchar(50)
						
						select @RowCode = RowCode,@SpecialMultiple = SpecialMultiple, @ComponentName = ComponentName,
						@SpecialFaultCodeCount = SpecialFaultCodeCount from @SpecialFaultCodesDetails where Id = @RowCounter
						
						DECLARE @InnerRowCounter INT 
						SET @InnerRowCounter = 1 
						WHILE ( @InnerRowCounter <= @SpecialMultiple)
							BEGIN
								if(Upper(RTRIM(LTRIM(@ComponentName))) = Upper(RTRIM(LTRIM('Driver'))))
									Begin
										insert into @SpecialFaultCodeTable
										select Case when @InnerRowCounter = 1 then @RowCode else Convert(varchar(10),@InnerRowCounter) + @RowCode end as RowCode, @SpecialFaultCodeCount * @InnerRowCounter  as RowOrder
									End
								else
									Begin
											insert into @SpecialFaultCodeTable
											select Case when @InnerRowCounter = 1 then @RowCode else Convert(varchar(10),@InnerRowCounter) + @RowCode end as RowCode, @SpecialFaultCodeCount * @InnerRowCounter * @machineSpeedRatio as RowOrder
									End
							
								SET @InnerRowCounter  = @InnerRowCounter  + 1
							End
					    SET @RowCounter  = @RowCounter  + 1
					END
					-- logic for merging special fault code row with non special fault code.
					Declare @SpecialRowOrder decimal(18,4)
					Declare @SpecialRowCode varchar(20)
					Declare @SpecialRowCount int
					set @SpecialRowCount = 1
					Declare @Id int
					
					--select * from @SpecialFaultCodeTable

					While(@SpecialRowCount <= (select count(*) from @SpecialFaultCodeTable))
						Begin
							select @SpecialRowCode = RowCode ,@SpecialRowOrder = RowOrder from @SpecialFaultCodeTable where RowId = @SpecialRowCount
							
							--select @SpecialRowCode,@SpecialRowOrder

							if exists (select Top 1 * from @NonSpecialFaultCodeTable where RowOrder =  @SpecialRowOrder and IsUpdate = 0)
								Begin
									select @Id = Id from @NonSpecialFaultCodeTable where RowOrder =  @SpecialRowOrder and IsUpdate = 0
									Update @NonSpecialFaultCodeTable set RowCode = @SpecialRowCode, IsUpdate = 1 where Id = @Id and RowId > 1
								End
							else
								Begin
									insert into @NonSpecialFaultCodeTable (RowCode,RowOrder)
									select @SpecialRowCode,@SpecialRowOrder
								End
							set @SpecialRowCount = @SpecialRowCount + 1
						End

						--select * from @NonSpecialFaultCodeTable

					set @FaultCodeMatrixJson = (select RowId as [RowId],RowCode as [FrequencyCode],convert(decimal(18,4),RowOrder) as [FaultCode]  from 
					(select ROW_NUMBER() over(order by (select 1)) as RowId, RowCode,RowOrder from @NonSpecialFaultCodeTable group by RowCode,RowOrder
					) as T order by RowOrder,RowCode for Json Path, Root('rows'))
					-- logic for merging special fault code row with non special fault code.
				End
			else 
			   Begin
			   	set @FaultCodeMatrixJson = (select RowId as [RowId],RowCode as [FrequencyCode],RowOrder as [FaultCode]  from 
					(select ROW_NUMBER() over(order by (select 1)) as RowId, RowCode,RowOrder from @NonSpecialFaultCodeTable
					) as T order by FaultCode,FrequencyCode for Json Path, Root('rows'))
			   End

		End
	else
		Begin
			insert into @NonSpecialFaultCodeTable
			select  RowId,Convert(varchar(20),RowId) + 'X' as FrequencyCode,
			convert(decimal(18,4),RowId) as FaultCode,0 from #RowTable order by RowId

			if exists(select * from @SpecialFaultCodesInputTable)
				Begin
					insert into @SpecialFaultCodesDetails
					select ROW_NUMBER() over(order by (select 1)) as Id,B.specialcode as RowCode,B.specialmultiple as SpecialMultiple,A.SpecialFaultCodeCount,ComponentName  from @SpecialFaultCodesInputTable A
					inner join master.tblSpecialFaultCodesDetails B on A.SpecialFaultCodeType = B.specialfaultcodetype
					
					DECLARE @RowNumber INT
					SET @RowNumber=1
					WHILE ( @RowNumber <= (select count(*) from @SpecialFaultCodesDetails))
					BEGIN
						Declare @RowCodes varchar(50)= ''
						Declare @SpecialMultiples int,@SpecialFaultCodeCounts int
						
						select @RowCodes = RowCode,@SpecialMultiples = SpecialMultiple, 
						@SpecialFaultCodeCounts = SpecialFaultCodeCount from @SpecialFaultCodesDetails where Id = @RowNumber

						DECLARE @InnerRowCounters INT 
						SET @InnerRowCounters = 1 
						WHILE ( @InnerRowCounters <= @SpecialMultiples)
							BEGIN
								insert into @SpecialFaultCodeTable
								select Case when @InnerRowCounters = 1 then @RowCodes else Convert(varchar(10),@InnerRowCounters) + @RowCodes end as RowCode, @SpecialFaultCodeCounts * @InnerRowCounters as RowOrder
								SET @InnerRowCounters  = @InnerRowCounters  + 1
							End
					    SET @RowNumber  = @RowNumber  + 1
					END
					-- logic for merging special fault code row with non special fault code.
					Declare @SpclRowOrder decimal(18,4)
					Declare @SpclRowCode varchar(20)
					Declare @SpclRowCount int
					set @SpclRowCount = 1
					Declare @Ids int
					While(@SpclRowCount <= (select count(*) from @SpecialFaultCodeTable))
						Begin
							select @SpclRowCode = RowCode ,@SpclRowOrder = RowOrder from @SpecialFaultCodeTable where RowId = @SpclRowCount
							
							if exists (select Top 1 * from @NonSpecialFaultCodeTable where RowOrder =  @SpclRowOrder and IsUpdate = 0)
								Begin
									select @Ids = Id from @NonSpecialFaultCodeTable where RowOrder =  @SpclRowOrder and IsUpdate = 0
									Update @NonSpecialFaultCodeTable set RowCode = @SpclRowCode, IsUpdate = 1 where Id = @Ids and RowId > 1
								End
							else
								Begin
								insert into @NonSpecialFaultCodeTable (RowCode,RowOrder)
									select @SpclRowCode,@SpclRowOrder
								End
							set @SpclRowCount = @SpclRowCount + 1
						End

					set @FaultCodeMatrixJson = (select RowId as [RowId],RowCode as [FrequencyCode],convert(decimal(18,4),RowOrder) as [FaultCode]  from 
					(select ROW_NUMBER() over(order by (select 1)) as RowId, RowCode,RowOrder from @NonSpecialFaultCodeTable group by RowCode,RowOrder
					) as T order by RowOrder,RowCode for Json Path, Root('rows'))
					-- logic for merging special fault code row with non special fault code.
				End
			else
				Begin
					set @FaultCodeMatrixJson = (select RowId as [RowId],RowCode as [FrequencyCode],convert(decimal(18,4),RowOrder) as [FaultCode]  from 
					(select ROW_NUMBER() over(order by (select 1)) as RowId, RowCode,RowOrder from @NonSpecialFaultCodeTable group by RowCode,RowOrder
					) as T order by RowOrder for Json Path, Root('rows'))
				End
		End
	drop table #RowTable
	--select @FaultCodeMatrixJson
End
GO
/****** Object:  StoredProcedure [dbo].[spGetAllCoupling1Details]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <30/04/2021>
-- Description: <SP used for get Coupling component data by componentType and CouplingType>
-- =============================================
Create PROCEDURE [dbo].[spGetAllCoupling1Details]
(
   @componentType varchar(50), 
   @couplingType varchar(50) 
)
AS
BEGIN
	if(@componentType IS NOT NULL and @couplingType IS NOT NULL)
		Begin
			select * from master.tblCoupling1Details 
			where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@componentType))) and
			UPPER(RTRIM(LTRIM(CouplingType))) = UPPER(RTRIM(LTRIM(@couplingType))) and isDeleted = 0
		End
	else if(@componentType IS NULL and @couplingType IS NOT NULL)
		Begin
			select * from master.tblCoupling1Details 
			where UPPER(RTRIM(LTRIM(CouplingType))) = UPPER(RTRIM(LTRIM(@couplingType))) and isDeleted = 0
		End
	else if(@componentType IS NOT NULL and @couplingType IS NULL)
		Begin
			select * from master.tblCoupling1Details 
			where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@componentType))) and isDeleted = 0
		End
	else
		Begin
			select * from master.tblCoupling1Details where isDeleted = 0
		End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllCoupling2Details]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <04/05/2021>
-- Description: <SP used for get Coupling component data by componentType and CouplingType>
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllCoupling2Details]
(
   @componentType varchar(50), 
   @couplingType varchar(50) 
)
AS
BEGIN
	if(@componentType IS NOT NULL and @couplingType IS NOT NULL)
		Begin
			select * from master.tblCoupling2Details 
			where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@componentType))) and
			UPPER(RTRIM(LTRIM(CouplingType))) = UPPER(RTRIM(LTRIM(@couplingType))) and isDeleted = 0
		End
	else if(@componentType IS NULL and @couplingType IS NOT NULL)
		Begin
			select * from master.tblCoupling2Details 
			where UPPER(RTRIM(LTRIM(CouplingType))) = UPPER(RTRIM(LTRIM(@couplingType))) and isDeleted = 0
		End
	else if(@componentType IS NOT NULL and @couplingType IS NULL)
		Begin
			select * from master.tblCoupling2Details 
			where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@componentType))) and isDeleted = 0
		End
	else
		Begin
			select * from master.tblCoupling2Details where isDeleted = 0
		End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllCSDMdefsDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <06/05/2021>
-- Description: <SP used for get CSDMdefs component data by csdmfile>
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllCSDMdefsDetails]
(
   @csdmfile varchar(50)
)
AS
BEGIN
	--Declare @csdmfile varchar(50) = 'VFDMOTR2'
	if(@csdmfile IS NOT NULL)
		Begin
			select * from master.tblCSDMdefsDetails 
			where UPPER(RTRIM(LTRIM(csdmfile))) = UPPER(RTRIM(LTRIM(@csdmfile)))  and isDeleted = 0
		End
	else
		Begin
			select * from master.tblCSDMdefsDetails where isDeleted = 0
		End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllDrivenDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <28/04/2021>
-- Description: <SP used for get driven component data by componentType and drivenType>
-- =============================================
Create PROCEDURE [dbo].[spGetAllDrivenDetails]
(
   @componentType varchar(50), 
   @drivenType varchar(50) 
)
AS
BEGIN
	if(@componentType IS NOT NULL and @drivenType IS NOT NULL)
		Begin
			select * from master.tblDrivenDetails 
			where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@componentType))) and
			UPPER(RTRIM(LTRIM(drivenType))) = UPPER(RTRIM(LTRIM(@drivenType))) and isDeleted = 0
		End
	else if(@componentType IS NULL and @drivenType IS NOT NULL)
		Begin
			select * from master.tblDrivenDetails 
			where UPPER(RTRIM(LTRIM(drivenType))) = UPPER(RTRIM(LTRIM(@drivenType))) and isDeleted = 0
		End
	else if(@componentType IS NOT NULL and @drivenType IS NULL)
		Begin
			select * from master.tblDrivenDetails 
			where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@componentType))) and isDeleted = 0
		End
	else
		Begin
			select * from master.tblDrivenDetails where isDeleted = 0
		End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllDriverDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <27/04/2021>
-- Description: <SP used for get driver component data by componentType and driverType>
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllDriverDetails]
(
   @componentType varchar(50), 
   @driverType varchar(50) 
)
AS
BEGIN
	if(@componentType IS NOT NULL and @driverType IS NOT NULL)
		Begin
			select * from master.tblDriverDetails 
			where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@componentType))) and
			UPPER(RTRIM(LTRIM(driverType))) = UPPER(RTRIM(LTRIM(@driverType))) and isDeleted = 0
		End
	else if(@componentType IS NULL and @driverType IS NOT NULL)
		Begin
			select * from master.tblDriverDetails 
			where UPPER(RTRIM(LTRIM(driverType))) = UPPER(RTRIM(LTRIM(@driverType))) and isDeleted = 0
		End
	else if(@componentType IS NOT NULL and @driverType IS NULL)
		Begin
			select * from master.tblDriverDetails 
			where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@componentType))) and isDeleted = 0
		End
	else
		Begin
			select * from master.tblDriverDetails where isDeleted = 0
		End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllIntermediateDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <29/04/2021>
-- Description: <SP used for get intermediate component data by componentType and intermediateType>
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllIntermediateDetails]
(
   @componentType varchar(50), 
   @intermediateType varchar(50) 
)
AS
BEGIN

 --Declare @componentType varchar(50) = 'vishal123345888'
 --  Declare @intermediateType varchar(50) = null

	if(@componentType IS NOT NULL and @intermediateType IS NOT NULL)
		Begin
			select * from master.tblIntermediateDetails 
			where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@componentType))) and
			UPPER(RTRIM(LTRIM(intermediateType))) = UPPER(RTRIM(LTRIM(@intermediateType))) and isDeleted = 0
		End
	else if(@componentType IS NULL and @intermediateType IS NOT NULL)
		Begin
			select * from master.tblIntermediateDetails 
			where UPPER(RTRIM(LTRIM(intermediateType))) = UPPER(RTRIM(LTRIM(@intermediateType))) and isDeleted = 0
		End
	else if(@componentType IS NOT NULL and @intermediateType IS NULL)
		Begin
			select * from master.tblIntermediateDetails 
			where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@componentType))) and isDeleted = 0
		End
	else
		Begin
			select * from master.tblIntermediateDetails where isDeleted = 0
		End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllPickupCodeDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <11/05/2021>
-- Description: <SP used for get PickupCode Details data>
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllPickupCodeDetails]
AS
BEGIN
	
			select * from master.tblPickupCodeDetails where isDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllSpecialFaultCodesDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <27/04/2021>
-- Description: <SP used for get SpecialFaultCodes data>
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllSpecialFaultCodesDetails]
(
   @specialFaultCodesType varchar(50), 
   @specialCode varchar(50) 
)
AS
BEGIN
	if(@SpecialFaultCodesType IS NOT NULL and @SpecialCode IS NOT NULL)
		Begin
			select * from master.tblSpecialFaultCodesDetails 
			where UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM(@specialFaultCodesType))) and
			UPPER(RTRIM(LTRIM(specialCode))) = UPPER(RTRIM(LTRIM(@specialCode))) and isDeleted = 0
		End
	else if(@SpecialFaultCodesType IS NULL and @SpecialCode IS NOT NULL)
		Begin
			select * from master.tblSpecialFaultCodesDetails 
			where UPPER(RTRIM(LTRIM(specialCode))) = UPPER(RTRIM(LTRIM(@specialCode))) and isDeleted = 0
		End
	else if(@SpecialFaultCodesType IS NOT NULL and @SpecialCode IS NULL)
		Begin
			select * from master.tblSpecialFaultCodesDetails 
			where UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM(@specialFaultCodesType))) and isDeleted = 0
		End
	else
		Begin
			select * from master.tblSpecialFaultCodesDetails where isDeleted = 0
		End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCoupling1Details]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --=============================================
 --Author:      <Vishal Dhure>
-- Create Date: <30/04/2021>
-- Description: <SP used for get coupling1 component data>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCoupling1Details]
(
   @xmlInput xml = ''
)
AS
BEGIN

--  Declare  @xmlInput xml = ''
--  set @xmlInput = '<?xml version="1.0"?>
--<Coupling1 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>0</id>
--  <componentType>Coupling1</componentType>
--  <couplingPosition xsi:nil="true" />
--  <locations xsi:nil="true" />
--  <speedratio xsi:nil="true" />
--</Coupling1>'
	
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		--Declare variable for coupling1 component --
		Declare @Id bigint, @c1componentType varchar(100),@c1couplingType varchar(100), @c1coupledComponentType1 varchar(100),@c1coupledComponentType2 varchar(100)
		Declare @c1couplingPosition int, @c1locations int
		--Declare variable for coupling1 component --

		--- Read xml for coupling1 component --
		select 
		@Id = id, 
		@c1componentType = Case when componentType = '' then null else componentType end,
		@c1couplingType = Case when couplingType = '' then null else couplingType end ,
		@c1coupledComponentType1 = Case when coupledComponentType1 = '' then null else coupledComponentType1 end ,
		@c1coupledComponentType2 = Case when coupledComponentType2 = '' then null else coupledComponentType2 end  ,
		@c1couplingPosition = Case when couplingPosition = '' then null else couplingPosition end ,
		@c1locations = Case when locations = '' then null else locations end 
		 FROM OPENXML (@xmlDocumentHandle, 'Coupling1',2)
		WITH (id bigint,componentType varchar(100),couplingType varchar(100),coupledComponentType1 varchar(100),coupledComponentType2 varchar(100),
		couplingPosition int,locations int)
		--- Read xml for coupling1 component --
		--select @id
		if(@id = 0 )
		Begin
				select * from master.tblCoupling1Details
				WHERE isDeleted = 0 
				and 
				ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @c1componentType = '' Or @c1componentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1componentType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(couplingType))),'X') = 
				Case when @c1couplingType = '' Or @c1couplingType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1couplingType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(coupledComponentType1))),'X') = 
				Case when @c1coupledComponentType1 = '' Or @c1coupledComponentType1 IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1coupledComponentType1))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(coupledComponentType2))),'X') = 
				Case when @c1coupledComponentType2 = '' Or @c1coupledComponentType2 IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1coupledComponentType2))) end 
				and
				ISNULL(couplingPosition,0) = 
				Case when @c1couplingPosition = '' Or @c1couplingPosition IS NULL then 0
				else @c1couplingPosition end 
				and 
				ISNULL(locations,0) = 
				Case when @c1locations = '' Or @c1locations IS NULL then 0
				else @c1locations end 
			End
		else
			Begin
				select * from master.tblCoupling1Details
				WHERE isDeleted = 0 and id <> @id
				and 
				ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @c1componentType = '' Or @c1componentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1componentType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(couplingType))),'X') = 
				Case when @c1couplingType = '' Or @c1couplingType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1couplingType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(coupledComponentType1))),'X') = 
				Case when @c1coupledComponentType1 = '' Or @c1coupledComponentType1 IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1coupledComponentType1))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(coupledComponentType2))),'X') = 
				Case when @c1coupledComponentType2 = '' Or @c1coupledComponentType2 IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1coupledComponentType2))) end 
				and
				ISNULL(couplingPosition,0) = 
				Case when @c1couplingPosition = '' Or @c1couplingPosition IS NULL then 0
				else @c1couplingPosition end 
				and 
				ISNULL(locations,0) = 
				Case when @c1locations = '' Or @c1locations IS NULL then 0
				else @c1locations end
			End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCoupling1DetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <30/04/2021>
-- Description: <SP used for get colupling1 details by id>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCoupling1DetailsById]
(
   @id bigint
)
AS
BEGIN
	select * from master.tblCoupling1Details where id = @id and isDeleted = 0
End
GO
/****** Object:  StoredProcedure [dbo].[spGetCoupling2Details]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --=============================================
 --Author:      <Vishal Dhure>
-- Create Date: <04/05/2021>
-- Description: <SP used for get Coupling2 component data>
-- =============================================
Create PROCEDURE [dbo].[spGetCoupling2Details]
(
   @xmlInput xml = ''
)
AS
BEGIN

--  Declare  @xmlInput xml = ''
--  set @xmlInput = '<?xml version="1.0"?>
--<Coupling2 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>0</id>
--  <componentType>Coupling2</componentType>
--  <couplingPosition xsi:nil="true" />
--  <locations xsi:nil="true" />
--  <speedratio xsi:nil="true" />
--</Coupling2>'
	
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		--Declare variable for Coupling2 component --
		Declare @Id bigint, @c1componentType varchar(100),@c1couplingType varchar(100), @c1coupledComponentType1 varchar(100),@c1coupledComponentType2 varchar(100)
		Declare @c1couplingPosition int, @c1locations int
		--Declare variable for Coupling2 component --

		--- Read xml for Coupling2 component --
		select 
		@Id = id, 
		@c1componentType = Case when componentType = '' then null else componentType end,
		@c1couplingType = Case when couplingType = '' then null else couplingType end ,
		@c1coupledComponentType1 = Case when coupledComponentType1 = '' then null else coupledComponentType1 end ,
		@c1coupledComponentType2 = Case when coupledComponentType2 = '' then null else coupledComponentType2 end  ,
		@c1couplingPosition = Case when couplingPosition = '' then null else couplingPosition end ,
		@c1locations = Case when locations = '' then null else locations end 
		 FROM OPENXML (@xmlDocumentHandle, 'Coupling2',2)
		WITH (id bigint,componentType varchar(100),couplingType varchar(100),coupledComponentType1 varchar(100),coupledComponentType2 varchar(100),
		couplingPosition int,locations int)
		--- Read xml for Coupling2 component --
		--select @id
		if(@id = 0 )
		Begin
				select * from master.tblCoupling2Details
				WHERE isDeleted = 0 
				and 
				ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @c1componentType = '' Or @c1componentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1componentType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(couplingType))),'X') = 
				Case when @c1couplingType = '' Or @c1couplingType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1couplingType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(coupledComponentType1))),'X') = 
				Case when @c1coupledComponentType1 = '' Or @c1coupledComponentType1 IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1coupledComponentType1))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(coupledComponentType2))),'X') = 
				Case when @c1coupledComponentType2 = '' Or @c1coupledComponentType2 IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1coupledComponentType2))) end 
				and
				ISNULL(couplingPosition,0) = 
				Case when @c1couplingPosition = '' Or @c1couplingPosition IS NULL then 0
				else @c1couplingPosition end 
				and 
				ISNULL(locations,0) = 
				Case when @c1locations = '' Or @c1locations IS NULL then 0
				else @c1locations end 
			End
		else
			Begin
				select * from master.tblCoupling2Details
				WHERE isDeleted = 0 and id <> @id
				and 
				ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @c1componentType = '' Or @c1componentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1componentType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(couplingType))),'X') = 
				Case when @c1couplingType = '' Or @c1couplingType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1couplingType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(coupledComponentType1))),'X') = 
				Case when @c1coupledComponentType1 = '' Or @c1coupledComponentType1 IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1coupledComponentType1))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(coupledComponentType2))),'X') = 
				Case when @c1coupledComponentType2 = '' Or @c1coupledComponentType2 IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@c1coupledComponentType2))) end 
				and
				ISNULL(couplingPosition,0) = 
				Case when @c1couplingPosition = '' Or @c1couplingPosition IS NULL then 0
				else @c1couplingPosition end 
				and 
				ISNULL(locations,0) = 
				Case when @c1locations = '' Or @c1locations IS NULL then 0
				else @c1locations end
			End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCoupling2DetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <04/05/2021>
-- Description: <SP used for get colupling2 details by id>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCoupling2DetailsById]
(
   @id bigint
)
AS
BEGIN
	select * from master.tblCoupling2Details where id = @id and isDeleted = 0
End
GO
/****** Object:  StoredProcedure [dbo].[spGetCSDMdefsDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --=============================================
 --Author:      <Vishal Dhure>
-- Create Date: <06/05/2021>
-- Description: <SP used for get CSDMdefs component data>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCSDMdefsDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN
	
--	Declare @xmlInput xml = '<?xml version="1.0"?>
--<CSDMdefsDetails xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>0</id>
--  <csdmfile>asdasd</csdmfile>
--  <componentCodeRangeStart>10.0</componentCodeRangeStart>
--  <componentCodeRangeEnd>10.0</componentCodeRangeEnd>
--  <csdmSize>1</csdmSize>
--  <csdmRelative>true</csdmRelative>
--  <defaultShaftLabel>Na</defaultShaftLabel>
--</CSDMdefsDetails>'

		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		--Declare variable for CSDMdefs component --
		Declare @id bigint
		Declare @CSDMfile varchar(50),@defaultshaftlabel varchar(50)
		Declare @componentcoderangestart decimal(18,2),@componentcoderangeend decimal(18,2)
		Declare @CSDMsize int
		Declare @CSDMrelative bit
		--Declare variable for CSDMdefs component --

		select @Id =id, @CSDMfile = Case when csdmfile = '' then null else csdmfile end,
		@defaultshaftlabel = Case when defaultshaftlabel = '' then null else defaultshaftlabel end , 
		@componentcoderangestart = Convert(decimal(18,2),Case when  componentcoderangestart = '' then null else componentcoderangestart end),
		@componentcoderangeend = Convert(decimal(18,2),case when componentCodeRangeEnd = '' then null else  componentCodeRangeEnd end) ,
		@CSDMsize = case when CSDMsize = '' then null else CSDMsize end ,
		@CSDMrelative = case when CSDMrelative = '' then null else CSDMrelative end
		FROM OPENXML (@xmlDocumentHandle, 'CSDMdefsDetails',2)
		WITH (id bigint,csdmfile varchar(50),componentCodeRangeStart varchar(20),
		componentCodeRangeEnd varchar(20),csdmSize int,csdmRelative bit,defaultShaftLabel varchar(50))

		if(@id = 0 )
		Begin
				select * from master.tblCSDMdefsDetails
				WHERE isDeleted = 0 
				and 
				ISNULL(UPPER(RTRIM(LTRIM(CSDMfile))),'X') = 
				Case when @CSDMfile = '' Or @CSDMfile IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@CSDMfile))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(defaultshaftlabel))),'X') = 
				Case when @defaultshaftlabel = '' Or @defaultshaftlabel IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@defaultshaftlabel))) end 
				and
				ISNULL(componentcoderangestart,0) = 
				Case when  @componentcoderangestart IS NULL then 0
				else @componentcoderangestart end 
				and
				ISNULL(componentcoderangeend,0) = 
				Case when  @componentcoderangeend IS NULL then 0
				else @componentcoderangeend end 
				and
				ISNULL(CSDMsize,0) = 
				Case when @CSDMsize = '' Or @CSDMsize IS NULL then 0
				else @CSDMsize end 
				and
				ISNULL(Convert(varchar(10),CSDMrelative),'X') = 
				Case when @CSDMrelative IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@CSDMrelative)) end 
			End
		else
			Begin
				select * from master.tblCSDMdefsDetails
				WHERE isDeleted = 0 and id <> @id
				and 
				ISNULL(UPPER(RTRIM(LTRIM(CSDMfile))),'X') = 
				Case when @CSDMfile = '' Or @CSDMfile IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@CSDMfile))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(defaultshaftlabel))),'X') = 
				Case when @defaultshaftlabel = '' Or @defaultshaftlabel IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@defaultshaftlabel))) end 
				and
				ISNULL(componentcoderangestart,0) = 
				Case when  @componentcoderangestart IS NULL then 0
				else @componentcoderangestart end 
				and
				ISNULL(componentcoderangeend,0) = 
				Case when  @componentcoderangeend IS NULL then 0
				else @componentcoderangeend end 
				and
				ISNULL(CSDMsize,0) = 
				Case when @CSDMsize = '' Or @CSDMsize IS NULL then 0
				else @CSDMsize end 
				and
				ISNULL(Convert(varchar(10),CSDMrelative),'X') = 
				Case when @CSDMrelative IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@CSDMrelative)) end 
			End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCSDMdefsDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <06/05/2021>
-- Description: <SP used for get CSDMdefs details by id>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCSDMdefsDetailsById]
(
   @id bigint
)
AS
BEGIN
	select * from master.tblCSDMdefsDetails where id = @id and isDeleted = 0
End
GO
/****** Object:  StoredProcedure [dbo].[spGetDrivenDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --=============================================
 --Author:      <Vishal Dhure>
-- Create Date: <28/04/2021>
-- Description: <SP used for get driven component data>
-- =============================================
CREATE PROCEDURE [dbo].[spGetDrivenDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN

--  Declare  @xmlInput xml = ''
--  set @xmlInput = '<?xml version="1.0"?>
--<DrivenDetails xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>0</id>
--  <componentType>Vishal</componentType>
--  <locations xsi:nil="true" />
--  <rotorOverhung xsi:nil="true" />
--  <attachedOilPump xsi:nil="true" />
--  <impellerOnMainShaft xsi:nil="true" />
--  <crankHasIntermediateBearing xsi:nil="true" />
--  <fanStages xsi:nil="true" />
--  <exciter xsi:nil="true" />
--  <centrifugalPumpHasBallBearings xsi:nil="true" />
--  <propellerpumpHasBallBearings xsi:nil="true" />
--  <rotaryThreadPumpHasBallBearings xsi:nil="true" />
--  <gearPumpHasBallBearings xsi:nil="true" />
--  <screwPumpHasBallBearings xsi:nil="true" />
--  <slidingVanePumpHasBallBearings xsi:nil="true" />
--  <axialRecipPumpHasBallBearings xsi:nil="true" />
--  <centrifugalCompressorHasBallBearings xsi:nil="true" />
--  <reciprocatingCompressorHasBallBearings xsi:nil="true" />
--  <screwCompressorHasBallBearings xsi:nil="true" />
--  <screwTwinCompressorHasBallBearingsOnHPSide xsi:nil="true" />
--  <lobedFanOrBlowerHasBallBearings xsi:nil="true" />
--  <overhungRotorFanOrBlowerHasBearings xsi:nil="true" />
--  <supportedRotorFanOrBlowerHasBearings xsi:nil="true" />
--  <componentCode xsi:nil="true" />
--</DrivenDetails>'
	
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		--Declare variable for driven component --
		Declare @drivencomponentType varchar(100),@drivenType varchar(100), 
		@pumpType varchar(100),@compressorType varchar(1000) ,@fan_or_blowerType varchar(1000),
		@purifierDrivenBy varchar(100),@bearingType varchar(100),@vacuumPumpType varchar(100),
		@exciterOverhungOrSupported varchar(100),@bearingsType varchar(100),@thrustBearing varchar(100),
		@drivenBy1 varchar(100) = null
		Declare @drivenlocations int, @id int
		Declare @rotorOverhung  varchar(10),@attachedOilPump  varchar(10),@impellerOnMainShaft  varchar(10),@crankHasIntermediateBearing  varchar(10),
		@fanStages  varchar(10),@exciter  varchar(10),@centrifugalPumpHasBallBearings  varchar(10),@propellerpumpHasBallBearings  varchar(10),
		@rotaryThreadPumpHasBallBearings  varchar(10), @gearPumpHasBallBearings  varchar(10),@screwPumpHasBallBearings  varchar(10),
		@slidingVanePumpHasBallBearings  varchar(10), @axialRecipPumpHasBallBearings  varchar(10),@centrifugalCompressorHasBallBearings  varchar(10),
		@reciprocatingCompressorHasBallBearings  varchar(10),@screwCompressorHasBallBearings  varchar(10),@screwTwinCompressorHasBallBearingsOnHPSide  varchar(10),
		@lobedFanOrBlowerHasBallBearings  varchar(10),@overhungRotorFanOrBlowerHasBearings  varchar(10), @supportedRotorFanOrBlowerHasBearings  varchar(10)
		--Declare variable for driven component --


		--- Read xml for driven component --
		select @Id = id,
		@drivencomponentType = Case when componentType = '' then null else componentType end,
		@drivenType = Case when drivenType = '' then null else drivenType end, 
		@pumpType = Case when pumpType = ''  then null else pumpType end,
		@compressorType = Case when compressorType = ''  then null else compressorType end,
		@fan_or_blowerType = Case when fan_or_blowerType = ''  then null else fan_or_blowerType end ,
		@purifierDrivenBy = Case when purifierDrivenBy = ''  then null else purifierDrivenBy end,
		@bearingType = Case when bearingType = ''  then null else bearingType end,
		@vacuumPumpType = Case when vacuumpumptype = ''  then null else vacuumpumptype end,
		@exciterOverhungOrSupported = Case when exciterOverhungOrSupported = '' then null else exciterOverhungOrSupported end ,
		@bearingsType = Case when bearingsType = '' then null else bearingsType end,
		@thrustBearing = Case when thrustBearing = '' then null else thrustBearing end ,
		@drivenBy1 = Case when drivenBy = '' then null else drivenBy end ,
		@drivenlocations = Case when locations = ''  then null else locations end,
		@rotorOverhung = Case when rotorOverhung = '' then null else rotorOverhung end ,
		@attachedOilPump = Case when attachedOilPump = '' then null else attachedOilPump end ,
		@impellerOnMainShaft = Case when impellerOnMainShaft = '' then null else impellerOnMainShaft end  ,
		@crankHasIntermediateBearing = Case when crankHasIntermediateBearing = '' then null else crankHasIntermediateBearing end ,
		@fanStages = Case when fanStages = '' then null else fanStages end ,
		@exciter = Case when exciter = '' then null else exciter end  ,
		@centrifugalPumpHasBallBearings = Case when centrifugalPumpHasBallBearings = '' then null else centrifugalPumpHasBallBearings end  ,
		@propellerpumpHasBallBearings = Case when propellerpumpHasBallBearings = '' then null else propellerpumpHasBallBearings end ,
		@rotaryThreadPumpHasBallBearings = Case when rotaryThreadPumpHasBallBearings = '' then null else rotaryThreadPumpHasBallBearings end  , 
		@gearPumpHasBallBearings = Case when gearPumpHasBallBearings = '' then null else gearPumpHasBallBearings end ,
		@screwPumpHasBallBearings = Case when screwPumpHasBallBearings = '' then null else screwPumpHasBallBearings end ,
		@slidingVanePumpHasBallBearings = Case when slidingVanePumpHasBallBearings = '' then null else slidingVanePumpHasBallBearings end , 
		@axialRecipPumpHasBallBearings = Case when axialRecipPumpHasBallBearings = '' then null else axialRecipPumpHasBallBearings end ,
		@centrifugalCompressorHasBallBearings = Case when centrifugalCompressorHasBallBearings = '' then null else centrifugalCompressorHasBallBearings end ,
		@reciprocatingCompressorHasBallBearings = Case when reciprocatingCompressorHasBallBearings = '' then null else reciprocatingCompressorHasBallBearings end ,
		@screwCompressorHasBallBearings = Case when screwCompressorHasBallBearings = '' then null else screwCompressorHasBallBearings end ,
		@screwTwinCompressorHasBallBearingsOnHPSide = Case when screwTwinCompressorHasBallBearingsOnHPSide = '' then null else screwTwinCompressorHasBallBearingsOnHPSide end  ,
		@lobedFanOrBlowerHasBallBearings = Case when lobedFanOrBlowerHasBallBearings = '' then null else lobedFanOrBlowerHasBallBearings end ,
		@overhungRotorFanOrBlowerHasBearings = Case when overhungRotorFanOrBlowerHasBearings = '' then null else overhungRotorFanOrBlowerHasBearings end  ,
		@supportedRotorFanOrBlowerHasBearings = Case when supportedRotorFanOrBlowerHasBearings = '' then null else supportedRotorFanOrBlowerHasBearings end  
		FROM OPENXML (@xmlDocumentHandle, 'DrivenDetails',2)
		WITH (id bigint,componentType varchar(100),drivenType varchar(100),pumpType varchar(100),compressorType varchar(1000),
		fan_or_blowerType varchar(1000),purifierDrivenBy varchar(100),bearingType varchar(100),vacuumpumptype varchar(100),
		exciterOverhungOrSupported varchar(100),bearingsType varchar(100),thrustBearing varchar(100),drivenBy varchar(100),
		locations int,rotorOverhung  varchar(10),attachedOilPump  varchar(10),impellerOnMainShaft  varchar(10),crankHasIntermediateBearing  varchar(10),
		fanStages  varchar(10),exciter  varchar(10),centrifugalPumpHasBallBearings  varchar(10),propellerpumpHasBallBearings  varchar(10),
		rotaryThreadPumpHasBallBearings  varchar(10), gearPumpHasBallBearings  varchar(10),screwPumpHasBallBearings  varchar(10),
		slidingVanePumpHasBallBearings  varchar(10), axialRecipPumpHasBallBearings  varchar(10),centrifugalCompressorHasBallBearings  varchar(10),
		reciprocatingCompressorHasBallBearings  varchar(10),screwCompressorHasBallBearings  varchar(10),screwTwinCompressorHasBallBearingsOnHPSide  varchar(10),
		lobedFanOrBlowerHasBallBearings  varchar(10),overhungRotorFanOrBlowerHasBearings  varchar(10), supportedRotorFanOrBlowerHasBearings  varchar(10))
		--- Read xml for driven component --

		if(@id = 0 )
		Begin
			select * from master.tblDrivenDetails
			WHERE isDeleted = 0 
				and 
				ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @drivencomponentType = '' Or @drivencomponentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@drivencomponentType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(drivenType))),'X') = 
				Case when @drivenType = '' Or @drivenType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@drivenType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(pumpType))),'X') = 
				Case when @pumpType = '' Or @pumpType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@pumpType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(compressorType))),'X') = 
				Case when @compressorType = '' Or @compressorType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@compressorType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(fan_or_blowerType))),'X') = 
					Case when @fan_or_blowerType = '' Or @fan_or_blowerType IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@fan_or_blowerType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(purifierDrivenBy))),'X') = 
					Case when @purifierDrivenBy = '' Or @purifierDrivenBy IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@purifierDrivenBy))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(bearingType))),'X') = 
					Case when @bearingType = '' Or @bearingType IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@bearingType))) end
				and
				ISNULL(UPPER(RTRIM(LTRIM(vacuumpumptype))),'X') = 
					Case when @vacuumPumpType = '' Or @vacuumPumpType IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@vacuumPumpType))) end
				and
				ISNULL(UPPER(RTRIM(LTRIM(exciterOverhungOrSupported))),'X') = 
					Case when @exciterOverhungOrSupported = '' Or @exciterOverhungOrSupported IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@exciterOverhungOrSupported))) end
				and
				ISNULL(UPPER(RTRIM(LTRIM(bearingsType))),'X') = 
					Case when @bearingsType = '' Or @bearingsType IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@bearingsType))) end
				and
				ISNULL(UPPER(RTRIM(LTRIM(thrustBearing))),'X') = 
					Case when @thrustBearing = '' Or @thrustBearing IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@thrustBearing))) end
				and
				ISNULL(UPPER(RTRIM(LTRIM(drivenBy))),'X') = 
					Case when @drivenBy1 = '' Or @drivenBy1 IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@drivenBy1))) end
				and
				ISNULL(Convert(varchar(10),locations),'X') = 
					Case when @drivenlocations = '' Or @drivenlocations IS NULL then 'X'
					else convert(varchar(10),@drivenlocations) end 
				and
				ISNULL(Convert(varchar(10),rotorOverhung),'X') = 
					Case when @rotorOverhung IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@rotorOverhung)) end 
				and
				ISNULL(Convert(varchar(10),attachedOilPump),'X') = 
					Case when @attachedOilPump IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@attachedOilPump)) end 
				and
				ISNULL(Convert(varchar(10),impellerOnMainShaft),'X') = 
					Case when @impellerOnMainShaft IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@impellerOnMainShaft)) end 
				and
				ISNULL(Convert(varchar(10),crankHasIntermediateBearing),'X') = 
					Case when @crankHasIntermediateBearing IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@crankHasIntermediateBearing)) end 
				and
				ISNULL(Convert(varchar(10),fanStages),'X') = 
					Case when @fanStages IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@fanStages)) end
				and
				ISNULL(Convert(varchar(10),exciter),'X') = 
					Case when @exciter IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@exciter)) end
				and
				ISNULL(Convert(varchar(10),centrifugalPumpHasBallBearings),'X') = 
					Case when @centrifugalPumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@centrifugalPumpHasBallBearings)) end 
				and
				ISNULL(Convert(varchar(10),propellerpumpHasBallBearings),'X') = 
					Case when @propellerpumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@propellerpumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),rotaryThreadPumpHasBallBearings),'X') = 
					Case when @rotaryThreadPumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@rotaryThreadPumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),gearPumpHasBallBearings),'X') = 
					Case when @gearPumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@gearPumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),screwPumpHasBallBearings),'X') = 
					Case when @screwPumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@screwPumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),slidingVanePumpHasBallBearings),'X') = 
					Case when @slidingVanePumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@slidingVanePumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),axialRecipPumpHasBallBearings),'X') = 
					Case when @axialRecipPumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@axialRecipPumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),centrifugalCompressorHasBallBearings),'X') = 
					Case when @centrifugalCompressorHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@centrifugalCompressorHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),reciprocatingCompressorHasBallBearings),'X') = 
					Case when @reciprocatingCompressorHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@reciprocatingCompressorHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),screwCompressorHasBallBearings),'X') = 
					Case when @screwCompressorHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@screwCompressorHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),screwTwinCompressorHasBallBearingsOnHPSide),'X') = 
					Case when @screwTwinCompressorHasBallBearingsOnHPSide IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@screwTwinCompressorHasBallBearingsOnHPSide)) end
				and
				ISNULL(Convert(varchar(10),lobedFanOrBlowerHasBallBearings),'X') = 
					Case when @lobedFanOrBlowerHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@lobedFanOrBlowerHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),overhungRotorFanOrBlowerHasBearings),'X') = 
					Case when @overhungRotorFanOrBlowerHasBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@overhungRotorFanOrBlowerHasBearings)) end
				and
				ISNULL(Convert(varchar(10),supportedRotorFanOrBlowerHasBearings),'X') = 
					Case when @supportedRotorFanOrBlowerHasBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@supportedRotorFanOrBlowerHasBearings)) end
			End
		else
			Begin
				select * from master.tblDrivenDetails
				WHERE isDeleted = 0 and id <> @id
				and 
				ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @drivencomponentType = '' Or @drivencomponentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@drivencomponentType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(drivenType))),'X') = 
				Case when @drivenType = '' Or @drivenType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@drivenType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(pumpType))),'X') = 
				Case when @pumpType = '' Or @pumpType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@pumpType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(compressorType))),'X') = 
				Case when @compressorType = '' Or @compressorType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@compressorType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(fan_or_blowerType))),'X') = 
					Case when @fan_or_blowerType = '' Or @fan_or_blowerType IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@fan_or_blowerType))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(purifierDrivenBy))),'X') = 
					Case when @purifierDrivenBy = '' Or @purifierDrivenBy IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@purifierDrivenBy))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(bearingType))),'X') = 
					Case when @bearingType = '' Or @bearingType IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@bearingType))) end
				and
				ISNULL(UPPER(RTRIM(LTRIM(vacuumPumpType))),'X') = 
					Case when @vacuumPumpType = '' Or @vacuumPumpType IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@vacuumPumpType))) end
				and
				ISNULL(UPPER(RTRIM(LTRIM(exciterOverhungOrSupported))),'X') = 
					Case when @exciterOverhungOrSupported = '' Or @exciterOverhungOrSupported IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@exciterOverhungOrSupported))) end
				and
				ISNULL(UPPER(RTRIM(LTRIM(bearingsType))),'X') = 
					Case when @bearingsType = '' Or @bearingsType IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@bearingsType))) end
				and
				ISNULL(UPPER(RTRIM(LTRIM(thrustBearing))),'X') = 
					Case when @thrustBearing = '' Or @thrustBearing IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@thrustBearing))) end
				and
				ISNULL(UPPER(RTRIM(LTRIM(drivenBy))),'X') = 
					Case when @drivenBy1 = '' Or @drivenBy1 IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@drivenBy1))) end
				and
				ISNULL(Convert(varchar(10),locations),'X') = 
					Case when @drivenlocations = '' Or @drivenlocations IS NULL then 'X'
					else convert(varchar(10),@drivenlocations) end 
				and
				ISNULL(Convert(varchar(10),rotorOverhung),'X') = 
					Case when @rotorOverhung IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@rotorOverhung)) end 
				and
				ISNULL(Convert(varchar(10),attachedOilPump),'X') = 
					Case when @attachedOilPump IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@attachedOilPump)) end 
				and
				ISNULL(Convert(varchar(10),impellerOnMainShaft),'X') = 
					Case when @impellerOnMainShaft IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@impellerOnMainShaft)) end 
				and
				ISNULL(Convert(varchar(10),crankHasIntermediateBearing),'X') = 
					Case when @crankHasIntermediateBearing IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@crankHasIntermediateBearing)) end 
				and
				ISNULL(Convert(varchar(10),fanStages),'X') = 
					Case when @fanStages IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@fanStages)) end
				and
				ISNULL(Convert(varchar(10),exciter),'X') = 
					Case when @exciter IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@exciter)) end
				and
				ISNULL(Convert(varchar(10),centrifugalPumpHasBallBearings),'X') = 
					Case when @centrifugalPumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@centrifugalPumpHasBallBearings)) end 
				and
				ISNULL(Convert(varchar(10),propellerpumpHasBallBearings),'X') = 
					Case when @propellerpumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@propellerpumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),rotaryThreadPumpHasBallBearings),'X') = 
					Case when @rotaryThreadPumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@rotaryThreadPumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),gearPumpHasBallBearings),'X') = 
					Case when @gearPumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@gearPumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),screwPumpHasBallBearings),'X') = 
					Case when @screwPumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@screwPumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),slidingVanePumpHasBallBearings),'X') = 
					Case when @slidingVanePumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@slidingVanePumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),axialRecipPumpHasBallBearings),'X') = 
					Case when @axialRecipPumpHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@axialRecipPumpHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),centrifugalCompressorHasBallBearings),'X') = 
					Case when @centrifugalCompressorHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@centrifugalCompressorHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),reciprocatingCompressorHasBallBearings),'X') = 
					Case when @reciprocatingCompressorHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@reciprocatingCompressorHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),screwCompressorHasBallBearings),'X') = 
					Case when @screwCompressorHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@screwCompressorHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),screwTwinCompressorHasBallBearingsOnHPSide),'X') = 
					Case when @screwTwinCompressorHasBallBearingsOnHPSide IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@screwTwinCompressorHasBallBearingsOnHPSide)) end
				and
				ISNULL(Convert(varchar(10),lobedFanOrBlowerHasBallBearings),'X') = 
					Case when @lobedFanOrBlowerHasBallBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@lobedFanOrBlowerHasBallBearings)) end
				and
				ISNULL(Convert(varchar(10),overhungRotorFanOrBlowerHasBearings),'X') = 
					Case when @overhungRotorFanOrBlowerHasBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@overhungRotorFanOrBlowerHasBearings)) end
				and
				ISNULL(Convert(varchar(10),supportedRotorFanOrBlowerHasBearings),'X') = 
					Case when @supportedRotorFanOrBlowerHasBearings IS NULL then 'X'
					else convert(varchar(10),Convert(bit,@supportedRotorFanOrBlowerHasBearings)) end
			End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetDrivenDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <28/04/2021>
-- Description: <SP used for get driven details by id>
-- =============================================
Create PROCEDURE [dbo].[spGetDrivenDetailsById]
(
   @id bigint
)
AS
BEGIN
	select * from master.tblDrivenDetails where id = @id and isDeleted = 0
End
GO
/****** Object:  StoredProcedure [dbo].[spGetDriverDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --=============================================
 --Author:      <Vishal Dhure>
-- Create Date: <27/04/2021>
-- Description: <SP used for get driver component data>
-- =============================================
CREATE PROCEDURE [dbo].[spGetDriverDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN

--  Declare  @xmlInput xml = ''
--  set @xmlInput = '<?xml version="1.0"?>
--<DriverDetails xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>211</id>
--  <componentType>driverVishal</componentType>
--  <locations>1</locations>
--  <driverType>diesel</driverType>
--  <cylinders>2</cylinders>
--  <motorFan xsi:nil="true" />
--  <motorBallBearings xsi:nil="true" />
--  <drivenBallBearings xsi:nil="true" />
--  <drivenBalanceable xsi:nil="true" />
--  <mortorPoles xsi:nil="true" />
--  <turbineReductionGear xsi:nil="true" />
--  <turbineRotorSupported xsi:nil="true" />
--  <turbineBallBearing xsi:nil="true" />
--  <turbineThrustBearing xsi:nil="true" />
--  <turbineThrustBearingIsBall xsi:nil="true" />
--  <componentCode xsi:nil="true" />
--</DriverDetails>'
	
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		--Declare variable for driver component --
		Declare @componentType varchar(100),@driverType varchar(100),@motorDrive varchar(100)
		Declare @locations int,@cylinders int,@mortorPoles int, @id int
		Declare @motorFan varchar(10),@motorBallBearings  varchar(10),@drivenBallBearings  varchar(10),@drivenBalanceable  varchar(10),
		@turbineReductionGear  varchar(10),@turbineRotorSupported  varchar(10),@turbineBallBearing  varchar(10),@turbineThrustBearing  varchar(10),
		@turbineThrustBearingIsBall  varchar(10)
		--Declare variable for driver component --

		--- Read xml for driver component --
		select @Id = id, @componentType = componentType,@driverType = driverType, @motorDrive = motorDrive,
		@locations = locations,@cylinders = cylinders,@mortorPoles = mortorPoles,
		@motorFan = Case when motorFan = '' then null else motorFan end ,
		@motorBallBearings = Case when motorBallBearings = '' then null else motorBallBearings end ,
		@drivenBallBearings = Case when drivenBallBearings = '' then null else drivenBallBearings end,
		@drivenBalanceable = Case when drivenBalanceable = '' then null else drivenBalanceable end ,
		@turbineReductionGear = Case when turbineReductionGear = '' then null else turbineReductionGear end ,
		@turbineRotorSupported = Case when turbineRotorSupported = '' then null else turbineRotorSupported end ,
		@turbineBallBearing = Case when turbineBallBearing = '' then null else turbineBallBearing end ,
		@turbineThrustBearing = Case when turbineThrustBearing = '' then null else turbineThrustBearing end , 
		@turbineThrustBearingIsBall = Case when turbineThrustBearingIsBall = '' then null else turbineThrustBearingIsBall end  
		FROM OPENXML (@xmlDocumentHandle, 'DriverDetails',2)
		WITH (id bigint,componentType varchar(100),locations int,driverType varchar(100),cylinders int,motorDrive varchar(100),motorFan varchar(10),
		motorBallBearings  varchar(10),drivenBallBearings  varchar(10),drivenBalanceable  varchar(10),mortorPoles int,turbineReductionGear  varchar(10),
		turbineRotorSupported  varchar(10),turbineBallBearing  varchar(10),turbineThrustBearing  varchar(10),turbineThrustBearingIsBall  varchar(10))
		--- Read xml for driver component --

		if(@id = 0 )
		Begin
			select * from master.tblDriverDetails
			WHERE isDeleted = 0 
				and 
				ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @componentType = '' Or @componentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@componentType))) end 
				and 
				ISNULL(locations,'0') = 
				Case when @locations = '' Or @locations IS NULL then '0'
				else @locations end
				and
				ISNULL(UPPER(RTRIM(LTRIM(driverType))),'X') = 
				Case when @driverType = '' Or @driverType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@driverType))) end 
				and
				ISNULL(Convert(varchar(10),cylinders),'X') = 
				Case when @cylinders = '' Or @cylinders IS NULL then 'X'
				else convert(varchar(10),@cylinders) end 
				and
				ISNULL(Convert(varchar(10),UPPER(RTRIM(LTRIM(motorDrive)))),'X') = 
				Case when @motorDrive = '' Or @motorDrive IS NULL then 'X'
				else convert(varchar(10),UPPER(RTRIM(LTRIM(@motorDrive)))) end 
				and
				ISNULL(Convert(varchar(10),motorFan),'X') = 
				Case when @motorFan IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@motorFan)) end 
				and
				ISNULL(Convert(varchar(10),motorBallBearings),'X') = 
				Case when @motorBallBearings IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@motorBallBearings)) end 
				and
				ISNULL(Convert(varchar(10),drivenBallBearings),'X') = 
				Case when @drivenBallBearings IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@drivenBallBearings)) end 
				and 
				ISNULL(Convert(varchar(10),drivenBalanceable),'X') = 
				Case when @drivenBalanceable IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@drivenBalanceable)) end 
				and
				ISNULL(convert(varchar(10),mortorPoles),'X') = 
				Case when @mortorPoles = '' Or @mortorPoles IS NULL then 'X'
				else convert(varchar(10),@mortorPoles) end
				and
				ISNULL(Convert(varchar(10),turbineReductionGear),'X') = 
				Case when @turbineReductionGear IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@turbineReductionGear)) end 
				and
				ISNULL(Convert(varchar(10),turbineRotorSupported),'X') = 
				Case when @turbineRotorSupported IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@turbineRotorSupported)) end 
				and
				ISNULL(Convert(varchar(10),turbineBallBearing),'X') = 
				Case when 
				@turbineBallBearing IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@turbineBallBearing)) end 
				and
				ISNULL(Convert(varchar(10),turbineThrustBearing),'X') = 
				Case when @turbineThrustBearing IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@turbineThrustBearing)) end 
				and
				ISNULL(Convert(varchar(10),turbineThrustBearingIsBall),'X') = 
				Case when @turbineThrustBearingIsBall IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@turbineThrustBearingIsBall)) end 
			End
		else
			Begin
				select * from master.tblDriverDetails
				WHERE isDeleted = 0 and id <> @id
				and 
				ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @componentType = '' Or @componentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@componentType))) end 
				and 
				ISNULL(locations,'0') = 
				Case when @locations = '' Or @locations IS NULL then '0'
				else @locations end
				and
				ISNULL(UPPER(RTRIM(LTRIM(driverType))),'X') = 
				Case when @driverType = '' Or @driverType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@driverType))) end 
				and
				ISNULL(Convert(varchar(10),cylinders),'X') = 
				Case when @cylinders = '' Or @cylinders IS NULL then 'X'
				else convert(varchar(10),@cylinders) end 
				and
				ISNULL(Convert(varchar(10),UPPER(RTRIM(LTRIM(motorDrive)))),'X') = 
				Case when @motorDrive = '' Or @motorDrive IS NULL then 'X'
				else convert(varchar(10),UPPER(RTRIM(LTRIM(@motorDrive)))) end 
				and
				ISNULL(Convert(varchar(10),motorFan),'X') = 
				Case when @motorFan IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@motorFan)) end 
				and
				ISNULL(Convert(varchar(10),motorBallBearings),'X') = 
				Case when @motorBallBearings IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@motorBallBearings)) end 
				and
				ISNULL(Convert(varchar(10),drivenBallBearings),'X') = 
				Case when @drivenBallBearings IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@drivenBallBearings)) end 
				and 
				ISNULL(Convert(varchar(10),drivenBalanceable),'X') = 
				Case when @drivenBalanceable IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@drivenBalanceable)) end 
				and
				ISNULL(convert(varchar(10),mortorPoles),'X') = 
				Case when @mortorPoles = '' Or @mortorPoles IS NULL then 'X'
				else convert(varchar(10),@mortorPoles) end
				and
				ISNULL(Convert(varchar(10),turbineReductionGear),'X') = 
				Case when @turbineReductionGear IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@turbineReductionGear)) end 
				and
				ISNULL(Convert(varchar(10),turbineRotorSupported),'X') = 
				Case when @turbineRotorSupported IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@turbineRotorSupported)) end 
				and
				ISNULL(Convert(varchar(10),turbineBallBearing),'X') = 
				Case when 
				@turbineBallBearing IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@turbineBallBearing)) end 
				and
				ISNULL(Convert(varchar(10),turbineThrustBearing),'X') = 
				Case when @turbineThrustBearing IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@turbineThrustBearing)) end 
				and
				ISNULL(Convert(varchar(10),turbineThrustBearingIsBall),'X') = 
				Case when @turbineThrustBearingIsBall IS NULL then 'X'
				else convert(varchar(10),Convert(bit,@turbineThrustBearingIsBall)) end 
			End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetDriverDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <27/04/2021>
-- Description: <SP used for get driver details by id>
-- =============================================
CREATE PROCEDURE [dbo].[spGetDriverDetailsById]
(
   @id bigint
)
AS
BEGIN
	select * from master.tblDriverDetails where id = @id and isDeleted = 0
End
GO
/****** Object:  StoredProcedure [dbo].[spGetIntermediateDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --=============================================
 --Author:      <Vishal Dhure>
-- Create Date: <29/04/2021>
-- Description: <SP used for get intermediate component data>
-- =============================================
CREATE PROCEDURE [dbo].[spGetIntermediateDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN

--  Declare  @xmlInput xml = ''
--  set @xmlInput = '<?xml version="1.0"?>
--<IntermediateDetails xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>0</id>
--  <componentType>vishal0335</componentType>
--  <locations xsi:nil="true" />
--  <speedChangesMax xsi:nil="true" />
--  <componentCode>0.0</componentCode>
--</IntermediateDetails>'
	
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		--Declare variable for intermediate component --
		Declare @id bigint, @intercomponentType varchar(100),@intermediateType varchar(100), 
		@drivenBy varchar(100),@inputBearing int ,@intermediateBearing1st varchar(1000),
		@intermediateBearing2nd varchar(1000),@outputBearing varchar(1000)
		Declare @speedChangesMax int,@interlocations int--, @gearBoxLocations int
		--Declare variable for intermediate component --

		--- Read xml for intermediate component --
		select @id= id, @intercomponentType = componentType,@intermediateType = intermediateType, 
		@drivenBy = drivenBy,@inputBearing = inputBearing,@intermediateBearing1st = intermediateBearing1st,
		@intermediateBearing2nd = intermediateBearing2nd,@outputBearing = outputBearing,
		@speedChangesMax = speedChangesMax,@interlocations = locations--, @gearBoxLocations = gearBoxLocations 
		FROM OPENXML (@xmlDocumentHandle, 'IntermediateDetails',2)
		WITH (id bigint,componentType varchar(100),intermediateType varchar(100), 
		drivenBy varchar(100),inputBearing int ,intermediateBearing1st varchar(1000),
		intermediateBearing2nd varchar(1000),outputBearing varchar(1000),speedChangesMax int,
		locations int)
		--- Read xml for intermediate component --

		if(@id = 0 )
		Begin
			select * from master.tblIntermediateDetails
			WHERE isDeleted = 0 and 
			ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @intercomponentType = '' Or @intercomponentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intercomponentType))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(intermediateType))),'X') = 
				Case when @intermediateType = '' Or @intermediateType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intermediateType))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(drivenBy))),'X') = 
				Case when @drivenBy = '' Or @drivenBy IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@drivenBy))) end 
			and
			
			ISNULL(speedChangesMax,0) = 
				Case when @speedChangesMax = '' Or @speedChangesMax IS NULL then 0
				else @speedChangesMax end 
			and 
			ISNULL(locations,0) = 
				Case when @interlocations = '' Or @interlocations IS NULL then 0
				else @interlocations end

			End
		else
			Begin
				select * from master.tblIntermediateDetails
				WHERE isDeleted = 0 and id <> @id and 
			ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @intercomponentType = '' Or @intercomponentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intercomponentType))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(intermediateType))),'X') = 
				Case when @intermediateType = '' Or @intermediateType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intermediateType))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(drivenBy))),'X') = 
				Case when @drivenBy = '' Or @drivenBy IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@drivenBy))) end 
			and
			
			ISNULL(speedChangesMax,0) = 
				Case when @speedChangesMax = '' Or @speedChangesMax IS NULL then 0
				else @speedChangesMax end 
			and 
			ISNULL(locations,0) = 
				Case when @interlocations = '' Or @interlocations IS NULL then 0
				else @interlocations end 
			End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetIntermediateDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <29/04/2021>
-- Description: <SP used for get Intermediate details by id>
-- =============================================
Create PROCEDURE [dbo].[spGetIntermediateDetailsById]
(
   @id bigint
)
AS
BEGIN
	select * from master.tblIntermediateDetails where id = @id and isDeleted = 0
End
GO
/****** Object:  StoredProcedure [dbo].[spGetPickupCodeDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --=============================================
 --Author:      <Vishal Dhure>
-- Create Date: <11/05/2021>
-- Description: <SP used for get Pickup Code data>
-- =============================================
CREATE PROCEDURE [dbo].[spGetPickupCodeDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN

--  Declare  @xmlInput xml = ''
--  set @xmlInput = '<?xml version="1.0"?>
--<PickupCodeDetails xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <id>0</id>
--  <driverLocations>10</driverLocations>
--  <driverLocationNDE>false</driverLocationNDE>
--  <driverLocationDE>false</driverLocationDE>
--  <intermediateLocations>0</intermediateLocations>
--  <intermediatepresent>false</intermediatepresent>
--  <drivenLocations>0</drivenLocations>
--  <drivenLocationDE>false</drivenLocationDE>
--  <drivenLocationNDE>false</drivenLocationNDE>
--</PickupCodeDetails>'
	
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		--Declare variable for PickupCode  --
		Declare @Id int,@driverLocations int,@driverLocationNDE bit,@driverLocationDE bit,
	    @intermediateLocations int,@intermediatepresent bit,@drivenLocations int,@drivenLocationDE bit,
		@drivenLocationNDE bit,@driverPickupCode varchar(50),@coupling1PickupCode varchar(50),@intermediatePickupCode varchar(50),
	    @coupling2PickupCode varchar(50),@drivenPickupCode varchar(50)
		--Declare variable for PickupCode  --

		--- Read xml for PickupCode  --
		select @Id = id,
		@driverLocations = Case when driverLocations  = '' then null else driverLocations end ,
		@driverLocationNDE = Case when driverLocationNDE  = '' then null else driverLocationNDE end ,
		@driverLocationDE = Case when driverLocationDE  = '' then null else driverLocationDE end ,
		@intermediateLocations = Case when intermediateLocations  = '' then null else intermediateLocations end,
		@intermediatepresent = Case when intermediatepresent  = '' then null else intermediatepresent end,
		@drivenLocations = Case when drivenLocations  = '' then null else drivenLocations end ,
		@drivenLocationDE = Case when drivenLocationDE  = '' then null else drivenLocationDE end,
		@drivenLocationNDE = Case when drivenLocationNDE  = '' then null else drivenLocationNDE end ,
		@driverPickupCode = Case when driverPickupCode = '' then null else driverPickupCode end ,
		@coupling1PickupCode = Case when coupling1PickupCode = '' then null else coupling1PickupCode end,
		@intermediatePickupCode = Case when intermediatePickupCode = '' then null else intermediatePickupCode end,
		@coupling2PickupCode = Case when coupling2PickupCode = '' then null else coupling2PickupCode end ,
		@drivenPickupCode = Case when drivenPickupCode = '' then null else drivenPickupCode end 
		FROM OPENXML (@xmlDocumentHandle, 'PickupCodeDetails',2)
		WITH (id int,driverLocations int,driverLocationNDE bit,driverLocationDE bit,
	    intermediateLocations int,intermediatepresent bit,drivenLocations int,drivenLocationDE bit,
		drivenLocationNDE bit,driverPickupCode varchar(50),coupling1PickupCode varchar(50),intermediatePickupCode varchar(50),
	    coupling2PickupCode varchar(50),drivenPickupCode varchar(50))	
		
		if(@id = 0 )
		Begin
				select * from master.tblPickupCodeDetails
				WHERE isDeleted = 0 
				and 
				ISNULL(driverLocations,0) = 
				Case when @driverLocations = '' Or @driverLocations IS NULL then 0
				else @driverLocations end 
				and
				ISNULL(driverLocationNDE,Convert(bit,0)) = 
				Case when @driverLocationNDE = '' Or @driverLocationNDE IS NULL then Convert(bit,0)
				else @driverLocationNDE end 
				and
				ISNULL(driverLocationDE,Convert(bit,0)) = 
				Case when @driverLocationDE = '' Or @driverLocationDE IS NULL then Convert(bit,0)
				else @driverLocationDE end 
				and
				ISNULL(intermediateLocations,0) = 
				Case when @intermediateLocations = '' Or @intermediateLocations IS NULL then 0
				else @intermediateLocations end 
				and
				ISNULL(intermediatepresent,Convert(bit,0)) = 
				Case when @intermediatepresent = '' Or @intermediatepresent IS NULL then Convert(bit,0)
				else @intermediatepresent end 
				and
				ISNULL(drivenLocations,0) = 
				Case when @drivenLocations = '' Or @drivenLocations IS NULL then 0
				else @drivenLocations end 
				and
				ISNULL(drivenLocationDE,Convert(bit,0)) = 
				Case when @drivenLocationDE = '' Or @drivenLocationDE IS NULL then Convert(bit,0)
				else @drivenLocationDE end 
				and
				ISNULL(drivenLocationNDE,Convert(bit,0)) = 
				Case when @drivenLocationNDE = '' Or @drivenLocationNDE IS NULL then Convert(bit,0)
				else @drivenLocationNDE end 
				
			End
		else
			Begin
				select * from master.tblPickupCodeDetails
				WHERE isDeleted = 0 and id <> @id
				and 
				ISNULL(driverLocations,0) = 
				Case when @driverLocations = '' Or @driverLocations IS NULL then 0
				else @driverLocations end 
				and
				ISNULL(driverLocationNDE,Convert(bit,0)) = 
				Case when @driverLocationNDE = '' Or @driverLocationNDE IS NULL then Convert(bit,0)
				else @driverLocationNDE end 
				and
				ISNULL(driverLocationDE,Convert(bit,0)) = 
				Case when @driverLocationDE = '' Or @driverLocationDE IS NULL then Convert(bit,0)
				else @driverLocationDE end 
				and
				ISNULL(intermediateLocations,0) = 
				Case when @intermediateLocations = '' Or @intermediateLocations IS NULL then 0
				else @intermediateLocations end 
				and
				ISNULL(intermediatepresent,Convert(bit,0)) = 
				Case when @intermediatepresent = '' Or @intermediatepresent IS NULL then Convert(bit,0)
				else @intermediatepresent end 
				and
				ISNULL(drivenLocations,0) = 
				Case when @drivenLocations = '' Or @drivenLocations IS NULL then 0
				else @drivenLocations end 
				and
				ISNULL(drivenLocationDE,Convert(bit,0)) = 
				Case when @drivenLocationDE = '' Or @drivenLocationDE IS NULL then Convert(bit,0)
				else @drivenLocationDE end 
				and
				ISNULL(drivenLocationNDE,Convert(bit,0)) = 
				Case when @drivenLocationNDE = '' Or @drivenLocationNDE IS NULL then Convert(bit,0)
				else @drivenLocationNDE end 
			End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetPickupCodeDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <11/05/2021>
-- Description: <SP used for get Pickup code details by id>
-- =============================================
CREATE PROCEDURE [dbo].[spGetPickupCodeDetailsById]
(
   @id bigint
)
AS
BEGIN
	select * from master.tblPickupCodeDetails where id = @id and isDeleted = 0
End
GO
/****** Object:  StoredProcedure [dbo].[spGetSpecialFaultCodesDetails]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --=============================================
 --Author:      <Vishal Dhure>
-- Create Date: <30/04/2021>
-- Description: <SP used for get special fault codes details>
-- =============================================
CREATE PROCEDURE [dbo].[spGetSpecialFaultCodesDetails]
(
   @xmlInput xml = ''
)
AS
BEGIN
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		Declare @id bigint,@specialmultiple int
		Declare @specialfaultcodetype varchar(50),@specialcode varchar(50)

		--- Read xml for SpecialFaultCodesDetails component --
		select @id = id, 
		@specialfaultcodetype = specialfaultcodetype,
		@specialmultiple = specialmultiple ,
		@specialcode = specialcode 
		FROM OPENXML (@xmlDocumentHandle, 'SpecialFaultCodesDetails',2)
		WITH (id bigint,specialmultiple int,specialfaultcodetype varchar(100),specialcode varchar(100))
		--- Read xml for SpecialFaultCodesDetails component --

		if(@id = 0 )
		Begin
				select * from master.tblSpecialFaultCodesDetails
				WHERE isDeleted = 0 
				and 
				ISNULL(UPPER(RTRIM(LTRIM(specialfaultcodetype))),'X') = 
				Case when @specialfaultcodetype = '' Or @specialfaultcodetype IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@specialfaultcodetype))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(specialcode))),'X') = 
				Case when @specialcode = '' Or @specialcode IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@specialcode))) end 
				and
				ISNULL(specialmultiple,0) = 
				Case when @specialmultiple = '' Or @specialmultiple IS NULL then 0
				else @specialmultiple end 
			End
		else
			Begin
				select * from master.tblSpecialFaultCodesDetails
				WHERE isDeleted = 0 and id <> @id
				and 
				ISNULL(UPPER(RTRIM(LTRIM(specialfaultcodetype))),'X') = 
				Case when @specialfaultcodetype = '' Or @specialfaultcodetype IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@specialfaultcodetype))) end 
				and
				ISNULL(UPPER(RTRIM(LTRIM(specialcode))),'X') = 
				Case when @specialcode = '' Or @specialcode IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@specialcode))) end 
				and
				ISNULL(specialmultiple,0) = 
				Case when @specialmultiple = '' Or @specialmultiple IS NULL then 0
				else @specialmultiple end 
			End
END
GO
/****** Object:  StoredProcedure [dbo].[spGetSpecialFaultCodesDetailsById]    Script Date: 19-05-2021 12:47:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <05/05/2021>
-- Description: <SP used for get SpecialFaultCodes details by id>
-- =============================================
Create PROCEDURE [dbo].[spGetSpecialFaultCodesDetailsById]
(
   @id bigint
)
AS
BEGIN
	select * from master.tblSpecialFaultCodesDetails where id = @id and isDeleted = 0
End
GO
ALTER DATABASE [midderivationlibrarycodes] SET  READ_WRITE 
GO
