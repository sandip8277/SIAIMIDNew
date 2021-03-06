using Microsoft.AspNetCore.Mvc.ModelBinding;
using MIDCodeGenerator.Models;
using MIDDerivationLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using static MIDDerivationLibrary.Enums.Coupling1Enums;
using static MIDDerivationLibrary.Enums.Coupling2Enums;
using static MIDDerivationLibrary.Enums.DrivenEnums;
using static MIDDerivationLibrary.Enums.DriverEnums;
using static MIDDerivationLibrary.Enums.IntermediateEnums;

namespace MIDDerivationLibrary.Helper
{
    public static class ValidationHelper
    {
        public static void ValidateInput(ref ModelStateDictionary modelState, ref MIDCodeCreatorRequest model)
        {
            #region validate input model
            if (model.machineComponentsForMIDgeneration == null)
                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration), "Machine components for MID generation shoulde not be null.");

            //Validations for Driver component
            if (model.machineComponentsForMIDgeneration.driver != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.componentType))
            {
                //componentType
                if (!Enum.IsDefined(typeof(DriverComponentType), model.machineComponentsForMIDgeneration.driver.componentType.ToLower()))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.componentType), Constants.driverComponentTypeValidationMsg);

                //locations
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.driverType) && model.machineComponentsForMIDgeneration.driver.driverType.ToLower() == DriverType.diesel.ToString())
                {
                    //locations - only a diesel driver can have 3
                    if (model.machineComponentsForMIDgeneration.driver.locations == null || !(model.machineComponentsForMIDgeneration.driver.locations >= 0 && model.machineComponentsForMIDgeneration.driver.locations <= 3))
                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.locations), Constants.driverLocationValidationMsg);
                }
                else
                {
                    if (model.machineComponentsForMIDgeneration.driver.locations == null || !(model.machineComponentsForMIDgeneration.driver.locations >= 0 && model.machineComponentsForMIDgeneration.driver.locations <= 2))
                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.locations), Constants.driverLocationValidationMsg);
                }

                //driverLocationNDE
                if (model.machineComponentsForMIDgeneration.driver.driverLocationNDE == null)
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.driverLocationNDE), Constants.driverLocationNDEValidationMsg);

                //driverLocationDE
                if (model.machineComponentsForMIDgeneration.driver.driverLocationDE == null)
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.driverLocationDE), Constants.driverLocationDEValidationMsg);

                //driverType
                if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.driverType) || !Enum.IsDefined(typeof(DriverType), model.machineComponentsForMIDgeneration.driver.driverType.ToLower()))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.driverType), Constants.driverTypeTypeValidationMsg);

                //drivers
                if (model.machineComponentsForMIDgeneration.driver.drivers == null || (model.machineComponentsForMIDgeneration.driver.drivers.diesel == null && model.machineComponentsForMIDgeneration.driver.drivers.motor == null && model.machineComponentsForMIDgeneration.driver.drivers.turbine == null))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers), Constants.driversValidationMsg);

                if (model.machineComponentsForMIDgeneration.driver.drivers != null)
                {
                    //diesel cylinders
                    if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.driverType) && model.machineComponentsForMIDgeneration.driver.driverType.ToLower() == "diesel")
                    {
                        if (model.machineComponentsForMIDgeneration.driver.drivers.diesel != null)
                        {
                            if (model.machineComponentsForMIDgeneration.driver.drivers.diesel.cylinders == null || !Enum.IsDefined(typeof(DieselCylinders), model.machineComponentsForMIDgeneration.driver.drivers.diesel.cylinders))
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.diesel.cylinders), Constants.driversCylindersValidationMsg);
                        }
                        model.machineComponentsForMIDgeneration.driver.drivers.motor = null;
                        model.machineComponentsForMIDgeneration.driver.drivers.turbine = null;
                    }

                    //motor
                    if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.driverType) && model.machineComponentsForMIDgeneration.driver.driverType.ToLower() == "motor")
                    {
                        if (model.machineComponentsForMIDgeneration.driver.drivers.motor != null)
                        {
                            //motorDrive
                            if (!Enum.IsDefined(typeof(MotorDrive), model.machineComponentsForMIDgeneration.driver.drivers.motor.motorDrive))
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.motorDrive), Constants.driversMotorDriveValidationMsg);

                            //motorFan
                            if (model.machineComponentsForMIDgeneration.driver.drivers.motor.motorFan == null)
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.motorFan), Constants.driverMotorFanRequiredValidationMsg);

                            //motorBallBearings
                            if (model.machineComponentsForMIDgeneration.driver.drivers.motor.motorBallBearings == null)
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.motorBallBearings), Constants.driverMotorBallBearingsRequiredValidationMsg);

                            //drivenBallBearings
                            if (model.machineComponentsForMIDgeneration.driver.drivers.motor.drivenBallBearings == null)
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.drivenBallBearings), Constants.driverDrivenBallBearingsRequiredValidationMsg);

                            //drivenBalanceable
                            if (model.machineComponentsForMIDgeneration.driver.drivers.motor.drivenBalanceable == null)
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.drivenBalanceable), Constants.driverDrivenBalanceableRequiredValidationMsg);

                            //VFD
                            if (model.machineComponentsForMIDgeneration.driver.drivers != null && model.machineComponentsForMIDgeneration.driver.drivers.motor != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.drivers.motor.motorDrive) && model.machineComponentsForMIDgeneration.driver.drivers.motor.motorDrive.ToUpper() == "VFD")
                            {
                                if (model.machineComponentsForMIDgeneration.driver.drivers.motor.vfd == null || (model.machineComponentsForMIDgeneration.driver.drivers.motor.vfd.motorPoles == null || !Enum.IsDefined(typeof(MotorPoles), model.machineComponentsForMIDgeneration.driver.drivers.motor.vfd.motorPoles)))
                                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.vfd.motorPoles), Constants.driverMotorPolesValidationMsg);
                            }
                        }
                        model.machineComponentsForMIDgeneration.driver.drivers.diesel = null;
                        model.machineComponentsForMIDgeneration.driver.drivers.turbine = null;
                    }

                    //Turbin
                    if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.driverType) && model.machineComponentsForMIDgeneration.driver.driverType.ToLower() == "turbine")
                    {
                        //turbineReductionGear
                        if (model.machineComponentsForMIDgeneration.driver.drivers.turbine == null || model.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineReductionGear == null)
                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineReductionGear), Constants.driverTurbineReductionGearRequiredValidationMsg);

                        //turbineRotorSupported
                        if (model.machineComponentsForMIDgeneration.driver.drivers.turbine == null || model.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineRotorSupported == null)
                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineRotorSupported), Constants.driverTurbineRotorSupportedRequiredValidationMsg);

                        //turbineBallBearing
                        if (model.machineComponentsForMIDgeneration.driver.drivers.turbine == null || model.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineBallBearing == null)
                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineBallBearing), Constants.driverTurbineBallBearingRequiredValidationMsg);

                        //turbineThrustBearing
                        if (model.machineComponentsForMIDgeneration.driver.drivers.turbine == null || model.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineThrustBearing == null)
                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineThrustBearing), Constants.driverTurbineThrustBearingRequiredValidationMsg);

                        model.machineComponentsForMIDgeneration.driver.drivers.diesel = null;
                        model.machineComponentsForMIDgeneration.driver.drivers.motor = null;
                    }
                }
            }
            else
                model.machineComponentsForMIDgeneration.driver = null;

            //Validations for coupling1 component
            if (model.machineComponentsForMIDgeneration.coupling1 != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.coupling1.componentType))
            {
                //componentType
                if (!Enum.IsDefined(typeof(Coupling1ComponentType), model.machineComponentsForMIDgeneration.coupling1.componentType.ToLower()))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.componentType), Constants.coupling1ComponentTypeValidationMsg);

                //couplingPosition
                if (model.machineComponentsForMIDgeneration.coupling1.couplingPosition == null || !Enum.IsDefined(typeof(Coupling1CouplingPosition), model.machineComponentsForMIDgeneration.coupling1.couplingPosition))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.couplingPosition), Constants.coupling1PositionTypeRequiredMessage);

                //couplingType
                if (model.machineComponentsForMIDgeneration.coupling1.couplingType == null || !Enum.IsDefined(typeof(Coupling1CouplingType), model.machineComponentsForMIDgeneration.coupling1.couplingType))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.couplingType), Constants.coupling1CouplingTypeRequiredMessage);

                //speedratio
                if (model.machineComponentsForMIDgeneration.coupling1.speedratio == null)
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.speedratio), Constants.coupling1SpeedRatioRequiredMessage);

            }
            else
                model.machineComponentsForMIDgeneration.coupling1 = null;

            //Validations for coupling2 component
            if (model.machineComponentsForMIDgeneration.coupling2 != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.coupling2.componentType))
            {
                //componentType
                if (model.machineComponentsForMIDgeneration.intermediate == null || model.machineComponentsForMIDgeneration.intermediate.componentType == null)
                {
                    //must be null if intermediate is not present
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.componentType), Constants.coupling2ComponentTypeValidationMsgIfIntermediateNotPresent);
                }
                else if ((model.machineComponentsForMIDgeneration.intermediate != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.componentType)) &&
                    (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.coupling2.componentType) || !Enum.IsDefined(typeof(Coupling2ComponentType), model.machineComponentsForMIDgeneration.coupling2.componentType.ToLower())))
                {
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.componentType), Constants.coupling2ComponentTypeValidationMsg);
                }

                //couplingPosition
                if (model.machineComponentsForMIDgeneration.coupling2.couplingPosition == null || !Enum.IsDefined(typeof(Coupling2CouplingPosition), model.machineComponentsForMIDgeneration.coupling2.couplingPosition))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.couplingPosition), Constants.coupling2PositionTypeRequiredMessage);

                //couplingType
                if (model.machineComponentsForMIDgeneration.coupling2.couplingType == null || !Enum.IsDefined(typeof(Coupling2CouplingType), model.machineComponentsForMIDgeneration.coupling2.couplingType))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.couplingType), Constants.coupling2CouplingTypeRequiredMessage);

                //speedratio
                if (model.machineComponentsForMIDgeneration.coupling2.speedratio == null)
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.speedratio), Constants.coupling2SpeedRatioRequiredMessage);
            }
            else
                model.machineComponentsForMIDgeneration.coupling2 = null;

            //Validations for Intermediate component 
            if (model.machineComponentsForMIDgeneration.intermediate != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.componentType))
            {
                //componentType
                if (!Enum.IsDefined(typeof(IntermediateComponentType), model.machineComponentsForMIDgeneration.intermediate.componentType.ToLower()))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.componentType), Constants.intermediateComponentTypeValidationMsg);

                //locations
                if (model.machineComponentsForMIDgeneration.intermediate.locations == null || !(model.machineComponentsForMIDgeneration.intermediate.locations >= 0 && model.machineComponentsForMIDgeneration.intermediate.locations <= 4))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.locations), Constants.intermediateLocationValidationMsg);

                //speedratio
                if (model.machineComponentsForMIDgeneration.intermediate.speedratio == null)
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.speedratio), Constants.intermediateSpeedratioValidationMsg);

                //intermediateType
                if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediateType) || !Enum.IsDefined(typeof(IntermediateType), model.machineComponentsForMIDgeneration.intermediate.intermediateType.ToLower()))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediateType), Constants.intermediateImmediateTypeValidationMsg);

                //intermediates
                if (model.machineComponentsForMIDgeneration.intermediate.intermediates == null || (model.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox == null && model.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr == null && model.machineComponentsForMIDgeneration.intermediate.intermediates.AOP == null))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates), Constants.intermediateIntermediatesValidationMsg);

                //gearbox
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediateType) && model.machineComponentsForMIDgeneration.intermediate.intermediateType.ToLower() == IntermediateType.gearbox.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.intermediate.intermediates == null || model.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox == null || model.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox.speedChangesMax == null || !(model.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox.speedChangesMax >= 1 && model.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox.speedChangesMax <= 3))
                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox.speedChangesMax), Constants.intermediateSpeedChangesMaxValidationMsg);

                    model.machineComponentsForMIDgeneration.intermediate.intermediates.AOP = null;
                    model.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr = null;
                }

                //AOP
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediateType) && model.machineComponentsForMIDgeneration.intermediate.intermediateType.ToLower() == IntermediateType.aop.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.intermediate.intermediates == null || model.machineComponentsForMIDgeneration.intermediate.intermediates.AOP == null || string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediates.AOP.drivenBy) || !Enum.IsDefined(typeof(IntermediateAOPDrivenBy), model.machineComponentsForMIDgeneration.intermediate.intermediates.AOP.drivenBy.ToLower()))
                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates.AOP) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates.AOP.drivenBy), Constants.intermediateAOPDrivenByValidationMsg);

                    model.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox = null;
                    model.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr = null;
                }

                //AccDrGr
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediateType) && model.machineComponentsForMIDgeneration.intermediate.intermediateType.ToLower() == IntermediateType.accdrgr.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.intermediate.intermediates == null || model.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr == null || string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr.drivenBy) || !Enum.IsDefined(typeof(IntermediateAccDrGrDrivenBy), model.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr.drivenBy.ToLower()))
                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr.drivenBy), Constants.intermediateAccDrGrDrivenByValidationMsg);

                    model.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox = null;
                    model.machineComponentsForMIDgeneration.intermediate.intermediates.AOP = null;
                }
            }
            else
                model.machineComponentsForMIDgeneration.intermediate = null;

            //Validations for Driven component 
            if (model.machineComponentsForMIDgeneration.driven != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.componentType))
            {
                //componentType
                if (!Enum.IsDefined(typeof(DrivenComponentType), model.machineComponentsForMIDgeneration.driven.componentType.ToLower()))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.componentType), Constants.drivenComponentTypeValidationMsg);

                //locations
                if (model.machineComponentsForMIDgeneration.driven.locations == null || !(model.machineComponentsForMIDgeneration.driven.locations >= 0 && model.machineComponentsForMIDgeneration.driven.locations <= 2))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.locations), Constants.drivenLocationValidationMsg);

                //drivenLocationNDE
                if (model.machineComponentsForMIDgeneration.driven.drivenLocationNDE == null)
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivenLocationNDE), Constants.drivenLocationNDEValidationMsg);

                //drivenLocationDE
                if (model.machineComponentsForMIDgeneration.driven.drivenLocationDE == null)
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivenLocationDE), Constants.drivenLocationDEValidationMsg);

                //drivenType
                if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivenType) || !Enum.IsDefined(typeof(DrivenType), model.machineComponentsForMIDgeneration.driven.drivenType.ToLower()))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivenType), Constants.drivenTypeValidationMsg);

                //drivens
                if (model.machineComponentsForMIDgeneration.driven.drivens == null || (model.machineComponentsForMIDgeneration.driven.drivens.pump == null
                    && model.machineComponentsForMIDgeneration.driven.drivens.compressor == null
                    && model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower == null
                    && model.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge == null
                    && model.machineComponentsForMIDgeneration.driven.drivens.decanter == null
                    && model.machineComponentsForMIDgeneration.driven.drivens.generator == null
                    && model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump == null
                    && model.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing == null))
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens), Constants.drivensValidationMsg);

                //pump
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivenType) && model.machineComponentsForMIDgeneration.driven.drivenType.ToLower() == DrivenType.pump.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.driven.drivens != null && model.machineComponentsForMIDgeneration.driven.drivens.pump != null)
                    {
                        //pumpType
                        if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpType) || !Enum.IsDefined(typeof(DrivenPumpType), model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpType.ToLower()))
                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.pump.pumpType), Constants.drivensPumpTypeValidationMsg);

                        if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes != null)
                        {
                            //pumpCentrifugal
                            if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.pump.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpType == DrivenPumpType.centrifugal.ToString())
                                {
                                    //rotorOverhung
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal.rotorOverhung == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal.rotorOverhung), Constants.drivensRotorOverhungValidationMsg);

                                    //centrifugalPumpHasBallBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal.centrifugalPumpHasBallBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal.centrifugalPumpHasBallBearings), Constants.drivensCentrifugalPumpHasBallBearingsValidationMsg);

                                    //thrustBearing
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal.thrustBearing == null || !Enum.IsDefined(typeof(DrivenThrustBearing), model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal.thrustBearing.ToLower()))
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal.thrustBearing), Constants.drivensThrustBearingValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpPropeller = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryThread = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpGear = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryScrew = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotarySlidingVane = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryRadialRecip = null;
                                }
                            }

                            //pumpPropeller
                            if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpPropeller != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.pump.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpType == DrivenPumpType.propeller.ToString())
                                {
                                    //propellerpumpHasBallBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpPropeller.propellerpumpHasBallBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpPropeller.propellerpumpHasBallBearings), Constants.drivensPropellerpumpHasBallBearingsValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryThread = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpGear = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryScrew = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotarySlidingVane = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryRadialRecip = null;
                                }
                            }

                            //pumpRotaryThread
                            if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryThread != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.pump.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpType == DrivenPumpType.rotarythread.ToString())
                                {
                                    //rotaryThreadPumpHasBallBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryThread.rotaryThreadPumpHasBallBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryThread.rotaryThreadPumpHasBallBearings), Constants.drivensRotaryThreadPumpHasBallBearingsValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpPropeller = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpGear = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryScrew = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotarySlidingVane = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryRadialRecip = null;
                                }
                            }

                            //pumpGear
                            if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpGear != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.pump.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpType == DrivenPumpType.gear.ToString())
                                {
                                    //gearPumpHasBallBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpGear.gearPumpHasBallBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpGear.gearPumpHasBallBearings), Constants.drivensGearPumpHasBallBearingsValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpPropeller = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryThread = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryScrew = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotarySlidingVane = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryRadialRecip = null;
                                }
                            }

                            //pumpRotaryScrew
                            if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryScrew != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.pump.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpType == DrivenPumpType.screw.ToString())
                                {
                                    //screwPumpHasBallBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryScrew.screwPumpHasBallBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryScrew.screwPumpHasBallBearings), Constants.drivensScrewPumpHasBallBearingsValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpPropeller = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryThread = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpGear = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotarySlidingVane = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryRadialRecip = null;
                                }
                            }

                            //pumpRotarySlidingVane
                            if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotarySlidingVane != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.pump.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpType == DrivenPumpType.slidingvane.ToString())
                                {

                                    //slidingVanePumpHasBallBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotarySlidingVane.slidingVanePumpHasBallBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotarySlidingVane.slidingVanePumpHasBallBearings), Constants.drivenSlidingVanePumpHasBallBearingsValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpPropeller = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryThread = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpGear = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryScrew = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryRadialRecip = null;
                                }
                            }

                            //pumpRotaryAxialRecip
                            if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.pump.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpType == DrivenPumpType.axialrecip.ToString())
                                {
                                    //axialRecipPumpHasBallBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip.axialRecipPumpHasBallBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip.axialRecipPumpHasBallBearings), Constants.drivenSlidingVanePumpHasBallBearingsValidationMsg);

                                    //thrustBearing
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip.thrustBearing != null && !Enum.IsDefined(typeof(PumpRotaryAxialRecipThrustBearing), model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip.thrustBearing.ToLower()))
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryAxialRecip.thrustBearing), Constants.drivenThrustBearingValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpCentrifugal = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpPropeller = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryThread = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpGear = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryScrew = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotarySlidingVane = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.pump.pumpTypes.pumpRotaryRadialRecip = null;
                                }
                            }
                        }

                        model.machineComponentsForMIDgeneration.driven.drivens.compressor = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.decanter = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.generator = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing = null;
                    }
                }

                //compressor
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivenType) && model.machineComponentsForMIDgeneration.driven.drivenType.ToLower() == DrivenType.compressor.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.driven.drivens != null && model.machineComponentsForMIDgeneration.driven.drivens.compressor != null)
                    {
                        //compressorType
                        if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorType) || !Enum.IsDefined(typeof(DrivenCompressorType), model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorType.ToLower()))
                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorType), Constants.drivensCompressorTypeValidationMsg);

                        if (model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorType != null && model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes != null)
                        {
                            //compressorCentrifugal
                            if (model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorCentrifugal != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.compressor.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorType == DrivenCompressorType.centrifugal.ToString())
                                {
                                    //impellerOnMainShaft
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorCentrifugal.impellerOnMainShaft == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorCentrifugal.impellerOnMainShaft), Constants.drivensImpellerOnMainShaftValidationMsg);

                                    //centrifugalPumpHasBallBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorCentrifugal.centrifugalCompressorHasBallBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorCentrifugal.centrifugalCompressorHasBallBearings), Constants.drivensCompressorCentrifugalCompressorHasBallBearings);

                                    //thrustBearing
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorCentrifugal.thrustBearing != null && !Enum.IsDefined(typeof(DrivenCompressorThrustBearing), model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorCentrifugal.thrustBearing.ToLower()))
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorCentrifugal.thrustBearing), Constants.drivensCompressorThrustBearingValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorReciporcating = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrew = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrewTwin = null;
                                }
                            }

                            //compressorReciporcating
                            if (model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorReciporcating != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.compressor.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorType == DrivenCompressorType.reciprocating.ToString())
                                {

                                    //reciprocatingCompressorHasBallBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorReciporcating.reciprocatingCompressorHasBallBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorReciporcating.reciprocatingCompressorHasBallBearings), Constants.drivensReciprocatingCompressorHasBallBearingsValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorCentrifugal = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrew = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrewTwin = null;
                                }
                            }

                            //compressorScrew
                            if (model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrew != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.compressor.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorType == DrivenPumpType.screw.ToString())
                                {
                                    //screwCompressorHasBallBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrew.screwCompressorHasBallBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrew.screwCompressorHasBallBearings), Constants.drivensScrewCompressorHasBallBearingsValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorCentrifugal = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorReciporcating = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrewTwin = null;
                                }
                            }

                            //compressorScrewTwin
                            if (model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrewTwin != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.compressor.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorType == DrivenCompressorType.screwtwin.ToString())
                                {
                                    //screwTwinCompressorHasBallBearingsOnHPSide
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrewTwin.screwTwinCompressorHasBallBearingsOnHPSide == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrewTwin.screwTwinCompressorHasBallBearingsOnHPSide), Constants.drivensScrewTwinCompressorHasBallBearingsOnHPSideValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorCentrifugal = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorReciporcating = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.compressor.compressorTypes.compressorScrew = null;
                                }
                            }
                        }

                        model.machineComponentsForMIDgeneration.driven.drivens.pump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.decanter = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.generator = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing = null;
                    }

                }

                //fan_or_blower
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivenType) && model.machineComponentsForMIDgeneration.driven.drivenType.ToLower() == DrivenType.fan_or_blower.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.driven.drivens != null && model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower != null)
                    {
                        if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.fan_or_blower.ToString())
                        //&& model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerType == Drivenfan_or_blowerType.lobed.ToString()
                        {
                            //fan_or_blowerType
                            if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerType) || !Enum.IsDefined(typeof(DrivenFan_or_BlowerType), model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerType.ToLower()))
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerType), Constants.drivensFan_or_blowerTypeValidationMsg);
                        }

                        if (model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes != null)
                        {
                            //fan_or_blowerLobed
                            if (model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerLobed != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.fan_or_blower.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerType == DrivenFan_or_BlowerType.lobed.ToString())
                                {
                                    //lobedFanOrBlowerHasBallBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerLobed.lobedFanOrBlowerHasBallBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerLobed.lobedFanOrBlowerHasBallBearings), Constants.drivensLobedFanOrBlowerHasBallBearingsValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerOverhungRotor = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerSupportedRotor = null;
                                }
                            }

                            //fan_or_blowerOverhungRotor
                            if (model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerOverhungRotor != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.fan_or_blower.ToString()
                                   && model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerType == DrivenFan_or_BlowerType.overhungrotor.ToString())
                                {
                                    //fanStages
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerOverhungRotor.fanStages == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerOverhungRotor) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerOverhungRotor.fanStages), Constants.drivensFanStagesValidationMsg);

                                    //overhungRotorFanOrBlowerHasBearings
                                    if (model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerOverhungRotor.overhungRotorFanOrBlowerHasBearings == null)
                                        modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerOverhungRotor.overhungRotorFanOrBlowerHasBearings), Constants.drivensOverhungRotorFanOrBlowerHasBearingsValidationMsg);

                                    model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerLobed = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerSupportedRotor = null;
                                }
                            }

                            //fan_or_blowerSupportedRotor
                            if (model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerSupportedRotor != null)
                            {
                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.fan_or_blower.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerType == DrivenFan_or_BlowerType.supportedrotor.ToString())
                                {
                                    model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerLobed = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower.fan_or_blowerTypes.fan_or_blowerOverhungRotor = null;
                                }
                            }
                        }

                        model.machineComponentsForMIDgeneration.driven.drivens.pump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.compressor = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.decanter = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.generator = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing = null;
                    }
                }

                //purifier_centrifuge
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivenType) && model.machineComponentsForMIDgeneration.driven.drivenType.ToLower() == DrivenType.purifier_centrifuge.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.driven.drivens != null && model.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge != null)
                    {
                        if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.purifier_centrifuge.ToString())
                        {
                            //purifierDrivenBy
                            if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge.purifierDrivenBy) || !Enum.IsDefined(typeof(DrivenPurifierDrivenBy), model.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge.purifierDrivenBy.ToLower()))
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge.purifierDrivenBy), Constants.drivenPurifierDrivenByValidationMsg);
                        }

                        model.machineComponentsForMIDgeneration.driven.drivens.pump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.compressor = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.decanter = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.generator = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing = null;
                    }
                }

                //generator
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivenType) && model.machineComponentsForMIDgeneration.driven.drivenType.ToLower() == DrivenType.generator.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.driven.drivens != null && model.machineComponentsForMIDgeneration.driven.drivens.generator != null)
                    {
                        if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.generator.ToString())
                        {
                            //bearingType
                            if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.generator.bearingType) || !Enum.IsDefined(typeof(DrivenBearingType), model.machineComponentsForMIDgeneration.driven.drivens.generator.bearingType.ToLower()))
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.generator.bearingType), Constants.drivensBearingTypeValidationMsg);

                            //exciter
                            if (model.machineComponentsForMIDgeneration.driven.drivens.generator.exciter == null)
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.generator.exciter), Constants.drivensExciterValidationMsg);

                            //exciterOverhungOrSupported
                            if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.generator.exciterOverhungOrSupported) && !Enum.IsDefined(typeof(DrivenExciterOverhungOrSupported), model.machineComponentsForMIDgeneration.driven.drivens.generator.exciterOverhungOrSupported.ToLower()))
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.generator.exciterOverhungOrSupported), Constants.drivensExciterOverhungOrSupportedValidationMsg);

                            //drivenBy
                            if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.generator.drivenBy) || !Enum.IsDefined(typeof(DrivenGeneratorDrivenBy), model.machineComponentsForMIDgeneration.driven.drivens.generator.drivenBy.ToLower()))
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.generator.drivenBy), Constants.drivensDrivenByValidationMsg);
                        }

                        model.machineComponentsForMIDgeneration.driven.drivens.pump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.compressor = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.decanter = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing = null;
                    }
                }

                //decanter
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivenType) && model.machineComponentsForMIDgeneration.driven.drivenType.ToLower() == DrivenType.decanter.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.driven.drivens != null)
                    {
                        model.machineComponentsForMIDgeneration.driven.drivens.pump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.compressor = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.generator = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing = null;
                    }
                }

                //vacuumpump
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivenType) && model.machineComponentsForMIDgeneration.driven.drivenType.ToLower() == DrivenType.vacuumpump.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.driven.drivens != null && model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump != null)
                    {
                        if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.vacuumpump.ToString())
                        {
                            //vacuumpumptype
                            if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumptype) || !Enum.IsDefined(typeof(DrivenVacuumPumpType), model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumptype.ToLower()))
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumptype), Constants.drivensVacuumPumptypeValidationMsg);

                            ///vacuumpumpTypes
                            if (model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes != null)
                            {
                                //vacuumpumpCentrifugal
                                if (model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpCentrifugal != null)
                                {
                                    if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.vacuumpump.ToString()
                                        && model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumptype == DrivenVacuumPumpType.centrifugal.ToString())
                                    {
                                        //bearingsType
                                        if (model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpCentrifugal.bearingsType == null || !Enum.IsDefined(typeof(DrivenBearingsType), model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpCentrifugal.bearingsType.ToLower()))
                                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpCentrifugal.bearingsType), Constants.drivensBearingsTypeValidationMsg);

                                        //thrustBearing
                                        if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpCentrifugal.thrustBearing) && !Enum.IsDefined(typeof(DrivenVaccumPumpThrustBearing), model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpCentrifugal.thrustBearing.ToLower()))
                                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpCentrifugal.thrustBearing), Constants.drivensVaccumPumpThrustBearingValidationMsg);

                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpAxialRecip = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpRadialRecip = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpReciprocating = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpLobed = null;
                                    }
                                }

                                //vacuumpumpAxialRecip
                                if (model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpAxialRecip != null)
                                {
                                    if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.vacuumpump.ToString()
                                        && model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumptype == DrivenVacuumPumpType.axialrecip.ToString())
                                    {
                                        //bearingsType
                                        if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpAxialRecip.bearingsType) && !Enum.IsDefined(typeof(DrivenVacuumPumpAxialRecipBearingsType), model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpAxialRecip.bearingsType.ToLower()))
                                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpAxialRecip.bearingsType), Constants.drivensBearingsTypeThrustBearingValidationMsg);

                                        //thrustBearing
                                        if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpAxialRecip.thrustBearing) && !Enum.IsDefined(typeof(DrivenVacuumPumpAxialRecipThrustBearing), model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpAxialRecip.thrustBearing.ToLower()))
                                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpAxialRecip.thrustBearing), Constants.drivensVacuumPumpAxialRecipThrustBearingValidationMsg);

                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpCentrifugal = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpRadialRecip = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpReciprocating = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpLobed = null;
                                    }
                                }

                                if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.vacuumpump.ToString()
                                    && model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumptype == DrivenVacuumPumpType.radialrecip.ToString())
                                {

                                    model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpCentrifugal = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpAxialRecip = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpReciprocating = null;
                                    model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpLobed = null;
                                }

                                //vacuumpumpReciprocating
                                if (model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpReciprocating != null)
                                {
                                    if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.vacuumpump.ToString()
                                        && model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumptype == DrivenVacuumPumpType.reciprocating.ToString())
                                    {
                                        //bearingsType
                                        if (model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpReciprocating.bearingsType == null || !Enum.IsDefined(typeof(DrivenVacuumPumpReciprocating), model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpReciprocating.bearingsType.ToLower()))
                                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpReciprocating.bearingsType), Constants.drivensVacuumpumpReciprocatingValidationMsg);

                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpCentrifugal = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpAxialRecip = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpRadialRecip = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpLobed = null;
                                    }
                                }

                                //vacuumpumpLobed
                                if (model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpLobed != null)
                                {
                                    if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.vacuumpump.ToString()
                                        && model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumptype == DrivenVacuumPumpType.lobed.ToString())
                                    {
                                        //bearingsType
                                        if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpLobed.bearingsType) || !Enum.IsDefined(typeof(DrivenVacuumpumpLobedBearingsType), model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpLobed.bearingsType.ToLower()))
                                            modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpLobed.bearingsType), Constants.drivensVacuumpumpLobedBearingsTypeValidationMsg);

                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpCentrifugal = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpAxialRecip = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpRadialRecip = null;
                                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump.vacuumpumpTypes.vacuumpumpReciprocating = null;
                                    }
                                }
                            }
                            model.machineComponentsForMIDgeneration.driven.drivens.pump = null;
                            model.machineComponentsForMIDgeneration.driven.drivens.compressor = null;
                            model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower = null;
                            model.machineComponentsForMIDgeneration.driven.drivens.decanter = null;
                            model.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge = null;
                            model.machineComponentsForMIDgeneration.driven.drivens.generator = null;
                            model.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing = null;
                        }
                    }
                }

                //spindle_or_shaft_or_bearing
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivenType) && model.machineComponentsForMIDgeneration.driven.drivenType.ToLower() == DrivenType.spindle_or_shaft_or_bearing.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.driven.drivens != null && model.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing != null)
                    {
                        if (model.machineComponentsForMIDgeneration.driven.drivenType == DrivenType.spindle_or_shaft_or_bearing.ToString())
                        {
                            //spindleShaftBearing
                            if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing.spindleShaftBearing) || !Enum.IsDefined(typeof(DrivenSpindleShaftBearing), model.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing.spindleShaftBearing.ToLower()))
                                modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivens.spindle_or_shaft_or_bearing.spindleShaftBearing), Constants.drivenspindleShaftBearingValidationMsg);
                        }

                        model.machineComponentsForMIDgeneration.driven.drivens.pump = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.compressor = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.fan_or_blower = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.decanter = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.purifier_centrifuge = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.generator = null;
                        model.machineComponentsForMIDgeneration.driven.drivens.vacuumpump = null;
                    }
                }
            }
            else
                model.machineComponentsForMIDgeneration.driven = null;

            //Validations for speed ratio of coupling 1 and coupling 2 component
            if ((model.machineComponentsForMIDgeneration.coupling1 != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.coupling1.componentType)) &&
                (model.machineComponentsForMIDgeneration.coupling2 != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.coupling2.componentType)))
            {
                if (model.machineComponentsForMIDgeneration.coupling1.speedratio != null &&
                    model.machineComponentsForMIDgeneration.coupling2.speedratio != null &&
                    model.machineComponentsForMIDgeneration.coupling1.speedratio != 1 &&
                    model.machineComponentsForMIDgeneration.coupling2.speedratio != 1)
                {
                    modelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.speedratio), Constants.c1AndC2CouplingValidationMessage);
                }
            }

            #endregion
        }
    }
}
