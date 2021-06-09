using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class IntermediateForDeconstruction
    {
        public string componentType { get; set; }
        public int? locations { get; set; }
        public decimal? speedratio { get; set; }
        public string intermediateType { get; set; }
        public IntermediatesForDeconstruction intermediates { get; set; }
    }
}
