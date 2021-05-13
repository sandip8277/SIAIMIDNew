using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Enums
{
    public class Coupling1Enums
    {
        public enum Coupling1ComponentType
        {
            driver = 1,
            coupling = 2,
            intermediate = 3,
            driven = 3
        }

        public enum Coupling1CouplingPosition
        {
            Position1 = 1,
            Position2 = 2
        }

        public enum Coupling1CouplingType
        {
            none_rigid = 1,
            beltdrive = 2,
            chaindrive = 3,
            magnetic = 4,
            flexible = 5,
            fluid = 6
        }
    }
}
