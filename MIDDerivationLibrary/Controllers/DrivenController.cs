using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using MIDCodeGenerator.Helper;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.Driven;
using MIDDerivationLibrary.Helper;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.DrivenModels;
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
    public class DrivenController : ControllerBase
    {
        private readonly IDrivenService _service;
        public DrivenController(IDrivenService service)
        {
            this._service = service;
        }

        [HttpPost]
        [Route("AddDrivenDetails")]
        public ActionResult AddDrivenDetails(DrivenDetails model)
        {
            long id = 0;
            ModelStateDictionary ModelState = new ModelStateDictionary();
            DrivenValidationHelper.ValidateDrivenInput(ref ModelState, ref model);
            if (ModelState.IsValid)
            {
                try
                {
                    string xmlString = XmlHelper.ConvertObjectToXML(model);
                    XElement xElement = XElement.Parse(xmlString);

                    bool isExist = _service.CheckIsDrivenDetailsExist(xmlString);

                    if (isExist == true)
                        return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                    else
                    {
                        id = _service.AddOrUpdateDrivenDetails(xElement.ToString());
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
        [Route("UpdateDrivenDetails")]
        public ActionResult UpdateDrivenDetails(DrivenDetails model)
        {
            long id = 0;
            ModelStateDictionary ModelState = new ModelStateDictionary();
            DrivenValidationHelper.ValidateDrivenInput(ref ModelState, ref model);

            if (model.id == 0)
                ModelState.AddModelError(nameof(DrivenDetails.id), Constants.idValidationMessage);
            if (ModelState.IsValid)
            {
                try
                {
                    string xmlString = XmlHelper.ConvertObjectToXML(model);
                    XElement xElement = XElement.Parse(xmlString);

                    bool isExist = _service.CheckIsDrivenDetailsExist(xmlString);

                    if (isExist == true)
                        return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                    else
                    {
                        id = _service.AddOrUpdateDrivenDetails(xElement.ToString());
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
        [Route("GetDrivenDetails")]
        public ActionResult GetDrivenDetails(string componentType, string drivenType)
        {
            try
            {
                List<DrivenDetails> detailsList = _service.GetAllDrivenDetails(componentType, drivenType);
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
        [Route("GetDrivenDetailsById")]
        public ActionResult GetDriverDetailsById(long id)
        {
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsDrivenDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    DrivenDetails details = _service.GetDrivenDetailsById(id);

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
        [Route("DeleteDrivenDetailsById")]
        public ActionResult DeleteDrivenDetailsById(long id)
        {
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsDrivenDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    id = _service.DeleteDrivenDetailsById(id);
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
