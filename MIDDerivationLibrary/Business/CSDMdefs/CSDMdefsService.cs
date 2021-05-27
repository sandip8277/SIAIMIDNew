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
        private readonly ICSDMdefsRepository _csdMdefsRepository;
        public CSDMdefsService(ICSDMdefsRepository csdMdefsRepository)
        {
            this._csdMdefsRepository = csdMdefsRepository;
        }
        public long AddOrUpdateCSDMdefsDetails(string xmlContent)
        {
            long id = 0;
            try
            {
                id = _csdMdefsRepository.AddOrUpdateCSDMdefsDetails(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public List<CSDMdefsDetails> GetAllCSDMdefsDetails(string csdmFile)
        {
            List<CSDMdefsDetails> detailsList = null;
            try
            {
                detailsList = _csdMdefsRepository.GetAllCSDMdefsDetails(csdmFile);
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
                details = _csdMdefsRepository.GetCSDMdefsDetailsById(id);
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
                Id = _csdMdefsRepository.DeleteCSDMdefsDetailsById(id);
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
                details = _csdMdefsRepository.GetCSDMdefsDetailsById(id);
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
                details = _csdMdefsRepository.GetCSDMdefsDetails(xmlContent);
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
