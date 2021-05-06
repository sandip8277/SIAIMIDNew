using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CSDMdefsModels
{
    public class CSDMdefsDetails
    {
        public long id { get; set; }
        public string csdmfile { get; set; }
        public decimal? componentCodeRangeStart { get; set; }
        public decimal? componentCodeRangeEnd { get; set; }
        public int? csdmSize { get; set; }
        public bool? csdmRelative { get; set; }
        public string defaultShaftLabel { get; set; }
    }
}
