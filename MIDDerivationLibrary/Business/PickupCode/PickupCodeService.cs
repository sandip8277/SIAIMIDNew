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
            id = _pickupRepository.AddOrUpdatePickupCodeDetails(xmlContent);
            return id;
        }
        public List<PickupCodeDetails> GetAllPickupCodeDetails()
        {
            List<PickupCodeDetails> detailsList = null;
            detailsList = _pickupRepository.GetAllPickupCodeDetails();
            return detailsList;
        }
        public PickupCodeDetails GetPickupCodeDetailsById(long id)
        {
            PickupCodeDetails details = null;
            details = _pickupRepository.GetPickupCodeDetailsById(id);
            return details;
        }
        public long DeletePickupCodeDetailsById(long id)
        {
            id = _pickupRepository.DeletePickupCodeDetailsById(id);
            return id;
        }
        public bool CheckIsPickupCodeDetailsExist(long id)
        {
            bool flag = true;
            PickupCodeDetails details = null;
            details = _pickupRepository.GetPickupCodeDetailsById(id);
            if (details != null && details.id == 0)
                flag = false;

            return flag;
        }
        public bool CheckIsPickupCodeDetailsExist(string xmlContent)
        {
            bool flag = false;
            PickupCodeDetails details = null;
            details = _pickupRepository.GetPickupCodeDetails(xmlContent);
            if (details != null && details.id > 0)
                flag = true;
            
            return flag;
        }
    }
}
