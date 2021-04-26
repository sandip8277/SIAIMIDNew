using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MIDCodeGenerator.Helper;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.Driver;
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
        public ActionResult AddDriverDetails(DriverDetails model)
        {
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);
                long id = _service.AddOrUpdateDriverDetails(xElement.ToString());
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
        public ActionResult UpdateDriver(DriverDetails model)
        {
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);
                long id = _service.AddOrUpdateDriverDetails(xElement.ToString());
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

        [HttpGet]
        public ActionResult GetAllDriver()
        {
            return null;
        }

        [HttpGet]
        public ActionResult GetDriver(string componentType,string driverType)
        {
            return null;
        }
        
    }
}
