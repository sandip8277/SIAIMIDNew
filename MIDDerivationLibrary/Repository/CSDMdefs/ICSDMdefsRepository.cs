using MIDDerivationLibrary.Models.CSDMdefsModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.CSDMdefs
{
    public interface ICSDMdefsRepository
    {
        long AddOrUpdateCSDMdefsDetails(string xml);
        List<CSDMdefsDetails> GetAllCSDMdefsDetails(string csdmfile = null);
        CSDMdefsDetails GetCSDMdefsDetailsById(long id);
        long DeleteCSDMdefsDetailsById(long id);
        CSDMdefsDetails GetCSDMdefsDetails(string xml);
    }
}
