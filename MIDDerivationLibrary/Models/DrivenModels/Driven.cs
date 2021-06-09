using MIDDerivationLibrary.Models.DrivenModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class Driven
    {
        public string componentType { get; set; }
        public int? locations { get; set; }
        public bool? drivenLocationNDE { get; set; }
        public bool? drivenLocationDE { get; set; }
        public string drivenType { get; set; }
        public Drivens drivens { get; set; }
    }
    //public class Drivens
    //{
    //    public Pump pump { get; set; }
    //    public Compressor compressor { get; set; }
    //    public FanOrBlower fan_or_blower { get; set; }
    //    public PurifierCentrifuge purifier_centrifuge { get; set; }
    //    public Decanter decanter { get; set; }
    //    public Generator generator { get; set; }
    //    public Vacuumpump vacuumpump { get; set; }
    //    public SpindleOrShaftOrBearing spindle_or_shaft_or_bearing { get; set; }
    //    public int? rpm { get; set; }
    //}
    //public class Pump
    //{
    //    public string pumpType { get; set; }
    //    public PumpTypes pumpTypes { get; set; }
    //}

    //public class PumpTypes
    //{
    //    public PumpCentrifugal pumpCentrifugal { get; set; }
    //    public PumpPropeller pumpPropeller { get; set; }
    //    public PumpRotaryThread pumpRotaryThread { get; set; }
    //    public PumpGear pumpGear { get; set; }
    //    public PumpRotaryScrew pumpRotaryScrew { get; set; }
    //    public PumpRotarySlidingVane pumpRotarySlidingVane { get; set; }
    //    public PumpRotaryAxialRecip pumpRotaryAxialRecip { get; set; }
    //    public PumpRotaryRadialRecip pumpRotaryRadialRecip { get; set; }
    //}
    //public class PumpCentrifugal
    //{
    //    public bool? rotorOverhung { get; set; }
    //    public bool? centrifugalPumpHasBallBearings { get; set; }
    //    public string thrustBearing { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}

    //public class PumpPropeller
    //{
    //    public bool? propellerpumpHasBallBearings { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}

    //public class PumpRotaryThread
    //{
    //    public bool? rotaryThreadPumpHasBallBearings { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}

    //public class PumpGear
    //{
    //    public bool? gearPumpHasBallBearings { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}

    //public class PumpRotaryScrew
    //{
    //    public bool? screwPumpHasBallBearings { get; set; }

    //    public ExtraFaultData extraFaultData { get; set; }
    //}

    //public class PumpRotarySlidingVane
    //{
    //    public bool? rotorOverhung { get; set; }
    //    public bool? slidingVanePumpHasBallBearings { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}

    //public class PumpRotaryAxialRecip
    //{
    //    public bool? attachedOilPump { get; set; }
    //    public bool? axialRecipPumpHasBallBearings { get; set; }
    //    public string thrustBearing { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}

    //public class PumpRotaryRadialRecip
    //{
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
    //public class Compressor
    //{
    //    public string compressorType { get; set; }
    //    public CompressorTypes compressorTypes { get; set; }
    //}
    //public class CompressorTypes
    //{
    //    public CompressorCentrifugal compressorCentrifugal { get; set; }
    //    public CompressorReciporcating compressorReciporcating { get; set; }
    //    public CompressorScrew compressorScrew { get; set; }
    //    public CompressorScrewTwin compressorScrewTwin { get; set; }
    //}
    //public class CompressorCentrifugal
    //{
    //    public bool? impellerOnMainShaft { get; set; }
    //    public bool? centrifugalCompressorHasBallBearings { get; set; }
    //    public string thrustBearing { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
    //public class CompressorReciporcating
    //{
    //    public bool? crankHasIntermediateBearing { get; set; }
    //    public bool? reciprocatingCompressorHasBallBearings { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
    //public class FanOrBlower
    //{
    //    public string fan_or_blowerType { get; set; }
    //    public FanOrBlowerTypes fan_or_blowerTypes { get; set; }
    //}

    //public class FanOrBlowerTypes
    //{
    //    public FanOrBlowerLobed fan_or_blowerLobed { get; set; }
    //    public FanOrBlowerOverhungRotor fan_or_blowerOverhungRotor { get; set; }
    //    public FanOrBlowerSupportedRotor fan_or_blowerSupportedRotor { get; set; }
    //}
    //public class FanOrBlowerLobed
    //{
    //    public bool? lobedFanOrBlowerHasBallBearings { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
    //public class FanOrBlowerOverhungRotor
    //{
    //    public bool? fanStages { get; set; }
    //    public bool? overhungRotorFanOrBlowerHasBearings { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }

    //}

    //public class FanOrBlowerSupportedRotor
    //{
    //    public bool? fanStages { get; set; }
    //    public bool? supportedRotorFanOrBlowerHasBearings { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
    //public class CompressorScrew
    //{
    //    public bool? screwCompressorHasBallBearings { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}

    //public class CompressorScrewTwin
    //{
    //    public bool? screwTwinCompressorHasBallBearingsOnHPSide { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
    //public class PurifierCentrifuge
    //{
    //    public string purifierDrivenBy { get; set; }
    //}
    //public class Decanter
    //{
    //}
    //public class Generator
    //{
    //    public string bearingType { get; set; }
    //    public bool? exciter { get; set; }
    //    public string exciterOverhungOrSupported { get; set; }
    //    public string drivenBy { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
    //public class Vacuumpump
    //{
    //    public string vacuumpumptype { get; set; }
    //    public VacuumpumpTypes vacuumpumpTypes { get; set; }
    //}
    //public class VacuumpumpTypes
    //{
    //    public VacuumpumpCentrifugal vacuumpumpCentrifugal { get; set; }
    //    public VacuumpumpAxialRecip vacuumpumpAxialRecip { get; set; }
    //    public VacuumpumpRadialRecip vacuumpumpRadialRecip { get; set; }
    //    public VacuumpumpReciprocating vacuumpumpReciprocating { get; set; }
    //    public VacuumpumpLobed vacuumpumpLobed { get; set; }
    //}

    //public class VacuumpumpCentrifugal
    //{
    //    public bool? rotorOverhung { get; set; }
    //    public bool? impellerOnMainShaft { get; set; }
    //    public string bearingsType { get; set; }
    //    public string thrustBearing { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
    //public class VacuumpumpAxialRecip
    //{
    //    public bool? attachedOilPump { get; set; }
    //    public string bearingsType { get; set; }
    //    public string thrustBearing { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
    //public class VacuumpumpRadialRecip
    //{
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
    //public class VacuumpumpReciprocating
    //{
    //    public string bearingsType { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
    //public class SpindleOrShaftOrBearing
    //{
    //    public string spindleShaftBearing { get; set; }
    //}
    //public class VacuumpumpLobed
    //{
    //    public string bearingsType { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
}
