using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class PumpPropellerForDeconstruction
    {
        public bool? propellerpumpHasBallBearings { get; set; }

        public PumpPropellerExtraFaultData extraFaultData { get; set; }
    }
}
