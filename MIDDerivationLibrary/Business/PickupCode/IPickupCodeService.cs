using MIDDerivationLibrary.Models.PickupModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.PickupCode
{
    public interface IPickupCodeService
    {
        long AddOrUpdatePickupCodeDetails(string xmlContent);
        List<PickupCodeDetails> GetAllPickupCodeDetails(string componentType, string PickupCodeType);
        PickupCodeDetails GetPickupCodeDetailsById(long id);
        long DeletePickupCodeDetailsById(long id);
        bool CheckIsPickupCodeDetailsExist(long id);
        bool CheckIsPickupCodeDetailsExist(string xmlContent);
    }
}
