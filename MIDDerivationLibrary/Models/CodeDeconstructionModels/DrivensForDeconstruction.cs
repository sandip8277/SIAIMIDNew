using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class DrivensForDeconstruction
    {
        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public PumpForDeconstruction pump { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public CompressorForDeconstruction compressor { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public FanOrBlowerForDeconstruction fan_or_blower { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public PurifierCentrifugeForDeconstruction purifier_centrifuge { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public DecanterForDeconstruction decanter { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public GeneratorForDeconstruction generator { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public VacuumpumpForDeconstruction vacuumpump { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public SpindleOrShaftOrBearingForDeconstruction spindle_or_shaft_or_bearing { get; set; }
    }
}
