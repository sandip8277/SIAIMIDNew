using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.IntermediateModels
{
    public class IntermediateDetails
    {
        public long id { get; set; }
        public string componentType { get; set; }
        public string intermediateType { get; set; }
        public int? locations { get; set; }
        public string drivenBy { get; set; }
        public string speedChangesMax { get; set; }
        public int? gearBoxLocations { get; set; }
        public int? inputBearing { get; set; }
        public string intermediateBearing1st { get; set; }
        public string intermediateBearing2nd { get; set; }
        public string outputBearing { get; set; }
        public decimal? componentCode { get; set; }
    }
}
