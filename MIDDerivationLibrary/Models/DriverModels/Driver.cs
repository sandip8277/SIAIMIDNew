using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DriverModels
{
    public class Driver
    {
        public string componentType { get; set; }
        public int? locations { get; set; }
        public bool? driverLocationNDE { get; set; }
        public bool? driverLocationDE { get; set; }
        public int? rpm { get; set; }
        public string driverType { get; set; }
        public Drivers drivers { get; set; }
    }
}
