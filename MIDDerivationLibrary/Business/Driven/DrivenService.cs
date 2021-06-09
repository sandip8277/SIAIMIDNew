using MIDDerivationLibrary.Models.DrivenModels;
using MIDDerivationLibrary.Repository.Driven;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Driven
{
    public class DrivenService : IDrivenService
    {
        private readonly IDrivenRepository _drivenRepository;
        public DrivenService(IDrivenRepository drivenRepository)
        {
            this._drivenRepository = drivenRepository;
        }
        public long AddOrUpdateDrivenDetails(string xmlContent)
        {
            long id = 0;
            id = _drivenRepository.AddOrUpdateDrivenDetails(xmlContent);
            return id;
        }
        public List<DrivenDetails> GetAllDrivenDetails(string componentType, string drivenType)
        {
            List<DrivenDetails> detailsList = null;
            detailsList = _drivenRepository.GetAllDrivenDetails(componentType, drivenType);
            return detailsList;
        }
        public DrivenDetails GetDrivenDetailsById(long id)
        {
            DrivenDetails details = null;
            details = _drivenRepository.GetDrivenDetailsById(id);
            return details;
        }
        public long DeleteDrivenDetailsById(long id)
        {
            id = _drivenRepository.DeleteDrivenDetailsById(id);
            return id;
        }
        public bool CheckIsDrivenDetailsExist(long id)
        {
            bool flag = true;
            DrivenDetails details = null;
            details = _drivenRepository.GetDrivenDetailsById(id);
            if (details != null && details.id == 0)
                flag = false;

            return flag;
        }
        public bool CheckIsDrivenDetailsExist(string xmlContent)
        {
            bool flag = false;
            DrivenDetails details = null;
            details = _drivenRepository.GetDrivenDetails(xmlContent);
            if (details != null && details.id > 0)
                flag = true;

            return flag;
        }
    }
}
