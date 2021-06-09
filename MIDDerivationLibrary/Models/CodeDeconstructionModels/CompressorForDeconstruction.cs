using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class CompressorForDeconstruction
    {
        public string compressorType { get; set; }
        public CompressorTypesForDeconstruction compressorTypes { get; set; }
    }
}
