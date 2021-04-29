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
            try
            {
                id = _driverRepository.AddOrUpdateDriverDetails(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public List<DriverDetails> GetAllDriverDetails(string componentType, string driverType)
        {
            List<DriverDetails> detailsList = null;
            try
            {
                detailsList = _driverRepository.GetAllDriverDetails(componentType, driverType);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return detailsList;
        }

        public DriverDetails GetDriverDetailsById(long id)
        {
            DriverDetails details = null;
            try
            {
                details = _driverRepository.GetDriverDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return details;
        }

        public long DeleteDriverDetailsById(long id)
        {
            long Id = 0;
            try
            {
                Id = _driverRepository.DeleteDriverDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public bool CheckIsDriverDetailsExist(long id)
        {
            bool flag = true;
            DriverDetails details = null;
            try
            {
                details = _driverRepository.GetDriverDetailsById(id);
                if (details != null && details.id == 0)
                    flag = false;
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return flag;
        }

        public bool CheckIsDriverDetailsExist(string xmlContent)
        {
            bool flag = false;
            DriverDetails details = null;
            try
            {
                details = _driverRepository.GetDriverDetails(xmlContent);
                if (details != null && details.id > 0)
                    flag = true;
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return flag;
        }

    }
}
