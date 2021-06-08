using MIDCodeGenerator.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.TestCaseModels
{
    public class TestCase
    {
        public string textCaseName { get; set; }
        public MachineComponentsForMIDgeneration machineComponentsForMIDgeneration { get; set; }
        public MIDCodeDetails result { get; set; }
        public string testCaseStatus { get; set; }
    }
}
