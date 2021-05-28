using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class Coupling1
    {
        //public long id { get; set; }
        public string componentType { get; set; }
        public int? couplingPosition { get; set; }
        public string couplingType { get; set; }
        public int? locations { get; set; }
        public decimal? speedratio { get; set; } 
    }
}
