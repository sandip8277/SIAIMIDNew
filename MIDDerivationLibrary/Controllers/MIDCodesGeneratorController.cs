using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MIDCodeGenerator.Helper;
using MIDCodeGenerator.Models;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Xml.Linq;
using static MIDDerivationLibrary.Enums.Coupling1Enums;
using static MIDDerivationLibrary.Enums.Coupling2Enums;
using static MIDDerivationLibrary.Enums.DriverEnums;
using static MIDDerivationLibrary.Enums.IntermediateEnums;

namespace MIDDerivationLibrary.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MIDCodesGeneratorController : ControllerBase
    {
        private readonly IMIDCodeGeneratorService _service;
        public MIDCodesGeneratorController(IMIDCodeGeneratorService service)
        {
            this._service = service;
        }


        [HttpPost]
        //[Authorize]
        [Route("GenerateCodes")]
        public ActionResult<MIDCodeDetails> GenerateCodes([FromBody] MIDCodeCreatorRequest model)
        {

            if (model.machineComponentsForMIDgeneration == null)
                ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration), "Machine components for MID generation shoulde not be null.");

            //Validations for Driver component
            if (model.machineComponentsForMIDgeneration.driver != null)
            {
                //componentType
                if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.componentType) || !Enum.IsDefined(typeof(DriverComponentType), model.machineComponentsForMIDgeneration.driver.componentType.ToLower()))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.componentType), Constants.driverComponentTypeValidationMsg);

                //locations
                if (model.machineComponentsForMIDgeneration.driver.locations == null || !(model.machineComponentsForMIDgeneration.driver.locations >= 1 && model.machineComponentsForMIDgeneration.driver.locations <= 10))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.locations), Constants.driverLocationValidationMsg);

                //driverLocationNDE
                if (model.machineComponentsForMIDgeneration.driver.driverLocationNDE == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.driverLocationNDE), Constants.driverLocationNDEValidationMsg);

                //driverLocationDE
                if (model.machineComponentsForMIDgeneration.driver.driverLocationDE == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.driverLocationDE), Constants.driverLocationDEValidationMsg);

                //driverType
                if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.driverType) || !Enum.IsDefined(typeof(DriverType), model.machineComponentsForMIDgeneration.driver.driverType.ToLower()))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.driverType), Constants.driverTypeTypeValidationMsg);

                //drivers
                if (model.machineComponentsForMIDgeneration.driver.drivers == null || (model.machineComponentsForMIDgeneration.driver.drivers.diesel == null && model.machineComponentsForMIDgeneration.driver.drivers.motor == null && model.machineComponentsForMIDgeneration.driver.drivers.turbine == null))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers), Constants.driversValidationMsg);

                //diesel cylinders
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.driverType) && model.machineComponentsForMIDgeneration.driver.driverType.ToLower() == "diesel")
                {
                    if (model.machineComponentsForMIDgeneration.driver.drivers.diesel.cylinders == null || !Enum.IsDefined(typeof(DieselCylinders), model.machineComponentsForMIDgeneration.driver.drivers.diesel.cylinders))
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.diesel.cylinders), Constants.driversCylindersValidationMsg);
                }

                //motor
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.driverType) && model.machineComponentsForMIDgeneration.driver.driverType.ToLower() == "motor")
                {
                    //motorDrive
                    if (!Enum.IsDefined(typeof(MotorDrive), model.machineComponentsForMIDgeneration.driver.drivers.motor.motorDrive))
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.motorDrive), Constants.driversMotorDriveValidationMsg);

                    //motorFan
                    if (model.machineComponentsForMIDgeneration.driver.drivers.motor.motorFan == null)
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.motorFan), Constants.driverMotorFanRequiredValidationMsg);

                    //motorBallBearings
                    if (model.machineComponentsForMIDgeneration.driver.drivers.motor.motorBallBearings == null)
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.motorBallBearings), Constants.driverMotorBallBearingsRequiredValidationMsg);

                    //drivenBallBearings
                    if (model.machineComponentsForMIDgeneration.driver.drivers.motor.drivenBallBearings == null)
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.drivenBallBearings), Constants.driverDrivenBallBearingsRequiredValidationMsg);

                    //drivenBalanceable
                    if (model.machineComponentsForMIDgeneration.driver.drivers.motor.drivenBalanceable == null)
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.drivenBalanceable), Constants.driverDrivenBalanceableRequiredValidationMsg);

                    //VFD
                    if (model.machineComponentsForMIDgeneration.driver.drivers != null && model.machineComponentsForMIDgeneration.driver.drivers.motor != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.drivers.motor.motorDrive) && model.machineComponentsForMIDgeneration.driver.drivers.motor.motorDrive.ToUpper() == "VFD")
                    {
                        if (model.machineComponentsForMIDgeneration.driver.drivers.motor.VFD == null || (model.machineComponentsForMIDgeneration.driver.drivers.motor.VFD.motorPoles == null || !Enum.IsDefined(typeof(MotorPoles), model.machineComponentsForMIDgeneration.driver.drivers.motor.VFD.motorPoles)))
                            ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.VFD.motorPoles), Constants.driverMotorPolesValidationMsg);
                    }

                }

                //Turbin
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.driver.driverType) && model.machineComponentsForMIDgeneration.driver.driverType.ToLower() == "turbine")
                {
                    //turbineReductionGear
                    if (model.machineComponentsForMIDgeneration.driver.drivers.turbine == null || model.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineReductionGear == null)
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineReductionGear), Constants.driverTurbineReductionGearRequiredValidationMsg);

                    //turbineRotorSupported
                    if (model.machineComponentsForMIDgeneration.driver.drivers.turbine == null || model.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineRotorSupported == null)
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineRotorSupported), Constants.driverTurbineRotorSupportedRequiredValidationMsg);

                    //turbineBallBearing
                    if (model.machineComponentsForMIDgeneration.driver.drivers.turbine == null || model.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineBallBearing == null)
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineBallBearing), Constants.driverTurbineBallBearingRequiredValidationMsg);

                    //turbineThrustBearing
                    if (model.machineComponentsForMIDgeneration.driver.drivers.turbine == null || model.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineThrustBearing == null)
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineThrustBearing), Constants.driverTurbineThrustBearingRequiredValidationMsg);

                    //turbineThrustBearingIsBall
                    if (model.machineComponentsForMIDgeneration.driver.drivers.turbine == null || model.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineThrustBearingIsBall == null)
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.turbine.turbineThrustBearingIsBall), Constants.driverTurbineThrustBearingIsBallRequiredValidationMsg);
                }

                //specialFaultCodesInput
                if (model.machineComponentsForMIDgeneration.driver.specialFaultCodesInput != null)
                {
                    foreach (var code in model.machineComponentsForMIDgeneration.driver.specialFaultCodesInput)
                    {
                        if (code.specialFaultCodeType != null && code.specialFaultCodeCount == null)
                            ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(model.machineComponentsForMIDgeneration.driver.specialFaultCodesInput) + "." + nameof(code.specialFaultCodeCount), Constants.driverSpecialFaultCodesInputValidationMsg);
                    }
                }
            }

            //Validations for coupling1 component
            if (model.machineComponentsForMIDgeneration.coupling1 != null)
            {
                //componentType
                if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.coupling1.componentType) || !Enum.IsDefined(typeof(Coupling1ComponentType), model.machineComponentsForMIDgeneration.coupling1.componentType.ToLower()))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.componentType), Constants.coupling1ComponentTypeValidationMsg);

                //couplingPosition
                if (model.machineComponentsForMIDgeneration.coupling1.couplingPosition == null || !Enum.IsDefined(typeof(Coupling1CouplingPosition), model.machineComponentsForMIDgeneration.coupling1.couplingPosition))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.couplingPosition), Constants.coupling1PositionTypeRequiredMessage);

                //couplingType
                if (model.machineComponentsForMIDgeneration.coupling1.couplingType == null || !Enum.IsDefined(typeof(Coupling1CouplingType), model.machineComponentsForMIDgeneration.coupling1.couplingType))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.couplingType), Constants.coupling1CouplingTypeRequiredMessage);

                //speedratio
                if (model.machineComponentsForMIDgeneration.coupling1.speedratio == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.speedratio), Constants.coupling1SpeedRatioRequiredMessage);

            }

            //Validations for coupling2 component
            if (model.machineComponentsForMIDgeneration.coupling2 != null)
            {
                //componentType
                if ((model.machineComponentsForMIDgeneration.intermediate == null || model.machineComponentsForMIDgeneration.intermediate.componentType == null) && model.machineComponentsForMIDgeneration.coupling2.componentType != null)
                {
                    //must be null if intermediate is not present
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.componentType), Constants.coupling2ComponentTypeValidationMsgIfIntermediateNotPresent);
                }
                else if ((model.machineComponentsForMIDgeneration.intermediate != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.componentType)) &&
                    (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.coupling2.componentType) || !Enum.IsDefined(typeof(Coupling2ComponentType), model.machineComponentsForMIDgeneration.coupling2.componentType.ToLower())))
                {
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.componentType), Constants.coupling2ComponentTypeValidationMsg);
                }

                //couplingPosition
                if (model.machineComponentsForMIDgeneration.coupling2.couplingPosition == null || !Enum.IsDefined(typeof(Coupling2CouplingPosition), model.machineComponentsForMIDgeneration.coupling2.couplingPosition))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.couplingPosition), Constants.coupling2PositionTypeRequiredMessage);

                //couplingType
                if (model.machineComponentsForMIDgeneration.coupling2.couplingType == null || !Enum.IsDefined(typeof(Coupling2CouplingType), model.machineComponentsForMIDgeneration.coupling2.couplingType))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.couplingType), Constants.coupling2CouplingTypeRequiredMessage);

                //speedratio
                if (model.machineComponentsForMIDgeneration.coupling2.speedratio == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.speedratio), Constants.coupling2SpeedRatioRequiredMessage);
            }


            //Validations for Intermediate component 
            if (model.machineComponentsForMIDgeneration.intermediate != null)
            {
                //componentType
                if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.componentType) || !Enum.IsDefined(typeof(IntermediateComponentType), model.machineComponentsForMIDgeneration.intermediate.componentType.ToLower()))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.componentType), Constants.intermediateComponentTypeValidationMsg);

                //locations
                if (model.machineComponentsForMIDgeneration.intermediate.locations == null || !(model.machineComponentsForMIDgeneration.intermediate.locations >= 1 && model.machineComponentsForMIDgeneration.intermediate.locations <= 10))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.locations), Constants.intermediateLocationValidationMsg);

                //speedratio
                if (model.machineComponentsForMIDgeneration.intermediate.speedratio == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.speedratio), Constants.intermediateSpeedratioValidationMsg);

                //intermediateType
                if (string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediateType) || !Enum.IsDefined(typeof(IntermediateType), model.machineComponentsForMIDgeneration.intermediate.intermediateType.ToLower()))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediateType), Constants.intermediateImmediateTypeValidationMsg);

                //intermediates
                if (model.machineComponentsForMIDgeneration.intermediate.intermediates == null || (model.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox == null && model.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr == null && model.machineComponentsForMIDgeneration.intermediate.intermediates.AOP == null))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates), Constants.intermediateIntermediatesValidationMsg);

                //gearbox
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediateType) && model.machineComponentsForMIDgeneration.intermediate.intermediateType.ToLower() == IntermediateType.gearbox.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.intermediate.intermediates == null || model.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox == null || model.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox.speedChangesMax == null || model.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox.speedChangesMax == 0)
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates.gearbox.speedChangesMax), Constants.intermediateSpeedChangesMaxValidationMsg);
                }

                //AOP
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediateType) && model.machineComponentsForMIDgeneration.intermediate.intermediateType.ToLower() == IntermediateType.aop.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.intermediate.intermediates == null || model.machineComponentsForMIDgeneration.intermediate.intermediates.AOP == null || string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediates.AOP.drivenBy))
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates.AOP) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates.AOP.drivenBy), Constants.intermediateAOPDrivenByValidationMsg);
                }

                //AccDrGr
                if (!string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediateType) && model.machineComponentsForMIDgeneration.intermediate.intermediateType.ToLower() == IntermediateType.accdrgr.ToString())
                {
                    if (model.machineComponentsForMIDgeneration.intermediate.intermediates == null || model.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr == null || string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr.drivenBy))
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.intermediates.AccDrGr.drivenBy), Constants.intermediateAccDrGrDrivenByValidationMsg);
                }
            }

            //Validations for speed ratio of coupling 1 and coupling 2 component
            if ((model.machineComponentsForMIDgeneration.coupling1 != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.coupling1.componentType)) &&
                (model.machineComponentsForMIDgeneration.coupling2 != null && !string.IsNullOrEmpty(model.machineComponentsForMIDgeneration.coupling2.componentType)))
            {
                if (model.machineComponentsForMIDgeneration.coupling1.speedratio != null &&
                    model.machineComponentsForMIDgeneration.coupling2.speedratio != null &&
                    model.machineComponentsForMIDgeneration.coupling1.speedratio != 1 &&
                    model.machineComponentsForMIDgeneration.coupling2.speedratio != 1)
                {
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.speedratio), Constants.c1AndC2CouplingValidationMessage);
                }
            }

            if (ModelState.IsValid)
            {
                try
                {
                    string xmlString = XmlHelper.ConvertObjectToXML(model);
                    XElement xElement = XElement.Parse(xmlString);
                    MIDCodeDetails details = _service.GenerareMIDCodes(xElement.ToString());
                    if (details != null)
                        return Ok(new ApiOkResponse(details));
                    else
                        return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
                }
                catch (Exception ex)
                {
                    ex.ToString();
                    return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
                }

            }
            else
                return BadRequest(new ApiBadRequestResponse(ModelState));
        }
    }
}
