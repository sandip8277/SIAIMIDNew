using MIDDerivationLibrary.Models.CodeDeconstructionModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.MIDCodeDeconstruction
{
    public interface IMIDCodeDeconstructionService
    {
        MIDdeconstrutionResponse MIDCodeDeconstruction(string xmlContent);
    }
}
