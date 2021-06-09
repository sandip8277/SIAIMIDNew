using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class PumpCentrifugalForDeconstruction
    {
        public bool? rotorOverhung { get; set; }
        public bool? centrifugalPumpHasBallBearings { get; set; }
        public string thrustBearing { get; set; }
        public PumpCentrifugalExtraFaultData extraFaultData { get; set; }
    }
}
