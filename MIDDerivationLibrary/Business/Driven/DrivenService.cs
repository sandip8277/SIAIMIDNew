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
            try
            {
                id = _drivenRepository.AddOrUpdateDrivenDetails(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public List<DrivenDetails> GetAllDrivenDetails(string componentType, string drivenType)
        {
            List<DrivenDetails> detailsList = null;
            try
            {
                detailsList = _drivenRepository.GetAllDrivenDetails(componentType, drivenType);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return detailsList;
        }

        public DrivenDetails GetDrivenDetailsById(long id)
        {
            DrivenDetails details = null;
            try
            {
                details = _drivenRepository.GetDrivenDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return details;
        }

        public long DeleteDrivenDetailsById(long id)
        {
            long Id = 0;
            try
            {
                Id = _drivenRepository.DeleteDrivenDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public bool CheckIsDrivenDetailsExist(long id)
        {
            bool flag = true;
            DrivenDetails details = null;
            try
            {
                details = _drivenRepository.GetDrivenDetailsById(id);
                if (details != null && details.id == 0)
                    flag = false;
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return flag;
        }

        public bool CheckIsDrivenDetailsExist(string xmlContent)
        {
            bool flag = false;
            DrivenDetails details = null;
            try
            {
                details = _drivenRepository.GetDrivenDetails(xmlContent);
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
