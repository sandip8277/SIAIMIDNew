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
        private readonly ICoupling2Repository _Coupling2Repository;
        public Coupling2Service(ICoupling2Repository Coupling2Repository)
        {
            this._Coupling2Repository = Coupling2Repository;
        }
        public long AddOrUpdateCoupling2Details(string xmlContent)
        {
            long id = 0;
            try
            {
                id = _Coupling2Repository.AddOrUpdateCoupling2Details(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public List<Coupling2Details> GetAllCoupling2Details(string componentType, string Coupling2Type)
        {
            List<Coupling2Details> detailsList = null;
            try
            {
                detailsList = _Coupling2Repository.GetAllCoupling2Details(componentType, Coupling2Type);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return detailsList;
        }

        public Coupling2Details GetCoupling2DetailsById(long id)
        {
            Coupling2Details details = null;
            try
            {
                details = _Coupling2Repository.GetCoupling2DetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return details;
        }

        public long DeleteCoupling2DetailsById(long id)
        {
            long Id = 0;
            try
            {
                Id = _Coupling2Repository.DeleteCoupling2DetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public bool CheckIsCoupling2DetailsExist(long id)
        {
            bool flag = true;
            Coupling2Details details = null;
            try
            {
                details = _Coupling2Repository.GetCoupling2DetailsById(id);
                if (details != null && details.id == 0)
                    flag = false;
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return flag;
        }

        public bool CheckIsCoupling2DetailsExist(string xmlContent)
        {
            bool flag = false;
            Coupling2Details details = null;
            try
            {
                details = _Coupling2Repository.GetCoupling2Details(xmlContent);
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
