using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class PumpRotaryThreadForDeconstruction
    {
        public bool? rotaryThreadPumpHasBallBearings { get; set; }
        public PumpRotaryThreadExtraFaultData extraFaultData { get; set; }
    }
}
