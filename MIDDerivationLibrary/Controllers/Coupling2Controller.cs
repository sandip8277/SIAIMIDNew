using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using MIDCodeGenerator.Helper;
using MIDDerivationLibrary.Business.Coupling;
using MIDDerivationLibrary.Helper;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.CouplingModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;

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

        [HttpPost]
        [Route("AddCoupling2Details")]
        public ActionResult AddCoupling2Details(Coupling2Details model)
        {
            long id = 0;
            ModelStateDictionary ModelState = new ModelStateDictionary();
            CouplingValidationHelper.ValidateCoupling2Input(ref ModelState, ref model);

            if (ModelState.IsValid)
            {
                try
                {
                    string xmlString = XmlHelper.ConvertObjectToXML(model);
                    XElement xElement = XElement.Parse(xmlString);

                    bool isExist = _service.CheckIsCoupling2DetailsExist(xmlString);

                    if (isExist == true)
                        return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                    else
                    {
                        id = _service.AddOrUpdateCoupling2Details(xElement.ToString());
                        if (id > 0)
                            return Ok(new ApiOkResponse(id, Constants.recordSaved));
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
            else
                return BadRequest(new ApiBadRequestResponse(ModelState));
        }

        [HttpPut]
        [Route("UpdateCoupling2Details")]
        public ActionResult UpdateCoupling2Details(Coupling2Details model)
        {
            long id = 0;
            ModelStateDictionary ModelState = new ModelStateDictionary();
            CouplingValidationHelper.ValidateCoupling2Input(ref ModelState, ref model);

            if (model.id == 0)
                ModelState.AddModelError(nameof(Coupling2Details.id), Constants.idValidationMessage);

            if (ModelState.IsValid)
            {
                try
                {
                    string xmlString = XmlHelper.ConvertObjectToXML(model);
                    XElement xElement = XElement.Parse(xmlString);

                    bool isExist = _service.CheckIsCoupling2DetailsExist(xmlString);

                    if (isExist == true)
                        return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                    else
                    {
                        id = _service.AddOrUpdateCoupling2Details(xElement.ToString());
                        if (id > 0)
                            return Ok(new ApiOkResponse(id, Constants.recordSaved));
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
            else
                return BadRequest(new ApiBadRequestResponse(ModelState));
        }

        [HttpGet]
        [Route("GetCoupling2Details")]
        public ActionResult GetCoupling2Details(string componentType, string couplingType)
        {
            try
            {
                List<Coupling2Details> detailsList = _service.GetAllCoupling2Details(componentType, couplingType);
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
        [Route("GetCoupling2DetailsById")]
        public ActionResult GetDriverDetailsById(long id)
        {
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsCoupling2DetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    Coupling2Details details = _service.GetCoupling2DetailsById(id);

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
        [Route("DeleteCoupling2DetailsById")]
        public ActionResult DeleteCoupling2DetailsById(long id)
        {
            long Id = 0;
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsCoupling2DetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    Id = _service.DeleteCoupling2DetailsById(id);
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
