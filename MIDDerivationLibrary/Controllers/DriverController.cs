using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using MIDCodeGenerator.Helper;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.Driver;
using MIDDerivationLibrary.Helper;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.DriverModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace MIDDerivationLibrary.Controllers
{
    [Route("api/[controller]")]
    [Authorize]
    [ApiController]
    public class DriverController : ControllerBase
    {
        private readonly IDriverService _service;
        public DriverController(IDriverService service)
        {
            this._service = service;
        }

        [HttpPost]
        [Route("AddDriverDetails")]
        public ActionResult AddDriverDetails(DriverDetails model)
        {
            long id = 0;
            ModelStateDictionary ModelState = new ModelStateDictionary();
            DriverValidationHelper.ValidateDriverInput(ref ModelState, ref model);

            if (ModelState.IsValid)
            {
                try
                {
                    string xmlString = XmlHelper.ConvertObjectToXML(model);
                    XElement xElement = XElement.Parse(xmlString);

                    bool isExist = _service.CheckIsDriverDetailsExist(xmlString);

                    if (isExist == true)
                        return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                    else
                    {
                        id = _service.AddOrUpdateDriverDetails(xElement.ToString());
                        if (id > 0)
                            return Ok(new ApiOkResponse(id, Constants.recordSaved));
                        else
                            return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
                    }
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

        [HttpPut]
        [Route("UpdateDriverDetails")]
        public ActionResult UpdateDriverDetails(DriverDetails model)
        {
            long id = 0;
            ModelStateDictionary ModelState = new ModelStateDictionary();
            DriverValidationHelper.ValidateDriverInput(ref ModelState, ref model);

            if (model.id == 0)
                ModelState.AddModelError(nameof(DriverDetails.id), Constants.idValidationMessage);

            if (ModelState.IsValid)
            {
                try
                {
                    string xmlString = XmlHelper.ConvertObjectToXML(model);
                    XElement xElement = XElement.Parse(xmlString);

                    bool isExist = _service.CheckIsDriverDetailsExist(xmlString);

                    if (isExist == true)
                        return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                    else
                    {
                        id = _service.AddOrUpdateDriverDetails(xElement.ToString());
                        if (id > 0)
                            return Ok(new ApiOkResponse(id, Constants.recordSaved));
                        else
                            return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
                    }
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

        [HttpGet]
        [Route("GetDriverDetails")]
        public ActionResult GetDriverDetails(string componentType, string driverType)
        {
            try
            {
                List<DriverDetails> detailsList = _service.GetAllDriverDetails(componentType, driverType);
                if (detailsList != null)
                    return Ok(new ApiOkResponse(detailsList));
                else
                    return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
            }
            catch (Exception ex)
            {
                ex.ToString();
                return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
            }
        }

        [HttpGet]
        [Route("GetDriverDetailsById")]
        public ActionResult GetDriverDetailsById(long id)
        {
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsDriverDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    DriverDetails details = _service.GetDriverDetailsById(id);

                    if (details != null)
                        return Ok(new ApiOkResponse(details));
                    else
                        return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));

                }
            }
            catch (Exception ex)
            {
                ex.ToString();
                return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
            }
        }

        [HttpDelete]
        [Route("DeleteDriverDetailsById")]
        public ActionResult DeleteDriverDetailsById(long id)
        {
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsDriverDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    id = _service.DeleteDriverDetailsById(id);
                    if (id > 0)
                        return Ok(new ApiOkResponse(null, Constants.recordDeleted));
                    else
                        return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
                return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
            }
        }
    }
}
