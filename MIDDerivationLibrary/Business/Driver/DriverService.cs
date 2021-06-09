using MIDDerivationLibrary.Models.DriverModels;
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
        public long AddOrUpdateDriverDetails(string xmlContent)
        {
            long id = 0;
            id = _driverRepository.AddOrUpdateDriverDetails(xmlContent);
            return id;
        }
        public List<DriverDetails> GetAllDriverDetails(string componentType, string driverType)
        {
            List<DriverDetails> detailsList = null;
            detailsList = _driverRepository.GetAllDriverDetails(componentType, driverType);
            return detailsList;
        }
        public DriverDetails GetDriverDetailsById(long id)
        {
            DriverDetails details = null;
            details = _driverRepository.GetDriverDetailsById(id);
            return details;
        }
        public long DeleteDriverDetailsById(long id)
        {
            id = _driverRepository.DeleteDriverDetailsById(id);
            return id;
        }
        public bool CheckIsDriverDetailsExist(long id)
        {
            bool flag = true;
            DriverDetails details = null;
            details = _driverRepository.GetDriverDetailsById(id);
            if (details != null && details.id == 0)
                flag = false;

            return flag;
        }
        public bool CheckIsDriverDetailsExist(string xmlContent)
        {
            bool flag = false;
            DriverDetails details = null;
            details = _driverRepository.GetDriverDetails(xmlContent);
            if (details != null && details.id > 0)
                flag = true;

            return flag;
        }
    }
}
