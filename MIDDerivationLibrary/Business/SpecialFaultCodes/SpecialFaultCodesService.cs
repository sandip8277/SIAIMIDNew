using MIDDerivationLibrary.Models.SpecialFaultCodeModels;
using MIDDerivationLibrary.Repository.SpecialFaultCodes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.SpecialFaultCodes
{
    public class SpecialFaultCodesService : ISpecialFaultCodesService
    {
        private readonly ISpecialFaultCodesRepository _SpecialFaultCodesRepository;
        public SpecialFaultCodesService(ISpecialFaultCodesRepository SpecialFaultCodesRepository)
        {
            this._SpecialFaultCodesRepository = SpecialFaultCodesRepository;
        }
        public long AddOrUpdateSpecialFaultCodesDetails(string xmlContent)
        {
            long id = 0;
            id = _SpecialFaultCodesRepository.AddOrUpdateSpecialFaultCodesDetails(xmlContent);
            return id;
        }
        public List<SpecialFaultCodesDetails> GetAllSpecialFaultCodesDetails(string specialFaultCodesType, string specialCode)
        {
            List<SpecialFaultCodesDetails> detailsList = null;
            detailsList = _SpecialFaultCodesRepository.GetAllSpecialFaultCodesDetails(specialCode, specialFaultCodesType);
            return detailsList;
        }
        public SpecialFaultCodesDetails GetSpecialFaultCodesDetailsById(long id)
        {
            SpecialFaultCodesDetails details = null;
            details = _SpecialFaultCodesRepository.GetSpecialFaultCodesDetailsById(id);
            return details;
        }
        public long DeleteSpecialFaultCodesDetailsById(long id)
        {
            id = _SpecialFaultCodesRepository.DeleteSpecialFaultCodesDetailsById(id);
            return id;
        }
        public bool CheckIsSpecialFaultCodesDetailsExist(long id)
        {
            bool flag = true;
            SpecialFaultCodesDetails details = null;
            details = _SpecialFaultCodesRepository.GetSpecialFaultCodesDetailsById(id);
            if (details != null && details.id == 0)
                flag = false;

            return flag;
        }

        public bool CheckIsSpecialFaultCodesDetailsExist(string xmlContent)
        {
            bool flag = false;
            SpecialFaultCodesDetails details = null;
            details = _SpecialFaultCodesRepository.GetSpecialFaultCodesDetails(xmlContent);
            if (details != null && details.id > 0)
                flag = true;

            return flag;
        }
    }
}
