using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MIDCodeGenerator.Helper;
using MIDCodeGenerator.Models;
using MIDDerivationLibrary.Business;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace MIDDerivationLibrary.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MIDCodesGeneratorController : ControllerBase
    {
        MIDCodeGeneratorService service = null;
        private IConfiguration _configuration;
        public MIDCodesGeneratorController()
        {
            service = new MIDCodeGeneratorService();
        }

        [HttpPost]
        [Route("GenerateCodes")]
        public ActionResult<MIDCodeDetails> GenerateCodes([FromBody] MIDCodeCreatorRequest model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    string xmlString = XmlHelper.ConvertObjectToXML(model);
                    XElement xElement = XElement.Parse(xmlString);
                    MIDCodeDetails details = service.GenerareMIDCodes(xElement.ToString());
                    if (details != null)
                    {
                        return Ok(details);
                    }
                }
                catch (Exception)
                {
                    return BadRequest();
                }

            }
            return BadRequest();
        }
    }
}
