using KellermanSoftware.CompareNetObjects;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using MIDCodeGenerator.Helper;
using MIDCodeGenerator.Models;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.MIDCodeDeconstruction;
using MIDDerivationLibrary.Helper;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.APIResponse;
using MIDDerivationLibrary.Models.TestCaseModels;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace MIDDerivationLibrary.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UnitTestCasesController : ControllerBase
    {
        private readonly IMIDCodeGeneratorService _service;
        public UnitTestCasesController(IMIDCodeGeneratorService service)
        {
            this._service = service;
        }

        [HttpPost]
        [Route("GenerateCodeUnitTest")]
        public ActionResult GenerateCodeUnitTest(TestCaseModel model)
        {
            try
            {
                if (model != null)
                {
                    foreach (var data in model.testGenerateCodes.testCases)
                    {
                        MIDCodeDetails expectedResult = null;
                        MachineComponentsForMIDgeneration machineComponentsForMIDgeneration = data.machineComponentsForMIDgeneration;

                        MIDCodeCreatorRequest mIDCodeCreatorRequest = new MIDCodeCreatorRequest();
                        mIDCodeCreatorRequest.machineComponentsForMIDgeneration = machineComponentsForMIDgeneration;

                        ModelStateDictionary ModelState = new ModelStateDictionary();
                        ValidationHelper.ValidateInput(ref ModelState, ref mIDCodeCreatorRequest);
                        if (ModelState.IsValid)
                        {
                            expectedResult = data.result;
                            string xmlString = XmlHelper.ConvertObjectToXML(mIDCodeCreatorRequest);
                            XElement xElement = XElement.Parse(xmlString);

                            MIDCodeDetails actulResult = _service.GenerareMIDCodes(xElement.ToString());

                            if (actulResult != null)
                            {
                                CompareLogic compareLogic = new CompareLogic();
                                compareLogic.Config.IgnoreProperty<Row>(x => x._faultcode);
                                ComparisonResult result = compareLogic.Compare(expectedResult, actulResult);
                                if (result.AreEqual)
                                    data.testCaseStatus = "Passed";
                                else
                                    data.testCaseStatus = "failed";
                            }
                            else
                                data.testCaseStatus = "Failed";
                        }
                        else
                            data.testCaseStatus = "Validation Failed";
                    }

                    if (model != null)
                        return Ok(new ApiOkResponse(model));
                    else
                        return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
                }
                else
                    return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
            }
            catch (Exception ex)
            {
                ex.ToString();
                return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
            }
        }

        [HttpPost]
        [Route("DeconstructCodeUnitTest")]
        public ActionResult DeconstructCodeUnitTest(TestCaseModel model)
        {
            try
            {
                if (model != null)
                {
                    foreach (var data in model.testGenerateCodes.testCases)
                    {
                        MIDCodeDetails expectedResult = null;
                        MachineComponentsForMIDgeneration machineComponentsForMIDgeneration = data.machineComponentsForMIDgeneration;

                        MIDCodeCreatorRequest mIDCodeCreatorRequest = new MIDCodeCreatorRequest();
                        mIDCodeCreatorRequest.machineComponentsForMIDgeneration = machineComponentsForMIDgeneration;

                        ModelStateDictionary ModelState = new ModelStateDictionary();
                        ValidationHelper.ValidateInput(ref ModelState, ref mIDCodeCreatorRequest);
                        if (ModelState.IsValid)
                        {
                            expectedResult = data.result;
                            string xmlString = XmlHelper.ConvertObjectToXML(mIDCodeCreatorRequest);
                            XElement xElement = XElement.Parse(xmlString);

                            MIDCodeDetails actulResult = _service.GenerareMIDCodes(xElement.ToString());

                            if (actulResult != null)
                            {
                                CompareLogic compareLogic = new CompareLogic();
                                compareLogic.Config.IgnoreProperty<Row>(x => x._faultcode);
                                ComparisonResult result = compareLogic.Compare(expectedResult, actulResult);
                                if (result.AreEqual)
                                    data.testCaseStatus = "Passed";
                                else
                                    data.testCaseStatus = "failed";
                            }
                            else
                                data.testCaseStatus = "Failed";
                        }
                        else
                            data.testCaseStatus = "Validation Failed";
                    }

                    if (model != null)
                        return Ok(new ApiOkResponse(model));
                    else
                        return StatusCode(StatusCodes.Status500InternalServerError, new ApiResponse(500, null));
                }
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
