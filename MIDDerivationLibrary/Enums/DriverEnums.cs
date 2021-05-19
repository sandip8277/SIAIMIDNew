using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Enums
{
    public class DriverEnums
    {
        public enum DriverComponentType
        {
            driver = 1,
            coupling = 2,
            intermediate = 3,
            driven = 4
        }

        public enum DriverType
        {
            diesel = 1,
            motor = 2,
            turbine = 3
        }

        public enum DieselCylinders
        {
            Cylinder2 = 2,
            Cylinder4 = 4,
            Cylinder6 = 6,
            Cylinder8 = 8,
            Cylinder10 = 10,
            Cylinder12 = 12,
            Cylinder14 = 14,
            Cylinder16 = 16,
            Cylinder18 = 18,
            Cylinder20 = 20
        }

        public enum MotorDrive
        {
            AC,
            DC,
            VFD
        }

        public enum MotorPoles
        {
            MotorPoles2 = 2,
            MotorPoles4 = 4,
            MotorPoles6 = 6,
            MotorPoles8 = 8,
            MotorPoles10 = 10

        }

    }
}
