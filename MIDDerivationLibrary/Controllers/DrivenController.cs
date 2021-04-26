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
        public ActionResult AddDriverDetails(DrivenDetails model)
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
        public ActionResult UpdateDriven(object value)
        {
            return null;
        }

        [HttpGet]
        public ActionResult GetAllDriven()
        {
            return null;
        }

        [HttpGet]
        public ActionResult GetDriven(string componentType, string driverType)
        {
            return null;
        }
    }
}
