using MIDDerivationLibrary.Models.DriverModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Driver
{
    public interface IDriverRepository 
    {
        long AddOrUpdateDriverDetails(string xml);
        List<DriverDetails> GetAllDriverDetails(string componentType, string driverType);
        DriverDetails GetDriverDetailsById(long id);
        long DeleteDriverDetailsById(long id);
        DriverDetails GetDriverDetails(string xml);
    }
}
