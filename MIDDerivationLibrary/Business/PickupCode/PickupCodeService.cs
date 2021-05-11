using MIDDerivationLibrary.Models.PickupModels;
using MIDDerivationLibrary.Repository.PickupCode;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.PickupCode
{
    public class PickupCodeService : IPickupCodeService
    {
        private readonly IPickupCodeRepository _pickupRepository;
        public PickupCodeService(IPickupCodeRepository pickupRepository)
        {
            this._pickupRepository = pickupRepository;
        }
        public long AddOrUpdatePickupCodeDetails(string xmlContent)
        {
            long id = 0;
            try
            {
                id = _pickupRepository.AddOrUpdatePickupCodeDetails(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public List<PickupCodeDetails> GetAllPickupCodeDetails()
        {
            List<PickupCodeDetails> detailsList = null;
            try
            {
                detailsList = _pickupRepository.GetAllPickupCodeDetails();
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return detailsList;
        }

        public PickupCodeDetails GetPickupCodeDetailsById(long id)
        {
            PickupCodeDetails details = null;
            try
            {
                details = _pickupRepository.GetPickupCodeDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return details;
        }

        public long DeletePickupCodeDetailsById(long id)
        {
            long Id = 0;
            try
            {
                Id = _pickupRepository.DeletePickupCodeDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public bool CheckIsPickupCodeDetailsExist(long id)
        {
            bool flag = true;
            PickupCodeDetails details = null;
            try
            {
                details = _pickupRepository.GetPickupCodeDetailsById(id);
                if (details != null && details.id == 0)
                    flag = false;
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return flag;
        }

        public bool CheckIsPickupCodeDetailsExist(string xmlContent)
        {
            bool flag = false;
            PickupCodeDetails details = null;
            try
            {
                details = _pickupRepository.GetPickupCodeDetails(xmlContent);
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
