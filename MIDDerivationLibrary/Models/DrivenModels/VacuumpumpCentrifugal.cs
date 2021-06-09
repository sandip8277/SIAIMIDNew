using MIDDerivationLibrary.Models.CommonModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class VacuumpumpCentrifugal
    {
        public bool? rotorOverhung { get; set; }
        public bool? impellerOnMainShaft { get; set; }
        public string bearingsType { get; set; }
        public string thrustBearing { get; set; }
        public ExtraFaultData extraFaultData { get; set; }
    }
}
