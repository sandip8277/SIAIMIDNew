using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class Codes
    {
        public string ComponentCode { get; set; }
        public string PickupCode { get; set; }
        public decimal? SpeedRatio { get; set; }
    }

    public class DriverCodes
    {
        public string ComponentCode { get; set; }
        public string PickupCode { get; set; }
    }

    public class DrivenCodes
    {
        public string ComponentCode { get; set; }
        public string PickupCode { get; set; }
    }
}
