--=========================[dbo].[funGetPickupCodeDetails]============================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funGetPickupCodeDetails]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
     DROP FUNCTION [dbo].[funGetPickupCodeDetails]
GO

Create FUNCTION [dbo].[funGetPickupCodeDetails]
(
@drivenType varchar(50),
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
--Declare @drivenType varchar(50) = 'spindle_or_shaft_or_bearing'
--Declare @componentType varchar(50) = 'driver'
--Declare @drivencomponentType varchar(50) = 'driven'
--Declare @intercomponentType varchar(50) = null
--Declare @c2componentType varchar(50) = null
--Declare @c1componentType varchar(50) = 'coupling'	
--Declare @locations int = 1
--Declare @driverLocationNDE bit = 0
--Declare @driverLocationDE bit = 1
--Declare @interlocations int = 0
--Declare @intermediatePresent bit = 0
--Declare @drivenlocations int = 2
--Declare @drivenLocationNDE bit = 1
--Declare @drivenLocationDE bit = 1

		Declare @driverPickupCode varchar(50),@drivenPickupCode varchar(50),@intermediatePickupCode varchar(50),
		@coupling1PickupCode varchar(50),@coupling2PickupCode varchar(50),@spindle_shaft_with_2locations bit
		
		if(RTRIM(LTRIM(UPPER(@drivenType))) = 'spindle_or_shaft_or_bearing')
			Begin
				set @spindle_shaft_with_2locations = convert(bit,1)
			End
		else	
			Begin
				set @spindle_shaft_with_2locations = convert(bit,0)
			End

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
		drivenLocationNDE = @drivenLocationNDE and
		spindle_shaft_with_2locations = @spindle_shaft_with_2locations

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
--=========================[dbo].[funGetPickupCodeDetails]============================

--=========================[dbo].[funGetExtraFaultData]============================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funGetExtraFaultData]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
     DROP FUNCTION [dbo].[funGetExtraFaultData]
GO

CREATE FUNCTION [dbo].[funGetExtraFaultData]
(
	@xmlInput xml,
	@type varchar(50)
) 
RETURNS @ResultTable TABLE
( componentName varchar(50),cylinders int,  motorbars int,motorfanblades int,turbineblades int,pumpvanes int, pumpblades int, pumpthreads int, pumpteeth int,
 idlerthreads int,pumppistons int,compressorvanes int,compressorpistons int,compressorthreads int,compressorthreads1 int,idlerthreads1 int,compressorthreads2 int,
 idlerthreads2 int,blowerlobes int,idlerlobes int, fanblades int,generatorbars int,pumplobes int
) AS

BEGIN
		Declare @xmlDocumentHandle int
		EXEC sp_xml_preparedocument @xmlDocumentHandle OUTPUT, @xmlInput;

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
RETURN
END

GO
--=========================[dbo].[funGetExtraFaultData]============================

--=========================[dbo].[funGetExtraFaultData]============================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funGetLocationDetailsFromPickupCodeDetailsTable]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
     DROP FUNCTION [dbo].[funGetLocationDetailsFromPickupCodeDetailsTable]
GO

CREATE FUNCTION [dbo].[funGetLocationDetailsFromPickupCodeDetailsTable]
(
@driverPickupCode varchar(50),
@drivenPickupCode varchar(50),
@intermediatePickupCode varchar(50),
@coupling1PickupCode varchar(50),
@coupling2PickupCode varchar(50))
RETURNS nvarchar(max) 
AS
	Begin
		declare @dynamicSql nvarchar(max) = ''
		set @dynamicSql = 'select Top 1 driverLocations,driverLocationNDE,
		driverLocationDE,intermediateLocations,drivenLocations,
		drivenLocationDE,drivenLocationNDE from master.tblPickupCodeDetails where 1 = 1'

		if(@driverPickupCode <> '' and @driverPickupCode IS NOT NULL)
			set @dynamicSql = @dynamicSql + ' and  driverPickupCode = ' + '''' + @driverPickupCode + ''''
		
		if(@drivenPickupCode <> '' and @drivenPickupCode IS NOT NULL)
			set @dynamicSql = @dynamicSql + ' and  drivenPickupCode = ' + '''' + @drivenPickupCode + ''''
		
		if(@intermediatePickupCode <> '' and @intermediatePickupCode IS NOT NULL)
			set @dynamicSql = @dynamicSql + ' and  intermediatePickupCode = ' + '''' + @intermediatePickupCode + ''''
		
		if(@coupling2PickupCode <> '' and @coupling2PickupCode IS NOT NULL)
			set @dynamicSql = @dynamicSql + ' and  coupling2PickupCode = ' + '''' + @coupling2PickupCode + ''''

		if(@coupling1PickupCode <> '' and @coupling1PickupCode IS NOT NULL)
			set @dynamicSql = @dynamicSql + ' and  coupling1PickupCode = ' + '''' + @coupling1PickupCode + ''''

	Return  @dynamicSql
End


GO
--=========================[dbo].[funGetLocationDetailsFromPickupCodeDetailsTable]============================