using MIDDerivationLibrary.Models.CommonModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class Generator
    {
        public string bearingType { get; set; }
        public bool? exciter { get; set; }
        public string exciterOverhungOrSupported { get; set; }
        public string drivenBy { get; set; }
        public ExtraFaultData extraFaultData { get; set; }
    }
}
