using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class Coupling2
    {
        public string componentType { get; set; }
        public int? couplingPosition { get; set; }
        public string couplingType { get; set; }
        public int? locations { get; set; }
        //public string coupledComponentType1 { get; set; }
        //public string coupledComponentType2 { get; set; }
        public decimal? speedratio { get; set; } 
    }
}
