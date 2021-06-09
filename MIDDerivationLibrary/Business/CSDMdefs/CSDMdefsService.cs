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
            id = _csdMdefsRepository.AddOrUpdateCSDMdefsDetails(xmlContent);
            return id;
        }
        public List<CSDMdefsDetails> GetAllCSDMdefsDetails(string csdmFile)
        {
            List<CSDMdefsDetails> detailsList = null;
            detailsList = _csdMdefsRepository.GetAllCSDMdefsDetails(csdmFile);
            return detailsList;
        }
        public CSDMdefsDetails GetCSDMdefsDetailsById(long id)
        {
            CSDMdefsDetails details = null;
            details = _csdMdefsRepository.GetCSDMdefsDetailsById(id);
            return details;
        }
        public long DeleteCSDMdefsDetailsById(long id)
        {
            id = _csdMdefsRepository.DeleteCSDMdefsDetailsById(id);
            return id;
        }
        public bool CheckIsCSDMdefsDetailsExist(long id)
        {
            bool flag = true;
            CSDMdefsDetails details = null;
            details = _csdMdefsRepository.GetCSDMdefsDetailsById(id);
            if (details != null && details.id == 0)
                flag = false;

            return flag;
        }
        public bool CheckIsCSDMdefsDetailsExist(string xmlContent)
        {
            bool flag = false;
            CSDMdefsDetails details = null;
            details = _csdMdefsRepository.GetCSDMdefsDetails(xmlContent);
            if (details != null && details.id > 0)
                flag = true;

            return flag;
        }
    }
}
