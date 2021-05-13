using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Enums
{
    public class Coupling2Enums
    {
        public enum Coupling2ComponentType
        {
            driver = 1,
            coupling = 2,
            intermediate = 3,
            driven = 3
        }

        public enum Coupling2CouplingPosition
        {
            Position1 = 1,
            Position2 = 2
        }

        public enum Coupling2CouplingType
        {
            none_rigid = 1,
            beltdrive = 2,
            chaindrive = 3,
            magnetic = 4,
            flexible = 5
        }
    }
}
