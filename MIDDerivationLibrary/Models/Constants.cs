using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class Constants
    {
        public static string xmlInput = "xmlInput";

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

        public static string coupling1SpeedRatioRequiredMessage = "speedratio is required decimal - default is 1.0000";

        //Coupling2 validation message

        public static string coupling2ComponentTypeValidationMsg = "componentType is a required string and must be driver, coupling, intermediate, driven; must be null if intermediate is not present";

        public static string coupling2ComponentTypeValidationMsgIfIntermediateNotPresent = "componentType must be null if intermediate is not present";

        public static string coupling2PositionTypeRequiredMessage = "couplingPosition is a required integer and must be 1,2";

        public static string coupling2CouplingTypeRequiredMessage = "couplingType is a required string and must be none_rigid, beltdrive, chaindrive, magnetic, flexible";



        public static string coupling2SpeedRatioRequiredMessage = "speedratio is required decimal - default is 1.0000";


        public static string couplingPositionTypeRequiredMessage = "CouplingPosition is required";

        public static string locationRequiredMessage = "Locations is required";

        public static string driverTypeRequiredMessage = "DriverType is required";


        public static string couplingTypeRequiredMessage = "CouplingType is required";

        public static string speedRatioRequiredMessage = "Speed ratio is required";

        public static string intermediateTypeRequiredMessage = "IntermediateType is required";

        public static string drivenTypeRequiredMessage = "DrivenType is required";

        public static string c1AndC2CouplingValidationMessage = "Any one coupling speedratio value should be <> 1";
   
    }
}
