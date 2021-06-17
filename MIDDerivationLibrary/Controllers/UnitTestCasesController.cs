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
using MIDDerivationLibrary.Models.CodeDeconstructionModels;
using MIDDerivationLibrary.Models.CommonModels;
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
        private readonly IMIDCodeDeconstructionService _deconstructionService;
        public UnitTestCasesController(IMIDCodeGeneratorService service, IMIDCodeDeconstructionService deconstructionService)
        {
            this._service = service;
            this._deconstructionService = deconstructionService;
        }

        [HttpPost]
        [Route("GenerateCodeUnitTest")]
        public ActionResult GenerateCodeUnitTest(TestCaseModel model)
        {
            try
            {
                if (model != null)
                {
                    Parallel.ForEach(model.testGenerateCodes.testCases, data =>
                    { data.testCaseStatus = GenerateCodeTestCaseResultsResponse(data); });

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

        private string GenerateCodeTestCaseResultsResponse(TestCase data)
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
        public ActionResult DeconstructCodeUnitTest(DeconstructCodesTestCaseModel model)
        {
            try
            {
                if (model != null)
                {
                    Parallel.ForEach(model.testGenerateCodes.testCases, data =>
                    { data.testCaseStatus = DeconstructTestCaseResultsResponse(data); });

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

        private string DeconstructTestCaseResultsResponse(DeconstructTestCase data)
        {
            string status = string.Empty;
            MIDdeconstrutionResponse expectedResult = null;
            MachineComponentsForMIDdeconstruction machineComponentsForMIDdeconstruction = data.machineComponentsForMIDdeconstruction;
            MIDCodeDeconstructionRequest midCodeDeconstructionRequest = new MIDCodeDeconstructionRequest();
            midCodeDeconstructionRequest.machineComponentsForMIDdeconstruction = machineComponentsForMIDdeconstruction;

            if (ModelState.IsValid)
            {
                expectedResult = data.result;
                string xmlString = XmlHelper.ConvertObjectToXML(midCodeDeconstructionRequest);
                XElement xElement = XElement.Parse(xmlString);

                MIDdeconstrutionResponse actulResult = _deconstructionService.MIDCodeDeconstruction(xElement.ToString());

                if (actulResult != null)
                {
                    CompareLogic compareLogic = new CompareLogic();
                    ComparisonResult result = compareLogic.Compare(expectedResult, actulResult);
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
    }
}
