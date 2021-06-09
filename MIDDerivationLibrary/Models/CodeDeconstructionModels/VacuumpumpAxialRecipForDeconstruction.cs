using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class VacuumpumpAxialRecipForDeconstruction
    {
        public bool? attachedOilPump { get; set; }
        public string bearingsType { get; set; }
        public string thrustBearing { get; set; }
        public VacuumpumpAxialRecipExtraFaultData extraFaultData { get; set; }
    }
}
