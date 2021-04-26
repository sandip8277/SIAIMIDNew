using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MIDCodeGenerator.Helper;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.Intermediate;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.IntermediateModels;
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
    public class IntermediateController : ControllerBase
    {
        private readonly IIntermediateService _service;
        public IntermediateController(IIntermediateService service)
        {
            this._service = service;
        }

        [HttpPost]
        public ActionResult AddIntermediateDetails(IntermediateDetails model)
        {
            long id = 0;
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);
               // id = _service.AddOrUpdateIntermediateDetails(xElement.ToString());
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

        [HttpPut]
        public ActionResult UpdateIntermediate(IntermediateDetails model)
        {
            long id = 0;
            try
            {
                string xmlString = XmlHelper.ConvertObjectToXML(model);
                XElement xElement = XElement.Parse(xmlString);
                //id = _service.AddOrUpdateIntermediateDetails(xElement.ToString());
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
        public ActionResult GetIntermediateDetails(string componentType, string driverType)
        {
            List<IntermediateDetails> detailsList = null;
            try
            {
                //detailsList = _service.GetAllIntermediateDetails(componentType, driverType);
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
        public ActionResult GetIntermediateDetailsById(long id)
        {
            IntermediateDetails details = null;
            try
            {
                //details = _service.GetIntermediateDetailsById(id);
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
        public ActionResult DeleteIntermediateDetailsById(long id)
        {
            long Id = 0;
            try
            {
                //Id = _service.DeleteIntermediateDetailsById(id);
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
