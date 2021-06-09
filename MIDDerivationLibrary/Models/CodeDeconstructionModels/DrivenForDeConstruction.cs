using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class DrivenForDeConstruction
    {
        public string componentType { get; set; }
        public int? locations { get; set; }
        public bool? drivenLocationNDE { get; set; }
        public bool? drivenLocationDE { get; set; }
        public int? rpm { get; set; }
        public string drivenType { get; set; }
        public DrivensForDeconstruction drivens { get; set; }
    }
}
