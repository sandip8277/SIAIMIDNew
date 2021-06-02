using MIDDerivationLibrary.Models.CodeDeconstructionModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.MIDCodeDeconstruction
{
    public interface IMIDCodeDeconstructionRepository
    {
        MIDdeconstrutionResponse MIDCodeDeconstruction(string xml);
    }
}
