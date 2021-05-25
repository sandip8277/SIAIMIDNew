using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.MIDCodeDeconstruction
{
    public interface IMIDCodeDeconstructionRepository
    {
        Models.MachineComponentsForMIDgeneration MIDCodeDeconstruction(string xml);
    }
}
