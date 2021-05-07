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

---------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAddOrUpdateCSDMdefsDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spAddOrUpdateCSDMdefsDetails]
Go

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
		col_cType varchar(50),
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
		Case when col_cType = ''  then null else col_cType end as col_cType,
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
		fan_or_blowerType varchar(1000),purifierDrivenBy varchar(100),bearingType varchar(100),col_cType varchar(100),
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
				purifierDrivenBy,bearingType,col_cType,
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
				purifierDrivenBy,bearingType,col_cType,
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
				col_cType = d.col_cType,
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
			SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_STATE() AS ErrorState,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;
	END CATCH

	select @Id
END

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
		cylinders int,mortorPoles int,motorFan bit, motorBallBearings bit,drivenBallBearings bit,drivenBalanceable bit,
		turbineReductionGear bit,turbineRotorSupported bit,turbineBallBearing bit,turbineThrustBearing bit,
		turbineThrustBearingIsBall bit, componentCode decimal(18,2))
				
				insert into @DetailsTable
				select id as RecordId,componentType,driverType,motorDrive,locations,
				Case when cylinders = '' then null else cylinders end  as cylinders,
				Case when mortorPoles = '' then null else mortorPoles end  as mortorPoles,
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
				motorBallBearings  varchar(10),drivenBallBearings  varchar(10),drivenBalanceable  varchar(10),mortorPoles varchar(10),turbineReductionGear  varchar(10),
				turbineRotorSupported  varchar(10),turbineBallBearing  varchar(10),turbineThrustBearing  varchar(10),turbineThrustBearingIsBall  varchar(10),
				componentCode varchar(10))

				select @Id = id from @DetailsTable

		if(@Id = 0)
			Begin
				insert into master.tblDriverDetails (componentType,driverType,motorDrive,locations,cylinders,mortorPoles,
				motorFan,motorBallBearings,drivenBallBearings,drivenBalanceable,turbineReductionGear,turbineRotorSupported,
				turbineBallBearing,turbineThrustBearing,turbineThrustBearingIsBall,componentCode)
				select componentType,driverType,motorDrive,locations,cylinders,mortorPoles,
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
				mortorPoles = d.mortorPoles,
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
		locations int,drivenBy varchar(100),speedChangesMax int,gearBoxLocations int,
		inputBearing int ,intermediateBearing1st varchar(1000),intermediateBearing2nd varchar(1000),
		outputBearing varchar(1000),componentCode decimal(18,2))
				
		insert into @DetailsTable
		select id,componentType,intermediateType, locations,drivenBy,speedChangesMax,gearBoxLocations,
		inputBearing,intermediateBearing1st,intermediateBearing2nd,outputBearing,componentCode
		FROM OPENXML (@xmlDocumentHandle, 'IntermediateDetails',2)
		WITH (id bigint,componentType varchar(100),intermediateType varchar(100), 
		drivenBy varchar(100),inputBearing int ,intermediateBearing1st varchar(1000),
		intermediateBearing2nd varchar(1000),outputBearing varchar(1000),speedChangesMax int,
		locations int, gearBoxLocations int,componentCode decimal(18,2))

		select @Id = id from @DetailsTable
		if(@Id = 0)
			Begin
				insert into master.tblIntermediateDetails (componentType,immediateType, locations,drivenBy,speedChangesMax,gearBoxLocations,
				inputBearing,intermediateBearing1st,intermediateBearing2nd,outputBearing,componentCode)
				select componentType,intermediateType, locations,drivenBy,speedChangesMax,gearBoxLocations,
				inputBearing,intermediateBearing1st,intermediateBearing2nd,outputBearing,componentCode from @DetailsTable
				
				set @Id = SCOPE_IDENTITY()

			End
		Else
			Begin
				Update master.tblIntermediateDetails set 
				componentType = d.componentType,
				immediateType = d.intermediateType,
				locations = d.locations,
				drivenBy = d.drivenBy,
				speedChangesMax = d.speedChangesMax,
				gearBoxLocations = d.gearBoxLocations,
				inputBearing = d.inputBearing,
				intermediateBearing1st = d.intermediateBearing1st,
				intermediateBearing2nd = d.intermediateBearing2nd,
				outputBearing = d.outputBearing,
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

--------------------------------------------------------------------------------------------- 7

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAddOrUpdateSpecialFaultCodesDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spAddOrUpdateSpecialFaultCodesDetails]
Go
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

--------------------------------------------------------------------------------------------- 8

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDeleteCoupling1DetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spDeleteCoupling1DetailsById]
Go

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

---------------------------------------------------------------------------------------------- 9

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDeleteCoupling2DetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spDeleteCoupling2DetailsById]
Go

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

------------------------------------------------------------------------------------------- 10

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDeleteCSDMdefsDetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spDeleteCSDMdefsDetailsById]
Go

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

------------------------------------------------------------------------------------------- 11

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDeleteDrivenDetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spDeleteDrivenDetailsById]
Go

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

------------------------------------------------------------------------------------------- 12

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDeleteDriverDetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spDeleteDriverDetailsById]
Go

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

------------------------------------------------------------------------------------------- 13

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDeleteIntermediateDetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spDeleteIntermediateDetailsById]
Go

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

------------------------------------------------------------------------------------------- 14

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' [dbo].[spDeleteSpecialFaultCodesDetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spDeleteSpecialFaultCodesDetailsById]
Go

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

------------------------------------------------------------------------------------------- 15

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' [dbo].[spGenerateMIDDerivation]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGenerateMIDDerivation]
Go

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
Declare @componentType varchar(100),@driverType varchar(100),@motorDrive varchar(100)
Declare @locations int,@cylinders int,@mortorPoles int
Declare @motorFan varchar(10),@motorBallBearings  varchar(10),@drivenBallBearings  varchar(10),@drivenBalanceable  varchar(10),
@turbineReductionGear  varchar(10),@turbineRotorSupported  varchar(10),@turbineBallBearing  varchar(10),@turbineThrustBearing  varchar(10),
@turbineThrustBearingIsBall  varchar(10),@driverLocationNDE bit,@driverLocationDE bit
Declare @driverRPM decimal(18,2) = null
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
Declare @intercomponentType varchar(100),@immediateType varchar(100), 
@drivenBy varchar(100),@inputBearing int ,@intermediateBearing1st varchar(1000),
@intermediateBearing2nd varchar(1000),@outputBearing varchar(1000)
Declare @speedChangesMax int,@interlocations int, @gearBoxLocations int,@intermediateSpeedRatio decimal(18,4)
Declare @intermediatePresent bit
--Declare variable for intermediate component --

--Declare variable for driven component --
Declare @drivencomponentType varchar(100),@drivenType varchar(100), 
@pumpType varchar(100),@compressorType varchar(1000) ,@fan_or_blowerType varchar(1000),
@purifierDrivenBy varchar(100),@bearingType varchar(100),@col_cType varchar(100),
@exciterOverhungOrSupported varchar(100),@bearingsType varchar(100),@thrustBearing varchar(100),
@drivenBy1 varchar(100) = null
Declare @drivenRPM decimal(18,2)
Declare @drivenlocations int
Declare @rotorOverhung  varchar(10),@attachedOilPump  varchar(10),@impellerOnMainShaft  varchar(10),@crankHasIntermediateBearing  varchar(10),
@fanStages  varchar(10),@exciter  varchar(10),@centrifugalPumpHasBallBearings  varchar(10),@propellerpumpHasBallBearings  varchar(10),
@rotaryThreadPumpHasBallBearings  varchar(10), @gearPumpHasBallBearings  varchar(10),@screwPumpHasBallBearings  varchar(10),
@slidingVanePumpHasBallBearings  varchar(10), @axialRecipPumpHasBallBearings  varchar(10),@centrifugalCompressorHasBallBearings  varchar(10),
@reciprocatingCompressorHasBallBearings  varchar(10),@screwCompressorHasBallBearings  varchar(10),@screwTwinCompressorHasBallBearingsOnHPSide  varchar(10),
@lobedFanOrBlowerHasBallBearings  varchar(10),@overhungRotorFanOrBlowerHasBearings  varchar(10), @supportedRotorFanOrBlowerHasBearings  varchar(10),
@drivenLocationNDE bit,@drivenLocationDE bit
--Declare variable for driven component --

--- Read xml for driver component --
select @componentType = case when componentType = '' then null else componentType end,@driverType = driverType, @motorDrive = motorDrive,
@locations = locations,@cylinders = cylinders,@mortorPoles = mortorPoles,
@motorFan = Case when motorFan = '' then null else motorFan end ,
@motorBallBearings = Case when motorBallBearings = '' then null else motorBallBearings end ,
@drivenBallBearings = Case when drivenBallBearings = '' then null else drivenBallBearings end,
@drivenBalanceable = Case when drivenBalanceable = '' then null else drivenBalanceable end ,
@turbineReductionGear = Case when turbineReductionGear = '' then null else turbineReductionGear end ,
@turbineRotorSupported = Case when turbineRotorSupported = '' then null else turbineRotorSupported end ,
@turbineBallBearing = Case when turbineBallBearing = '' then null else turbineBallBearing end ,
@turbineThrustBearing = Case when turbineThrustBearing = '' then null else turbineThrustBearing end , 
@turbineThrustBearingIsBall = Case when turbineThrustBearingIsBall = '' then null else turbineThrustBearingIsBall end  ,
@driverLocationNDE  = Case when driverLocationNDE  = '' then null else driverLocationNDE end  ,
@driverLocationDE  = Case when driverLocationDE  = '' then null else driverLocationDE end  ,
--@driverRPM = rpm
@driverRPM = Convert(decimal(18,2),Case when rpm = '' then null else rpm end )
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driver',2)
WITH (componentType varchar(100),locations int,driverType varchar(100),cylinders int,motorDrive varchar(100),motorFan varchar(10),
motorBallBearings  varchar(10),drivenBallBearings  varchar(10),drivenBalanceable  varchar(10),mortorPoles int,turbineReductionGear  varchar(10),
turbineRotorSupported  varchar(10),turbineBallBearing  varchar(10),turbineThrustBearing  varchar(10),turbineThrustBearingIsBall  varchar(10),
rpm  varchar(10),driverLocationDE varchar(10),driverLocationNDE varchar(10))
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
WITH (componentType varchar(100),couplingType varchar(100),coupledComponentType1 varchar(100),coupledComponentType2 varchar(100),
couplingPosition int,locations int,speedratio varchar(20))
--- Read xml for coupling2 component --

--- Read xml for intermediate component --
select @intercomponentType = case when componentType = '' then null else componentType end,@immediateType = immediateType, 
@drivenBy = drivenBy,@inputBearing = inputBearing,@intermediateBearing1st = intermediateBearing1st,
@intermediateBearing2nd = intermediateBearing2nd,@outputBearing = outputBearing,
@speedChangesMax = speedChangesMax,@interlocations = locations, @gearBoxLocations = gearBoxLocations,
@intermediateSpeedRatio = ISNULL(Convert(decimal(18,4),Case when speedratio = '' then null else speedratio end ),1) 
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/intermediate',2)
WITH (componentType varchar(100),immediateType varchar(100), 
drivenBy varchar(100),inputBearing int ,intermediateBearing1st varchar(1000),
intermediateBearing2nd varchar(1000),outputBearing varchar(1000),speedChangesMax int,
locations int, gearBoxLocations int,speedratio varchar(20))
--- Read xml for intermediate component --

--- Read xml for driven component --
select @drivencomponentType = Case when componentType = '' then null else componentType end,@drivenType = drivenType, 
@pumpType = pumpType,@compressorType = compressorType,@fan_or_blowerType = fan_or_blowerType,
@purifierDrivenBy = purifierDrivenBy,@bearingType = bearingType,@col_cType = col_cType,
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
--@drivenRPM = rpm
@drivenRPM = Convert(decimal(18,2),Case when rpm = '' then null else rpm end ),
@drivenLocationNDE  = Case when drivenLocationNDE  = '' then null else drivenLocationNDE end  ,
@drivenLocationDE  = Case when drivenLocationDE  = '' then null else drivenLocationDE end  
FROM OPENXML (@xmlDocumentHandle, 'MIDCodeCreatorRequest/machineComponentsForMIDgeneration/driven',2)
WITH (componentType varchar(100),drivenType varchar(100),pumpType varchar(100),compressorType varchar(1000),
fan_or_blowerType varchar(1000),purifierDrivenBy varchar(100),bearingType varchar(100),col_cType varchar(100),
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

select @intermediatePresent = case when @intercomponentType IS NOT NULL and @intercomponentType <> '' then convert(bit,1) 
else convert(bit,0) end 

select @driverPickupCode = driverPickupCode,@drivenPickupCode = drivenPickupCode,@intermediatePickupCode = intermediatePickupCode,
@coupling1PickupCode = coupling1PickupCode,@coupling2PickupCode = coupling2PickupCode
from funGetPickupCodeDetails (@componentType,@drivencomponentType,@intercomponentType,@c2componentType,@c1componentType, ISNULL(@locations,0),ISNULL(@driverLocationNDE,convert(bit,0)),ISNULL(@driverLocationDE,convert(bit,0)),
ISNULL(@interlocations,0),@intermediatePresent, ISNULL(@drivenlocations,0),
ISNULL(@drivenLocationNDE,convert(bit,0)),ISNULL(@drivenLocationDE,convert(bit,0)))

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
ISNULL(mortorPoles,0) = 
	Case when @mortorPoles = '' Or @mortorPoles IS NULL then 0
	else @mortorPoles end
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
ISNULL(immediateType,'X') = 
	Case when @immediateType = '' Or @immediateType IS NULL then 'X'
	else @immediateType end 
and
ISNULL(drivenBy,'X') = 
	Case when @drivenBy = '' Or @drivenBy IS NULL then 'X'
	else @drivenBy end 
and
ISNULL(Convert(varchar(10),inputBearing),'X') = 
	Case when @inputBearing = '' Or @inputBearing IS NULL then 'X'
	else convert(varchar(10),@inputBearing) end 
and
ISNULL(intermediateBearing1st,'X') = 
	Case when @intermediateBearing1st = '' Or @intermediateBearing1st IS NULL then 'X'
	else @intermediateBearing1st end 
and
ISNULL(intermediateBearing2nd,'X') = 
	Case when @intermediateBearing2nd = '' Or @intermediateBearing2nd IS NULL then 'X'
	else @intermediateBearing2nd end 
and
ISNULL(outputBearing,'X') = 
	Case when @outputBearing = '' Or @outputBearing IS NULL then 'X'
	else @outputBearing end
and
ISNULL(Convert(varchar(10),speedChangesMax),'X') = 
	Case when @speedChangesMax = '' Or @speedChangesMax IS NULL then 'X'
	else convert(varchar(10),@speedChangesMax) end 
and 
ISNULL(Convert(varchar(10),locations),'X') = 
	Case when @interlocations = '' Or @interlocations IS NULL then 'X'
	else convert(varchar(10),@interlocations) end 
and 
ISNULL(Convert(varchar(10),gearBoxLocations),'X') = 
	Case when @gearBoxLocations = '' Or @gearBoxLocations IS NULL then 'X'
	else convert(varchar(10),@gearBoxLocations) end 

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
ISNULL(UPPER(RTRIM(LTRIM(col_cType))),'X') = 
	Case when @col_cType = '' Or @col_cType IS NULL then 'X'
	else UPPER(RTRIM(LTRIM(@col_cType))) end
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
	--select @MachineSpeedRatio

	Exec dbo.spGenerateMIDDerivation1 @xmlInput,@DriverComponentCode,@DrivenComponentCode,@MachineSpeedRatio,@FaultCodeMatrixJson output
	
	select Component,ComponentCode,PickupCode,null as FaultCodeMatrixJson from #ComponentCodeDetails
	Union all
	select  'FaultCodeMatrix' as Component,null,null,@FaultCodeMatrixJson as FaultCodeMatrixJson
	
	drop table #ComponentCodeDetails
End


------------------------------------------------------------------------------------------- 16

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' [dbo].[spGenerateMIDDerivation1]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGenerateMIDDerivation1]
Go

CREATE Procedure [dbo].[spGenerateMIDDerivation1]
@xmlInput xml = '',
@driverComponentCode decimal(18,4),
@drivenComponentCode decimal(18,4),
@machineSpeedRatio decimal(18,4),
@FaultCodeMatrixJson nvarchar(max) output
As
Begin

--Declare @machineSpeedRatio decimal(18,4) = 1.28
--Declare @driverComponentCode decimal(18,4) = 5.01
--Declare @drivenComponentCode decimal(18,4) = null
--Declare @xmlInput xml = ''
--Declare @FaultCodeMatrixJson nvarchar(max) --output

--set @xmlInput = '<MIDCodeCreatorRequest xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><machineComponentsForMIDgeneration><driver><componentType>Driver</componentType><locations>1</locations><driverType>motor</driverType><cylinders xsi:nil="true" /><motorDrive>AC</motorDrive><motorFan>true</motorFan><motorBallBearings>true</motorBallBearings><drivenBallBearings>true</drivenBallBearings><drivenBalanceable>true</drivenBalanceable><mortorPoles xsi:nil="true" /><turbineReductionGear xsi:nil="true" /><turbineRotorSupported xsi:nil="true" /><turbineBallBearing xsi:nil="true" /><turbineThrustBearing xsi:nil="true" /><turbineThrustBearingIsBall xsi:nil="true" /><rpm>9</rpm><specialFaultCodesInput><SpecialFaultCodesInput><specialFaultCodeCount xsi:nil="true" /></SpecialFaultCodesInput></specialFaultCodesInput></driver><coupling1><id>0</id><componentType>coupling</componentType><couplingPosition>1</couplingPosition><couplingType>beltdrive</couplingType><locations xsi:nil="true" /><speedratio>3.2</speedratio></coupling1><intermediate><componentType>intermediate</componentType><immediateType>gearbox</immediateType><locations xsi:nil="true" /><speedChangesMax>1</speedChangesMax><gearBoxLocations>1</gearBoxLocations><inputBearing>3</inputBearing></intermediate><coupling2><componentType>coupling</componentType><couplingPosition>2</couplingPosition><couplingType>chaindrive</couplingType><locations xsi:nil="true" /><speedratio>1</speedratio></coupling2><driven><componentType>driven</componentType><drivenType>pump</drivenType><locations>1</locations><pumpType>centrifugal</pumpType><rotorOverhung xsi:nil="true" /><attachedOilPump xsi:nil="true" /><impellerOnMainShaft xsi:nil="true" /><crankHasIntermediateBearing xsi:nil="true" /><fanStages xsi:nil="true" /><exciter xsi:nil="true" /><centrifugalPumpHasBallBearings>true</centrifugalPumpHasBallBearings><propellerpumpHasBallBearings xsi:nil="true" /><rotaryThreadPumpHasBallBearings xsi:nil="true" /><gearPumpHasBallBearings xsi:nil="true" /><screwPumpHasBallBearings xsi:nil="true" /><slidingVanePumpHasBallBearings xsi:nil="true" /><axialRecipPumpHasBallBearings xsi:nil="true" /><centrifugalCompressorHasBallBearings xsi:nil="true" /><reciprocatingCompressorHasBallBearings xsi:nil="true" /><screwCompressorHasBallBearings xsi:nil="true" /><screwTwinCompressorHasBallBearingsOnHPSide xsi:nil="true" /><lobedFanOrBlowerHasBallBearings xsi:nil="true" /><overhungRotorFanOrBlowerHasBearings>true</overhungRotorFanOrBlowerHasBearings><supportedRotorFanOrBlowerHasBearings xsi:nil="true" /><rpm>25</rpm><specialFaultCodesInput><SpecialFaultCodesInput><specialFaultCodeType>vanes</specialFaultCodeType><specialFaultCodeCount>8</specialFaultCodeCount></SpecialFaultCodesInput></specialFaultCodesInput></driven></machineComponentsForMIDgeneration></MIDCodeCreatorRequest>'

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

	--Declare @FaultCodeMatrixJson nvarchar(max) = '';

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

------------------------------------------------------------------------------------------- 18

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' [dbo].[spGetAllCoupling2Details]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetAllCoupling2Details]
Go

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

------------------------------------------------------------------------------------------- 19

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' [dbo].[spGetAllCSDMdefsDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetAllCSDMdefsDetails]
Go

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

------------------------------------------------------------------------------------------- 20

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' [dbo].[spGetAllDrivenDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetAllDrivenDetails]
Go

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

------------------------------------------------------------------------------------------- 21

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetAllDriverDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetAllDriverDetails]
Go

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

------------------------------------------------------------------------------------------- 22

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetAllIntermediateDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetAllIntermediateDetails]
Go

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
			UPPER(RTRIM(LTRIM(immediateType))) = UPPER(RTRIM(LTRIM(@intermediateType))) and isDeleted = 0
		End
	else if(@componentType IS NULL and @intermediateType IS NOT NULL)
		Begin
			select * from master.tblIntermediateDetails 
			where UPPER(RTRIM(LTRIM(immediateType))) = UPPER(RTRIM(LTRIM(@intermediateType))) and isDeleted = 0
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

------------------------------------------------------------------------------------------- 23

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetAllSpecialFaultCodesDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetAllSpecialFaultCodesDetails]
Go

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

------------------------------------------------------------------------------------------- 24

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetCoupling1Details]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetCoupling1Details]
Go

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

------------------------------------------------------------------------------------------- 25

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetCoupling1DetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetCoupling1DetailsById]
Go

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

------------------------------------------------------------------------------------------- 26

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetCoupling2Details]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetCoupling2Details]
Go

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

------------------------------------------------------------------------------------------- 27

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetCoupling2DetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetCoupling2DetailsById]
Go

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

------------------------------------------------------------------------------------------- 28

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

------------------------------------------------------------------------------------------- 29

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetCSDMdefsDetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetCSDMdefsDetailsById]
Go

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

------------------------------------------------------------------------------------------- 30

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetDrivenDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetDrivenDetails]
Go

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
		@purifierDrivenBy varchar(100),@bearingType varchar(100),@col_cType varchar(100),
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
		@col_cType = Case when col_cType = ''  then null else col_cType end,
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
		fan_or_blowerType varchar(1000),purifierDrivenBy varchar(100),bearingType varchar(100),col_cType varchar(100),
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
				ISNULL(UPPER(RTRIM(LTRIM(col_cType))),'X') = 
					Case when @col_cType = '' Or @col_cType IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@col_cType))) end
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
				ISNULL(UPPER(RTRIM(LTRIM(col_cType))),'X') = 
					Case when @col_cType = '' Or @col_cType IS NULL then 'X'
					else UPPER(RTRIM(LTRIM(@col_cType))) end
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

------------------------------------------------------------------------------------------- 31

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetDrivenDetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetDrivenDetailsById]
Go

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

------------------------------------------------------------------------------------------- 32

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetDriverDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetDriverDetails]
Go

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

------------------------------------------------------------------------------------------- 33

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetDriverDetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetDriverDetailsById]
Go

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

------------------------------------------------------------------------------------------- 34

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetIntermediateDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetIntermediateDetails]
Go


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
		Declare @speedChangesMax int,@interlocations int, @gearBoxLocations int
		--Declare variable for intermediate component --

		--- Read xml for intermediate component --
		select @id= id, @intercomponentType = componentType,@intermediateType = intermediateType, 
		@drivenBy = drivenBy,@inputBearing = inputBearing,@intermediateBearing1st = intermediateBearing1st,
		@intermediateBearing2nd = intermediateBearing2nd,@outputBearing = outputBearing,
		@speedChangesMax = speedChangesMax,@interlocations = locations, @gearBoxLocations = gearBoxLocations FROM OPENXML (@xmlDocumentHandle, 'IntermediateDetails',2)
		WITH (id bigint,componentType varchar(100),intermediateType varchar(100), 
		drivenBy varchar(100),inputBearing int ,intermediateBearing1st varchar(1000),
		intermediateBearing2nd varchar(1000),outputBearing varchar(1000),speedChangesMax int,
		locations int, gearBoxLocations int)
		--- Read xml for intermediate component --

		if(@id = 0 )
		Begin
			select * from master.tblIntermediateDetails
			WHERE isDeleted = 0 and 
			ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @intercomponentType = '' Or @intercomponentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intercomponentType))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(immediateType))),'X') = 
				Case when @intermediateType = '' Or @intermediateType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intermediateType))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(drivenBy))),'X') = 
				Case when @drivenBy = '' Or @drivenBy IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@drivenBy))) end 
			and
			ISNULL(Convert(varchar(10),inputBearing),'X') = 
				Case when @inputBearing = '' Or @inputBearing IS NULL then 'X'
				else convert(varchar(10),@inputBearing) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(intermediateBearing1st))),'X') = 
				Case when @intermediateBearing1st = '' Or @intermediateBearing1st IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intermediateBearing1st))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(intermediateBearing2nd))),'X') = 
				Case when @intermediateBearing2nd = '' Or @intermediateBearing2nd IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intermediateBearing2nd))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(outputBearing))),'X') = 
				Case when @outputBearing = '' Or @outputBearing IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@outputBearing))) end
			and
			ISNULL(Convert(varchar(10),speedChangesMax),'X') = 
				Case when @speedChangesMax = '' Or @speedChangesMax IS NULL then 'X'
				else convert(varchar(10),@speedChangesMax) end 
			and 
			ISNULL(locations,'0') = 
				Case when @interlocations = '' Or @interlocations IS NULL then '0'
				else @interlocations end
			and 
			ISNULL(gearBoxLocations,'0') = 
				Case when @gearBoxLocations = '' Or @gearBoxLocations IS NULL then '0'
				else @gearBoxLocations end

			End
		else
			Begin
				select * from master.tblIntermediateDetails
				WHERE isDeleted = 0 and id <> @id and 
			ISNULL(UPPER(RTRIM(LTRIM(componentType))),'X') = 
				Case when @intercomponentType = '' Or @intercomponentType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intercomponentType))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(immediateType))),'X') = 
				Case when @intermediateType = '' Or @intermediateType IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intermediateType))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(drivenBy))),'X') = 
				Case when @drivenBy = '' Or @drivenBy IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@drivenBy))) end 
			and
			ISNULL(Convert(varchar(10),inputBearing),'X') = 
				Case when @inputBearing = '' Or @inputBearing IS NULL then 'X'
				else convert(varchar(10),@inputBearing) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(intermediateBearing1st))),'X') = 
				Case when @intermediateBearing1st = '' Or @intermediateBearing1st IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intermediateBearing1st))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(intermediateBearing2nd))),'X') = 
				Case when @intermediateBearing2nd = '' Or @intermediateBearing2nd IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@intermediateBearing2nd))) end 
			and
			ISNULL(UPPER(RTRIM(LTRIM(outputBearing))),'X') = 
				Case when @outputBearing = '' Or @outputBearing IS NULL then 'X'
				else UPPER(RTRIM(LTRIM(@outputBearing))) end
			and
			ISNULL(Convert(varchar(10),speedChangesMax),'X') = 
				Case when @speedChangesMax = '' Or @speedChangesMax IS NULL then 'X'
				else convert(varchar(10),@speedChangesMax) end 
			and 
			ISNULL(locations,'0') = 
				Case when @interlocations = '' Or @interlocations IS NULL then '0'
				else @interlocations end
			and 
			ISNULL(gearBoxLocations,'0') = 
				Case when @gearBoxLocations = '' Or @gearBoxLocations IS NULL then '0'
				else @gearBoxLocations end  
			End
END

------------------------------------------------------------------------------------------- 35

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetIntermediateDetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetIntermediateDetailsById]
Go

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

------------------------------------------------------------------------------------------- 36

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetSpecialFaultCodesDetails]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE  [dbo].[spGetSpecialFaultCodesDetails]
Go

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

------------------------------------------------------------------------------------------- 37

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetSpecialFaultCodesDetailsById]') 
AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spGetSpecialFaultCodesDetailsById]
Go

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
