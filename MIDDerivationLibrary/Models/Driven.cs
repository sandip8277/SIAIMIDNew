using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class Driven
    {
        public string componentType { get; set; }
        public string drivenType { get; set; }
        public int? locations { get; set; }
        public string pumpType { get; set; }
        public string compressorType { get; set; }
        public string fan_or_blowerType { get; set; }
        public string purifierDrivenBy { get; set; }
        public string bearingType { get; set; }
        public string col_cType { get; set; }
        public bool? rotorOverhung { get; set; }
        public bool? attachedOilPump { get; set; }
        public bool? impellerOnMainShaft { get; set; }
        public bool? crankHasIntermediateBearing { get; set; }
        public bool? fanStages { get; set; }
        public bool? exciter { get; set; }
        public bool? centrifugalPumpHasBallBearings { get; set; }
        public bool? propellerpumpHasBallBearings { get; set; }
        public bool? rotaryThreadPumpHasBallBearings { get; set; }
        public bool? gearPumpHasBallBearings { get; set; }
        public bool? screwPumpHasBallBearings { get; set; }
        public bool? slidingVanePumpHasBallBearings { get; set; }
        public bool? axialRecipPumpHasBallBearings { get; set; }
        public bool? centrifugalCompressorHasBallBearings { get; set; }
        public bool? reciprocatingCompressorHasBallBearings { get; set; }
        public bool? screwCompressorHasBallBearings { get; set; }
        public bool? screwTwinCompressorHasBallBearingsOnHPSide { get; set; }
        public bool? lobedFanOrBlowerHasBallBearings { get; set; }
        public bool? overhungRotorFanOrBlowerHasBearings { get; set; }
        public bool? supportedRotorFanOrBlowerHasBearings { get; set; }
        public string exciterOverhungOrSupported { get; set; }
        public string bearingsType { get; set; }
        public string thrustBearing { get; set; }
        public string drivenBy { get; set; }
        public decimal? rpm { get; set; }
        public List<SpecialFaultCodesInput> specialFaultCodesInput { get; set; }

    }
}
