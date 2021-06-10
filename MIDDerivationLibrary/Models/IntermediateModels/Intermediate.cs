using MIDDerivationLibrary.Models.IntermediateModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.IntermediateModels
{
    public class Intermediate
    {
        public string componentType { get; set; }
        public string intermediateType { get; set; }
        public int? locations { get; set; }
        public decimal? speedratio { get; set; }
        public Intermediates intermediates { get; set; }
    }
}
