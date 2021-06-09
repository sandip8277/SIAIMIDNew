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

    //public class DrivenForDeConstruction
    //{
    //    public string componentType { get; set; }
    //    public int? locations { get; set; }
    //    public bool? drivenLocationNDE { get; set; }
    //    public bool? drivenLocationDE { get; set; }
    //    public int? rpm { get; set; }
    //    public string drivenType { get; set; }
    //    public DrivensForDeconstruction drivens { get; set; }
    //}

    
    //public class DrivensForDeconstruction
    //{
    //    public PumpForDeconstruction pump { get; set; }
    //    public CompressorForDeconstruction compressor { get; set; }
    //    public FanOrBlowerForDeconstruction fan_or_blower { get; set; }
    //    public PurifierCentrifugeForDeconstruction purifier_centrifuge { get; set; }
    //    public DecanterForDeconstruction decanter { get; set; }
    //    public GeneratorForDeconstruction generator { get; set; }
    //    public VacuumpumpForDeconstruction vacuumpump { get; set; }
    //    public SpindleOrShaftOrBearingForDeconstruction spindle_or_shaft_or_bearing { get; set; }
    //    public int? rpm { get; set; }
    //}

    //public class PurifierCentrifugeForDeconstruction
    //{
    //    public string purifierDrivenBy { get; set; }
    //}
    //public class DecanterForDeconstruction
    //{
    //}
    //public class GeneratorForDeconstruction
    //{
    //    public string bearingType { get; set; }
    //    public bool? exciter { get; set; }
    //    public string exciterOverhungOrSupported { get; set; }
    //    public string drivenBy { get; set; }
    //    public ExtraFaultDataForGenerator extraFaultData { get; set; }
    //}

    //public class ExtraFaultDataForGenerator
    //{
    //    public int? generatorbars { get; set; }
    //}
    //public class FanOrBlowerForDeconstruction
    //{
    //    public string fan_or_blowerType { get; set; }
    //    public FanOrBlowerTypesForDeconstruction fan_or_blowerTypes { get; set; }
    //}

    //public class FanOrBlowerLobedForDeconstruction
    //{
    //    public bool? lobedFanOrBlowerHasBallBearings { get; set; }
    //    public ExtraFaultDataForFan_or_blower extraFaultData { get; set; }
    //}
    //public class ExtraFaultDataForFan_or_blower
    //{
    //    public int? blowerlobes { get; set; }
    //    public int? idlerlobes { get; set; }
    //    public int? fanblades { get; set; }
    //}

    //public class FanOrBlowerTypesForDeconstruction
    //{
    //    public FanOrBlowerLobedForDeconstruction fan_or_blowerLobed { get; set; }
    //    public FanOrBlowerOverhungRotorForDeconstruction fan_or_blowerOverhungRotor { get; set; }
    //    public FanOrBlowerSupportedRotorForDeconstruction fan_or_blowerSupportedRotor { get; set; }
    //}

    //public class FanOrBlowerSupportedRotorForDeconstruction
    //{
    //    public bool? supportedRotorFanOrBlowerHasBearings { get; set; }
    //    public FanOrBlowerSupportedRotorExtraFaultData extraFaultData { get; set; }
    //}

    //public class FanOrBlowerSupportedRotorExtraFaultData
    //{
    //    public int? fanblades { get; set; }
    //}
    //public class FanOrBlowerOverhungRotorForDeconstruction
    //{
    //    public bool? fanStages { get; set; }
    //    public bool? overhungRotorFanOrBlowerHasBearings { get; set; }
    //    public FanOrBlowerOverhungRotorExtraFaultData extraFaultData { get; set; }
    //}

    //public class FanOrBlowerOverhungRotorExtraFaultData
    //{
    //    public int? fanblades { get; set; }
    //}


    //public class CompressorForDeconstruction
    //{
    //    public string compressorType { get; set; }
    //    public CompressorTypesForDeconstruction compressorTypes { get; set; }
    //}
    //public class CompressorTypesForDeconstruction
    //{
    //    public CompressorCentrifugalForDeconstruction compressorCentrifugal { get; set; }
    //    public CompressorReciporcatingForDeconstruction compressorReciporcating { get; set; }
    //    public CompressorScrewForDeconstruction compressorScrew { get; set; }
    //    public CompressorScrewTwinForDeconstruction compressorScrewTwin { get; set; }
    //}
    //public class CompressorScrewForDeconstruction
    //{
    //    public bool? screwCompressorHasBallBearings { get; set; }
    //    public CompressorScrewExtraFaultData extraFaultData { get; set; }

    //}

    //public class CompressorScrewExtraFaultData
    //{
    //    public int? compressorthreads { get; set; }
    //    public int? idlerthreads { get; set; }
    //}

    //public class CompressorScrewTwinForDeconstruction
    //{
    //    public bool? screwTwinCompressorHasBallBearingsOnHPSide { get; set; }
    //    public CompressorScrewTwinExtraFaultData extraFaultData { get; set; }
    //}

    //public class CompressorScrewTwinExtraFaultData
    //{
    //    public int? compressorthreads1 { get; set; }
    //    public int? idlerthreads1 { get; set; }
    //    public int? compressorthreads2 { get; set; }
    //    public int? idlerthreads2 { get; set; }
     
    //}

    //public class CompressorCentrifugalForDeconstruction
    //{
    //    public bool? impellerOnMainShaft { get; set; }
    //    public bool? centrifugalCompressorHasBallBearings { get; set; }
    //    public string thrustBearing { get; set; }
    //    public CompressorCentrifugalExtraFaultData extraFaultData { get; set; }
    //}

    //public class CompressorCentrifugalExtraFaultData
    //{
    //    public int? compressorvanes { get; set; }
    //}

    //public class CompressorReciporcatingForDeconstruction
    //{
    //    public bool? crankHasIntermediateBearing { get; set; }
    //    public bool? reciprocatingCompressorHasBallBearings { get; set; }
    //    public CompressorReciporcatingExtraFaultData extraFaultData { get; set; }
    //}

    //public class CompressorReciporcatingExtraFaultData
    //{
    //    public int? compressorpistons { get; set; }
    //}

    //public class PumpForDeconstruction
    //{
    //    public string pumpType { get; set; }
    //    public PumpTypesForDeconstruction pumpTypes { get; set; }
    //}
    //public class PumpCentrifugalForDeconstruction
    //{
    //    public bool? rotorOverhung { get; set; }
    //    public bool? centrifugalPumpHasBallBearings { get; set; }
    //    public string thrustBearing { get; set; }
    //    public PumpCentrifugalExtraFaultData extraFaultData { get; set; }
    //}
    //public class PumpCentrifugalExtraFaultData
    //{
    //    public int? pumpvanes { get; set; }
    //}
    //public class PumpPropellerExtraFaultData
    //{
    //    public int? pumpvanes { get; set; }
    //    public int? pumpblades { get; set; }
    //}

    //public class PumpPropellerForDeconstruction
    //{
    //    public bool? propellerpumpHasBallBearings { get; set; }

    //    public PumpPropellerExtraFaultData extraFaultData { get; set; }
    //}
    //public class PumpRotaryThreadExtraFaultData
    //{
    //    public int? pumpthreads { get; set; }
    //}
    //public class PumpRotaryThreadForDeconstruction
    //{
    //    public bool? rotaryThreadPumpHasBallBearings { get; set; }
    //    public PumpRotaryThreadExtraFaultData extraFaultData { get; set; }
    //}

    //public class PumpGearForDeconstruction
    //{
    //    public bool? gearPumpHasBallBearings { get; set; }
    //    public PumpGearExtraFaultData extraFaultData { get; set; }
    //}
    //public class pumpRotaryScrewExtraFaultData
    //{
    //    public int? pumpthreads { get; set; }
    //    public int? idlerthreads { get; set; }
    //}

    //public class PumpGearExtraFaultData
    //{
    //    public int? pumpteeth { get; set; }

    //}

    //public class PumpRotarySlidingVaneExtraFaultData
    //{
    //    public int? pumpvanes { get; set; }

    //}
    //public class PumpRotarySlidingVaneForDeconstruction
    //{
    //    public bool? rotorOverhung { get; set; }
    //    public bool? slidingVanePumpHasBallBearings { get; set; }
    //    public PumpRotarySlidingVaneExtraFaultData extraFaultData { get; set; }
    //}


    //public class PumpTypesForDeconstruction
    //{
    //    public PumpCentrifugalForDeconstruction pumpCentrifugal { get; set; }
    //    public PumpPropellerForDeconstruction pumpPropeller { get; set; }
    //    public PumpRotaryThreadForDeconstruction pumpRotaryThread { get; set; }
    //    public PumpGearForDeconstruction pumpGear { get; set; }
    //    public PumpRotaryScrewForDeconstruction pumpRotaryScrew { get; set; }
    //    public PumpRotarySlidingVaneForDeconstruction pumpRotarySlidingVane { get; set; }
    //    public PumpRotaryAxialRecipForDeconstruction pumpRotaryAxialRecip { get; set; }
    //    public PumpRotaryRadialRecipForDeconstruction pumpRotaryRadialRecip { get; set; }
    //}
    //public class PumpRotaryRadialRecipForDeconstruction
    //{
    //    public PumpRotaryRadialRecipExtraFaultData extraFaultData { get; set; }
    //}
    //public class PumpRotaryRadialRecipExtraFaultData
    //{
    //    public int? pumppistons { get; set; }
    //}
    //public class PumpRotaryAxialRecipExtraFaultData
    //{
    //    public int? pumppistons { get; set; }

    //}
    //public class PumpRotaryAxialRecipForDeconstruction
    //{
    //    public bool? attachedOilPump { get; set; }
    //    public bool? axialRecipPumpHasBallBearings { get; set; }
    //    public string thrustBearing { get; set; }
    //    public PumpRotaryAxialRecipExtraFaultData extraFaultData { get; set; }

    //}
    //public class PumpRotaryScrewForDeconstruction
    //{
    //    public bool? screwPumpHasBallBearings { get; set; }
    //    public pumpRotaryScrewExtraFaultData extraFaultData { get; set; }
    //}
    //public class IntermediateForDeconstruction
    //{
    //    public string componentType { get; set; }
    //    public int? locations { get; set; }
    //    public decimal? speedratio { get; set; }
    //    public string intermediateType { get; set; }
    //    public IntermediatesForDeconstruction intermediates { get; set; }
    //}
    //public class IntermediatesForDeconstruction
    //{
    //    public GearboxForDeconstruction gearbox { get; set; }
    //    public AOPForDeconstruction AOP { get; set; }
    //    public AccDrGrForConstruction AccDrGr { get; set; }
    //}

    //public class AccDrGrForConstruction
    //{
    //    public string drivenBy { get; set; }
    //}
    //public class AOPForDeconstruction
    //{
    //    public string drivenBy { get; set; }
    //}
    //public class GearboxForDeconstruction
    //{
    //    public int? speedChangesMax { get; set; }
    //}
    //public class Coupling2ForDeconstruction
    //{
    //    public string componentType { get; set; }
    //    public int? couplingPosition { get; set; }
    //    public string couplingType { get; set; }
    //    public int? locations { get; set; }
    //    public decimal? speedratio { get; set; }
    //}
    //public class Coupling1ForDeconstruction
    //{
    //    public string componentType { get; set; }
    //    public int? couplingPosition { get; set; }
    //    public string couplingType { get; set; }
    //    public int? locations { get; set; }
    //    public decimal? speedratio { get; set; }
    //}
    //public class DriverForDeconstruction
    //{
    //    public string componentType { get; set; }
    //    public int? locations { get; set; }
    //    public bool? driverLocationNDE { get; set; }
    //    public bool? driverLocationDE { get; set; }
    //    public int? rpm { get; set; }
    //    public string driverType { get; set; }
    //    public DriversForDeconstruction drivers { get; set; }
    //}
    //public class DriversForDeconstruction
    //{
    //    [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
    //    public DieselForDeconstruction diesel { get; set; }
    //    public MotorForDeconstruction motor { get; set; }

    //    [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
    //    public TurbineForDeconstruction turbine { get; set; }
    //}

    //public class DieselForDeconstruction
    //{
    //    public int? cylinders { get; set; }
    //}
    //public class MotorForDeconstruction
    //{
    //    public string motorDrive { get; set; }
    //    public bool? motorFan { get; set; }
    //    public bool? motorBallBearings { get; set; }
    //    public bool? drivenBallBearings { get; set; }
    //    public bool? drivenBalanceable { get; set; }
    //    public VFDForDeconstruction vfd { get; set; }
    //    public MotorExtraFaultDataForDeconstruction extraFaultData { get; set; }
    //}
    //public class VFDForDeconstruction
    //{
    //    public int? motorPoles { get; set; }
    //}
    //public class TurbineForDeconstruction
    //{
    //    public bool? turbineReductionGear { get; set; }
    //    public bool? turbineRotorSupported { get; set; }
    //    public bool? turbineBallBearing { get; set; }
    //    public bool? turbineThrustBearing { get; set; }
    //    public bool? turbineThrustBearingIsBall { get; set; }
    //    public TurbineExtraFaultDataForDeconstruction extraFaultData { get; set; }
    //}
    //public class MotorExtraFaultDataForDeconstruction
    //{
    //    public int? motorbars { get; set; }
    //    public int? motorfanblades { get; set; }
    //}

    //public class TurbineExtraFaultDataForDeconstruction
    //{
    //    public int? turbineblades { get; set; }
    //}
    //public class VacuumpumpForDeconstruction
    //{
    //    public string vacuumpumptype { get; set; }
    //    public VacuumpumpTypesForDeconstruction vacuumpumpTypes { get; set; }
    //}
    //public class VacuumpumpTypesForDeconstruction
    //{
    //    public VacuumpumpCentrifugalForDeconstruction vacuumpumpCentrifugal { get; set; }
    //    public VacuumpumpAxialRecipForDeconstruction vacuumpumpAxialRecip { get; set; }
    //    public VacuumpumpRadialRecipForDeconstruction vacuumpumpRadialRecip { get; set; }
    //    public VacuumpumpReciprocatingForDeconstruction vacuumpumpReciprocating { get; set; }
    //    public VacuumpumpLobedForDeconstruction vacuumpumpLobed { get; set; }
    //}

    //public class VacuumpumpCentrifugalForDeconstruction
    //{
    //    public bool? rotorOverhung { get; set; }
    //    public bool? impellerOnMainShaft { get; set; }
    //    public string bearingsType { get; set; }
    //    public string thrustBearing { get; set; }
    //    public VacuumpumpCentrifugalExtraFaultData extraFaultData { get; set; }
    //}

    //public class VacuumpumpCentrifugalExtraFaultData
    //{
    //    public int? pumpvanes { get; set; }
    //}

    //public class VacuumpumpAxialRecipForDeconstruction
    //{
    //    public bool? attachedOilPump { get; set; }
    //    public string bearingsType { get; set; }
    //    public string thrustBearing { get; set; }
    //    public VacuumpumpAxialRecipExtraFaultData extraFaultData { get; set; }
    //}

    //public class VacuumpumpAxialRecipExtraFaultData
    //{
    //    public int? pumppistons { get; set; }
       
    //}

    //public class VacuumpumpRadialRecipExtraFaultData
    //{
    //    public int? pumppistons { get; set; }

    //}

    //public class VacuumpumpRadialRecipForDeconstruction
    //{
        
    //    public VacuumpumpRadialRecipExtraFaultData extraFaultData { get; set; }


    //}

    //public class VacuumpumpReciprocatingExtraFaultData
    //{
    //    public int? pumppistons { get; set; }
    //}

    //public class VacuumpumpReciprocatingForDeconstruction
    //{
    //    public string bearingsType { get; set; }
        
    //    public VacuumpumpReciprocatingExtraFaultData extraFaultData { get; set; }
    //}
    //public class SpindleOrShaftOrBearingForDeconstruction
    //{
    //    public string spindleShaftBearing { get; set; }
    //}
    //public class VacuumpumpLobedForDeconstruction
    //{
    //    public string bearingsType { get; set; }
        
    //    public VacuumpumpLobedExtraFaultData extraFaultData { get; set; }
    //}

    //public class VacuumpumpLobedExtraFaultData
    //{
    //    public int? pumplobes { get; set; }

    //    public int? idlerlobes { get; set; }

    //}
}
