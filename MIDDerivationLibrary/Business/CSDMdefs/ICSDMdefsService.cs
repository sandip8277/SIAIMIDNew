using MIDDerivationLibrary.Models.CSDMdefsModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.CSDMdefs
{
    public interface ICSDMdefsService
    {
        long AddOrUpdateCSDMdefsDetails(string xmlContent);
        List<CSDMdefsDetails> GetAllCSDMdefsDetails(string csdmfile);
        CSDMdefsDetails GetCSDMdefsDetailsById(long id);
        bool CheckIsCSDMdefsDetailsExist(long id);
        bool CheckIsCSDMdefsDetailsExist(string xmlContent);

        long DeleteCSDMdefsDetailsById(long id);
    }
}
