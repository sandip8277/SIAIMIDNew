using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class GeneratorForDeconstruction
    {
        public string bearingType { get; set; }
        public bool? exciter { get; set; }
        public string exciterOverhungOrSupported { get; set; }
        public string drivenBy { get; set; }
        public ExtraFaultDataForGenerator extraFaultData { get; set; }
    }
}
