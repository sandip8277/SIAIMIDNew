using MIDCodeGenerator.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business
{
    public interface IMIDCodeGeneratorService
    {
        public MIDCodeDetails GenerareMIDCodes(string xmlContent);
    }
}
