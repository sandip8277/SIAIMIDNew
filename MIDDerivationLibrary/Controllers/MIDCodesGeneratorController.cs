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
using static MIDDerivationLibrary.Models.DriverEnums;


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

            if (model.machineComponentsForMIDgeneration.driver != null)
            {
                //componentType
                if (string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.driver.componentType) || !Enum.IsDefined(typeof(DriverComponentType), model.machineComponentsForMIDgeneration.driver.componentType.ToLower()))
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
                if (string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.driver.driverType) || !Enum.IsDefined(typeof(DriverType), model.machineComponentsForMIDgeneration.driver.driverType.ToLower()))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.driverType), Constants.driverTypeTypeValidationMsg);

                //drivers
                if (model.machineComponentsForMIDgeneration.driver.drivers == null || (model.machineComponentsForMIDgeneration.driver.drivers.diesel == null && model.machineComponentsForMIDgeneration.driver.drivers.motor == null && model.machineComponentsForMIDgeneration.driver.drivers.turbine == null))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers), Constants.driversValidationMsg);

                //diesel cylinders
                if (model.machineComponentsForMIDgeneration.driver.driverType.ToLower() == "diesel")
                {
                    if (model.machineComponentsForMIDgeneration.driver.drivers.diesel.cylinders == null || !Enum.IsDefined(typeof(DieselCylinders), model.machineComponentsForMIDgeneration.driver.drivers.diesel.cylinders))
                        ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.diesel.cylinders), Constants.driversCylindersValidationMsg);
                }

                //motor
                if (model.machineComponentsForMIDgeneration.driver.driverType.ToLower() == "motor")
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
                    if (model.machineComponentsForMIDgeneration.driver.drivers.motor.motorDrive.ToUpper() == "VFD")
                    {
                        if (model.machineComponentsForMIDgeneration.driver.drivers.motor.VFD == null || (model.machineComponentsForMIDgeneration.driver.drivers.motor.VFD.motorPoles == null || !Enum.IsDefined(typeof(MotorPoles), model.machineComponentsForMIDgeneration.driver.drivers.motor.VFD.motorPoles)))
                            ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.drivers.motor.VFD.motorPoles), Constants.driverMotorPolesValidationMsg);
                    }

                }

                //Turbin
                if (model.machineComponentsForMIDgeneration.driver.driverType.ToLower() == "turbine")
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
            if (model.machineComponentsForMIDgeneration.coupling1 != null && !string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.coupling1.componentType))
            {
                if (model.machineComponentsForMIDgeneration.coupling1.couplingPosition == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.couplingPosition), Constants.couplingPositionTypeRequiredMessage);

                if (string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.coupling1.couplingType))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.couplingType), Constants.couplingTypeRequiredMessage);

                if (model.machineComponentsForMIDgeneration.coupling1.speedratio == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.speedratio), Constants.speedRatioRequiredMessage);
            }

            //Validations for intermediate component
            if (model.machineComponentsForMIDgeneration.intermediate != null && !string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.intermediate.componentType))
            {
                if (string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.intermediate.immediateType))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.immediateType), Constants.intermediateTypeRequiredMessage);
            }

            //Validations for coupling2 component
            if (model.machineComponentsForMIDgeneration.coupling2 != null && !string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.coupling2.componentType))
            {
                if (model.machineComponentsForMIDgeneration.coupling2.couplingPosition == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.couplingPosition), Constants.couplingPositionTypeRequiredMessage);

                if (string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.coupling2.couplingType))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.couplingType), Constants.couplingTypeRequiredMessage);

                if (model.machineComponentsForMIDgeneration.coupling2.speedratio == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.speedratio), Constants.speedRatioRequiredMessage);
            }

            //Validations for driven component
            if (model.machineComponentsForMIDgeneration.driven != null && !string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.driven.componentType))
            {

                if (string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.driven.drivenType))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivenType), Constants.drivenTypeRequiredMessage);

                if (model.machineComponentsForMIDgeneration.driven.locations == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.locations), Constants.locationRequiredMessage);

            }

            //Validations for speed ratio of coupling 1 and coupling 2 component
            if ((model.machineComponentsForMIDgeneration.coupling1 != null && !string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.coupling1.componentType)) &&
                (model.machineComponentsForMIDgeneration.coupling2 != null && !string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.coupling2.componentType)))
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
