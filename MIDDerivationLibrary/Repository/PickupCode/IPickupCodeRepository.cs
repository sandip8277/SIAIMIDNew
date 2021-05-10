using MIDDerivationLibrary.Models.PickupModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.PickupCode
{
    public interface IPickupCodeRepository
    {
        long AddOrUpdatePickupCodeDetails(string xml);
        List<PickupCodeDetails> GetAllPickupCodeDetails(string componentType = null, string PickupCodeType = null);
        PickupCodeDetails GetPickupCodeDetailsById(long id);
        long DeletePickupCodeDetailsById(long id);
        PickupCodeDetails GetPickupCodeDetails(string xml);
    }
}
