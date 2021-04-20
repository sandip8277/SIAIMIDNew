using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class MachineComponentsForMIDgeneration
    {
        public Driver driver { get; set; }
        public Coupling1 coupling1 { get; set; }
        public Intermediate intermediate { get; set; }
        public Coupling2 coupling2 { get; set; }
        public Driven driven { get; set; }
    }
}
