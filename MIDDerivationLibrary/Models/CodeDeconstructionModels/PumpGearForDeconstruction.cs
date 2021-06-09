using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class PumpGearForDeconstruction
    {
        public bool? gearPumpHasBallBearings { get; set; }
        public PumpGearExtraFaultData extraFaultData { get; set; }
    }
}
