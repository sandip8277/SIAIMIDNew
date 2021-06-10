using Microsoft.AspNetCore.Mvc.ModelBinding;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.DrivenModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using static MIDDerivationLibrary.Enums.DrivenEnums;

namespace MIDDerivationLibrary.Helper
{
    public class DrivenValidationHelper
    {
        public static void ValidateDrivenInput(ref ModelStateDictionary modelState, ref DrivenDetails model)
        {
            if (model != null)
            {
                //componentType
                if (!Enum.IsDefined(typeof(DrivenComponentType), model.componentType.ToLower()))
                    modelState.AddModelError(nameof(model.componentType), Constants.drivenComponentTypeValidationMsg);

                //locations
                if (model.locations == null || !(model.locations >= 0 && model.locations <= 2))
                    modelState.AddModelError(nameof(model.locations), Constants.drivenLocationValidationMsg);

                //drivenType
                if (string.IsNullOrEmpty(model.drivenType) || !Enum.IsDefined(typeof(DrivenType), model.drivenType.ToLower()))
                    modelState.AddModelError(nameof(model.drivenType), Constants.drivenTypeValidationMsg);

                //pump
                if (!string.IsNullOrEmpty(model.drivenType) && model.drivenType.ToLower() == DrivenType.pump.ToString())
                {
                    //pumpType
                    if (string.IsNullOrEmpty(model.pumpType) || !Enum.IsDefined(typeof(DrivenPumpType), model.pumpType.ToLower()))
                        modelState.AddModelError(nameof(model.pumpType), Constants.drivensPumpTypeValidationMsg);

                    if (model.pumpType == DrivenPumpType.centrifugal.ToString())
                    {
                        //rotorOverhung
                        if (model.rotorOverhung == null)
                            modelState.AddModelError(nameof(model.rotorOverhung), Constants.drivensRotorOverhungValidationMsg);

                        //centrifugalPumpHasBallBearings
                        if (model.centrifugalPumpHasBallBearings == null)
                            modelState.AddModelError(nameof(model.centrifugalPumpHasBallBearings), Constants.drivensCentrifugalPumpHasBallBearingsValidationMsg);

                        //thrustBearing
                        if (model.thrustBearing == null || !Enum.IsDefined(typeof(DrivenThrustBearing), model.thrustBearing.ToLower()))
                            modelState.AddModelError(nameof(model.thrustBearing), Constants.drivensThrustBearingValidationMsg);

                        //model.propellerpumpHasBallBearings = null;
                        //model.rotaryThreadPumpHasBallBearings = null;
                        //model.gearPumpHasBallBearings = null;
                        //model.screwPumpHasBallBearings = null;
                        //model.slidingVanePumpHasBallBearings = null;
                        //model.axialRecipPumpHasBallBearings = null;
                        //model.attachedOilPump = null;
                    }

                    if (model.pumpType == DrivenPumpType.propeller.ToString())
                    {
                        //propellerpumpHasBallBearings
                        if (model.propellerpumpHasBallBearings == null)
                            modelState.AddModelError(nameof(model.propellerpumpHasBallBearings), Constants.drivensPropellerpumpHasBallBearingsValidationMsg);

                        //model.rotorOverhung = null;
                        //model.centrifugalPumpHasBallBearings = null;
                        //model.thrustBearing = null;
                        //model.rotaryThreadPumpHasBallBearings = null;
                        //model.gearPumpHasBallBearings = null;
                        //model.screwPumpHasBallBearings = null;
                        //model.slidingVanePumpHasBallBearings = null;
                        //model.axialRecipPumpHasBallBearings = null;
                        //model.thrustBearing = null;
                        //model.attachedOilPump = null;
                    }

                    if (model.pumpType == DrivenPumpType.rotarythread.ToString())
                    {
                        //rotaryThreadPumpHasBallBearings
                        if (model.rotaryThreadPumpHasBallBearings == null)
                            modelState.AddModelError(nameof(model.rotaryThreadPumpHasBallBearings), Constants.drivensRotaryThreadPumpHasBallBearingsValidationMsg);

                        //model.rotorOverhung = null;
                        //model.centrifugalPumpHasBallBearings = null;
                        //model.thrustBearing = null;
                        //model.propellerpumpHasBallBearings = null;
                        //model.gearPumpHasBallBearings = null;
                        //model.screwPumpHasBallBearings = null;
                        //model.slidingVanePumpHasBallBearings = null;
                        //model.axialRecipPumpHasBallBearings = null;
                        //model.thrustBearing = null;
                        //model.attachedOilPump = null;
                    }

                    if (model.pumpType == DrivenPumpType.gear.ToString())
                    {
                        //gearPumpHasBallBearings
                        if (model.gearPumpHasBallBearings == null)
                            modelState.AddModelError(nameof(model.gearPumpHasBallBearings), Constants.drivensGearPumpHasBallBearingsValidationMsg);

                        //model.rotorOverhung = null;
                        //model.centrifugalPumpHasBallBearings = null;
                        //model.thrustBearing = null;
                        //model.propellerpumpHasBallBearings = null;
                        //model.rotaryThreadPumpHasBallBearings = null;
                        //model.screwPumpHasBallBearings = null;
                        //model.slidingVanePumpHasBallBearings = null;
                        //model.axialRecipPumpHasBallBearings = null;
                        //model.thrustBearing = null;
                        //model.attachedOilPump = null;
                    }

                    if (model.pumpType == DrivenPumpType.screw.ToString())
                    {
                        //screwPumpHasBallBearings
                        if (model.screwPumpHasBallBearings == null)
                            modelState.AddModelError(nameof(model.screwPumpHasBallBearings), Constants.drivensScrewPumpHasBallBearingsValidationMsg);

                        //model.rotorOverhung = null;
                        //model.centrifugalPumpHasBallBearings = null;
                        //model.thrustBearing = null;
                        //model.propellerpumpHasBallBearings = null;
                        //model.rotaryThreadPumpHasBallBearings = null;
                        //model.gearPumpHasBallBearings = null;
                        //model.slidingVanePumpHasBallBearings = null;
                        //model.axialRecipPumpHasBallBearings = null;
                        //model.thrustBearing = null;
                        //model.attachedOilPump = null;
                    }

                    if (model.pumpType == DrivenPumpType.slidingvane.ToString())
                    {
                        //slidingVanePumpHasBallBearings
                        if (model.slidingVanePumpHasBallBearings == null)
                            modelState.AddModelError(nameof(model.slidingVanePumpHasBallBearings), Constants.drivenSlidingVanePumpHasBallBearingsValidationMsg);

                        //model.rotorOverhung = null;
                        //model.centrifugalPumpHasBallBearings = null;
                        //model.thrustBearing = null;
                        //model.propellerpumpHasBallBearings = null;
                        //model.rotaryThreadPumpHasBallBearings = null;
                        //model.gearPumpHasBallBearings = null;
                        //model.screwPumpHasBallBearings = null;
                        //model.axialRecipPumpHasBallBearings = null;
                        //model.thrustBearing = null;
                        //model.attachedOilPump = null;
                    }

                    if (model.pumpType == DrivenPumpType.axialrecip.ToString())
                    {
                        //axialRecipPumpHasBallBearings
                        if (model.axialRecipPumpHasBallBearings == null)
                            modelState.AddModelError(nameof(model.axialRecipPumpHasBallBearings), Constants.drivenSlidingVanePumpHasBallBearingsValidationMsg);

                        //thrustBearing
                        if (model.thrustBearing != null && !Enum.IsDefined(typeof(PumpRotaryAxialRecipThrustBearing), model.thrustBearing.ToLower()))
                            modelState.AddModelError(nameof(model.thrustBearing), Constants.drivenThrustBearingValidationMsg);

                        //model.rotorOverhung = null;
                        //model.centrifugalPumpHasBallBearings = null;
                        //model.propellerpumpHasBallBearings = null;
                        //model.rotaryThreadPumpHasBallBearings = null;
                        //model.gearPumpHasBallBearings = null;
                        //model.screwPumpHasBallBearings = null;
                        //model.slidingVanePumpHasBallBearings = null;
                    }
                }

                //--

                //compressor
                if (!string.IsNullOrEmpty(model.drivenType) && model.drivenType.ToLower() == DrivenType.compressor.ToString())
                {
                    //compressorType
                    if (string.IsNullOrEmpty(model.compressorType) || !Enum.IsDefined(typeof(DrivenCompressorType), model.compressorType.ToLower()))
                        modelState.AddModelError(nameof(model.compressorType), Constants.drivensCompressorTypeValidationMsg);

                    if (model.compressorType == DrivenCompressorType.centrifugal.ToString())
                    {
                        //impellerOnMainShaft
                        if (model.impellerOnMainShaft == null)
                            modelState.AddModelError(nameof(model.impellerOnMainShaft), Constants.drivensImpellerOnMainShaftValidationMsg);

                        //centrifugalPumpHasBallBearings
                        if (model.centrifugalCompressorHasBallBearings == null)
                            modelState.AddModelError(nameof(model.centrifugalCompressorHasBallBearings), Constants.drivensCompressorCentrifugalCompressorHasBallBearings);

                        //thrustBearing
                        if (model.drivenType.ToLower() == DrivenType.compressor.ToString() && model.thrustBearing != null && !Enum.IsDefined(typeof(DrivenCompressorThrustBearing), model.thrustBearing.ToLower()))
                            modelState.AddModelError(nameof(model.thrustBearing), Constants.drivensCompressorThrustBearingValidationMsg);
                    }

                    if (model.compressorType == DrivenCompressorType.reciprocating.ToString())
                    {
                        //reciprocatingCompressorHasBallBearings
                        if (model.reciprocatingCompressorHasBallBearings == null)
                            modelState.AddModelError(nameof(model.reciprocatingCompressorHasBallBearings), Constants.drivensReciprocatingCompressorHasBallBearingsValidationMsg);
                    }

                    if (model.compressorType == DrivenPumpType.screw.ToString())
                    {
                        //screwCompressorHasBallBearings
                        if (model.screwCompressorHasBallBearings == null)
                            modelState.AddModelError(nameof(model.screwCompressorHasBallBearings), Constants.drivensScrewCompressorHasBallBearingsValidationMsg);
                    }

                    if (model.compressorType == DrivenCompressorType.screwtwin.ToString())
                    {
                        //screwTwinCompressorHasBallBearingsOnHPSide
                        if (model.screwTwinCompressorHasBallBearingsOnHPSide == null)
                            modelState.AddModelError(nameof(model.screwTwinCompressorHasBallBearingsOnHPSide), Constants.drivensScrewTwinCompressorHasBallBearingsOnHPSideValidationMsg);
                    }
                }

                //fan_or_blower
                if (!string.IsNullOrEmpty(model.drivenType) && model.drivenType.ToLower() == DrivenType.fan_or_blower.ToString())
                {
                    //fan_or_blowerType
                    if (string.IsNullOrEmpty(model.fan_or_blowerType) || !Enum.IsDefined(typeof(DrivenFan_or_BlowerType), model.fan_or_blowerType.ToLower()))
                        modelState.AddModelError(nameof(model.fan_or_blowerType), Constants.drivensFan_or_blowerTypeValidationMsg);


                    if (model.fan_or_blowerType == DrivenFan_or_BlowerType.lobed.ToString())
                    {
                        //lobedFanOrBlowerHasBallBearings
                        if (model.lobedFanOrBlowerHasBallBearings == null)
                            modelState.AddModelError(nameof(model.lobedFanOrBlowerHasBallBearings), Constants.drivensLobedFanOrBlowerHasBallBearingsValidationMsg);
                    }

                    if (model.fan_or_blowerType == DrivenFan_or_BlowerType.overhungrotor.ToString())
                    {
                        //fanStages
                        if (model.fanStages == null)
                            modelState.AddModelError(nameof(model.fanStages), Constants.drivensFanStagesValidationMsg);

                        //overhungRotorFanOrBlowerHasBearings
                        if (model.overhungRotorFanOrBlowerHasBearings == null)
                            modelState.AddModelError(nameof(model.overhungRotorFanOrBlowerHasBearings), Constants.drivensOverhungRotorFanOrBlowerHasBearingsValidationMsg);
                    }
                }

                //purifier_centrifuge
                if (!string.IsNullOrEmpty(model.drivenType) && model.drivenType.ToLower() == DrivenType.purifier_centrifuge.ToString())
                {
                    if (model.drivenType == DrivenType.purifier_centrifuge.ToString())
                    {
                        //purifierDrivenBy
                        if (string.IsNullOrEmpty(model.purifierDrivenBy) || !Enum.IsDefined(typeof(DrivenPurifierDrivenBy), model.purifierDrivenBy.ToLower()))
                            modelState.AddModelError(nameof(model.purifierDrivenBy), Constants.drivenPurifierDrivenByValidationMsg);
                    }
                }

                //generator
                if (!string.IsNullOrEmpty(model.drivenType) && model.drivenType.ToLower() == DrivenType.generator.ToString())
                {
                    //bearingType
                    if (string.IsNullOrEmpty(model.bearingType) || !Enum.IsDefined(typeof(DrivenBearingType), model.bearingType.ToLower()))
                        modelState.AddModelError(nameof(model.bearingType), Constants.drivensBearingTypeValidationMsg);

                    //exciter
                    if (model.exciter == null)
                        modelState.AddModelError(nameof(model.exciter), Constants.drivensExciterValidationMsg);

                    //exciterOverhungOrSupported
                    if (!string.IsNullOrEmpty(model.exciterOverhungOrSupported) && !Enum.IsDefined(typeof(DrivenExciterOverhungOrSupported), model.exciterOverhungOrSupported.ToLower()))
                        modelState.AddModelError(nameof(model.exciterOverhungOrSupported), Constants.drivensExciterOverhungOrSupportedValidationMsg);

                    //drivenBy
                    if (string.IsNullOrEmpty(model.drivenBy) || !Enum.IsDefined(typeof(DrivenGeneratorDrivenBy), model.drivenBy.ToLower()))
                        modelState.AddModelError(nameof(model.drivenBy), Constants.drivensDrivenByValidationMsg);
                }

                //vacuumpump
                if (!string.IsNullOrEmpty(model.drivenType) && model.drivenType.ToLower() == DrivenType.vacuumpump.ToString())
                {
                    //vacuumpumptype
                    if (string.IsNullOrEmpty(model.vacuumPumpType) || !Enum.IsDefined(typeof(DrivenVacuumPumpType), model.vacuumPumpType.ToLower()))
                        modelState.AddModelError(nameof(model.vacuumPumpType), Constants.drivensVacuumPumptypeValidationMsg);

                    if (model.vacuumPumpType == DrivenVacuumPumpType.centrifugal.ToString())
                    {
                        //bearingsType
                        if (model.bearingsType == null || !Enum.IsDefined(typeof(DrivenBearingsType), model.bearingsType.ToLower()))
                            modelState.AddModelError(nameof(model.bearingsType), Constants.drivensBearingsTypeValidationMsg);

                        //thrustBearing
                        if (!string.IsNullOrEmpty(model.thrustBearing) && !Enum.IsDefined(typeof(DrivenVaccumPumpThrustBearing), model.thrustBearing.ToLower()))
                            modelState.AddModelError(nameof(model.thrustBearing), Constants.drivensVaccumPumpThrustBearingValidationMsg);
                    }

                    if (model.vacuumPumpType == DrivenVacuumPumpType.reciprocating.ToString())
                    {
                        //bearingsType
                        if (model.bearingsType == null || !Enum.IsDefined(typeof(DrivenVacuumPumpReciprocating), model.bearingsType.ToLower()))
                            modelState.AddModelError(nameof(model.bearingsType), Constants.drivensVacuumpumpReciprocatingValidationMsg);
                    }

                    if (model.vacuumPumpType == DrivenVacuumPumpType.lobed.ToString())
                    {
                        //bearingsType
                        if (string.IsNullOrEmpty(model.bearingsType) || !Enum.IsDefined(typeof(DrivenVacuumpumpLobedBearingsType), model.bearingsType.ToLower()))
                            modelState.AddModelError(nameof(model.bearingsType), Constants.drivensVacuumpumpLobedBearingsTypeValidationMsg);
                    }

                }

                //spindle_or_shaft_or_bearing
                if (!string.IsNullOrEmpty(model.drivenType) && model.drivenType.ToLower() == DrivenType.spindle_or_shaft_or_bearing.ToString())
                {
                    if (model.drivenType == DrivenType.spindle_or_shaft_or_bearing.ToString())
                    {
                        //spindleShaftBearing
                        if (string.IsNullOrEmpty(model.spindleShaftBearing) || !Enum.IsDefined(typeof(DrivenSpindleShaftBearing), model.spindleShaftBearing.ToLower()))
                            modelState.AddModelError(nameof(model.spindleShaftBearing), Constants.drivenspindleShaftBearingValidationMsg);
                    }
                }
            }
        }
    }
}
