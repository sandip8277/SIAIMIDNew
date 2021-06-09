using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class MotorForDeconstruction
    {
        public string motorDrive { get; set; }
        public bool? motorFan { get; set; }
        public bool? motorBallBearings { get; set; }
        public bool? drivenBallBearings { get; set; }
        public bool? drivenBalanceable { get; set; }
        public VFDForDeconstruction vfd { get; set; }
        public MotorExtraFaultDataForDeconstruction extraFaultData { get; set; }
    }
}
