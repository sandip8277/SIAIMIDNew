IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funGetPickupCodeDetails]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
     DROP FUNCTION [dbo].[funGetPickupCodeDetails]
GO


Create FUNCTION [dbo].[funGetPickupCodeDetails]
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