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
using static MIDDerivationLibrary.Enums.Coupling1Enums;

namespace MIDDerivationLibrary.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Coupling1Controller : ControllerBase
    {
        private readonly ICoupling1Service _service;
        public Coupling1Controller(ICoupling1Service service)
        {
            this._service = service;
        }

        [HttpPost]
        [Route("AddCoupling1Details")]
        public ActionResult AddCoupling1Details(Coupling1Details model)
        {
            long id = 0;
            ModelStateDictionary ModelState = new ModelStateDictionary();
            CouplingValidationHelper.ValidateCoupling1Input(ref ModelState, ref model);

            if (ModelState.IsValid)
            {
                try
                {
                    string xmlString = XmlHelper.ConvertObjectToXML(model);
                    XElement xElement = XElement.Parse(xmlString);

                    bool isExist = _service.CheckIsCoupling1DetailsExist(xmlString);

                    if (isExist == true)
                        return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                    else
                    {
                        id = _service.AddOrUpdateCoupling1Details(xElement.ToString());
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
        [Route("UpdateCoupling1Details")]
        public ActionResult UpdateCoupling1Details(Coupling1Details model)
        {
            long id = 0;
            ModelStateDictionary ModelState = new ModelStateDictionary();
            CouplingValidationHelper.ValidateCoupling1Input(ref ModelState, ref model);

            //id
            if (model.id == 0)
                ModelState.AddModelError(nameof(Coupling2Details.id), Constants.idValidationMessage);

            if (ModelState.IsValid)
            {
                try
                {
                    string xmlString = XmlHelper.ConvertObjectToXML(model);
                    XElement xElement = XElement.Parse(xmlString);

                    bool isExist = _service.CheckIsCoupling1DetailsExist(xmlString);

                    if (isExist == true)
                        return StatusCode(StatusCodes.Status409Conflict, new ApiResponse(404, Constants.recordExist));
                    else
                    {
                        id = _service.AddOrUpdateCoupling1Details(xElement.ToString());
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
        [Route("GetCoupling1Details")]
        public ActionResult GetCoupling1Details(string componentType, string couplingType)
        {
            try
            {
                List<Coupling1Details> detailsList = _service.GetAllCoupling1Details(componentType, couplingType);
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
        [Route("GetCoupling1DetailsById")]
        public ActionResult GetDriverDetailsById(long id)
        {
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsCoupling1DetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    Coupling1Details details = _service.GetCoupling1DetailsById(id);

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
        [Route("DeleteCoupling1DetailsById")]
        public ActionResult DeleteCoupling1DetailsById(long id)
        {
            long Id = 0;
            try
            {
                if (id <= 0)
                    return BadRequest(new ApiBadRequestResponse());
                else
                {
                    bool isExist = _service.CheckIsCoupling1DetailsExist(id);
                    if (isExist == false)
                        return StatusCode(StatusCodes.Status404NotFound, new ApiResponse(404, Constants.recordNotFound));

                    Id = _service.DeleteCoupling1DetailsById(id);
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
