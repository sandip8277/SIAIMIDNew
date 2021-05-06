using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MIDCodeGenerator.Helper;
using MIDDerivationLibrary.Business.CSDMdefs;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.CSDMdefsModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace MIDDerivationLibrary.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CSDMdefsController : ControllerBase
    {
        private readonly ICSDMdefsService _service;
        public CSDMdefsController(ICSDMdefsService service)
        {
            this._service = service;
        }

        [HttpPost]
        [Route("AddCSDMdefsDetails")]
        public ActionResult AddCSDMdefsDetails(CSDMdefsDetails model)
        {
            long id = 0;
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);

                bool isExist = _service.CheckIsCSDMdefsDetailsExist(xmlString);

                if (isExist == true)
                    return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                else
                {
                    id = _service.AddOrUpdateCSDMdefsDetails(xElement.ToString());
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
        [Route("UpdateCSDMdefsDetails")]
        public ActionResult UpdateCSDMdefsDetails(CSDMdefsDetails model)
        {
            long id = 0;
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);

                bool isExist = _service.CheckIsCSDMdefsDetailsExist(xmlString);

                if (isExist == true)
                    return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                else
                {
                    id = _service.AddOrUpdateCSDMdefsDetails(xElement.ToString());
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
        [Route("GetCSDMdefsDetails")]
        public ActionResult GetCSDMdefsDetails(string csdmfile)
        {
            try
            {
                List<CSDMdefsDetails> detailsList = _service.GetAllCSDMdefsDetails(csdmfile);
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
        [Route("GetCSDMdefsDetailsById")]
        public ActionResult GetCSDMdefsDetailsById(long id)
        {
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsCSDMdefsDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    CSDMdefsDetails details = _service.GetCSDMdefsDetailsById(id);

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
        [Route("DeleteCSDMdefsDetailsById")]
        public ActionResult DeleteCSDMdefsDetailsById(long id)
        {
            long Id = 0;
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsCSDMdefsDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    Id = _service.DeleteCSDMdefsDetailsById(id);
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
