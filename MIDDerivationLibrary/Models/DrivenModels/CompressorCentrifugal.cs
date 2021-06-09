using MIDDerivationLibrary.Models.CommonModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class CompressorCentrifugal
    {
        public bool? impellerOnMainShaft { get; set; }
        public bool? centrifugalCompressorHasBallBearings { get; set; }
        public string thrustBearing { get; set; }
        public ExtraFaultData extraFaultData { get; set; }
    }
}
