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

        public Models.MachineComponentsForMIDgeneration MIDCodeDeconstruction(string xmlContent)
        {
            Models.MachineComponentsForMIDgeneration codeDetails = null;
            try
            {
                codeDetails = _midCodeDeconstructionRepository.MIDCodeDeconstruction(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return codeDetails;
        }
    }
}
