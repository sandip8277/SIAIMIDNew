using Microsoft.AspNetCore.Mvc;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.Intermediate;
using MIDDerivationLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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
        public ActionResult AddIntermediate(object value)
        {
            return null;
        }

        [HttpPut]
        public ActionResult UpdateIntermediate(object value)
        {
            return null;
        }

        [HttpGet]
        public ActionResult GetAllIntermediate()
        {
            return null;
        }

        [HttpGet]
        public ActionResult GetIntermediate(string componentType, string driverType)
        {
            return null;
        }
    }
}
