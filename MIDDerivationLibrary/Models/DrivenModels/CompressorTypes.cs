using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class CompressorTypes
    {
        public CompressorCentrifugal compressorCentrifugal { get; set; }
        public CompressorReciporcating compressorReciporcating { get; set; }
        public CompressorScrew compressorScrew { get; set; }
        public CompressorScrewTwin compressorScrewTwin { get; set; }
    }
}
