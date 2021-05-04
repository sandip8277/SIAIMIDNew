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


        public static string componentType = "componentType";

        public static string driverType = "driverType";

        public static string drivenType = "drivenType";

        public static string couplingType = "couplingType";

        public static string intermediateType = "intermediateType";

        public static string Id = "Id";

        public static string recordSaved = "Record saved successfully";

        public static string recordDeleted = "Record deleted successfully";

        public static string recordNotFound = "Record not found";

        public static string recordExist = "Record already exist";

        public static string locationRequiredMessage = "Locations is required";

        public static string driverTypeRequiredMessage = "DriverType is required";

        public static string couplingPositionTypeRequiredMessage = "CouplingPosition is required";

        public static string couplingTypeRequiredMessage = "CouplingType is required";

        public static string speedRatioRequiredMessage = "Speed ratio is required";

        public static string intermediateTypeRequiredMessage = "IntermediateType is required";

        public static string drivenTypeRequiredMessage = "DrivenType is required";

        public static string c1AndC2CouplingValidationMessage = "Any one coupling speedratio value should be <> 1";







    }
}
