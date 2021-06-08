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
                    //foreach (var data in model.testGenerateCodes.testCases)
                    //  data.testCaseStatus  = await GenerateTestCaseResultsResponse(data);
                    //Task<TestCaseModel> task = Task.Factory.StartNew<TestCaseModel>(() => GenerateTestCaseResultsResponse1());
                    //await Task.Factory.StartNew(() =>
                    Parallel.ForEach(model.testGenerateCodes.testCases, data =>
                     {
                         data.testCaseStatus = GenerateTestCaseResultsResponse1(data);
                     });
                    //);

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

        private async Task<string> GenerateTestCaseResultsResponse(TestCase data)
        {
            string status = string.Empty;
            await Task.Run(() =>
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

                    MIDCodeDetails actualResult = _service.GenerareMIDCodes(xElement.ToString());

                    if (actualResult != null)
                    {
                        CompareLogic compareLogic = new CompareLogic();
                        compareLogic.Config.IgnoreProperty<Row>(x => x._faultcode);
                        ComparisonResult result = compareLogic.Compare(expectedResult, actualResult);
                        if (result.AreEqual)
                            status = "Passed";
                        else
                            status = "failed";
                    }
                    else
                        status = "Failed";
                }
                else
                    status = "Validation Failed";
            });
            return status;
        }

        private string GenerateTestCaseResultsResponse1(TestCase data)
        {
            string status = string.Empty;
            //await Task.Run(() =>
            //{
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

                MIDCodeDetails actualResult = _service.GenerareMIDCodes(xElement.ToString());

                if (actualResult != null)
                {
                    CompareLogic compareLogic = new CompareLogic();
                    compareLogic.Config.IgnoreProperty<Row>(x => x._faultcode);
                    ComparisonResult result = compareLogic.Compare(expectedResult, actualResult);
                    if (result.AreEqual)
                        status = "Passed";
                    else
                        status = "failed";
                }
                else
                    status = "Failed";
            }
            else
                status = "Validation Failed";
            //});

            return status;
        }

        private string GenerateTestCaseResultsResponse123(TestCase data)
        {
            string status = string.Empty;

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

                MIDCodeDetails actualResult = _service.GenerareMIDCodes(xElement.ToString());

                if (actualResult != null)
                {
                    CompareLogic compareLogic = new CompareLogic();
                    compareLogic.Config.IgnoreProperty<Row>(x => x._faultcode);
                    ComparisonResult result = compareLogic.Compare(expectedResult, actualResult);
                    if (result.AreEqual)
                        status = "Passed";
                    else
                        status = "failed";
                }
                else
                    status = "Failed";
            }
            else
                status = "Validation Failed";

            return status;
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
