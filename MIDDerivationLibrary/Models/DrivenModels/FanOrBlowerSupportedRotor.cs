using MIDDerivationLibrary.Models.CommonModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class FanOrBlowerSupportedRotor
    {
        public bool? fanStages { get; set; }
        public bool? supportedRotorFanOrBlowerHasBearings { get; set; }
        public ExtraFaultData extraFaultData { get; set; }
    }
}
