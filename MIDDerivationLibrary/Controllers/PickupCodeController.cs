using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MIDCodeGenerator.Helper;
using MIDDerivationLibrary.Business.PickupCode;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.PickupModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace MIDDerivationLibrary.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PickupCodeController : ControllerBase
    {
        private readonly IPickupCodeService _service;
        public PickupCodeController(IPickupCodeService service)
        {
            this._service = service;
        }

        [HttpPost]
        [Route("AddPickupCodeDetails")]
        public ActionResult AddPickupCodeDetails(PickupCodeDetails model)
        {
            long id = 0;
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);

                bool isExist = _service.CheckIsPickupCodeDetailsExist(xmlString);

                if (isExist == true)
                    return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(409, Constants.recordExist));
                else
                {
                    id = _service.AddOrUpdatePickupCodeDetails(xElement.ToString());
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
        [Route("UpdatePickupCodeDetails")]
        public ActionResult UpdatePickupCodeDetails(PickupCodeDetails model)
        {
            long id = 0;
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);

                bool isExist = _service.CheckIsPickupCodeDetailsExist(xmlString);

                if (isExist == true)
                    return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                else
                {
                    id = _service.AddOrUpdatePickupCodeDetails(xElement.ToString());
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
        [Route("GetPickupCodeDetails")]
        public ActionResult GetPickupCodeDetails()
        {
            try
            {
                List<PickupCodeDetails> detailsList = _service.GetAllPickupCodeDetails();
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
        [Route("GetPickupCodeDetailsById")]
        public ActionResult GetPickupCodeDetailsById(long id)
        {
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsPickupCodeDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    PickupCodeDetails details = _service.GetPickupCodeDetailsById(id);

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
        [Route("DeletePickupCodeDetailsById")]
        public ActionResult DeletePickupCodeDetailsById(long id)
        {
            long Id = 0;
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsPickupCodeDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    Id = _service.DeletePickupCodeDetailsById(id);
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
