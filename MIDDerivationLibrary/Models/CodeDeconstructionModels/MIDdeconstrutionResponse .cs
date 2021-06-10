using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;


namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
   
    public class MIDdeconstrutionResponse
    {
        public DriverForDeconstruction driver { get; set; }
        public Coupling1ForDeconstruction coupling1 { get; set; }
        public IntermediateForDeconstruction intermediate { get; set; }
        public Coupling2ForDeconstruction coupling2 { get; set; }
        public DrivenForDeConstruction driven { get; set; }
    }
}
