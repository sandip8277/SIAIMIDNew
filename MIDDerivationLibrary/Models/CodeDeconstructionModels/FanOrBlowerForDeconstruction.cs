using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class FanOrBlowerForDeconstruction
    {
        public string fan_or_blowerType { get; set; }
        public FanOrBlowerTypesForDeconstruction fan_or_blowerTypes { get; set; }
    }
}
