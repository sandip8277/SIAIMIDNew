using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class Driver
    {
        //[Required]
        public string componentType { get; set; }
        public int? locations { get; set; }
        public string driverType { get; set; }
        public int? cylinders { get; set; }
        public string motorDrive { get; set; }
        public bool? motorFan { get; set; }
        public bool? motorBallBearings { get; set; }
        public bool? drivenBallBearings { get; set; }
        public bool? drivenBalanceable { get; set; }
        public int? mortorPoles { get; set; }
        public bool? turbineReductionGear { get; set; }
        public bool? turbineRotorSupported { get; set; }
        public bool? turbineBallBearing { get; set; }
        public bool? turbineThrustBearing { get; set; }
        public bool? turbineThrustBearingIsBall { get; set; }
        public decimal? rpm { get; set; }
        public List<SpecialFaultCodesInput> specialFaultCodesInput { get; set; }
    }
}
