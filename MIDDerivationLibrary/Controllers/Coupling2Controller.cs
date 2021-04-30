using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MIDDerivationLibrary.Business.Coupling;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Coupling2Controller : ControllerBase
    {
        private readonly ICoupling2Service _service;
        public Coupling2Controller(ICoupling2Service service)
        {
            this._service = service;
        }
    }
}
