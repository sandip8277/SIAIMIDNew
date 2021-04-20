using Microsoft.Extensions.Configuration;
using MIDCodeGenerator.Models;
using MIDCodeGenerator.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business
{
    public class MIDCodeGeneratorService
    {
        IMIDCodeGeneratorRepository repository = null;
        private IConfiguration configuration;
        public MIDCodeGeneratorService()
        {
            repository = new MIDCodeGeneratorRepository(configuration);
        }

        public MIDCodeDetails GenerareMIDCodes(string xmlContent)
        {
            MIDCodeDetails codeDetails=repository.GenerareMIDCodes(xmlContent);
            return codeDetails;
        }
    }
}
