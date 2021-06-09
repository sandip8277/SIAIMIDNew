using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Enums
{
    public class DrivenEnums
    {
        public enum DrivenComponentType
        {
            driver = 1,
            coupling = 2,
            intermediate = 3,
            driven = 4
        }

        public enum DrivenType
        {
            pump = 1,
            compressor = 2,
            fan_or_blower = 3,
            purifier_centrifuge = 4,
            decanter = 5,
            generator = 6,
            vacuumpump = 7,
            spindle_or_shaft_or_bearing = 8
        }

        public enum DrivenPumpType
        {
            centrifugal = 1,
            propeller = 2,
            rotarythread = 3,
            gear = 4,
            screw = 5,
            slidingvane = 6,
            axialrecip = 7,
            radialrecip = 8
        }

        

        public enum DrivenThrustBearing
        {
            journal = 1,
            ball = 2,
            no = 3,
            yes = 4
        }

        public enum PumpRotaryAxialRecipThrustBearing
        {
            journal = 1,
            ball = 2
        }

        public enum DrivenCompressorType
        {
            centrifugal = 1,
            reciprocating = 2,
            screw = 3,
            screwtwin = 4
        }

        public enum DrivenCompressorThrustBearing
        {
            no = 1,
            yes = 2
        }

        public enum DrivenFan_or_BlowerType
        {
            lobed = 1,
            overhungrotor = 2,
            supportedrotor = 3
        }

        public enum DrivenPurifierDrivenBy
        {
            gearedwithclutch = 1,
            beltdrive = 2
        }

        public enum DrivenSpindleShaftBearing
        {
            spindle = 1,
            shaft = 2
        }

        public enum DrivenSpecialFaultCodeType
        {
            vanes = 1,
            driven_threads = 2,
            idler_threads = 3,
            teeth = 4,
            pistons = 5,
            input_lobes = 6,
            idler_lobes = 7,
            stage1_fan_blades = 8,
            stage2_fan_blades = 9,
            fan_blades = 10
        }

        public enum DrivenBearingType
        {
            nde_journal = 1,
            nde_ball = 2,
            ballbearingsbothends = 3,
            journalbearingsbothends = 4
        }

        public enum DrivenExciterOverhungOrSupported
        {
            overhung = 1,
            supported = 2
        }

        public enum DrivenGeneratorDrivenBy
        {
            notdieselengine = 1,
            dieselengine = 2
        }

        public enum DrivenVacuumPumpType
        {
            centrifugal = 1,
            axialrecip = 2,
            radialrecip = 3,
            reciprocating = 4,
            lobed = 5
        }

        public enum DrivenBearingsType
        {
            journal = 1,
            ballbearings = 2,
            journalbearingsonmain = 3,
            ballbearingsonmain = 4
        }

        public enum DrivenVaccumPumpThrustBearing
        {
            journal = 1,
            ball = 2,
            no = 3,
            yes = 4,
            journalthrust = 5,
            ballthrustbearing = 6
        }

        public enum DrivenVacuumPumpAxialRecipBearingsType
        {
            ballbearings = 1,
            journal = 2
        }

        public enum DrivenVacuumPumpAxialRecipThrustBearing
        {
            journalthrust = 1,
            ballthrustbearingplate = 2
        }

        public enum DrivenVacuumpumpLobedBearingsType
        {
            ballbearings = 1,
            journal = 2,
            journalandballbearings = 3
        }

        public enum DrivenVacuumPumpReciprocating
        {
            crankshaftjournalbearingsatendonly = 1,
            allballbearings = 2
        }

    }
}
