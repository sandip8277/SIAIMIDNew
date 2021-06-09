using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class FanOrBlowerTypesForDeconstruction
    {
        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public FanOrBlowerLobedForDeconstruction fan_or_blowerLobed { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public FanOrBlowerOverhungRotorForDeconstruction fan_or_blowerOverhungRotor { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public FanOrBlowerSupportedRotorForDeconstruction fan_or_blowerSupportedRotor { get; set; }
    }
}
