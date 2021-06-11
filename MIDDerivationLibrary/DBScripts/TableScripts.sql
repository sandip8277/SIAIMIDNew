
--====================================tblCoupling1Details==========================================================

/****** Object:  Table [master].[tblCoupling1Details]    Script Date: 19-05-2021 18:32:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[master].[tblCoupling1Details]') AND type in (N'U'))
DROP TABLE [master].[tblCoupling1Details]
GO

/****** Object:  Table [master].[tblCoupling1Details]    Script Date: 19-05-2021 18:32:16 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Coupling1_Details] UNIQUE NONCLUSTERED 
(
	[componentType] ASC,
	[couplingPosition] ASC,
	[couplingType] ASC,
	[locations] ASC,
	[coupledComponentType1] ASC,
	[coupledComponentType2] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [master].[tblCoupling1Details] ADD  CONSTRAINT [DF_tblCoupling1Details_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
--====================================tblCoupling1Details==========================================================


--==============================================tblCoupling2Details===============================================================

/****** Object:  Table [master].[tblCoupling2Details]    Script Date: 19-05-2021 18:40:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[master].[tblCoupling2Details]') AND type in (N'U'))
DROP TABLE [master].[tblCoupling2Details]
GO

/****** Object:  Table [master].[tblCoupling2Details]    Script Date: 19-05-2021 18:40:13 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Coupling2_Details] UNIQUE NONCLUSTERED 
(
	[componentType] ASC,
	[couplingPosition] ASC,
	[couplingType] ASC,
	[locations] ASC,
	[coupledComponentType1] ASC,
	[coupledComponentType2] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [master].[tblCoupling2Details] ADD  CONSTRAINT [DF_tblCoupling2Details_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
--==============================================tblCoupling2Details===============================================================


--=============================================tblCSDMdefsDetails========================================================


/****** Object:  Table [master].[tblCSDMdefsDetails]    Script Date: 19-05-2021 18:41:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[master].[tblCSDMdefsDetails]') AND type in (N'U'))
DROP TABLE [master].[tblCSDMdefsDetails]
GO

/****** Object:  Table [master].[tblCSDMdefsDetails]    Script Date: 19-05-2021 18:41:59 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [CSDMdefsDetails] UNIQUE NONCLUSTERED 
(
	[CSDMfile] ASC,
	[componentcoderangestart] ASC,
	[componentcoderangeend] ASC,
	[CSDMsize] ASC,
	[CSDMrelative] ASC,
	[defaultshaftlabel] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [master].[tblCSDMdefsDetails] ADD  CONSTRAINT [DF_tblCSDMdefsDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
--=============================================tblCSDMdefsDetails========================================================


--=============================================tblDrivenDetails========================================================


/****** Object:  Table [master].[tblDrivenDetails]    Script Date: 19-05-2021 18:43:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[master].[tblDrivenDetails]') AND type in (N'U'))
DROP TABLE [master].[tblDrivenDetails]
GO

/****** Object:  Table [master].[tblDrivenDetails]    Script Date: 19-05-2021 18:43:17 ******/
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
	[spindleShaftBearing] [varchar](50) NULL,
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
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblDrivenDetails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Driven_Detail] UNIQUE NONCLUSTERED 
(
	[locations] ASC,
	[pumpType] ASC,
	[compressorType] ASC,
	[fan_or_blowerType] ASC,
	[purifierDrivenBy] ASC,
	[bearingType] ASC,
	[vacuumPumpType] ASC,
	[spindleShaftBearing] ASC,
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [master].[tblDrivenDetails] ADD  CONSTRAINT [DF_tblDrivenDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
--=============================================tblDrivenDetails========================================================


--=============================================tblDriverDetails========================================================

/****** Object:  Table [master].[tblDriverDetails]    Script Date: 19-05-2021 18:44:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[master].[tblDriverDetails]') AND type in (N'U'))
DROP TABLE [master].[tblDriverDetails]
GO

/****** Object:  Table [master].[tblDriverDetails]    Script Date: 19-05-2021 18:44:26 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Driver_Details] UNIQUE NONCLUSTERED 
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [master].[tblDriverDetails] ADD  CONSTRAINT [DF_tblDriverDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
--=============================================tblDriverDetails========================================================


--=============================================tblIntermediateDetails========================================================

/****** Object:  Table [master].[tblIntermediateDetails]    Script Date: 19-05-2021 18:45:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[master].[tblIntermediateDetails]') AND type in (N'U'))
DROP TABLE [master].[tblIntermediateDetails]
GO

/****** Object:  Table [master].[tblIntermediateDetails]    Script Date: 19-05-2021 18:45:35 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Intermediate_Details] UNIQUE NONCLUSTERED 
(
	[componentType] ASC,
	[intermediateType] ASC,
	[locations] ASC,
	[drivenBy] ASC,
	[speedChangesMax] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [master].[tblIntermediateDetails] ADD  CONSTRAINT [DF_tblIntermediateDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
--=============================================tblIntermediateDetails========================================================


--=============================================tblPickupCodeDetails========================================================


/****** Object:  Table [master].[tblPickupCodeDetails]    Script Date: 19-05-2021 18:46:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[master].[tblPickupCodeDetails]') AND type in (N'U'))
DROP TABLE [master].[tblPickupCodeDetails]
GO

/****** Object:  Table [master].[tblPickupCodeDetails]    Script Date: 19-05-2021 18:46:28 ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [tblPickup_CodeDetails] UNIQUE NONCLUSTERED 
(
	[driverLocations] ASC,
	[driverLocationNDE] ASC,
	[driverLocationDE] ASC,
	[intermediateLocations] ASC,
	[intermediatepresent] ASC,
	[drivenLocations] ASC,
	[drivenLocationDE] ASC,
	[drivenLocationNDE] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [master].[tblPickupCodeDetails] ADD  CONSTRAINT [DF__tblPickup__isDel__4F47C5E3]  DEFAULT ((0)) FOR [isDeleted]
GO
--=============================================tblPickupCodeDetails========================================================


--=============================================tblSpecialFaultCodesDetails========================================================

/****** Object:  Table [master].[tblSpecialFaultCodesDetails]    Script Date: 19-05-2021 18:47:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[master].[tblSpecialFaultCodesDetails]') AND type in (N'U'))
DROP TABLE [master].[tblSpecialFaultCodesDetails]
GO

/****** Object:  Table [master].[tblSpecialFaultCodesDetails]    Script Date: 19-05-2021 18:47:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [master].[tblSpecialFaultCodesDetails](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[specialfaultcodetype] [varchar](50) NOT NULL,
	[specialmultiple] [int] NOT NULL,
	[specialcode] [varchar](50) NOT NULL,
	[componentType] [varchar](50) NULL,
	[componentTypeSub1] [varchar](50) NULL,
	[componentTypeSub2] [varchar](50) NULL,
	[isDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [tblSpecial_FaultCodes_Details] UNIQUE NONCLUSTERED 
(
	[specialfaultcodetype] ASC,
	[componentType] ASC,
	[componentTypeSub1] ASC,
	[componentTypeSub2] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [master].[tblSpecialFaultCodesDetails] ADD  CONSTRAINT [DF_tblSpecialFaultCodesDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

--=============================================tblSpecialFaultCodesDetails========================================================

