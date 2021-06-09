using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CommonModels
{
    public class Row
    {
        [System.Text.Json.Serialization.JsonIgnore()]
        public decimal? _faultcode { get; set; }
        public int rowId { get; set; }
        public string frequencyCode { get; set; }
        public decimal? faultcode 
        {
            get { return _faultcode; }
            set {
                if (value != null)
                    _faultcode = Convert.ToDecimal(String.Format("{0:0.0000}", value));
            }
        }
    }
}
