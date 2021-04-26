using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MIDCodeGenerator.Helper;
using MIDCodeGenerator.Models;
using MIDDerivationLibrary.Business;

using MIDDerivationLibrary.Models.APIResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Xml.Linq;

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
        [Route("GenerateCodes")]
        public ActionResult<MIDCodeDetails> GenerateCodes([FromBody] MIDCodeCreatorRequest model)
        {
      

            if (model.machineComponentsForMIDgeneration == null)
                ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration), "Machine components for MID generation shoulde not be null.");

            //Validations for driver component
            else if (model.machineComponentsForMIDgeneration.driver != null && !string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.driver.componentType))
            {
                if (model.machineComponentsForMIDgeneration.driver.locations == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.locations), "Locations is required");

                if (string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.driver.driverType))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driver.driverType), "DriverType is required");
            }

            //Validations for coupling1 component
            else if (model.machineComponentsForMIDgeneration.coupling1 != null && !string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.coupling1.componentType))
            {
                if (model.machineComponentsForMIDgeneration.coupling1.couplingPosition == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.couplingPosition), "CouplingPosition is required");

                if (string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.coupling1.couplingType))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling1.couplingType), "CouplingType is required");
            }

            //Validations for intermediate component
            else if (model.machineComponentsForMIDgeneration.intermediate != null && !string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.intermediate.componentType))
            {
                if (string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.intermediate.immediateType))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.intermediate.immediateType), "ImmediateType is required");
            }

            //Validations for coupling2 component
            else if (model.machineComponentsForMIDgeneration.coupling2 != null && !string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.coupling2.componentType))
            {
                if (model.machineComponentsForMIDgeneration.coupling2.couplingPosition == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.couplingPosition), "CouplingPosition is required");

                if (string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.coupling2.couplingType))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.coupling2.couplingType), "CouplingType is required");
            }

            //Validations for driven component
            else if (model.machineComponentsForMIDgeneration.driven != null && !string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.driven.componentType))
            {
              
                if (string.IsNullOrWhiteSpace(model.machineComponentsForMIDgeneration.driven.drivenType))
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.drivenType), "DrivenType is required");

                if (model.machineComponentsForMIDgeneration.driven.locations == null)
                    ModelState.AddModelError(nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven) + "." + nameof(MIDCodeCreatorRequest.machineComponentsForMIDgeneration.driven.locations), "Locations is required");

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
                        return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500,null));
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
