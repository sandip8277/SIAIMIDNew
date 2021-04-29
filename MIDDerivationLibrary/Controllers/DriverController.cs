using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MIDCodeGenerator.Helper;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.Driver;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.DriverModels;
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
            }
            return Ok(new ApiOkResponse(id));
        }

        [HttpPut]
        [Route("UpdateDriverDetails")]
        public ActionResult UpdateDriverDetails(DriverDetails model)
        {
            long id = 0;
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
            }
            return Ok(new ApiOkResponse(id));
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
            long Id = 0;
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsDriverDetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    Id = _service.DeleteDriverDetailsById(id);
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
