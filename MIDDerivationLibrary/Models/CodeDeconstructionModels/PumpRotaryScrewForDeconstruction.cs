using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class PumpRotaryScrewForDeconstruction
    {
        public bool? screwPumpHasBallBearings { get; set; }
        public pumpRotaryScrewExtraFaultData extraFaultData { get; set; }
    }
}
