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
        private readonly IMIDCodeGeneratorRepository _MIDCodeGeneratorRepository;
        public MIDCodeGeneratorService(IMIDCodeGeneratorRepository MIDCodeGeneratorRepository)
        {
            this._MIDCodeGeneratorRepository = MIDCodeGeneratorRepository;
        }

        public MIDCodeDetails GenerareMIDCodes(string xmlContent)
        {
            MIDCodeDetails codeDetails = null;
            try
            {
                 codeDetails = _MIDCodeGeneratorRepository.GenerareMIDCodes(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return codeDetails;
        }
    }
}
