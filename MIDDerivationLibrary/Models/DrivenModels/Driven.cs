using MIDDerivationLibrary.Models.DrivenModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class Driven
    {
        public string componentType { get; set; }
        public int? locations { get; set; }
        public bool? drivenLocationNDE { get; set; }
        public bool? drivenLocationDE { get; set; }
        public string drivenType { get; set; }
        public Drivens drivens { get; set; }
    }
}
