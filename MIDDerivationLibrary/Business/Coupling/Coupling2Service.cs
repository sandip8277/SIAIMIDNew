using MIDDerivationLibrary.Models.CouplingModels;
using MIDDerivationLibrary.Repository.Coupling;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Coupling
{
    public class Coupling2Service : ICoupling2Service
    {
        private readonly ICoupling2Repository _coupling2Repository;
        public Coupling2Service(ICoupling2Repository coupling2Repository)
        {
            this._coupling2Repository = coupling2Repository;
        }
        public long AddOrUpdateCoupling2Details(string xmlContent)
        {
            long id = 0;
            id = _coupling2Repository.AddOrUpdateCoupling2Details(xmlContent);
            return id;
        }
        public List<Coupling2Details> GetAllCoupling2Details(string componentType, string coupling2Type)
        {
            List<Coupling2Details> detailsList = null;
            detailsList = _coupling2Repository.GetAllCoupling2Details(componentType, coupling2Type);
            return detailsList;
        }
        public Coupling2Details GetCoupling2DetailsById(long id)
        {
            Coupling2Details details = null;
            details = _coupling2Repository.GetCoupling2DetailsById(id);
            return details;
        }
        public long DeleteCoupling2DetailsById(long id)
        {
            id = _coupling2Repository.DeleteCoupling2DetailsById(id);
            return id;
        }
        public bool CheckIsCoupling2DetailsExist(long id)
        {
            bool flag = true;
            Coupling2Details details = null;
            details = _coupling2Repository.GetCoupling2DetailsById(id);
            if (details != null && details.id == 0)
                flag = false;

            return flag;
        }
        public bool CheckIsCoupling2DetailsExist(string xmlContent)
        {
            bool flag = false;
            Coupling2Details details = null;
            details = _coupling2Repository.GetCoupling2Details(xmlContent);
            if (details != null && details.id > 0)
                flag = true;

            return flag;
        }
    }
}
