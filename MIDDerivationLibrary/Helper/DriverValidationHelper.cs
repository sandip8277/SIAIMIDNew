using Microsoft.AspNetCore.Mvc.ModelBinding;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.DriverModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using static MIDDerivationLibrary.Enums.DriverEnums;

namespace MIDDerivationLibrary.Helper
{
    public class DriverValidationHelper
    {
        public static void ValidateDriverInput(ref ModelStateDictionary modelState, ref DriverDetails model)
        {
            if (model != null)
            {
                //componentType
                if (!Enum.IsDefined(typeof(DriverComponentType), model.componentType.ToLower()))
                    modelState.AddModelError(nameof(model.componentType), Constants.driverComponentTypeValidationMsg);

                //locations
                if (!string.IsNullOrEmpty(model.driverType) && model.driverType.ToLower() == DriverType.diesel.ToString())
                {
                    //locations - only a diesel driver can have 3
                    if (model.locations == null || !(model.locations >= 0 && model.locations <= 3))
                        modelState.AddModelError(nameof(model.locations), Constants.driverLocationValidationMsg);
                }
                else
                {
                    if (model.locations == null || !(model.locations >= 0 && model.locations <= 2))
                        modelState.AddModelError(nameof(model.locations), Constants.driverLocationValidationMsg);
                }

                //driverType
                if (string.IsNullOrEmpty(model.driverType) || !Enum.IsDefined(typeof(DriverType), model.driverType.ToLower()))
                    modelState.AddModelError(nameof(model.driverType), Constants.driverTypeTypeValidationMsg);

                //Diesel
                if (!string.IsNullOrEmpty(model.driverType) && model.driverType.ToLower() == "diesel")
                {
                    if (!Enum.IsDefined(typeof(DieselCylinders), model.cylinders))
                        modelState.AddModelError(nameof(model.cylinders), Constants.driversCylindersValidationMsg);

                    model.motorDrive = null;
                    model.motorFan = null;
                    model.motorBallBearings = null;
                    model.drivenBallBearings = null;
                    model.drivenBalanceable = null;
                    model.motorPoles = null;
                    model.turbineReductionGear = null;
                    model.turbineRotorSupported = null;
                    model.turbineBallBearing = null;
                    model.turbineThrustBearing = null;
                    model.turbineThrustBearingIsBall = null;
                }

                //Motor
                if (!string.IsNullOrEmpty(model.driverType) && model.driverType.ToLower() == "motor")
                {
                    //motorDrive
                    if (string.IsNullOrEmpty(model.motorDrive) || !Enum.IsDefined(typeof(MotorDrive), model.motorDrive))
                        modelState.AddModelError(nameof(model.motorDrive), Constants.driversMotorDriveValidationMsg);

                    //motorFan
                    if (model.motorFan == null)
                        modelState.AddModelError(nameof(model.motorFan), Constants.driverMotorFanRequiredValidationMsg);

                    //motorBallBearings
                    if (model.motorBallBearings == null)
                        modelState.AddModelError(nameof(model.motorBallBearings), Constants.driverMotorBallBearingsRequiredValidationMsg);

                    //drivenBallBearings
                    if (model.drivenBallBearings == null)
                        modelState.AddModelError(nameof(model.drivenBallBearings), Constants.driverDrivenBallBearingsRequiredValidationMsg);

                    //drivenBalanceable
                    if (model.drivenBalanceable == null)
                        modelState.AddModelError(nameof(model.drivenBalanceable), Constants.driverDrivenBalanceableRequiredValidationMsg);

                    //VFD
                    if (!string.IsNullOrEmpty(model.motorDrive) && model.motorDrive.ToUpper() == "VFD")
                    {
                        if (model.motorPoles == null || !Enum.IsDefined(typeof(MotorPoles), model.motorPoles))
                            modelState.AddModelError(nameof(model.motorPoles), Constants.driverMotorPolesValidationMsg);
                    }

                    model.cylinders = null;
                    model.turbineReductionGear = null;
                    model.turbineRotorSupported = null;
                    model.turbineBallBearing = null;
                    model.turbineThrustBearing = null;
                    model.turbineThrustBearingIsBall = null;
                }

                //Turbin
                if (!string.IsNullOrEmpty(model.driverType) && model.driverType.ToLower() == "turbine")
                {
                    //turbineReductionGear
                    if (model.turbineReductionGear == null)
                        modelState.AddModelError(nameof(model.turbineReductionGear), Constants.driverTurbineReductionGearRequiredValidationMsg);

                    //turbineRotorSupported
                    if (model.turbineRotorSupported == null)
                        modelState.AddModelError(nameof(model.turbineRotorSupported), Constants.driverTurbineRotorSupportedRequiredValidationMsg);

                    //turbineBallBearing
                    if (model.turbineBallBearing == null)
                        modelState.AddModelError(nameof(model.turbineBallBearing), Constants.driverTurbineBallBearingRequiredValidationMsg);

                    //turbineThrustBearing
                    if (model.turbineThrustBearing == null)
                        modelState.AddModelError(nameof(model.turbineThrustBearing), Constants.driverTurbineThrustBearingRequiredValidationMsg);

                    model.motorDrive = null;
                    model.motorFan = null;
                    model.motorBallBearings = null;
                    model.drivenBallBearings = null;
                    model.drivenBalanceable = null;
                    model.motorPoles = null;
                    model.cylinders = null;
                }

                //componentCode
                if (model.componentCode == null)
                    modelState.AddModelError(nameof(model.componentCode), Constants.componentCodeRequiredMessage);
            }
        }
    }
}
