using MIDDerivationLibrary.Models.CouplingModels;
using MIDDerivationLibrary.Repository.Coupling;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Coupling
{
    public class Coupling1Service : ICoupling1Service
    {
        private readonly ICoupling1Repository _coupling1Repository;
        public Coupling1Service(ICoupling1Repository coupling1Repository)
        {
            this._coupling1Repository = coupling1Repository;
        }
        public long AddOrUpdateCoupling1Details(string xmlContent)
        {
            long id = 0;
            id = _coupling1Repository.AddOrUpdateCoupling1Details(xmlContent);
            return id;
        }
        public List<Coupling1Details> GetAllCoupling1Details(string componentType, string coupling1Type)
        {
            List<Coupling1Details> detailsList = null;
            detailsList = _coupling1Repository.GetAllCoupling1Details(componentType, coupling1Type);
            return detailsList;
        }
        public Coupling1Details GetCoupling1DetailsById(long id)
        {
            Coupling1Details details = null;
            details = _coupling1Repository.GetCoupling1DetailsById(id);
            return details;
        }
        public long DeleteCoupling1DetailsById(long id)
        {
            id = _coupling1Repository.DeleteCoupling1DetailsById(id);
            return id;
        }
        public bool CheckIsCoupling1DetailsExist(long id)
        {
            bool flag = true;
            Coupling1Details details = null;
            details = _coupling1Repository.GetCoupling1DetailsById(id);
            if (details != null && details.id == 0)
                flag = false;

            return flag;
        }
        public bool CheckIsCoupling1DetailsExist(string xmlContent)
        {
            bool flag = false;
            Coupling1Details details = null;
            details = _coupling1Repository.GetCoupling1Details(xmlContent);

            if (details != null && details.id > 0)
                flag = true;

            return flag;
        }
    }
}
