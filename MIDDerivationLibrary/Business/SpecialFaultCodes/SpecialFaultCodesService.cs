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
            try
            {
                id = _SpecialFaultCodesRepository.AddOrUpdateSpecialFaultCodesDetails(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public List<SpecialFaultCodesDetails> GetAllSpecialFaultCodesDetails(string specialFaultCodesType, string specialCode)
        {
            List<SpecialFaultCodesDetails> detailsList = null;
            try
            {
                detailsList = _SpecialFaultCodesRepository.GetAllSpecialFaultCodesDetails(specialCode, specialFaultCodesType);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return detailsList;
        }

        public SpecialFaultCodesDetails GetSpecialFaultCodesDetailsById(long id)
        {
            SpecialFaultCodesDetails details = null;
            try
            {
                details = _SpecialFaultCodesRepository.GetSpecialFaultCodesDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return details;
        }

        public long DeleteSpecialFaultCodesDetailsById(long id)
        {
            long Id = 0;
            try
            {
                Id = _SpecialFaultCodesRepository.DeleteSpecialFaultCodesDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public bool CheckIsSpecialFaultCodesDetailsExist(long id)
        {
            bool flag = true;
            SpecialFaultCodesDetails details = null;
            try
            {
                details = _SpecialFaultCodesRepository.GetSpecialFaultCodesDetailsById(id);
                if (details != null && details.id == 0)
                    flag = false;
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return flag;
        }

        public bool CheckIsSpecialFaultCodesDetailsExist(string xmlContent)
        {
            bool flag = false;
            SpecialFaultCodesDetails details = null;
            try
            {
                details = _SpecialFaultCodesRepository.GetSpecialFaultCodesDetails(xmlContent);
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
