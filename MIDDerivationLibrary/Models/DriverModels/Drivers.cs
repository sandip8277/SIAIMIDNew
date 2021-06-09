using MIDDerivationLibrary.DriverModels;
using MIDDerivationLibrary.Models.DriverModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DriverModels
{
    public class Drivers
    {
        public Diesel diesel { get; set; }
        public Motor motor { get; set; }
        public Turbine turbine { get; set; }
    }
}
