using MIDDerivationLibrary.Models.DrivenModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class PumpTypes
    {
        public PumpCentrifugal pumpCentrifugal { get; set; }
        public PumpPropeller pumpPropeller { get; set; }
        public PumpRotaryThread pumpRotaryThread { get; set; }
        public PumpGear pumpGear { get; set; }
        public PumpRotaryScrew pumpRotaryScrew { get; set; }
        public PumpRotarySlidingVane pumpRotarySlidingVane { get; set; }
        public PumpRotaryAxialRecip pumpRotaryAxialRecip { get; set; }
        public PumpRotaryRadialRecip pumpRotaryRadialRecip { get; set; }
    }
}
