using MIDDerivationLibrary.Models.DriverModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Driver
{
    public interface IDriverService
    {
        long AddOrUpdateDriverDetails(string xmlContent);
        List<DriverDetails> GetAllDriverDetails(string componentType, string driverType);
        DriverDetails GetDriverDetailsById(long id);
    }
}
