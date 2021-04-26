using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Driven
{
    public interface IDrivenService
    {
        long AddOrUpdateDrivenDetails(string xmlContent);
    }
}
