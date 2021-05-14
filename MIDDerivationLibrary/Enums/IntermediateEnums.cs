using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Enums
{
    public class IntermediateEnums
    {
        public enum IntermediateComponentType
        {
            driver = 1,
            coupling = 2,
            intermediate = 3,
            driven = 3
        }

        public enum IntermediateLocations
        {
            location1 = 1,
            location2 = 2,
            location3 = 3,
            location4 = 4,
            location5 = 5,
            location6 = 6,
            location7 = 7,
            location8 = 8,
            location9 = 9,
            location10 = 10,
        }

        public enum IntermediateType
        {
            gearbox = 1,
            aop = 2,
            accdrgr = 3
        }

        public enum IntermediateAOPDrivenBy
        {
            inputshaft = 1,
            intermediateshaft = 2,
            outputshaft = 3
        }

        public enum IntermediateAccDrGrDrivenBy
        {
            inputshaft = 1,
            intermediateshaft = 2,
            outputshaft = 3
        }

    }
}
