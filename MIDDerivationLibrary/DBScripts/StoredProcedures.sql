-------------------------------------------------------------------------------------1

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAddOrUpdateCoupling1Details]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spAddOrUpdateCoupling1Details]
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

---------------------------------------------------------------------------------------- 2

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAddOrUpdateCoupling2Details]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spAddOrUpdateCoupling2Details]
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


------------------------------------------------------------------------------------------- 3

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAddOrUpdateCSDMdefsDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spAddOrUpdateCSDMdefsDetails]
GO

---------------------------------------------------------------------------------------- 3

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAddOrUpdateCSDMdefsDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spAddOrUpdateCSDMdefsDetails]
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

------------------------------------------------------------------------------------------- 4

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAddOrUpdateDrivenDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spAddOrUpdateDrivenDetails]
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
		vacuumPumpType varchar(50),
		spindleShaftBearing varchar(50),
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
		Case when spindleShaftBearing = ''  then null else spindleShaftBearing end as spindleShaftBearing,
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
		componentCode varchar(10), spindleShaftBearing varchar(100))

		select @Id = id from @DetailsTable
		if(@Id = 0)
			Begin
				insert into master.tblDrivenDetails (componentType,drivenType,
				locations,pumpType,compressorType,fan_or_blowerType,
				purifierDrivenBy,bearingType,vacuumPumpType,spindleShaftBearing,
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
				purifierDrivenBy,bearingType,vacuumPumpType,spindleShaftBearing,
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
				spindleShaftBearing = d.spindleShaftBearing,
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

--------------------------------------------------------------------------------------------- 5

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAddOrUpdateDriverDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spAddOrUpdateDriverDetails]
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

-------------------------------------------------------------------------------------------- 6


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAddOrUpdateIntermediateDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spAddOrUpdateIntermediateDetails]
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
--------------------------------------------------------------------------------------------- 7

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAddOrUpdatePickupCodeDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spAddOrUpdatePickupCodeDetails]
GO

CREATE PROCEDURE [dbo].[spAddOrUpdatePickupCodeDetails]
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
		
		Declare @DetailsTable table (id int,driverLocations int,driverLocationNDE bit,driverLocationDE bit,
	    intermediateLocations int,intermediatepresent bit,drivenLocations int,drivenLocationDE bit,
		drivenLocationNDE bit,driverPickupCode varchar(50),coupling1PickupCode varchar(50),intermediatePickupCode varchar(50),
	    coupling2PickupCode varchar(50),drivenPickupCode varchar(50),spindle_shaft_with_2locations bit)
		
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
		Case when drivenPickupCode = '' then null else drivenPickupCode end as drivenPickupCode,
		spindle_shaft_with_2locations
		FROM OPENXML (@xmlDocumentHandle, 'PickupCodeDetails',2)
		WITH (id int,driverLocations int,driverLocationNDE bit,driverLocationDE bit,
	    intermediateLocations int,intermediatepresent bit,drivenLocations int,drivenLocationDE bit,
		drivenLocationNDE bit,driverPickupCode varchar(50),coupling1PickupCode varchar(50),intermediatePickupCode varchar(50),
	    coupling2PickupCode varchar(50),drivenPickupCode varchar(50),spindle_shaft_with_2locations bit)	
		
		--select * from @DetailsTable

		select @Id = id from @DetailsTable
		if(@Id = 0)
			Begin
				insert into master.tblPickupCodeDetails
				(driverLocations,driverLocationNDE,driverLocationDE,intermediateLocations,intermediatepresent,
				 drivenLocations,drivenLocationDE,drivenLocationNDE,
				 driverPickupCode,coupling1PickupCode,intermediatePickupCode,coupling2PickupCode,drivenPickupCode,spindle_shaft_with_2locations)
				 select driverLocations,driverLocationNDE,driverLocationDE,intermediateLocations,intermediatepresent,
				 drivenLocations,drivenLocationDE,drivenLocationNDE,
				 driverPickupCode,coupling1PickupCode,intermediatePickupCode,coupling2PickupCode,drivenPickupCode,spindle_shaft_with_2locations from @DetailsTable
				
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
				drivenPickupCode = d.drivenPickupCode,
				spindle_shaft_with_2locations = d.spindle_shaft_with_2locations
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

----------------------------------------------------------------------------------------------8

-- =============================================
-- Author:      <Vishal Dhure>  Updated By: <Sandip Patil>
-- Create Date: <05/05/2021>
-- Description: <SP used for save Special Fault Codes Detail>
-- =============================================

CREATE PROCEDURE [dbo].[spAddOrUpdateSpecialFaultCodesDetails]
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

		Declare @DetailsTable table (id bigint,specialfaultcodetype varchar(50),specialcode varchar(50),specialmultiple int,componentType varchar(50),componentTypeSub1 varchar(50),componentTypeSub2 varchar(50) )
				
		insert into @DetailsTable
		select id,specialfaultcodetype,specialcode,specialmultiple,componentType,componentTypeSub1,componentTypeSub2
		FROM OPENXML (@xmlDocumentHandle, 'SpecialFaultCodesDetails',2)
		WITH (id bigint,specialfaultcodetype varchar(50),specialcode varchar(50),specialmultiple int,componentType varchar(50),componentTypeSub1 varchar(50),componentTypeSub2 varchar(50))

		select @Id = id from @DetailsTable

		if(@Id = 0)
			Begin
				insert into master.tblSpecialFaultCodesDetails (specialfaultcodetype,specialcode,specialmultiple,componentType,componentTypeSub1,componentTypeSub2)
				select specialfaultcodetype,specialcode,specialmultiple,componentType,componentTypeSub1,componentTypeSub2 FROM @DetailsTable
				set @Id = SCOPE_IDENTITY()
			End
		Else
			Begin
				
				Update master.tblSpecialFaultCodesDetails set 
				specialfaultcodetype = d.specialfaultcodetype,
				specialcode = d.specialcode,
				specialmultiple = d.specialmultiple,
				componentType = d.componentType,
				componentTypeSub1 = d.componentTypeSub1,
				componentTypeSub2 = d.componentTypeSub2
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

----------------------------------------------------------------------------------------------9

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

---------------------------------------------------------------------------------------------- 10

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

---------------------------------------------------------------------------------------------- 11

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

---------------------------------------------------------------------------------------------- 12


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

---------------------------------------------------------------------------------------------- 13

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

---------------------------------------------------------------------------------------------- 14

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

---------------------------------------------------------------------------------------------- 15

-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <28/04/2021>
-- Description: <SP used for Delete Pickup Code Details By Id>
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

---------------------------------------------------------------------------------------------- 16

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

---------------------------------------------------------------------------------------------- 17

-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <05/05/2021>
-- Description: <SP used for Generate MID Derivation>
-- =============================================

CREATE Procedure [dbo].[spGenerateMIDDerivation]
@xmlInput xml = ''
As
Begin

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
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/drivers/diesel',2)
WITH (cylinders int)


select @motorDrive =  Case when motorDrive = '' then null else motorDrive end,
@motorFan = Case when motorFan = '' then null else motorFan end ,
@motorBallBearings = Case when motorBallBearings = '' then null else motorBallBearings end ,
@drivenBallBearings = Case when drivenBallBearings = '' then null else drivenBallBearings end,
@drivenBalanceable = Case when drivenBalanceable = '' then null else drivenBalanceable end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/drivers/motor',2)
WITH (motorDrive varchar(100),motorFan varchar(10),motorBallBearings  varchar(10),drivenBallBearings  varchar(10),drivenBalanceable  varchar(10))

select @motorPoles = motorPoles 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/drivers/motor/vfd',2)
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
select @drivencomponentType = Case when componentType = '' then null else componentType end,
@drivenlocations = locations,
@drivenLocationNDE  = Case when drivenLocationNDE  = '' then null else drivenLocationNDE end  ,
@drivenLocationDE  = Case when drivenLocationDE  = '' then null else drivenLocationDE end ,
@drivenType = Case when drivenType = '' then null else drivenType end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven',2)
WITH (componentType varchar(100),drivenType varchar(100),locations int,
drivenLocationDE varchar(10),drivenLocationNDE varchar(10))

--<pumpType>--
select @pumpType = pumpType FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump',2)
WITH (pumpType varchar(100))
--<pumpType>--

--<pumpCentrifugal>
select @thrustBearing = thrustBearing,
@rotorOverhung = Case when rotorOverhung = '' then null else rotorOverhung end ,
@centrifugalPumpHasBallBearings = Case when centrifugalPumpHasBallBearings = '' then null else centrifugalPumpHasBallBearings end   
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpCentrifugal',2)
WITH (thrustBearing varchar(100),rotorOverhung  varchar(10),centrifugalPumpHasBallBearings  varchar(10))
--<pumpCentrifugal>


--<pumpPropeller>
select @propellerpumpHasBallBearings = Case when propellerpumpHasBallBearings = '' then null else propellerpumpHasBallBearings end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpPropeller',2)
WITH (propellerpumpHasBallBearings  varchar(10))
--<pumpPropeller>

--<pumpRotaryThread>
select @rotaryThreadPumpHasBallBearings = Case when rotaryThreadPumpHasBallBearings = '' then null else rotaryThreadPumpHasBallBearings end  
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpRotaryThread',2)
WITH (rotaryThreadPumpHasBallBearings  varchar(10))
--<pumpRotaryThread>

--<pumpGear>
select @gearPumpHasBallBearings = Case when gearPumpHasBallBearings = '' then null else gearPumpHasBallBearings end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpGear',2)
WITH (gearPumpHasBallBearings  varchar(10))
--<pumpGear>

--<pumpRotaryScrew>
select @screwPumpHasBallBearings = Case when screwPumpHasBallBearings = '' then null else screwPumpHasBallBearings end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpRotaryScrew',2)
WITH (screwPumpHasBallBearings  varchar(10))
--<pumpRotaryScrew>

--<pumpRotarySlidingVane>
select @rotorOverhung = Case when rotorOverhung = '' then null else rotorOverhung end ,
@slidingVanePumpHasBallBearings = Case when slidingVanePumpHasBallBearings = '' then null else slidingVanePumpHasBallBearings end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpRotarySlidingVane',2)
WITH (rotorOverhung  varchar(10),slidingVanePumpHasBallBearings  varchar(10))
--<pumpRotarySlidingVane>

--<pumpRotaryAxialRecip>
select @attachedOilPump = Case when attachedOilPump = '' then null else attachedOilPump end ,
@axialRecipPumpHasBallBearings = Case when axialRecipPumpHasBallBearings = '' then null else axialRecipPumpHasBallBearings end ,
@thrustBearing = Case when thrustBearing = '' then null else thrustBearing end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpRotaryAxialRecip',2)
WITH (attachedOilPump  varchar(10),axialRecipPumpHasBallBearings  varchar(10),thrustBearing varchar(50))
--<pumpRotaryAxialRecip>

--<compressor>
select @compressorType = Case when compressorType = '' then null else compressorType end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/compressor',2)
WITH (compressorType varchar(50))
--<compressor>

--<compressorCentrifugal>
select @impellerOnMainShaft = Case when impellerOnMainShaft = '' then null else impellerOnMainShaft end,  
@centrifugalCompressorHasBallBearings = Case when centrifugalCompressorHasBallBearings = '' then null else centrifugalCompressorHasBallBearings end ,
@thrustBearing = Case when thrustBearing = '' then null else thrustBearing end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/compressor/compressorTypes/compressorCentrifugal',2)
WITH (impellerOnMainShaft  varchar(20),centrifugalCompressorHasBallBearings  varchar(20),thrustBearing  varchar(100))
--<compressorCentrifugal>

--<compressorReciporcating>
select @crankHasIntermediateBearing = Case when crankHasIntermediateBearing = '' then null else crankHasIntermediateBearing end ,
@reciprocatingCompressorHasBallBearings = Case when reciprocatingCompressorHasBallBearings = '' then null else reciprocatingCompressorHasBallBearings end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/compressor/compressorTypes/compressorReciporcating',2)
WITH (crankHasIntermediateBearing  varchar(20),reciprocatingCompressorHasBallBearings  varchar(20))
--<compressorReciporcating>

--<compressorScrew>
select @screwCompressorHasBallBearings = Case when screwCompressorHasBallBearings = '' then null else screwCompressorHasBallBearings end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/compressor/compressorTypes/compressorScrew',2)
WITH (screwCompressorHasBallBearings  varchar(10))
--<compressorScrew>

--<compressorScrewTwin>
select @screwTwinCompressorHasBallBearingsOnHPSide = Case when screwTwinCompressorHasBallBearingsOnHPSide = '' then null else screwTwinCompressorHasBallBearingsOnHPSide end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/compressor/compressorTypes/compressorScrewTwin',2)
WITH (screwTwinCompressorHasBallBearingsOnHPSide  varchar(10))
--<compressorScrewTwin>

--<fan_or_blowerType>
select @fan_or_blowerType = case when fan_or_blowerType = '' then null else fan_or_blowerType end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/fan_or_blower',2)
WITH (fan_or_blowerType varchar(1000))
--<fan_or_blowerType>

--<fan_or_blowerLobed>
select @lobedFanOrBlowerHasBallBearings = Case when lobedFanOrBlowerHasBallBearings = '' then null else lobedFanOrBlowerHasBallBearings end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/fan_or_blower/fan_or_blowerTypes/fan_or_blowerLobed',2)
WITH (lobedFanOrBlowerHasBallBearings  varchar(10))
--<fan_or_blowerLobed>

--<fan_or_blowerOverhungRotor>
select @fanStages = Case when fanStages = '' then null else fanStages end ,
@overhungRotorFanOrBlowerHasBearings = Case when overhungRotorFanOrBlowerHasBearings = '' then null else overhungRotorFanOrBlowerHasBearings end  
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/fan_or_blower/fan_or_blowerTypes/fan_or_blowerOverhungRotor',2)
WITH (fanStages  varchar(10),overhungRotorFanOrBlowerHasBearings  varchar(10))
--<fan_or_blowerOverhungRotor>

--<fan_or_blowerSupportedRotor>
select @fanStages = Case when fanStages = '' then null else fanStages end ,
@supportedRotorFanOrBlowerHasBearings = Case when supportedRotorFanOrBlowerHasBearings = '' then null else supportedRotorFanOrBlowerHasBearings end  
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/fan_or_blower/fan_or_blowerTypes/fan_or_blowerSupportedRotor',2)
WITH (fanStages  varchar(10),supportedRotorFanOrBlowerHasBearings  varchar(10))
--<fan_or_blowerSupportedRotor>

--<purifier_centrifuge>
select @purifierDrivenBy = case when purifierDrivenBy = '' then null else purifierDrivenBy end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/purifier_centrifuge',2)
WITH (purifierDrivenBy varchar(100))
--<purifier_centrifuge>

--<generator>
select @bearingType = case when bearingType = '' then null else bearingType end,
@exciter = Case when exciter = '' then null else exciter end  ,
@drivenBy1 = Case when drivenBy = '' then null else drivenBy end,
@exciterOverhungOrSupported = Case when exciterOverhungOrSupported = '' then null else exciterOverhungOrSupported end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/generator',2)
WITH (bearingType varchar(100),exciter  varchar(10),drivenBy varchar(100),exciterOverhungOrSupported varchar(100))
--<generator>

--<vacuumpumptype>
select @vacuumPumpType = case when vacuumpumptype = '' then null else vacuumpumptype end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/vacuumpump',2)
WITH (vacuumpumptype varchar(100))
--<vacuumpumptype>

--<vacuumpumpCentrifugal>
select @rotorOverhung = Case when rotorOverhung = '' then null else rotorOverhung end,
@impellerOnMainShaft = Case when impellerOnMainShaft = '' then null else impellerOnMainShaft end,
@thrustBearing =  Case when thrustBearing = '' then null else thrustBearing end,
@bearingsType = Case when bearingsType = '' then null else bearingsType end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/vacuumpump/vacuumpumpTypes/vacuumpumpCentrifugal',2)
WITH (rotorOverhung  varchar(100),impellerOnMainShaft  varchar(100),bearingsType varchar(500),thrustBearing varchar(100))
--<vacuumpumpCentrifugal>

--<vacuumpumpAxialRecip>
select @attachedOilPump = Case when attachedOilPump = '' then null else attachedOilPump end,
@bearingsType = bearingsType,
@thrustBearing =  Case when thrustBearing = '' then null else thrustBearing end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/vacuumpump/vacuumpumpTypes/vacuumpumpAxialRecip',2)
WITH (attachedOilPump  varchar(10),bearingsType  varchar(100),thrustBearing varchar(100))
--<vacuumpumpAxialRecip>

--<vacuumpumpReciprocating>
select @bearingsType = Case when bearingsType = '' then null else bearingsType end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/vacuumpump/vacuumpumpTypes/vacuumpumpReciprocating',2)
WITH (bearingsType  varchar(100))
--<vacuumpumpReciprocating

--<vacuumpumpLobed>
select @bearingsType = Case when bearingsType = '' then null else bearingsType end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/vacuumpump/vacuumpumpTypes/vacuumpumpLobed',2)
WITH (bearingsType  varchar(100))
--<vacuumpumpLobed

--<spindle_or_shaft_or_bearing>
Declare @spindleShaftBearing varchar(100)
select  @spindleShaftBearing = Case when spindleShaftBearing = '' then null else spindleShaftBearing end 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/spindle_or_shaft_or_bearing',2)
WITH (spindleShaftBearing  varchar(100))
--<spindle_or_shaft_or_bearing>

--- Read xml for driven special code and insert into SpecialFaultCodesInputTable --
insert into @SpecialFaultCodesInputTable select specialFaultCodeType,specialFaultCodeCount
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/specialFaultCodesInput/SpecialFaultCodesInput',2)
WITH (specialFaultCodeType varchar(100),specialFaultCodeCount int)
--- Read xml for driven special code and insert into SpecialFaultCodesInputTable --

--<rpm>
select  @drivenRPM = Convert(decimal(18,2),Case when rpm = '' then null else rpm end )
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens',2)
WITH (rpm varchar(10))
--<rpm>

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
@coupling1PickupCode = coupling1PickupCode,@coupling2PickupCode = coupling2PickupCode from funGetPickupCodeDetails (@drivenType,@componentType,@drivencomponentType,@intercomponentType,@c2componentType,@c1componentType, ISNULL(@locations,0),ISNULL(@driverLocationNDE,convert(bit,0)),ISNULL(@driverLocationDE,convert(bit,0)),
ISNULL(@interlocations,0),@intermediatePresent, ISNULL(@drivenlocations,0),ISNULL(@drivenLocationNDE,convert(bit,0)),ISNULL(@drivenLocationDE,convert(bit,0)))

---============================================

--Here is the logic to derive coupledComponentType1 and coupledComponentType2 
Declare @drivencomponentType1 varchar(50)
set @drivencomponentType1  = @drivenType 

if(UPPER(RTRIM(LTRIM(@drivenType))) = UPPER(RTRIM(LTRIM('pump'))))
	Begin
		set @drivencomponentType1 = @drivencomponentType1 + @pumpType
	End
else if(UPPER(RTRIM(LTRIM(@drivenType))) = UPPER(RTRIM(LTRIM('compressor'))))
	Begin
		set @drivencomponentType1 = @drivencomponentType1 + @compressorType
	End
else if(UPPER(RTRIM(LTRIM(@drivenType))) = UPPER(RTRIM(LTRIM('fan_or_blower'))))
	Begin
		set @drivencomponentType1 = @fan_or_blowerType
	End
else if(UPPER(RTRIM(LTRIM(@drivenType))) = UPPER(RTRIM(LTRIM('vacuumpump'))))
	Begin
		set @drivencomponentType1 = @drivencomponentType1 + @vacuumPumpType
	End

if(@c1componentType <> '' and @c1componentType IS NOT NULL)
  Begin

	if not exists (select * from master.tblCoupling1Details where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@c1componentType))) 
	and couplingPosition = @c1couplingPosition and UPPER(RTRIM(LTRIM(couplingType))) = UPPER(RTRIM(LTRIM(@c1couplingType)))
	and ISNULL(Convert(varchar(10),locations),'X') = Case when @c1locations = '' Or @c1locations IS NULL then 'X'
    else convert(varchar(10),@c1locations) end and coupledComponentType1 IS NULL and coupledComponentType2 IS NULL
	)
	Begin
		if(@c1couplingPosition = 1) 
			Begin
				set @c1coupledComponentType1 = @driverType  
			
				if(@intercomponentType <> '' and @intercomponentType IS NOT NULL)
					Begin
						set @c1coupledComponentType2 = @intermediateType
					End
				else
					Begin
						set @c1coupledComponentType2 = @drivencomponentType1
					End
			End
		else
			Begin
				set @c1coupledComponentType1 = @intermediateType
				set @c1coupledComponentType2= @drivencomponentType1
		End
	End
End

if(@c2componentType <> '' and @c2componentType IS NOT NULL)
  Begin
		if not exists (select * from master.tblCoupling2Details where UPPER(RTRIM(LTRIM(componentType))) = UPPER(RTRIM(LTRIM(@c2componentType))) 
		and couplingPosition = @c2couplingPosition and UPPER(RTRIM(LTRIM(couplingType))) = UPPER(RTRIM(LTRIM(@c2couplingType)))
		and ISNULL(Convert(varchar(10),locations),'X') = Case when @c2locations = '' Or @c2locations IS NULL then 'X'
		else convert(varchar(10),@c2locations) end and coupledComponentType1 IS NULL and coupledComponentType2 IS NULL
		)
		Begin
			if(@c2couplingPosition = 1) 
				Begin
					set @c2coupledComponentType1 = @drivenType  
					if(@intercomponentType <> '' and @intercomponentType IS NOT NULL)
						Begin
							set @c2coupledComponentType2 = @intermediateType
						End
					else
						Begin
							set @c2coupledComponentType2 = @drivencomponentType1
						End
				End
			else
				Begin
					set @c2coupledComponentType1 = @intermediateType
					set @c2coupledComponentType2= @drivencomponentType1
				End
		End
End

Declare @MachineSpeedRatio decimal(18,4) = null
set @c1SpeedRatio = ISNULL(@c1SpeedRatio,1)
set @c2SpeedRatio = ISNULL(@c2SpeedRatio,1)
set @intermediateSpeedRatio = ISNULL(@intermediateSpeedRatio,1)
set @MachineSpeedRatio =  @c1SpeedRatio * @c2SpeedRatio * @intermediateSpeedRatio

select 'Driver' as Component, ComponentCode, 
@driverPickupCode as PickupCode, Convert(decimal(18,2),1) as SpeedRatio
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
@coupling1PickupCode as PickupCode, @c1SpeedRatio as SpeedRatio
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
@coupling2PickupCode as pickupCode, @c2SpeedRatio as SpeedRatio
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
@intermediatePickupCode as pickupCode, @intermediateSpeedRatio as SpeedRatio
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
@drivenPickupCode as pickupCode, Convert(decimal(18,4),1) as SpeedRatio
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
ISNULL(UPPER(RTRIM(LTRIM(spindleShaftBearing))),'X') = 
	Case when @spindleShaftBearing = '' Or @spindleShaftBearing IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@spindleShaftBearing))) end
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
	--Declare @MachineSpeedRatio decimal(18,4) = null

	select @DriverComponentCode = componentCode from #ComponentCodeDetails where Component = 'Driver'
	select @DrivenComponentCode = componentCode from #ComponentCodeDetails where Component = 'Driven'
	
	Exec dbo.spGenerateMIDDerivation1 @xmlInput,@DriverComponentCode,@DrivenComponentCode,@MachineSpeedRatio,@FaultCodeMatrixJson output
	
	select Component,ComponentCode,PickupCode,null as FaultCodeMatrixJson,SpeedRatio from #ComponentCodeDetails
	Union all
	select  'FaultCodeMatrix' as Component,null,null,@FaultCodeMatrixJson as FaultCodeMatrixJson,null
	
	drop table #ComponentCodeDetails
End
GO

---------------------------------------------------------------------------------------------- 18

-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <05/05/2021>
-- Description: <SP used for Generate MID Derivation>
-- =============================================

CREATE Procedure [dbo].[spGenerateMIDDerivation1]
@xmlInput xml = '',
@driverComponentCode decimal(18,4),
@drivenComponentCode decimal(18,4),
@machineSpeedRatio decimal(18,4),
@FaultCodeMatrixJson nvarchar(max) output
As
Begin

Declare @xmlDocumentHandle int
EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
Declare  @SpecialFaultCodesInputTable table (SpecialFaultCodeType varchar(50),SpecialFaultCodeCount int)
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
select specialFaultCodeType,specialFaultCodeCount
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/specialFaultCodesInput/SpecialFaultCodesInput',2)
WITH (specialFaultCodeType varchar(100),specialFaultCodeCount int)
--- Read xml for driver special code and insert into SpecialFaultCodesInputTable --

--- Read xml for driven special code and insert into SpecialFaultCodesInputTable --
insert into @SpecialFaultCodesInputTable
select specialFaultCodeType,specialFaultCodeCount
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


	DECLARE @SpecialFaultCodesDetails TABLE(Id INT,RowCode VARCHAR(30),SpecialMultiple int, SpecialFaultCodeCount int);
			
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
			
			if exists(select * from @SpecialFaultCodesInputTable)
				Begin
				
					insert into @SpecialFaultCodesDetails
					select ROW_NUMBER() over(order by (select 1)) as Id,B.specialcode as RowCode,B.specialmultiple as SpecialMultiple,A.SpecialFaultCodeCount  from @SpecialFaultCodesInputTable A
					inner join master.tblSpecialFaultCodesDetails B on A.SpecialFaultCodeType = B.specialfaultcodetype
					
					DECLARE @RowCounter INT 
					SET @RowCounter=1
					WHILE ( @RowCounter <= (select count(*) from @SpecialFaultCodesDetails))
					BEGIN
						Declare @RowCode varchar(50)= ''
						Declare @SpecialMultiple int,@SpecialFaultCodeCount int
						
						select @RowCode = RowCode,@SpecialMultiple = SpecialMultiple, 
						@SpecialFaultCodeCount = SpecialFaultCodeCount from @SpecialFaultCodesDetails where Id = @RowCounter

						DECLARE @InnerRowCounter INT 
						SET @InnerRowCounter = 1 
						WHILE ( @InnerRowCounter <= @SpecialMultiple)
							BEGIN
								insert into @SpecialFaultCodeTable
								select Case when @InnerRowCounter = 1 then @RowCode else Convert(varchar(10),@InnerRowCounter) + @RowCode end as RowCode, @SpecialFaultCodeCount * @InnerRowCounter * @machineSpeedRatio as RowOrder
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
					While(@SpecialRowCount <= (select count(*) from @SpecialFaultCodeTable))
						Begin
							select @SpecialRowCode = RowCode ,@SpecialRowOrder = RowOrder from @SpecialFaultCodeTable where RowId = @SpecialRowCount
							
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
					select ROW_NUMBER() over(order by (select 1)) as Id,B.specialcode as RowCode,B.specialmultiple as SpecialMultiple,A.SpecialFaultCodeCount  from @SpecialFaultCodesInputTable A
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

------------------------------------------------------------------------------------------- 17

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' [dbo].[spGetAllCoupling1Details]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetAllCoupling1Details]
Go

---------------------------------------------------------------------------------------------- 19

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

---------------------------------------------------------------------------------------------- 20

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

---------------------------------------------------------------------------------------------- 21

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

---------------------------------------------------------------------------------------------- 22

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

---------------------------------------------------------------------------------------------- 23

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

---------------------------------------------------------------------------------------------- 24

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

---------------------------------------------------------------------------------------------- 25

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

---------------------------------------------------------------------------------------------- 26

-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <27/04/2021>
-- Description: <sp Get All Pickup Code Details>
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllPickupCodeDetails]
AS
BEGIN
	
			select * from master.tblPickupCodeDetails where isDeleted = 0
END
GO

---------------------------------------------------------------------------------------------- 27

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
---------------------------------------------------------------------------------------------- 28

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

---------------------------------------------------------------------------------------------- 29

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

---------------------------------------------------------------------------------------------- 30

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

------------------------------------------------------------------------------------------- 31

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetCSDMdefsDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetCSDMdefsDetails]
Go
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

------------------------------------------------------------------------------------------- 32

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
------------------------------------------------------------------------------------------- 33

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
		@lobedFanOrBlowerHasBallBearings  varchar(10),@overhungRotorFanOrBlowerHasBearings  varchar(10), @supportedRotorFanOrBlowerHasBearings  varchar(10),
		@spindleShaftBearing  varchar(100)
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
		@supportedRotorFanOrBlowerHasBearings = Case when supportedRotorFanOrBlowerHasBearings = '' then null else supportedRotorFanOrBlowerHasBearings end,
		@spindleShaftBearing = Case when spindleShaftBearing = '' then null else @spindleShaftBearing end
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
		spindleShaftBearing varchar(100))
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
				ISNULL(UPPER(RTRIM(LTRIM(spindleShaftBearing))),'X') = 
					Case when @spindleShaftBearing = '' Or @spindleShaftBearing IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@spindleShaftBearing))) end
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
				ISNULL(UPPER(RTRIM(LTRIM(spindleShaftBearing))),'X') = 
					Case when @spindleShaftBearing = '' Or @spindleShaftBearing IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@spindleShaftBearing))) end
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

------------------------------------------------------------------------------------------- 34

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

------------------------------------------------------------------------------------------- 35

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


		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		--Declare variable for driver component --
		Declare @componentType varchar(100),@driverType varchar(100),@motorDrive varchar(100)
		Declare @locations int,@cylinders int,@motorPoles int, @id int
		Declare @motorFan varchar(10),@motorBallBearings  varchar(10),@drivenBallBearings  varchar(10),@drivenBalanceable  varchar(10),
		@turbineReductionGear  varchar(10),@turbineRotorSupported  varchar(10),@turbineBallBearing  varchar(10),@turbineThrustBearing  varchar(10),
		@turbineThrustBearingIsBall  varchar(10)
		--Declare variable for driver component --

		--- Read xml for driver component --
		select @Id = id, @componentType = componentType,@driverType = driverType, @motorDrive = motorDrive,
		@locations = locations,@cylinders = cylinders,@motorPoles = motorPoles,
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
		motorBallBearings  varchar(10),drivenBallBearings  varchar(10),drivenBalanceable  varchar(10),motorPoles int,turbineReductionGear  varchar(10),
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
				ISNULL(convert(varchar(10),motorPoles),'X') = 
				Case when @motorPoles = '' Or @motorPoles IS NULL then 'X'
				else convert(varchar(10),@motorPoles) end
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
				ISNULL(convert(varchar(10),motorPoles),'X') = 
				Case when @motorPoles = '' Or @motorPoles IS NULL then 'X'
				else convert(varchar(10),@motorPoles) end
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

------------------------------------------------------------------------------------------- 36

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

------------------------------------------------------------------------------------------- 37

-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: <27/04/2021>
-- Description: <SP used for get extra fault data>
-- =============================================
CREATE Procedure [dbo].[spGetExtraFaultData]
@xmlInput xml = '',
@type varchar(50)
As
Declare @ResultTable TABLE
( componentName varchar(50),cylinders int,  motorbars int,motorfanblades int,turbineblades int,pumpvanes int, pumpblades int, pumpthreads int, pumpteeth int,
 idlerthreads int,pumppistons int,compressorvanes int,compressorpistons int,compressorthreads int,compressorthreads1 int,idlerthreads1 int,compressorthreads2 int,
 idlerthreads2 int,blowerlobes int,idlerlobes int, fanblades int,generatorbars int,pumplobes int
) 

BEGIN
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('diesel'))))
			Begin
				insert into @ResultTable(componentName,cylinders)
				select 'Driver',cylinders FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/drivers/diesel',2)
				WITH (cylinders int)
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('motor'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driver',0 as cylinders,  motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/drivers/motor/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('turbine'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driver',0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver/drivers/turbine/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('pumpCentrifugal'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven',0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpCentrifugal/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
			End
        
		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('pumpPropeller'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven',0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpPropeller/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('pumpRotaryThread'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven',0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpRotaryThread/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
			End
        
		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('pumpGear'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven',0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpGear/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
			End
		
			if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('pumpRotaryScrew'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven',0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpRotaryScrew/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End
        
			if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('pumpRotarySlidingVane'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven',0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpRotarySlidingVane/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End

			if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('pumpRotaryAxialRecip'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven',0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpRotaryAxialRecip/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
			End
        
		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('pumpRotaryRadialRecip'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven',0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/pump/pumpTypes/pumpRotaryRadialRecip/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
	
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('compressorCentrifugal'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/compressor/compressorTypes/compressorCentrifugal/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('compressorReciporcating'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/compressor/compressorTypes/compressorReciporcating/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End


		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('compressorScrew'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/compressor/compressorTypes/compressorScrew/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('compressorScrewTwin'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/compressor/compressorTypes/compressorScrewTwin/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('fan_or_blowerLobed'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/fan_or_blower/fan_or_blowerTypes/fan_or_blowerLobed/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('fan_or_blowerOverhungRotor'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/fan_or_blower/fan_or_blowerTypes/fan_or_blowerOverhungRotor/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('fan_or_blowerSupportedRotor'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/fan_or_blower/fan_or_blowerTypes/fan_or_blowerSupportedRotor/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End


		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('generator'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/generator/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('vacuumpumpCentrifugal'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/vacuumpump/vacuumpumpTypes/vacuumpumpCentrifugal/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('vacuumpumpAxialRecip'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/vacuumpump/vacuumpumpTypes/vacuumpumpAxialRecip/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('vacuumpumpRadialRecip'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/vacuumpump/vacuumpumpTypes/vacuumpumpRadialRecip/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
		
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('vacuumpumpReciprocating'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/vacuumpump/vacuumpumpTypes/vacuumpumpReciprocating/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
			End

		if(UPPER(RTRIM(LTRIM(@type))) = UPPER(RTRIM(LTRIM('vacuumpumpLobed'))))
			Begin
				INSERT INTO @ResultTable
				select 'Driven', 0 as cylinders, motorbars,motorfanblades,turbineblades,pumpvanes, pumpblades, pumpthreads, pumpteeth,
				idlerthreads,pumppistons,compressorvanes,compressorpistons,compressorthreads,compressorthreads1,idlerthreads1,compressorthreads2,
				idlerthreads2,blowerlobes,idlerlobes, fanblades,generatorbars,pumplobes   
				FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven/drivens/vacuumpump/vacuumpumpTypes/vacuumpumpLobed/extraFaultData',2)
				WITH (motorbars int,motorfanblades int, turbineblades int,pumpvanes int,pumpblades int, pumpthreads int, pumpteeth int,
				idlerthreads int,pumppistons int, compressorvanes int, compressorpistons int, compressorthreads int, compressorthreads1 int,
				idlerthreads1 int, compressorthreads2 int, idlerthreads2 int, blowerlobes int, idlerlobes int, fanblades int, generatorbars int, pumplobes int)
			End

			select * from @ResultTable
RETURN
END
GO
---------------------------------------------------------------------------------------------38

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

---------------------------------------------------------------------------------------------39

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

---------------------------------------------------------------------------------------------40

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


	
		SET NOCOUNT ON
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;
		
		--Declare variable for PickupCode  --
		Declare @Id int,@driverLocations int,@driverLocationNDE bit,@driverLocationDE bit,
	    @intermediateLocations int,@intermediatepresent bit,@drivenLocations int,@drivenLocationDE bit,
		@drivenLocationNDE bit,@driverPickupCode varchar(50),@coupling1PickupCode varchar(50),@intermediatePickupCode varchar(50),
	    @coupling2PickupCode varchar(50),@drivenPickupCode varchar(50),@spindle_shaft_with_2locations bit
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
		@drivenPickupCode = Case when drivenPickupCode = '' then null else drivenPickupCode end ,
		@spindle_shaft_with_2locations = spindle_shaft_with_2locations
		FROM OPENXML (@xmlDocumentHandle, 'PickupCodeDetails',2)
		WITH (id int,driverLocations int,driverLocationNDE bit,driverLocationDE bit,
	    intermediateLocations int,intermediatepresent bit,drivenLocations int,drivenLocationDE bit,
		drivenLocationNDE bit,driverPickupCode varchar(50),coupling1PickupCode varchar(50),intermediatePickupCode varchar(50),
	    coupling2PickupCode varchar(50),drivenPickupCode varchar(50),spindle_shaft_with_2locations bit)	
		
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
				and
				ISNULL(spindle_shaft_with_2locations,Convert(bit,0)) = 
				Case when @spindle_shaft_with_2locations = '' Or @spindle_shaft_with_2locations IS NULL then Convert(bit,0)
				else @spindle_shaft_with_2locations end 
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
				and
				ISNULL(spindle_shaft_with_2locations,Convert(bit,0)) = 
				Case when @spindle_shaft_with_2locations = '' Or @spindle_shaft_with_2locations IS NULL then Convert(bit,0)
				else @spindle_shaft_with_2locations end 
			End
END
GO

---------------------------------------------------------------------------------------------41

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

---------------------------------------------------------------------------------------------42

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
		
		Declare @id bigint
		Declare @specialfaultcodetype varchar(50),@specialcode varchar(50), @specialmultiple int

		--- Read xml for SpecialFaultCodesDetails component --
		select @id = id, 
		@specialfaultcodetype = specialfaultcodetype,
		@specialcode = specialcode ,
		@specialmultiple = specialmultiple
		FROM OPENXML (@xmlDocumentHandle, 'SpecialFaultCodesDetails',2)
		WITH (id bigint,specialfaultcodetype varchar(100),specialcode varchar(100),specialmultiple int)
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
				specialmultiple = @specialmultiple
				 
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
				specialmultiple = @specialmultiple
			End
END
GO

---------------------------------------------------------------------------------------------43

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

---------------------------------------------------------------------------------------------44
-- =============================================
-- Author:      <Vishal Dhure>
-- Create Date: < >
-- Description: <SP MID Code Deconstruction Logic>
-- =============================================

CREATE Procedure [dbo].[spMIDCodeDeconstruction]
@xmlInput xml = ''
As
Begin

Declare @xmlDocumentHandle int
EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;

Declare @driverPickupCode varchar(50),@drivenPickupCode varchar(50),@intermediatePickupCode varchar(50),
@coupling1PickupCode varchar(50),@coupling2PickupCode varchar(50),@driverComponentCode varchar(50),
@drivenComponentCode varchar(50),@intermediateComponentCode varchar(50),@coupling1ComponentCode varchar(50),
@coupling2ComponentCode varchar(50),@cylinders int, @driverLocations int,@driverLocationNDE int,@driverLocationDE int,@intermediateLocations int,
@intermediatepresent bit,@drivenLocations int, @drivenLocationDE int, @drivenLocationNDE int,
@driverComponentType varchar(100),@drivenComponentType varchar(100),@coupling1ComponentType varchar(100),
@coupling2ComponentType varchar(100),@intermediateComponentType varchar(100),@coupling1Location int,
@coupling2Location int, @driverType varchar(100),@drivenType varchar(100), @coupling1SpeedRatio decimal(18,4),@intermediateSpeedRatio decimal(18,2),
@coupling2SpeedRatio decimal(18,4),@coupling1Position int,@coupling2Position int,@coupling1Type varchar(100),
@coupling2Type varchar(100),@intermediateType varchar(100),@drivenId bigint,
@driverJson nvarchar(max),@drivenJson nvarchar(max),@driverId bigint,@motorPoles int,@driverSpeedRatio decimal(18,4) = 1.0000,
@interMediateJson nvarchar(max),@intermediateSpeedChangeMax int, @intermediateDrivenBy varchar(50),
@spindleShaftBearing varchar(50),@pumpType varchar(50),@rotorOverhung bit, @centrifugalPumpHasBallBearings bit, @thrustBearing varchar(50),
@pumpVanes int, @drivenSpeedRatio decimal(18,4),@compressorType varchar(50),@fan_or_blowerType varchar(50),
@vacuumpumpType varchar(50)

select frequencyCode as FrequencyCode,faultcode as Faultcode into #FaultCodeMatrixTableForDriver
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeDeconstructionRequest/machineComponentsForMIDdeconstruction/FaultCodeMatrix/rows/Row',2)
WITH (rowId int,frequencyCode varchar(100), faultcode decimal(18,4))

--- Read xml for driver component --
select @driverPickupCode = case when PickupCode = '' then null else PickupCode end,
@driverComponentCode = case when ComponentCode = '' then null else ComponentCode end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeDeconstructionRequest/machineComponentsForMIDdeconstruction/Driver',2)
WITH (PickupCode varchar(100),ComponentCode varchar(100))
--- Read xml for driver component --

--- Read xml for driven Coupling1 --
select @coupling1PickupCode = case when PickupCode = '' then null else PickupCode end,
@coupling1ComponentCode = case when ComponentCode = '' then null else ComponentCode end,
@coupling1SpeedRatio = Convert(decimal(18,4),case when SpeedRatio = '' then null else SpeedRatio end)
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeDeconstructionRequest/machineComponentsForMIDdeconstruction/Coupling1',2)
WITH (PickupCode varchar(100),ComponentCode varchar(100),SpeedRatio varchar(100))
--- Read xml for driven Coupling1 --

--- Read xml for driven Coupling2 --
select @coupling2PickupCode = case when PickupCode = '' then null else PickupCode end,
@coupling2ComponentCode = case when ComponentCode = '' then null else ComponentCode end,
@coupling2SpeedRatio = Convert(decimal(18,4),case when SpeedRatio = '' then null else SpeedRatio end)
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeDeconstructionRequest/machineComponentsForMIDdeconstruction/Coupling2',2)
WITH (PickupCode varchar(100),ComponentCode varchar(100),SpeedRatio varchar(100))
--- Read xml for driven Coupling2 --

--- Read xml for driven Intermediate --
select @intermediatePickupCode = case when PickupCode = '' then null else PickupCode end,
@intermediateComponentCode = case when ComponentCode = '' then null else ComponentCode end,
@intermediateSpeedRatio = Convert(decimal(18,4),case when SpeedRatio = '' then null else SpeedRatio end)
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeDeconstructionRequest/machineComponentsForMIDdeconstruction/Intermediate',2)
WITH (PickupCode varchar(100),ComponentCode varchar(100),SpeedRatio varchar(100))
--- Read xml for driven Intermediate --

--- Read xml for driven Driven --
select @drivenPickupCode = case when PickupCode = '' then null else PickupCode end,
@drivenComponentCode = case when ComponentCode = '' then null else ComponentCode end
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeDeconstructionRequest/machineComponentsForMIDdeconstruction/Driven',2)
WITH (PickupCode varchar(100),ComponentCode varchar(100))
--- Read xml for driven Driven --


select Top 1 @driverId = id, @driverComponentType = componentType,@driverLocations = locations,@driverType = driverType,@cylinders = cylinders, @motorPoles = motorPoles from master.tblDriverDetails where isDeleted = 0 and componentCode = convert(decimal(18,2),@driverComponentCode) order by id 
select Top 1 @drivenId = id, @drivenComponentType = componentType, @drivenLocations = locations,@drivenType = drivenType, @spindleShaftBearing = spindleShaftBearing, @pumpType = pumpType ,
@rotorOverhung = rotorOverhung,@centrifugalPumpHasBallBearings = centrifugalPumpHasBallBearings,@thrustBearing = thrustBearing,@compressorType = compressorType,@fan_or_blowerType = fan_or_blowerType,@vacuumpumpType = vacuumpumpType
from master.tblDrivenDetails where isDeleted = 0 and componentCode = convert(decimal(18,2),@drivenComponentCode)  order by id 
select Top 1 @intermediateComponentType = componentType, @intermediateLocations = locations,@intermediateType = intermediateType, @intermediateSpeedChangeMax = speedChangesMax, @intermediateDrivenBy =  drivenBy from master.tblIntermediateDetails where isDeleted = 0 and componentCode = convert(decimal(18,2),@intermediateComponentCode) order by id 
select Top 1 @coupling1ComponentType = componentType, @coupling1Location = locations, @coupling1Type = couplingType, @coupling1Position = couplingPosition from master.tblCoupling1Details where isDeleted = 0 and componentCode = convert(decimal(18,2),@coupling1ComponentCode) order by id 
select Top 1 @coupling2ComponentType = componentType, @coupling2Location = locations, @coupling2Type = couplingType, @coupling2Position = couplingPosition from master.tblCoupling2Details where isDeleted = 0 and componentCode = convert(decimal(18,2),@coupling2ComponentCode) order by id 

Declare  @LocationDetails table (driverLocations int,driverLocationNDE int,driverLocationDE int,
intermediateLocations int,drivenLocations int,drivenLocationDE int,drivenLocationNDE int)
Declare @sqlStr nvarchar(max) 
set @sqlStr = dbo.funGetLocationDetailsFromPickupCodeDetailsTable(@driverPickupCode,@drivenPickupCode,@intermediatePickupCode,@coupling1PickupCode,@coupling2PickupCode)

insert into @LocationDetails
EXECUTE sp_executesql @sqlStr

select @driverLocations = driverLocations,@driverLocationNDE = driverLocationNDE,@driverLocationDE = driverLocationDE,@intermediateLocations = intermediateLocations,
@drivenLocations = drivenLocations,@drivenLocationDE = drivenLocationDE,@drivenLocationNDE = drivenLocationNDE from @LocationDetails


Declare @driverFaultCode decimal(18,4)

select @driverFaultCode = B.Faultcode from master.tblSpecialFaultCodesDetails A
inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
where A.componentType = @driverComponentType
and A.componentTypeSub1 = @driverType

if(UPPER(RTRIM(LTRIM(@driverType))) = UPPER(RTRIM(LTRIM('diesel'))))
	Begin
		set @driverJson  = (select Convert(int,@driverFaultCode) as [diesel.cylinders] for Json Path)
		set @driverJson = REPLACE(@driverJson,'[','') set @driverJson = REPLACE(@driverJson,']','')
	End
	
if(UPPER(RTRIM(LTRIM(@driverType))) = UPPER(RTRIM(LTRIM('motor'))))
	Begin
		Declare @motorbarsFaultCode decimal(18,4), @motorFanBladesFaultCode decimal(18,4)

		select @motorbarsFaultCode = Faultcode from master.tblSpecialFaultCodesDetails A
		inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
		where A.componentType = @driverComponentType
		and A.componentTypeSub1 = @driverType and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('motorbars')))

		select @motorFanBladesFaultCode = Faultcode from master.tblSpecialFaultCodesDetails A
		inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
		where A.componentType = @driverComponentType
		and A.componentTypeSub1 = @driverType and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('motorfanblades')))
		
		set @driverJson = (select motorDrive,motorFan,motorBallBearings,drivenBallBearings,drivenBalanceable,@motorPoles as [vfd.motorPoles],
		Convert(int,Convert(decimal(18,4),@motorbarsFaultCode)/Convert(decimal(18,4),@driverSpeedRatio)) as [extraFaultData.motorbars],
		Convert(int,Convert(decimal(18,4),@motorFanBladesFaultCode)/Convert(decimal(18,4),@driverSpeedRatio)) as [extraFaultData.motorfanblades]
		from master.tblDriverDetails where Id = @driverId for Json Path, Root ('motor'))
		set @driverJson = REPLACE(@driverJson,'[','') set @driverJson = REPLACE(@driverJson,']','')
	End
	
if(UPPER(RTRIM(LTRIM(@driverType))) = UPPER(RTRIM(LTRIM('turbine'))))
	Begin
		set @driverJson = (select turbineReductionGear,turbineRotorSupported,turbineBallBearing,turbineThrustBearing,turbineThrustBearingIsBall,
		Convert(int,Convert(decimal(18,4),@driverFaultCode)/Convert(decimal(18,4),@driverSpeedRatio)) as [extraFaultData.turbineblades]
		from master.tblDriverDetails where Id = @driverId for Json Path, Root ('turbine'))
		set @driverJson = REPLACE(@driverJson,'[','') set @driverJson = REPLACE(@driverJson,']','')
	End

----======================== Intermediate ======================================================
if(UPPER(RTRIM(LTRIM(@intermediateType))) = UPPER(RTRIM(LTRIM('gearbox'))))
	Begin
		set @interMediateJson  = (select @intermediateSpeedChangeMax as [gearbox.speedChangesMax] for Json Path)
		set @interMediateJson = REPLACE(@interMediateJson,'[','') set @interMediateJson = REPLACE(@interMediateJson,']','')
	End	

if(UPPER(RTRIM(LTRIM(@intermediateType))) = UPPER(RTRIM(LTRIM('AOP'))))
	Begin
		set @interMediateJson  = (select @intermediateDrivenBy as [AOP.drivenBy] for Json Path)
		set @interMediateJson = REPLACE(@interMediateJson,'[','') set @interMediateJson = REPLACE(@interMediateJson,']','')
	End	

if(UPPER(RTRIM(LTRIM(@intermediateType))) = UPPER(RTRIM(LTRIM('AccDrGr'))))
	Begin
		set @interMediateJson  = (select @intermediateDrivenBy as [AccDrGr.drivenBy] for Json Path)
		set @interMediateJson = REPLACE(@interMediateJson,'[','') set @interMediateJson = REPLACE(@interMediateJson,']','')
	End
----======================== Intermediate ======================================================

--======================== Driven ======================================================

	Declare @drivenFaultCode decimal(18,4),@drivenComponentTypeSub2 varchar(50)

	if(@drivenType = 'pump')
		Begin
			set @drivenComponentTypeSub2 = @pumpType
		End
	if(@drivenType = 'compressor')
		Begin
			set @drivenComponentTypeSub2 = @compressorType
		End
	if(@drivenType = 'fan_or_blower')
		Begin
			set @drivenComponentTypeSub2 = @fan_or_blowerType
		End
	if(@drivenType = 'vacuumpump')
		Begin
			set @drivenComponentTypeSub2 = @vacuumpumpType
		End
		

	select @drivenFaultCode = Convert(decimal(18,4),B.Faultcode) from master.tblSpecialFaultCodesDetails A
	inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
	where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
	and componentTypeSub2 = @drivenComponentTypeSub2

	set @drivenSpeedRatio = ISNULL(@intermediateSpeedRatio,1) * ISNULL(@coupling1SpeedRatio,1) * ISNULL(@coupling2SpeedRatio,1)
	
	if(UPPER(RTRIM(LTRIM(@drivenType))) = UPPER(RTRIM(LTRIM('pump'))))
		Begin
			if(UPPER(RTRIM(LTRIM(@pumpType))) = UPPER(RTRIM(LTRIM('centrifugal'))))
				Begin
					set @drivenJson = (select @pumpType as pumpType,@rotorOverhung as [pumpTypes.pumpCentrifugal.rotorOverhung],
					@centrifugalPumpHasBallBearings as [pumpTypes.pumpCentrifugal.centrifugalPumpHasBallBearings],
					@thrustBearing as [pumpTypes.pumpCentrifugal.thrustBearing],
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [pumpTypes.pumpCentrifugal.extraFaultData.pumpvanes]
					for Json Path, Root ('pump'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
			End
			if(UPPER(RTRIM(LTRIM(@pumpType))) = UPPER(RTRIM(LTRIM('propeller'))))
				Begin
					Declare @propplerPumpVanesFaultcode decimal(18,4), @propplerpumpBladesFaultcode decimal(18,4)
					
					select @propplerPumpVanesFaultcode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('pumpvanes')))

					select @propplerpumpBladesFaultcode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('pumpblades')))

					set @drivenJson = (select @pumpType as pumpType,propellerpumpHasBallBearings as [pumpTypes.pumpPropeller.propellerpumpHasBallBearings],
					Convert(int,Convert(decimal(18,4),@propplerPumpVanesFaultcode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [pumpTypes.pumpPropeller.extraFaultData.pumpvanes],
					Convert(int,Convert(decimal(18,4),@propplerpumpBladesFaultcode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [pumpTypes.pumpPropeller.extraFaultData.pumpblades]
					from master.tblDrivenDetails where Id = @drivenId
					for Json Path, Root ('pump'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
			End
			if(UPPER(RTRIM(LTRIM(@pumpType))) = UPPER(RTRIM(LTRIM('rotarythread'))))
				Begin
					set @drivenJson = (select @pumpType as pumpType,rotaryThreadPumpHasBallBearings as [pumpTypes.pumpRotaryThread.rotaryThreadPumpHasBallBearings],
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [pumpTypes.pumpRotaryThread.extraFaultData.pumpthreads]
					from master.tblDrivenDetails where Id = @drivenId
					for Json Path, Root ('pump'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
			End
			if(UPPER(RTRIM(LTRIM(@pumpType))) = UPPER(RTRIM(LTRIM('gear'))))
				Begin
					set @drivenJson = (select @pumpType as pumpType,gearPumpHasBallBearings as [pumpTypes.pumpGear.gearPumpHasBallBearings],
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [pumpTypes.pumpGear.extraFaultData.pumpteeth]
					from master.tblDrivenDetails where Id = @drivenId
					for Json Path, Root ('pump'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
			End
			if(UPPER(RTRIM(LTRIM(@pumpType))) = UPPER(RTRIM(LTRIM('screw'))))
				Begin
					Declare @screwPumpthreadsFaultcode decimal(18,4), 
					@idlerThreadsFaultcode decimal(18,4)
					
					select @screwPumpthreadsFaultcode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('pumpthreads')))

					select @idlerThreadsFaultcode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('idlerthreads')))

					set @drivenJson = (select @pumpType as pumpType,screwPumpHasBallBearings as [pumpTypes.pumpRotaryScrew.screwPumpHasBallBearings],
					Convert(int,Convert(decimal(18,4),@screwPumpthreadsFaultcode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [pumpTypes.pumpRotaryScrew.extraFaultData.pumpthreads],

					Convert(int,Convert(decimal(18,4),@idlerThreadsFaultcode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [pumpTypes.pumpRotaryScrew.extraFaultData.idlerthreads]
					
					from master.tblDrivenDetails where Id = @drivenId
					for Json Path, Root ('pump'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
			End
			if(UPPER(RTRIM(LTRIM(@pumpType))) = UPPER(RTRIM(LTRIM('slidingvane'))))
				Begin
					set @drivenJson = (select @pumpType as pumpType,rotorOverhung as [pumpTypes.pumpRotarySlidingVane.rotorOverhung],
					slidingVanePumpHasBallBearings as [pumpTypes.pumpRotarySlidingVane.slidingVanePumpHasBallBearings],
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [pumpTypes.pumpRotarySlidingVane.extraFaultData.pumpvanes]
					from master.tblDrivenDetails where Id = @drivenId
					for Json Path, Root ('pump'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
				End
			if(UPPER(RTRIM(LTRIM(@pumpType))) = UPPER(RTRIM(LTRIM('axialrecip'))))
				Begin
					set @drivenJson = (select @pumpType as pumpType,attachedOilPump as [pumpTypes.pumpRotaryAxialRecip.attachedOilPump],
					axialRecipPumpHasBallBearings as [pumpTypes.pumpRotaryAxialRecip.axialRecipPumpHasBallBearings],
					thrustBearing as [pumpTypes.pumpRotaryAxialRecip.thrustBearing],
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [pumpTypes.pumpRotaryAxialRecip.extraFaultData.pumppistons]
					from master.tblDrivenDetails where Id = @drivenId
					for Json Path, Root ('pump'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
				End
			if(UPPER(RTRIM(LTRIM(@pumpType))) = UPPER(RTRIM(LTRIM('radialrecip'))))
				Begin
					set @drivenJson = (select @pumpType as pumpType,
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [pumpTypes.pumpRotaryRadialRecip.extraFaultData.pumppistons]
					from master.tblDrivenDetails where Id = @drivenId
					for Json Path, Root ('pump'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
				End
	End

	if(UPPER(RTRIM(LTRIM(@drivenType))) = UPPER(RTRIM(LTRIM('compressor'))))
		Begin
			if(UPPER(RTRIM(LTRIM(@compressorType))) = UPPER(RTRIM(LTRIM('centrifugal'))))
				Begin
					set @drivenJson = (select @compressorType as compressorType,impellerOnMainShaft as [compressorTypes.compressorCentrifugal.impellerOnMainShaft],
					centrifugalCompressorHasBallBearings as [compressorTypes.compressorCentrifugal.centrifugalCompressorHasBallBearings],
					thrustBearing as [compressorTypes.compressorCentrifugal.thrustBearing],
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [compressorTypes.compressorCentrifugal.extraFaultData.compressorvanes] from master.tblDrivenDetails where Id = @drivenId
					for Json Path, Root ('compressor'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
				End

			if(UPPER(RTRIM(LTRIM(@compressorType))) = UPPER(RTRIM(LTRIM('reciprocating'))))
				Begin
					set @drivenJson = (select @compressorType as compressorType,crankHasIntermediateBearing as [compressorTypes.compressorReciporcating.crankHasIntermediateBearing],
					reciprocatingCompressorHasBallBearings as [compressorTypes.compressorReciporcating.reciprocatingCompressorHasBallBearings],
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [compressorTypes.compressorReciporcating.extraFaultData.compressorpistons] from master.tblDrivenDetails where Id = @drivenId
					for Json Path, Root ('compressor'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
				End

			if(UPPER(RTRIM(LTRIM(@compressorType))) = UPPER(RTRIM(LTRIM('screw'))))
				Begin
				
					Declare @screwCompressorthreadsFaultCode decimal(18,4), @screwidlerthreadsFaultCode decimal(18,4)
					
					select @screwCompressorthreadsFaultCode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('compressorthreads')))

					select @screwidlerthreadsFaultCode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('idlerthreads')))

					set @drivenJson = (select @compressorType as compressorType,screwCompressorHasBallBearings as [compressorTypes.compressorScrew.screwCompressorHasBallBearings],
					Convert(int,Convert(decimal(18,4),@screwCompressorthreadsFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [compressorTypes.compressorScrew.extraFaultData.compressorthreads] ,
					Convert(int,Convert(decimal(18,4),@screwidlerthreadsFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [compressorTypes.compressorScrew.extraFaultData.idlerthreads] 
					from master.tblDrivenDetails where Id = @drivenId
					for Json Path, Root ('compressor'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
					--select @drivenJson
				End

			if(UPPER(RTRIM(LTRIM(@compressorType))) = UPPER(RTRIM(LTRIM('screwtwin'))))
				Begin
					Declare @screwtwinCompressorThreads1FaultCode decimal(18,4), 
					@screwtwinIdlerThreads1FaultCode decimal(18,4),
					@screwtwinCompressorthreads2FaultCode decimal(18,4),
					@screwtwinidlerthreads2FaultCode decimal(18,4)
					
					select top 1 @screwtwinCompressorThreads1FaultCode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('compressorthreads1')))
					order by Faultcode

					select top 1 @screwtwinIdlerThreads1FaultCode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('idlerthreads1')))
					order by Faultcode

					select top 1 @screwtwinCompressorthreads2FaultCode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('compressorthreads2')))
					order by Faultcode

					select @screwtwinidlerthreads2FaultCode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('idlerthreads2')))
					order by Faultcode

					set @drivenJson = (select @compressorType as compressorType,
					screwTwinCompressorHasBallBearingsOnHPSide as [compressorTypes.compressorScrewTwin.screwTwinCompressorHasBallBearingsOnHPSide],
					Convert(int,Convert(decimal(18,4),@screwtwinCompressorThreads1FaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [compressorTypes.compressorScrewTwin.extraFaultData.compressorthreads1] ,

					Convert(int,Convert(decimal(18,4),@screwtwinIdlerThreads1FaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [compressorTypes.compressorScrewTwin.extraFaultData.idlerthreads1] ,

					Convert(int,Convert(decimal(18,4),@screwtwinCompressorthreads2FaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [compressorTypes.compressorScrewTwin.extraFaultData.compressorthreads2] ,

					Convert(int,Convert(decimal(18,4),@screwtwinidlerthreads2FaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [compressorTypes.compressorScrewTwin.extraFaultData.idlerthreads2] 

					from master.tblDrivenDetails where Id = @drivenId
					for Json Path, Root ('compressor'))
					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')

				End
		End
	
	if(UPPER(RTRIM(LTRIM(@drivenType))) = UPPER(RTRIM(LTRIM('fan_or_blower'))))
		Begin
					
			if(UPPER(RTRIM(LTRIM(@fan_or_blowerType))) = UPPER(RTRIM(LTRIM('lobed'))))
				Begin
					Declare @lobbedBlowerlobesFaultCode decimal(18,4), @lobbedIdlerlobesFaultCode decimal(18,4)
					
					select @lobbedBlowerlobesFaultCode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('blowerlobes')))

					select @lobbedIdlerlobesFaultCode = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('idlerlobes')))

					set @drivenJson = (select @fan_or_blowerType as fan_or_blowerType,lobedFanOrBlowerHasBallBearings as [fan_or_blowerTypes.fan_or_blowerLobed.lobedFanOrBlowerHasBallBearings],
					Convert(int,Convert(decimal(18,4),@lobbedBlowerlobesFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [fan_or_blowerTypes.fan_or_blowerLobed.extraFaultData.blowerlobes],
					Convert(int,Convert(decimal(18,4),@lobbedIdlerlobesFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [fan_or_blowerTypes.fan_or_blowerLobed.extraFaultData.idlerlobes] 
					from master.tblDrivenDetails where Id = @drivenId for Json Path, Root ('fan_or_blower'))

					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')

				End

			if(UPPER(RTRIM(LTRIM(@fan_or_blowerType))) = UPPER(RTRIM(LTRIM('overhungrotor'))))
				Begin
					
					set @drivenJson = (select @fan_or_blowerType as fan_or_blowerType,fanStages as [fan_or_blowerTypes.fan_or_blowerOverhungRotor.fanStages],
					overhungRotorFanOrBlowerHasBearings as [fan_or_blowerTypes.fan_or_blowerOverhungRotor.overhungRotorFanOrBlowerHasBearings],
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [fan_or_blowerTypes.fan_or_blowerOverhungRotor.extraFaultData.fanblades] 
					from master.tblDrivenDetails where Id = @drivenId for Json Path, Root ('fan_or_blower'))

					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
				End

			if(UPPER(RTRIM(LTRIM(@fan_or_blowerType))) = UPPER(RTRIM(LTRIM('supportedrotor'))))
				Begin
					set @drivenJson = (select @fan_or_blowerType as fan_or_blowerType,supportedRotorFanOrBlowerHasBearings as [fan_or_blowerTypes.fan_or_blowerSupportedRotor.supportedRotorFanOrBlowerHasBearings],
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [fan_or_blowerTypes.fan_or_blowerSupportedRotor.extraFaultData.fanblades] 
					from master.tblDrivenDetails where Id = @drivenId for Json Path, Root ('fan_or_blower'))

					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
				End
		End

	if(UPPER(RTRIM(LTRIM(@drivenType))) = UPPER(RTRIM(LTRIM('purifier_centrifuge'))))
		Begin
			set @drivenJson = (select purifierDrivenBy --as [purifier_centrifuge.purifierDrivenBy]
			from master.tblDrivenDetails where Id = @drivenId for Json Path, Root ('purifier_centrifuge'))

			set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')

		End

	if(UPPER(RTRIM(LTRIM(@drivenType))) = UPPER(RTRIM(LTRIM('generator'))))
		Begin
				Declare @generatorFaultCode decimal(18,4)
				
				select @generatorFaultCode = B.Faultcode from master.tblSpecialFaultCodesDetails A
				inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
				where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType

				set @drivenJson = (select bearingType,exciter ,exciterOverhungOrSupported ,
				drivenBy ,Convert(int,Convert(decimal(18,4),@generatorFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
				as [extraFaultData.generatorbars]
				from master.tblDrivenDetails where Id = @drivenId for Json Path, Root ('generator'))
			
				set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
		End

	if(UPPER(RTRIM(LTRIM(@drivenType))) = UPPER(RTRIM(LTRIM('vacuumpump'))))
		Begin
			if(UPPER(RTRIM(LTRIM(@vacuumpumpType))) = UPPER(RTRIM(LTRIM('centrifugal'))))
				Begin
					set @drivenJson = (select @vacuumpumpType as vacuumpumptype,rotorOverhung as [vacuumpumpTypes.vacuumpumpCentrifugal.rotorOverhung],
					impellerOnMainShaft as [vacuumpumpTypes.vacuumpumpCentrifugal.impellerOnMainShaft],
					bearingsType as [vacuumpumpTypes.vacuumpumpCentrifugal.bearingsType],
					thrustBearing as [vacuumpumpTypes.vacuumpumpCentrifugal.thrustBearing],
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [vacuumpumpTypes.vacuumpumpCentrifugal.extraFaultData.pumpvanes] 
					from master.tblDrivenDetails where Id = @drivenId for Json Path, Root ('vacuumpump'))

					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')

				End

			if(UPPER(RTRIM(LTRIM(@vacuumpumpType))) = UPPER(RTRIM(LTRIM('axialrecip'))))
				Begin
					set @drivenJson = (select @vacuumpumpType as vacuumpumptype,attachedOilPump as [vacuumpumpTypes.vacuumpumpAxialRecip.attachedOilPump],
					bearingsType as [vacuumpumpTypes.vacuumpumpAxialRecip.bearingsType],
					thrustBearing as [vacuumpumpTypes.vacuumpumpAxialRecip.thrustBearing],
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [vacuumpumpTypes.vacuumpumpAxialRecip.extraFaultData.pumppistons] 
					from master.tblDrivenDetails where Id = @drivenId for Json Path, Root ('vacuumpump'))

					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
				End

			if(UPPER(RTRIM(LTRIM(@vacuumpumpType))) = UPPER(RTRIM(LTRIM('radialrecip'))))
				Begin
					set @drivenJson = (select Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [vacuumpumpTypes.vacuumpumpRadialRecip.extraFaultData.pumppistons] 
					from master.tblDrivenDetails where Id = @drivenId for Json Path, Root ('vacuumpump'))

					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
				End

			if(UPPER(RTRIM(LTRIM(@vacuumpumpType))) = UPPER(RTRIM(LTRIM('reciprocating'))))
				Begin
					set @drivenJson = (select bearingsType, 
					Convert(int,Convert(decimal(18,4),@drivenFaultCode)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [vacuumpumpTypes.vacuumpumpReciprocating.extraFaultData.pumppistons] 
					from master.tblDrivenDetails where Id = @drivenId for Json Path, Root ('vacuumpump'))

					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
				End

			if(UPPER(RTRIM(LTRIM(@vacuumpumpType))) = UPPER(RTRIM(LTRIM('lobed'))))
				Begin
					Declare @pumplobesVacuumpumpLobed decimal(18,4), 
					@idlerlobesVacuumpumpLobed decimal(18,4)
					
					select @pumplobesVacuumpumpLobed = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('pumplobes')))

					select @idlerlobesVacuumpumpLobed = B.Faultcode from master.tblSpecialFaultCodesDetails A
					inner join #FaultCodeMatrixTableForDriver B on Upper(Rtrim(Ltrim(A.specialcode))) = Upper(Rtrim(Ltrim(B.FrequencyCode)))
					where A.componentType = @drivenComponentType and A.componentTypeSub1 = @drivenType
					and componentTypeSub2 = @drivenComponentTypeSub2 and UPPER(RTRIM(LTRIM(specialfaultcodetype))) = UPPER(RTRIM(LTRIM('idlerlobes')))

					set @drivenJson = (select bearingsType as [vacuumpumpTypes.vacuumpumpLobed.bearingsType],
					Convert(int,Convert(decimal(18,4),@pumplobesVacuumpumpLobed)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [vacuumpumpTypes.vacuumpumpLobed.extraFaultData.pumplobes],
					Convert(int,Convert(decimal(18,4),@idlerlobesVacuumpumpLobed)/Convert(decimal(18,4),@drivenSpeedRatio))
					as [vacuumpumpTypes.vacuumpumpLobed.extraFaultData.idlerlobes] 
					from master.tblDrivenDetails where Id = @drivenId for Json Path, Root ('vacuumpump'))

					set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
				End
		End

	if(UPPER(RTRIM(LTRIM(@drivenType))) = UPPER(RTRIM(LTRIM('spindle_or_shaft_or_bearing'))))
		Begin
			set @drivenJson  = (select @spindleShaftBearing as [spindle_or_shaft_or_bearing.spindleShaftBearing] for Json Path)
			set @drivenJson = REPLACE(@drivenJson,'[','') set @drivenJson = REPLACE(@drivenJson,']','')
		End

--======================== Driven ====================================================

select * from (
select @driverComponentType as ComponentType, 'Driver' as  Component,@driverLocations as Locations, null as Rpm, @driverLocationDE as LocationDE, @driverLocationNDE as LocationNDE,
@driverType as DriverType,null as SpeedRatio,null as CouplingPosition, null as CouplingType, null as IntermediateType,null as DrivenType,@driverJson as TypeDeatils
Union all
select @drivenComponentType as ComponentType, 'Driven' as  Component,@drivenLocations as locations, null,@drivenLocationDE,@drivenLocationNDE,
null,null,null,null,null,@drivenType as DrivenType,@drivenJson
Union all
select @coupling1ComponentType as ComponentType, 'Coupling1' as  Component,@coupling1Location as locations, null,null,null,
null,@coupling1SpeedRatio,@coupling1Position, @coupling1Type,null,null,null 
Union all
select @coupling2ComponentType as ComponentType, 'Coupling2' as  Component,@coupling2Location as locations, null,null,null,
null,@coupling2SpeedRatio,@coupling2Position, @coupling2Type,null,null,null
Union all
select @intermediateComponentType as ComponentType, 'Intermediate' as  Component,@intermediateLocations as locations, null,null,null,
null,@intermediateSpeedRatio,null, null,@intermediateType ,null,@interMediateJson
) as T where ComponentType IS NOT NULL

drop table #FaultCodeMatrixTableForDriver

End
GO