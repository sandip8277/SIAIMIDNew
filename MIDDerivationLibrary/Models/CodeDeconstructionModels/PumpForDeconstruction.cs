using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class PumpForDeconstruction
    {
        public string pumpType { get; set; }
        public PumpTypesForDeconstruction pumpTypes { get; set; }
    }
}
