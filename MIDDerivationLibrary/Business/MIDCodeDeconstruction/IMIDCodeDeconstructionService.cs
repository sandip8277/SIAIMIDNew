using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.MIDCodeDeconstruction
{
    public interface IMIDCodeDeconstructionService
    {
        Models.MachineComponentsForMIDgeneration MIDCodeDeconstruction(string xmlContent);
    }
}
