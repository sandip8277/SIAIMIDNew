using MIDDerivationLibrary.Models.CommonModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class PumpRotarySlidingVane
    {
        public bool? rotorOverhung { get; set; }
        public bool? slidingVanePumpHasBallBearings { get; set; }
        public ExtraFaultData extraFaultData { get; set; }
    }
}
