using MIDDerivationLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDCodeGenerator.Models
{
    public class MIDCodeDetails
    {
        public DriverCodes driver { get; set; }
        public Codes coupling1 { get; set; }
        public Codes intermediate { get; set; }
        public Codes coupling2 { get; set; }
        public DrivenCodes driven { get; set; }
        public FaultCodeMatrix faultCodeMatrix { get; set; }
    }
}
