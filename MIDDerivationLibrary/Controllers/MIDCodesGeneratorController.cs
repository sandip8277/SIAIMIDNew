using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.Extensions.Configuration;
using MIDCodeGenerator.Helper;
using MIDCodeGenerator.Models;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.MIDCodeDeconstruction;
using MIDDerivationLibrary.Helper;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.CodeDeconstructionModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Xml.Linq;
using static MIDDerivationLibrary.Enums.Coupling1Enums;
using static MIDDerivationLibrary.Enums.Coupling2Enums;
using static MIDDerivationLibrary.Enums.DrivenEnums;
using static MIDDerivationLibrary.Enums.DriverEnums;
using static MIDDerivationLibrary.Enums.IntermediateEnums;

namespace MIDDerivationLibrary.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MIDCodesGeneratorController : ControllerBase
    {
        private readonly IMIDCodeGeneratorService _service;
        private readonly IMIDCodeDeconstructionService _deconstructionService;
        public MIDCodesGeneratorController(IMIDCodeGeneratorService service, IMIDCodeDeconstructionService deconstructionService)
        {
            this._service = service;
            this._deconstructionService = deconstructionService;
        }


        [HttpPost]
        //[Authorize]
        [Route("GenerateCodes")]
        public ActionResult<MIDCodeDetails> GenerateCodes([FromBody] MIDCodeCreatorRequest model)
        {
            ModelStateDictionary ModelState = new ModelStateDictionary();
            ValidationHelper.ValidateInput(ref ModelState, ref model);
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

        [HttpPost]
        //[Authorize]
        [Route("MIDCodeDeconstruction")]
        public ActionResult<MIDdeconstrutionResponse> MIDCodeDeconstruction([FromBody] MIDCodeDeconstructionRequest model)
        {
            ModelStateDictionary ModelState = new ModelStateDictionary();
            if (ModelState.IsValid)
            {
                try
                {
                    string xmlString = XmlHelper.ConvertObjectToXML(model);
                    XElement xElement = XElement.Parse(xmlString);
                    MIDdeconstrutionResponse details = _deconstructionService.MIDCodeDeconstruction(xElement.ToString());
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
//return Ok(new ApiOkResponse(JsonConvert.DeserializeObject<MIDdeconstrutionResponse>(JsonConvert.SerializeObject(details,
//                      Newtonsoft.Json.Formatting.None,
//                      new JsonSerializerSettings
//                      {
//                          NullValueHandling = NullValueHandling.Ignore
//                      }))));