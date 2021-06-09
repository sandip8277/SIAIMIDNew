using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class CompressorReciporcatingForDeconstruction
    {
        public bool? crankHasIntermediateBearing { get; set; }
        public bool? reciprocatingCompressorHasBallBearings { get; set; }
        public CompressorReciporcatingExtraFaultData extraFaultData { get; set; }
    }
}
