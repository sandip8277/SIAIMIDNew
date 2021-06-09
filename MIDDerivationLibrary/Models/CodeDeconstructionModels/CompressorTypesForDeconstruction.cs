using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class CompressorTypesForDeconstruction
    {
        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public CompressorCentrifugalForDeconstruction compressorCentrifugal { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public CompressorReciporcatingForDeconstruction compressorReciporcating { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public CompressorScrewForDeconstruction compressorScrew { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public CompressorScrewTwinForDeconstruction compressorScrewTwin { get; set; }
    }
}
