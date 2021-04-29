using MIDDerivationLibrary.Models.IntermediateModels;
using MIDDerivationLibrary.Repository.Intermediate;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Intermediate
{
    public class IntermediateService : IIntermediateService
    {
        private readonly IIntermediateRepository _intermediateRepository;
        public IntermediateService(IIntermediateRepository intermediateRepository)
        {
            this._intermediateRepository = intermediateRepository;
        }
        public long AddOrUpdateIntermediateDetails(string xmlContent)
        {
            long id = 0;
            try
            {
                id = _intermediateRepository.AddOrUpdateIntermediateDetails(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public List<IntermediateDetails> GetAllIntermediateDetails(string componentType, string intermediateType)
        {
            List<IntermediateDetails> detailsList = null;
            try
            {
                detailsList = _intermediateRepository.GetAllIntermediateDetails(componentType, intermediateType);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return detailsList;
        }

        public IntermediateDetails GetIntermediateDetailsById(long id)
        {
            IntermediateDetails details = null;
            try
            {
                details = _intermediateRepository.GetIntermediateDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return details;
        }

        public long DeleteIntermediateDetailsById(long id)
        {
            long Id = 0;
            try
            {
                Id = _intermediateRepository.DeleteIntermediateDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public bool CheckIsIntermediateDetailsExist(long id)
        {
            bool flag = true;
            IntermediateDetails details = null;
            try
            {
                details = _intermediateRepository.GetIntermediateDetailsById(id);
                if (details != null && details.id == 0)
                    flag = false;
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return flag;
        }

        public bool CheckIsIntermediateDetailsExist(string xmlContent)
        {
            bool flag = false;
            IntermediateDetails details = null;
            try
            {
                details = _intermediateRepository.GetIntermediateDetails(xmlContent);
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
