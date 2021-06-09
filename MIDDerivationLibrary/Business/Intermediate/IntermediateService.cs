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
            id = _intermediateRepository.AddOrUpdateIntermediateDetails(xmlContent);

            return id;
        }
        public List<IntermediateDetails> GetAllIntermediateDetails(string componentType, string intermediateType)
        {
            List<IntermediateDetails> detailsList = null;
            detailsList = _intermediateRepository.GetAllIntermediateDetails(componentType, intermediateType);
            return detailsList;
        }
        public IntermediateDetails GetIntermediateDetailsById(long id)
        {
            IntermediateDetails details = null;
            details = _intermediateRepository.GetIntermediateDetailsById(id);
            return details;
        }
        public long DeleteIntermediateDetailsById(long id)
        {
            id = _intermediateRepository.DeleteIntermediateDetailsById(id);
            return id;
        }
        public bool CheckIsIntermediateDetailsExist(long id)
        {
            bool flag = true;
            IntermediateDetails details = null;
            details = _intermediateRepository.GetIntermediateDetailsById(id);
            if (details != null && details.id == 0)
                flag = false;

            return flag;
        }
        public bool CheckIsIntermediateDetailsExist(string xmlContent)
        {
            bool flag = false;
            IntermediateDetails details = null;
            details = _intermediateRepository.GetIntermediateDetails(xmlContent);
            if (details != null && details.id > 0)
                flag = true;

            return flag;
        }
    }
}
