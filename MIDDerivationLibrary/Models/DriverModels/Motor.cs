using MIDDerivationLibrary.Models.CommonModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DriverModels
{
    public class Motor
    {
        public string motorDrive { get; set; }
        public bool? motorFan { get; set; }
        public bool? motorBallBearings { get; set; }
        public bool? drivenBallBearings { get; set; }
        public bool? drivenBalanceable { get; set; }
        public VFD vfd { get; set; }
        public ExtraFaultData extraFaultData { get; set; }
    }
}
