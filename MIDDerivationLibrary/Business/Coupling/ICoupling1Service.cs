using MIDDerivationLibrary.Models.CouplingModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Coupling
{
    public interface ICoupling1Service
    {
        long AddOrUpdateCoupling1Details(string xmlContent);
        List<Coupling1Details> GetAllCoupling1Details(string componentType, string Coupling1Type);
        Coupling1Details GetCoupling1DetailsById(long id);
        long DeleteCoupling1DetailsById(long id);
        bool CheckIsCoupling1DetailsExist(long id);
        bool CheckIsCoupling1DetailsExist(string xmlContent);
    }
}
