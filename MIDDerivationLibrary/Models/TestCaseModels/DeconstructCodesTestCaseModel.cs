using MIDDerivationLibrary.Models.CodeDeconstructionModels;
using MIDDerivationLibrary.Models.CouplingModels;
using MIDDerivationLibrary.Models.DrivenModels;
using MIDDerivationLibrary.Models.DriverModels;
using MIDDerivationLibrary.Models.IntermediateModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.TestCaseModels
{
    public class DeconstructCodesTestCaseModel
    {
        public TestDeconstructCodes testGenerateCodes { get; set; }
    }
    public class TestDeconstructCodes
    {
       public List<DeconstructTestCase> testCases { get; set; }
    }

    public class DeconstructTestCase
    {
        public string textCaseName { get; set; }
        public MachineComponentsForMIDdeconstruction machineComponentsForMIDdeconstruction { get; set; }
        public MIDdeconstrutionResponse result { get; set; }
        public string testCaseStatus { get; set; }
    }

    //public class MachineComponentsForMIDgeneration1
    //{
    //    public Driver driver { get; set; }
    //    public Coupling1 coupling1 { get; set; }
    //    public Intermediate intermediate { get; set; }
    //    public Coupling2 coupling2 { get; set; }
    //    public Driven driven { get; set; }
    //}
}
