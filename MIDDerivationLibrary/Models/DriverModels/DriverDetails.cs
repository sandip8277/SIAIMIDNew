using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace MIDDerivationLibrary.Models.DriverModels
{
    public class DriverDetails
    {
        public long id { get; set; }
        public string componentType { get; set; }
        public int? locations { get; set; }
        public string driverType { get; set; }
        public int? cylinders { get; set; }
        public string motorDrive { get; set; }
        public bool? motorFan { get; set; }
        public bool? motorBallBearings { get; set; }
        public bool? drivenBallBearings { get; set; }
        public bool? drivenBalanceable { get; set; }
        public int? motorPoles { get; set; }
        public bool? turbineReductionGear { get; set; }
        public bool? turbineRotorSupported { get; set; }
        public bool? turbineBallBearing { get; set; }
        public bool? turbineThrustBearing { get; set; }
        public bool? turbineThrustBearingIsBall { get; set; }
        public decimal? componentCode { get; set; }
    }
}
