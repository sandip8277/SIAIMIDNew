using MIDDerivationLibrary.Models.CouplingModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Coupling
{
    public interface ICoupling2Service
    {
        long AddOrUpdateCoupling2Details(string xmlContent);
        List<Coupling2Details> GetAllCoupling2Details(string componentType, string Coupling2Type);
        Coupling2Details GetCoupling2DetailsById(long id);
        long DeleteCoupling2DetailsById(long id);
        bool CheckIsCoupling2DetailsExist(long id);
        bool CheckIsCoupling2DetailsExist(string xmlContent);
    }
}
