using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class Coupling2ForDeconstruction
    {
        public string componentType { get; set; }
        public int? couplingPosition { get; set; }
        public string couplingType { get; set; }
        public int? locations { get; set; }
        public decimal? speedratio { get; set; }
    }
}
