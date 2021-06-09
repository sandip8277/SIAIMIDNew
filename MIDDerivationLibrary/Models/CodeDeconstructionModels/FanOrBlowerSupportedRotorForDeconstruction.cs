using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class FanOrBlowerSupportedRotorForDeconstruction
    {
        public bool? supportedRotorFanOrBlowerHasBearings { get; set; }
        public FanOrBlowerSupportedRotorExtraFaultData extraFaultData { get; set; }
    }
}
