using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class PumpRotaryAxialRecipForDeconstruction
    {
        public bool? attachedOilPump { get; set; }
        public bool? axialRecipPumpHasBallBearings { get; set; }
        public string thrustBearing { get; set; }
        public PumpRotaryAxialRecipExtraFaultData extraFaultData { get; set; }
    }
}
