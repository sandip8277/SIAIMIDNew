using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Driver
{
    public interface IDriverService
    {
        long AddDriverDetails(string xmlContent);
    }
}
