using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MIDCodeGenerator.Helper;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.Intermediate;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.IntermediateModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace MIDDerivationLibrary.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IntermediateController : ControllerBase
    {
        private readonly IIntermediateService _service;
        public IntermediateController(IIntermediateService service)
        {
            this._service = service;
        }

        [HttpPost]
        [Route("AddIntermediateDetails")]
        public ActionResult AddIntermediateDetails([FromBody]IntermediateDetails model)
        {
            long id = 0;
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);

                bool isExist = _service.CheckIsIntermediateDetailsExist(xmlString);

                if (isExist == true)
                    return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                else
                {
                    id = _service.AddOrUpdateIntermediateDetails(xElement.ToString());
                    if (id > 0)
                        return Ok(new ApiOkResponse(id, Constants.recordSaved));
                    else
                        return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return Ok(new ApiOkResponse(id));
        }


        [HttpPut]
        [Route("UpdateIntermediateDetails")]
        public ActionResult UpdateIntermediateDetails(IntermediateDetails model)
        {
            long id = 0;
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);

                bool isExist = _service.CheckIsIntermediateDetailsExist(xmlString);

                if (isExist == true)
                    return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                else
                {
                    id = _service.AddOrUpdateIntermediateDetails(xElement.ToString());
                    if (id > 0)
                        return Ok(new ApiOkResponse(id, Constants.recordSaved));
                    else
                        return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return Ok(new ApiOkResponse(id));
        }

        [HttpGet]
        [Route("GetIntermediateDetails")]
        public ActionResult GetIntermediateDetails(string componentType, string intermediateType)
        {
            try
            {
                List<IntermediateDetails> detailsList = _service.GetAllIntermediateDetails(componentType, intermediateType);
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
        [Route("GetIntermediateDetailsById")]
        public ActionResult GetIntermediateDetailsById(long id)
        {
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsIntermediateDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    IntermediateDetails details = _service.GetIntermediateDetailsById(id);

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
        [Route("DeleteIntermediateDetailsById")]
        public ActionResult DeleteIntermediateDetailsById(long id)
        {
            long Id = 0;
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsIntermediateDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    Id = _service.DeleteIntermediateDetailsById(id);
                    if (Id > 0)
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
