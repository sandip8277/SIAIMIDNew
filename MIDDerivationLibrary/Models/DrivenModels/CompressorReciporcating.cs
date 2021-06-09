using MIDDerivationLibrary.Models.CommonModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class CompressorReciporcating
    {
        public bool? crankHasIntermediateBearing { get; set; }
        public bool? reciprocatingCompressorHasBallBearings { get; set; }
        public ExtraFaultData extraFaultData { get; set; }
    }
}
