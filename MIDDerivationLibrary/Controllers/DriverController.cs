using Microsoft.AspNetCore.Mvc;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.Driver;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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
        public ActionResult AddDriverDetails(object value)
        {
            try
            {
                _service.AddDriverDetails(null);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return null;
        }

        [HttpPut]
        public ActionResult UpdateDriver(object value)
        {
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
