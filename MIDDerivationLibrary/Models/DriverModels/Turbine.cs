using MIDDerivationLibrary.Models.CommonModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DriverModels
{
    public class Turbine
    {
        public bool? turbineReductionGear { get; set; }
        public bool? turbineRotorSupported { get; set; }
        public bool? turbineBallBearing { get; set; }
        public bool? turbineThrustBearing { get; set; }
        public bool? turbineThrustBearingIsBall { get; set; }
        public ExtraFaultData extraFaultData { get; set; }
    }
}
