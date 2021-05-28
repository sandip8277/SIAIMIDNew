using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class Constants
    {
        public static string xmlInput = "xmlInput";

        public static string spMIDCodeDeconstruction = "spMIDCodeDeconstruction";

        public static string spGenerareMIDCodesSPName = "spGenerateMIDDerivation";

        public static string spAddOrUpdateDriverDetails = "spAddOrUpdateDriverDetails";

        public static string spGetAllDriverDetails = "spGetAllDriverDetails";

        public static string spGetDriverDetailsById = "spGetDriverDetailsById";

        public static string spDeleteDriverDetailsById = "spDeleteDriverDetailsById";

        public static string spCheckIsDriverDetailsExist = "spGetDriverDetails";


        public static string spAddOrUpdateDrivenDetails = "spAddOrUpdateDrivenDetails";

        public static string spCheckIsDrivenDetailsExist = "spGetDrivenDetails";

        public static string spDeleteDrivenDetailsById = "spDeleteDrivenDetailsById";

        public static string spGetDrivenDetailsById = "spGetDrivenDetailsById";

        public static string spGetAllDrivenDetails = "spGetAllDrivenDetails";


        public static string spAddOrUpdateIntermediateDetails = "spAddOrUpdateIntermediateDetails";

        public static string spCheckIsIntermediateDetailsExist = "spGetIntermediateDetails";

        public static string spDeleteIntermediateDetailsById = "spDeleteIntermediateDetailsById";

        public static string spGetIntermediateDetailsById = "spGetIntermediateDetailsById";

        public static string spGetAllIntermediateDetails = "spGetAllIntermediateDetails";

        
        public static string spAddOrUpdateCoupling1Details = "spAddOrUpdateCoupling1Details";

        public static string spCheckIsCoupling1DetailsExist = "spGetCoupling1Details";

        public static string spDeleteCoupling1DetailsById = "spDeleteCoupling1DetailsById";

        public static string spGetCoupling1DetailsById = "spGetCoupling1DetailsById";

        public static string spGetAllCoupling1Details = "spGetAllCoupling1Details";


        public static string spAddOrUpdateCoupling2Details = "spAddOrUpdateCoupling2Details";

        public static string spCheckIsCoupling2DetailsExist = "spGetCoupling2Details";

        public static string spDeleteCoupling2DetailsById = "spDeleteCoupling2DetailsById";

        public static string spGetCoupling2DetailsById = "spGetCoupling2DetailsById";

        public static string spGetAllCoupling2Details = "spGetAllCoupling2Details";



        public static string spAddOrUpdateSpecialFaultCodesDetails = "spAddOrUpdateSpecialFaultCodesDetails";

        public static string spCheckIsSpecialFaultCodesDetailsExist = "spGetSpecialFaultCodesDetails";

        public static string spDeleteSpecialFaultCodesDetailsById = "spDeleteSpecialFaultCodesDetailsById";

        public static string spGetSpecialFaultCodesDetailsById = "spGetSpecialFaultCodesDetailsById";

        public static string spGetAllSpecialFaultCodesDetails = "spGetAllSpecialFaultCodesDetails";


        public static string spAddOrUpdateCSDMdefsDetails = "spAddOrUpdateCSDMdefsDetails";

        public static string spCheckIsCSDMdefsDetailsExist = "spGetCSDMdefsDetails";

        public static string spDeleteCSDMdefsDetailsById = "spDeleteCSDMdefsDetailsById";

        public static string spGetCSDMdefsDetailsById = "spGetCSDMdefsDetailsById";

        public static string spGetAllCSDMdefsDetails = "spGetAllCSDMdefsDetails";


        public static string spAddOrUpdatePickupCodeDetails = "spAddOrUpdatePickupCodeDetails";

        public static string spCheckIsPickupCodeDetailsExist = "spGetPickupCodeDetails";

        public static string spDeletePickupCodeDetailsById = "spDeletePickupCodeDetailsById";

        public static string spGetPickupCodeDetailsById = "spGetPickupCodeDetailsById";

        public static string spGetAllPickupCodeDetails = "spGetAllPickupCodeDetails";



        public static string componentType = "componentType";

        public static string driverType = "driverType";

        public static string drivenType = "drivenType";

        public static string couplingType = "couplingType";

        public static string intermediateType = "intermediateType";

        public static string Id = "Id";

        public static string specialFaultCodesType = "specialFaultCodesType";

        public static string specialCode = "specialCode";

        public static string csdmfile = "csdmfile";

        public static string recordSaved = "Record saved successfully";

        public static string recordDeleted = "Record deleted successfully";

        public static string recordNotFound = "Record not found";

        public static string recordExist = "Record already exist";


        //Driver validation message

        public static string driverComponentTypeValidationMsg = "componentType is a required string and must be driver, coupling, intermediate, driven";

        public static string driverLocationValidationMsg = "locations is a required integer and must be 1 through 10";

        public static string driverLocationNDEValidationMsg = "driverLocationNDE is a required boolean";

        public static string driverLocationDEValidationMsg = "driverLocationDE is a required boolean";

        public static string driverTypeTypeValidationMsg = "driverType is a required string and must be diesel, motor, turbine";

        public static string driversValidationMsg = "drivers one type must be used diesel, motor, turbine";

        public static string driversCylindersValidationMsg = "cylinders is a required integer if driverType is diesel and must be 2, 4, 6, 8, 10, 12, 16, 18, 20";

        public static string driversMotorDriveValidationMsg = "motorDrive is a required string if driverType is motor and must be AC, DC, VFD";

        public static string driverMotorFanRequiredValidationMsg = "motorFan is a required boolean if driverType is motor";

        public static string driverMotorBallBearingsRequiredValidationMsg = "motorBallBearings is a required boolean if driverType is motor";

        public static string driverDrivenBallBearingsRequiredValidationMsg = "drivenBallBearings is a required boolean if driverType is motor";

        public static string driverDrivenBalanceableRequiredValidationMsg = "drivenBallBearings is a required boolean if driverType is motor";

        public static string driverMotorPolesValidationMsg = "motorPoles is a required integer if motorDrive is VFD and must be 2, 4, 6, 8, 10";

        public static string driverTurbineReductionGearRequiredValidationMsg = "turbineReductionGear is a required boolean if driverType is turbine";

        public static string driverTurbineRotorSupportedRequiredValidationMsg = "turbineRotorSupported is a required boolean if driverType is turbine";

        public static string driverTurbineBallBearingRequiredValidationMsg = "turbineBallBearing is a required boolean if driverType is turbine";

        public static string driverTurbineThrustBearingRequiredValidationMsg = "turbineThrustBearing is a required boolean if driverType is turbine";

        public static string driverTurbineThrustBearingIsBallRequiredValidationMsg = "turbineThrustBearingIsBall is a optional boolean if driverType is turbine";

        public static string driverSpecialFaultCodesInputValidationMsg = "specialFaultCodeCount is a required integer if specialFaultCodeType is not null";


        //Coupling1 validation message

        public static string coupling1ComponentTypeValidationMsg = "componentType is a required string and must be driver, coupling, intermediate, driven";
        
        public static string coupling1PositionTypeRequiredMessage = "couplingPosition is a required integer and must be 1,2";

        public static string coupling1CouplingTypeRequiredMessage = "couplingType is a required string and must be none_rigid, beltdrive, chaindrive, magnetic, flexible, fluid";

        public static string coupling1LocationValidationMessage = "locations is an optional integer and must be 1 through 10";

        public static string coupling1SpeedRatioRequiredMessage = "speedratio is required decimal - default is 1.0000";

        public static string componentCodeRequiredMessage = "component code is required";

        public static string idValidationMessage = "id should be greater than 0";

        //Coupling2 validation message
        public static string coupling2ComponentTypeRequiredMsg = "componentType is a required string and must be driver, coupling, intermediate, driven";

        public static string coupling2ComponentTypeValidationMsg = "componentType is a required string and must be driver, coupling, intermediate, driven; must be null if intermediate is not present";

        public static string coupling2ComponentTypeValidationMsgIfIntermediateNotPresent = "componentType must be null if intermediate is not present";

        public static string coupling2PositionTypeRequiredMessage = "couplingPosition is a required integer and must be 1,2";

        public static string coupling2CouplingTypeRequiredMessage = "couplingType is a required string and must be none_rigid, beltdrive, chaindrive, magnetic, flexible";

        public static string coupling2LocationValidationMessage = "locations is an optional integer and must be 1 through 10";

        //Intermediate validation message

        public static string intermediateComponentTypeValidationMsg = "componentType is a required string and must be driver, coupling, intermediate, driven";

        public static string intermediateLocationValidationMsg = "locations is a required integer and must be 1 through 10";

        public static string intermediateSpeedratioValidationMsg = "speedratio is required decimal - default is 1.0000";

        public static string intermediateImmediateTypeValidationMsg = "intermediateType is a required string and must be gearbox, AOP, AccDrGr";

        public static string intermediateIntermediatesValidationMsg = "intermediates one type must be used gearbox, AOP, AccDrGr";

        public static string intermediateSpeedChangesMaxValidationMsg = "speedChangesMax is a required integer and must be 1 through 3";
        
        public static string intermediateAOPDrivenByValidationMsg = "drivenBy is a required string and must be inputshaft, intermediateshaft, outputshaft, inputshaft, intermediateshaft, outputshaft";

        public static string intermediateAccDrGrDrivenByValidationMsg = "drivenBy is a required string and must be inputshaft, intermediateshaft, outputshaft, inputshaft, intermediateshaft, outputshaft";

        public static string intermediateDrivenByValidationMsg = "drivenBy is a required string and must be inputshaft, intermediateshaft, outputshaft, inputshaft, intermediateshaft, outputshaft";


        //Driven validation message

        public static string drivenComponentTypeValidationMsg = "componentType is a required string and must be driver, coupling, intermediate, driven";

        public static string drivenLocationValidationMsg = "locations is a required integer and must be 1 through 10";

        public static string drivenLocationNDEValidationMsg = "drivenLocationNDE is a required boolean";

        public static string drivenLocationDEValidationMsg = "drivenLocationDE is a required boolean";



        public static string drivenTypeValidationMsg = "drivenType is a required string and must be pump, compressor, fan_or_blower, purifier_centrifuge, decanter, generator, vacuumpump, spindle_or_shaft_or_bearing";

        public static string drivensValidationMsg = "drivens one type must be used pump, compressor, fan_or_blower, purifier_centrifuge, decanter, generator, vacuumpump, spindle_or_shaft_or_bearing";

        public static string drivensPumpTypeValidationMsg = "pumpType is a required string and must be centrifugal, propeller, rotarythread, gear, screw, slidingvane, axialrecip, radialrecip";

        public static string drivensRotorOverhungValidationMsg = "rotorOverhung is a required boolean if drivenType is pump and pumpType is centrifugal";

        public static string drivensCentrifugalPumpHasBallBearingsValidationMsg = "centrifugalPumpHasBallBearings is a required boolean if drivenType is pump and pumpType is centrifugal";

        public static string drivensThrustBearingValidationMsg = "thrustBearing is a required string if drivenType is pump and pumpType is centrifugal and must be journal, ball, no, yes";

        public static string drivensPropellerpumpHasBallBearingsValidationMsg = "propellerpumpHasBallBearings is a required boolean if drivenType is pump and pumpType is propeller";

        public static string drivensRotaryThreadPumpHasBallBearingsValidationMsg = "rotaryThreadPumpHasBallBearings is a required boolean if drivenType is pump and pumpType is rotarythread";

        public static string drivensGearPumpHasBallBearingsValidationMsg = "gearPumpHasBallBearings is a required boolean if drivenType is pump and pumpType is gear";

        public static string drivensScrewPumpHasBallBearingsValidationMsg = "screwPumpHasBallBearings is a required boolean if drivenType is pump and pumpType is screw";

        public static string drivenSpumpRotarySlidingVaneRotorOverhungValidationMsg = "rotorOverhung is a required boolean if drivenType is pump and pumpType is slidingvane";

        public static string drivenSlidingVanePumpHasBallBearingsValidationMsg = "slidingVanePumpHasBallBearings is a required boolean if drivenType is pump and pumpType is slidingvane";

        public static string drivenAttachedOilPumpValidationMsg = "attachedOilPump is an optional boolean if drivenType is pump and pumpType is axialrecip";

        public static string drivenAxialRecipPumpHasBallBearingsValidationMsg = "axialRecipPumpHasBallBearings is an optional boolean if drivenType is pump and pumpType is axialrecip";

        public static string drivenThrustBearingValidationMsg = "thrustBearing is an optional string journal,ball if drivenType is pump and pumpType is axialrecip";


        public static string drivensCompressorTypeValidationMsg = "pumpType is a required string and must be centrifugal, reciprocating, screw, screwtwin";

        public static string drivensImpellerOnMainShaftValidationMsg = "impellerOnMainShaft is an required boolean if drivenType is compressor and compressorType is centrifugal";

        public static string drivensCompressorCentrifugalCompressorHasBallBearings = "centrifugalCompressorHasBallBearings is an required boolean if drivenType is compressor and compressorType is centrifugal";

        public static string drivensCompressorThrustBearingValidationMsg = "thrustBearing is an optional string if drivenType is compressor and compressorType is centrifugal";
        
        public static string drivensCrankHasIntermediateBearingValidationMsg = "crankHasIntermediateBearing is an optional boolean if drivenType is compressor and compressorType is reciprocating";

        public static string drivensReciprocatingCompressorHasBallBearingsValidationMsg = "reciprocatingCompressorHasBallBearings is an required boolean if drivenType is compressor and compressorType is reciprocating";

        public static string drivensScrewCompressorHasBallBearingsValidationMsg = "screwCompressorHasBallBearings is an required boolean if drivenType is compressor and compressorType is screw";

        public static string drivensScrewTwinCompressorHasBallBearingsOnHPSideValidationMsg = "screwTwinCompressorHasBallBearingsOnHPSide is an required boolean if drivenType is compressor and compressorType is screwtwin";

        public static string drivensFan_or_blowerTypeValidationMsg = "fan_or_blowerType is a required string if drivenType is fan_or_blower and must be lobed, overhungrotor, supportedrotor";

        public static string drivensLobedFanOrBlowerHasBallBearingsValidationMsg = "lobedFanOrBlowerHasBallBearings is an required boolean if drivenType is fan_or_blower and fan_or_blowerType is lobed";

        public static string drivensFanStagesValidationMsg = "fanStages is an required boolean";

        public static string drivensOverhungRotorFanOrBlowerHasBearingsValidationMsg = "overhungRotorFanOrBlowerHasBearings is an required boolean if drivenType is fan_or_blower and fan_or_blowerType is overhungrotor";

        public static string drivenSupportedRotorFanOrBlowerHasBearingsValidationMsg = "supportedRotorFanOrBlowerHasBearings is an optional boolean if drivenType is fan_or_blower and fan_or_blowerType is supportedrotor";

        public static string drivenPurifierDrivenByValidationMsg = "purifierDrivenBy is a required string  if drivenType is purifier_centrifuge and must be gearedwithclutch,beltdrive";

        public static string drivenspindleShaftBearingValidationMsg = "spindleShaftBearing is required if drivenType is spindle_or_shaft_or_bearing and must by spindle, shaft";

        public static string drivenSpecialFaultCodesInputValidationMsg = "specialFaultCodeCount is a required integer if specialFaultCodeType is not null";

        public static string drivensSpecialFaultCodeTypeValidationMsg = "specialFaultCodeType is a required string and must be vanes, driven_threads, idler_threads, teeth, pistons, input_lobes, idler_lobes, stage1_fan_blades, stage2_fan_blades, fan_blades";

        public static string drivensBearingTypeValidationMsg = "bearingType is a required string if drivenType is generator and must be NDE_Journal, NDE_Ball, ballbearingsbothends, journalbearingsbothends, beltdrive";

        public static string drivensExciterValidationMsg = "exciter is an required boolean";

        public static string drivensExciterOverhungOrSupportedValidationMsg = "exciterOverhungOrSupported is an optional string if drivenType is generator";

        public static string drivensDrivenByValidationMsg = "drivenBy is an required string if drivenType is generator and must be NOTdieselengine, dieselengine";

        public static string drivensVacuumPumptypeValidationMsg = "vacuumpumptype is a required string if drivenType is vacuumpump and must be centrifugal, axialrecip, radialrecip, reciprocating, lobed";

        public static string drivensBearingsTypeValidationMsg = "bearingsType is an required string if drivenType is vacuumpump and vacuumpumptype is centrifugal and must be journal, ballbearings,journalbearingsonmain,ballbearingsonmain";

        public static string drivensVaccumPumpThrustBearingValidationMsg = "thrustBearing is an optional string journal, ball, no, yes, journalthrust, ballthrustbearing";

        public static string drivensBearingsTypeThrustBearingValidationMsg = "bearingsType is an optional string  if drivenType is vacuumpump and vacuumpumptype is axialrecip and must be ballbearings, journal";

        public static string drivensVacuumPumpAxialRecipThrustBearingValidationMsg = "thrustBearing is an optional string  if drivenType is vacuumpump and vacuumpumptype is axialrecip and must be journalthrust, ballthrustbearingplate";

        public static string drivensVacuumpumpLobedBearingsTypeValidationMsg = "bearingsType is a required string if drivenType is vacuumpump and vacuumpumptype is lobed and must be ballbearings, journal,journalandballbearings";

        public static string drivensVacuumpumpReciprocatingValidationMsg = "bearingsType is a required string if drivenType is vacuumpump and vacuumpumptype is reciprocating and must be crankshaftjournalbearingsatendonly, allballbearings";

        public static string drivensSpecialFaultCodeCountValidationMsg = "specialFaultCodeCount should be between 1 and 99";



        public static string coupling2SpeedRatioRequiredMessage = "speedratio is required decimal - default is 1.0000";
        
        public static string c1AndC2CouplingValidationMessage = "Any one coupling speedratio value should be <> 1";

        public static string dieselDriverType = "diesel";

        public static string motorDriverType = "motor";

    }
}
