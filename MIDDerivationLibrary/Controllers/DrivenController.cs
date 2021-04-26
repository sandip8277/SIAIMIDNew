using Microsoft.AspNetCore.Mvc;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.Driven;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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
        public ActionResult AddDriven(object value)
        {
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
