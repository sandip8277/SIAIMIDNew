using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class CompressorCentrifugalForDeconstruction
    {
        public bool? impellerOnMainShaft { get; set; }
        public bool? centrifugalCompressorHasBallBearings { get; set; }
        public string thrustBearing { get; set; }
        public CompressorCentrifugalExtraFaultData extraFaultData { get; set; }
    }
}
