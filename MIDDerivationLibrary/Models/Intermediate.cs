using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class Intermediate
    {
        public string componentType { get; set; }
        public string immediateType { get; set; }
        public int? locations { get; set; }
        public string drivenBy { get; set; }
        public int? speedChangesMax { get; set; }
        public int? gearBoxLocations { get; set; }
        public int? inputBearing { get; set; }
        public string intermediateBearing1st { get; set; }
        public string intermediateBearing2nd { get; set; }
        public string outputBearing { get; set; }
        public decimal? speedratio { get; set; }
    }
}
