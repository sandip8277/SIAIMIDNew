using MIDDerivationLibrary.Repository.Driver;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Driver
{
    public class DriverService : IDriverService
    {
        private readonly IDriverRepository _driverRepository;
        public DriverService(IDriverRepository driverRepository)
        {
            this._driverRepository = driverRepository;
        }
        public long AddDriverDetails(string xmlContent)
        {
            long id = 0;
            try
            {
                id = _driverRepository.AddDriverDetails(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }
    }
}
