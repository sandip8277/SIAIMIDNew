using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class Intermediate
    {
        public string componentType { get; set; }
        public string intermediateType { get; set; }
        public int? locations { get; set; }
        public string drivenBy { get; set; }
        public int? inputBearing { get; set; }
        public decimal? speedratio { get; set; }
        public Intermediates intermediates { get; set; }
    }
    public class Intermediates
    {
        public Gearbox gearbox { get; set; }
        public AOP AOP { get; set; }
        public AccDrGr AccDrGr { get; set; }
    }

    public class Gearbox
    {
        public int? speedChangesMax { get; set; }
    }

    public class AOP
    {
        public string drivenBy { get; set; }
    }

    public class AccDrGr
    {
        public string drivenBy { get; set; }
    }
}
