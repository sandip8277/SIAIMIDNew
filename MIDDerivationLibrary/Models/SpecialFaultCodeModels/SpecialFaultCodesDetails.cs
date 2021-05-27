using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.SpecialFaultCodeModels
{
    public class SpecialFaultCodesDetails
    {
        public long id { get; set; }
        public string specialfaultcodetype { get; set; }
        public int? specialmultiple { get; set; }
        public string specialcode { get; set; }
    }
}
