using MIDDerivationLibrary.Models.CouplingModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Coupling
{
    public interface ICoupling1Repository
    {
        long AddOrUpdateCoupling1Details(string xml);
        List<Coupling1Details> GetAllCoupling1Details(string componentType = null, string couplingType = null);
        Coupling1Details GetCoupling1DetailsById(long id);
        long DeleteCoupling1DetailsById(long id);
        Coupling1Details GetCoupling1Details(string xml);
    }
}
