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
        public Coupling1Service(ICoupling1Repository Coupling1Repository)
        {
            this._coupling1Repository = Coupling1Repository;
        }
        public long AddOrUpdateCoupling1Details(string xmlContent)
        {
            long id = 0;
            try
            {
                id = _coupling1Repository.AddOrUpdateCoupling1Details(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public List<Coupling1Details> GetAllCoupling1Details(string componentType, string Coupling1Type)
        {
            List<Coupling1Details> detailsList = null;
            try
            {
                detailsList = _coupling1Repository.GetAllCoupling1Details(componentType, Coupling1Type);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return detailsList;
        }

        public Coupling1Details GetCoupling1DetailsById(long id)
        {
            Coupling1Details details = null;
            try
            {
                details = _coupling1Repository.GetCoupling1DetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return details;
        }

        public long DeleteCoupling1DetailsById(long id)
        {
            long Id = 0;
            try
            {
                Id = _coupling1Repository.DeleteCoupling1DetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public bool CheckIsCoupling1DetailsExist(long id)
        {
            bool flag = true;
            Coupling1Details details = null;
            try
            {
                details = _coupling1Repository.GetCoupling1DetailsById(id);
                if (details != null && details.id == 0)
                    flag = false;
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return flag;
        }

        public bool CheckIsCoupling1DetailsExist(string xmlContent)
        {
            bool flag = false;
            Coupling1Details details = null;
            try
            {
                details = _coupling1Repository.GetCoupling1Details(xmlContent);
                if (details != null && details.id > 0)
                    flag = true;
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return flag;
        }
    }
}
