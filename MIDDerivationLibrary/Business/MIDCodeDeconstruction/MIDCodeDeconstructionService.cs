using MIDDerivationLibrary.Models.CodeDeconstructionModels;
using MIDDerivationLibrary.Repository.MIDCodeDeconstruction;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.MIDCodeDeconstruction
{
    public class MIDCodeDeconstructionService : IMIDCodeDeconstructionService
    {
        private readonly IMIDCodeDeconstructionRepository _midCodeDeconstructionRepository;
        public MIDCodeDeconstructionService(IMIDCodeDeconstructionRepository midCodeDeconstructionRepository)
        {
            this._midCodeDeconstructionRepository = midCodeDeconstructionRepository;
        }

        public MIDdeconstrutionResponse MIDCodeDeconstruction(string xmlContent)
        {
            MIDdeconstrutionResponse codeDetails = null;
            codeDetails = _midCodeDeconstructionRepository.MIDCodeDeconstruction(xmlContent);
            return codeDetails;
        }
    }
}
