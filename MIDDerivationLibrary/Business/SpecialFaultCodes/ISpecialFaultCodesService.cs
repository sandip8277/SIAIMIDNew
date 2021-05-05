using MIDDerivationLibrary.Models.SpecialFaultCodeModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.SpecialFaultCodes
{
    public interface ISpecialFaultCodesService
    {
        long AddOrUpdateSpecialFaultCodesDetails(string xmlContent);
        List<SpecialFaultCodesDetails> GetAllSpecialFaultCodesDetails(string specialFaultCodesType, string specialcode);
        SpecialFaultCodesDetails GetSpecialFaultCodesDetailsById(long id);
        long DeleteSpecialFaultCodesDetailsById(long id);
        bool CheckIsSpecialFaultCodesDetailsExist(long id);
        bool CheckIsSpecialFaultCodesDetailsExist(string xmlContent);
    }
}
