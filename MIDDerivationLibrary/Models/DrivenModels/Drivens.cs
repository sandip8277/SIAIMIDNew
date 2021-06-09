using MIDDerivationLibrary.Models.DrivenModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class Drivens
    {
        public Pump pump { get; set; }
        public Compressor compressor { get; set; }
        public FanOrBlower fan_or_blower { get; set; }
        public PurifierCentrifuge purifier_centrifuge { get; set; }
        public Decanter decanter { get; set; }
        public Generator generator { get; set; }
        public Vacuumpump vacuumpump { get; set; }
        public SpindleOrShaftOrBearing spindle_or_shaft_or_bearing { get; set; }
        public int? rpm { get; set; }
    }
}
