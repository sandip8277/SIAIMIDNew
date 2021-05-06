using MIDDerivationLibrary.Models.CSDMdefsModels;
using MIDDerivationLibrary.Repository.CSDMdefs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.CSDMdefs
{
    public class CSDMdefsService : ICSDMdefsService
    {
        private readonly ICSDMdefsRepository _CSDMdefsRepository;
        public CSDMdefsService(ICSDMdefsRepository CSDMdefsRepository)
        {
            this._CSDMdefsRepository = CSDMdefsRepository;
        }
        public long AddOrUpdateCSDMdefsDetails(string xmlContent)
        {
            long id = 0;
            try
            {
                id = _CSDMdefsRepository.AddOrUpdateCSDMdefsDetails(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public List<CSDMdefsDetails> GetAllCSDMdefsDetails(string csdmfile)
        {
            List<CSDMdefsDetails> detailsList = null;
            try
            {
                detailsList = _CSDMdefsRepository.GetAllCSDMdefsDetails(csdmfile);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return detailsList;
        }

        public CSDMdefsDetails GetCSDMdefsDetailsById(long id)
        {
            CSDMdefsDetails details = null;
            try
            {
                details = _CSDMdefsRepository.GetCSDMdefsDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return details;
        }

        public long DeleteCSDMdefsDetailsById(long id)
        {
            long Id = 0;
            try
            {
                Id = _CSDMdefsRepository.DeleteCSDMdefsDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public bool CheckIsCSDMdefsDetailsExist(long id)
        {
            bool flag = true;
            CSDMdefsDetails details = null;
            try
            {
                details = _CSDMdefsRepository.GetCSDMdefsDetailsById(id);
                if (details != null && details.id == 0)
                    flag = false;
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return flag;
        }

        public bool CheckIsCSDMdefsDetailsExist(string xmlContent)
        {
            bool flag = false;
            CSDMdefsDetails details = null;
            try
            {
                details = _CSDMdefsRepository.GetCSDMdefsDetails(xmlContent);
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
