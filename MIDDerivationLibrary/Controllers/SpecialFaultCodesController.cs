using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MIDCodeGenerator.Helper;
using MIDDerivationLibrary.Business.SpecialFaultCodes;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.SpecialFaultCodeModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace MIDDerivationLibrary.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SpecialFaultCodesController : ControllerBase
    {
        private readonly ISpecialFaultCodesService _service;
        public SpecialFaultCodesController(ISpecialFaultCodesService service)
        {
            this._service = service;
        }

        [HttpPost]
        [Route("AddSpecialFaultCodesDetails")]
        public ActionResult AddSpecialFaultCodesDetails(SpecialFaultCodesDetails model)
        {
            long id = 0;
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);

                bool isExist = _service.CheckIsSpecialFaultCodesDetailsExist(xmlString);

                if (isExist == true)
                    return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                else
                {
                    id = _service.AddOrUpdateSpecialFaultCodesDetails(xElement.ToString());
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
        [Route("UpdateSpecialFaultCodesDetails")]
        public ActionResult UpdateSpecialFaultCodesDetails(SpecialFaultCodesDetails model)
        {
            long id = 0;
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);

                bool isExist = _service.CheckIsSpecialFaultCodesDetailsExist(xmlString);

                if (isExist == true)
                    return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                else
                {
                    id = _service.AddOrUpdateSpecialFaultCodesDetails(xElement.ToString());
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
        [Route("GetSpecialFaultCodesDetails")]
        public ActionResult GetSpecialFaultCodesDetails(string specialFaultCodesType, string specialcode)
        {
            try
            {
                List<SpecialFaultCodesDetails> detailsList = _service.GetAllSpecialFaultCodesDetails(specialFaultCodesType, specialcode);
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
        [Route("GetSpecialFaultCodesDetailsById")]
        public ActionResult GetSpecialFaultCodesDetailsById(long id)
        {
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsSpecialFaultCodesDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    SpecialFaultCodesDetails details = _service.GetSpecialFaultCodesDetailsById(id);

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
        [Route("DeleteSpecialFaultCodesDetailsById")]
        public ActionResult DeleteSpecialFaultCodesDetailsById(long id)
        {
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsSpecialFaultCodesDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    id = _service.DeleteSpecialFaultCodesDetailsById(id);
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
