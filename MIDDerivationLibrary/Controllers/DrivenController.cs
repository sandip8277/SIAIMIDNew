using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MIDCodeGenerator.Helper;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.Driven;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.DrivenModels;
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
    public class DrivenController : ControllerBase
    {
        private readonly IDrivenService _service;
        public DrivenController(IDrivenService service)
        {
            this._service = service;
        }

        [HttpPost]
        public ActionResult AddDrivenDetails(DrivenDetails model)
        {
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);
                long id = _service.AddOrUpdateDrivenDetails(xElement.ToString());
                if (id > 0)
                    return Ok(new ApiOkResponse(id));
                else
                    return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return null;
        }

        [HttpPut]
        public ActionResult UpdateDriven(DrivenDetails model)
        {
            long id = 0;
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);
                id = _service.AddOrUpdateDrivenDetails(xElement.ToString());
                if (id > 0)
                    return Ok(new ApiOkResponse(id));
                else
                    return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return Ok(new ApiOkResponse(id));
        }

        [HttpGet]
        public ActionResult GetDrivenDetails(string componentType, string driverType)
        {
            try
            {
                List<DrivenDetails> detailsList = _service.GetAllDrivenDetails(componentType, driverType);
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
        public ActionResult GetDrivenDetailsById(long id)
        {
            try
            {
                DrivenDetails details = _service.GetDrivenDetailsById(id);
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

        [HttpGet]
        public ActionResult DeleteDrivenDetailsById(long id)
        {
            long Id = 0;
            try
            {
                Id = _service.DeleteDrivenDetailsById(id);
                if (Id > 0)
                    return Ok(new ApiOkResponse(id));
                else
                    return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
            }
            catch (Exception ex)
            {
                ex.ToString();
                return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
            }
        }
    }
}
