using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Driver
{
    public interface IDriverRepository 
    {
        long AddOrUpdateDriverDetails(string xml);
    }
}
