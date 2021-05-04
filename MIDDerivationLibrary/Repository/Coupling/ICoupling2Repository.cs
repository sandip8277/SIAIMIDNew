using MIDDerivationLibrary.Models.CouplingModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Coupling
{
    public interface ICoupling2Repository
    {
        long AddOrUpdateCoupling2Details(string xml);
        List<Coupling2Details> GetAllCoupling2Details(string componentType = null, string couplingType = null);
        Coupling2Details GetCoupling2DetailsById(long id);
        long DeleteCoupling2DetailsById(long id);
        Coupling2Details GetCoupling2Details(string xml);
    }
}
