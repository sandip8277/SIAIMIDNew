using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.PickupModels
{
    public class PickupCodeDetails
    {
        public int id { get; set; }
        public int driverLocations { get; set; }
        public bool driverLocationNDE { get; set; }
        public bool driverLocationDE { get; set; }
        public int intermediateLocations { get; set; }
        public bool intermediatepresent { get; set; }
        public int drivenLocations { get; set; }
        public bool drivenLocationDE { get; set; }
        public bool drivenLocationNDE { get; set; }
        public bool spindle_shaft_with_2locations { get; set; }
        public string driverPickupCode { get; set; }
        public string coupling1PickupCode { get; set; }
        public string intermediatePickupCode { get; set; }
        public string coupling2PickupCode { get; set; }
        public string drivenPickupCode { get; set; }
    }
}
