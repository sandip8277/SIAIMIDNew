using Microsoft.Extensions.Configuration;
using MIDCodeGenerator.Models;
using MIDCodeGenerator.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business
{
    public class MIDCodeGeneratorService : IMIDCodeGeneratorService
    {
        private readonly IMIDCodeGeneratorRepository _midCodeGeneratorRepository;
        public MIDCodeGeneratorService(IMIDCodeGeneratorRepository midCodeGeneratorRepository)
        {
            this._midCodeGeneratorRepository = midCodeGeneratorRepository;
        }

        public MIDCodeDetails GenerareMIDCodes(string xmlContent)
        {
            MIDCodeDetails codeDetails = null;
            try
            {
                 codeDetails = _midCodeGeneratorRepository.GenerareMIDCodes(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return codeDetails;
        }
    }
}
