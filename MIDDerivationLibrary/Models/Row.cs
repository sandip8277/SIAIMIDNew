using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class Row
    {
        public int rowId { get; set; }
        public string frequencyCode { get; set; }
        public double? faultcode { get; set; }
    }
}
