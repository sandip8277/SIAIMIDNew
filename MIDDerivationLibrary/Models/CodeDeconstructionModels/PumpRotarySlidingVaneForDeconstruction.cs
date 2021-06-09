using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class PumpRotarySlidingVaneForDeconstruction
    {
        public bool? rotorOverhung { get; set; }
        public bool? slidingVanePumpHasBallBearings { get; set; }
        public PumpRotarySlidingVaneExtraFaultData extraFaultData { get; set; }
    }
}
