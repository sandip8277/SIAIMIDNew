using MIDDerivationLibrary.Models.SpecialFaultCodeModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.SpecialFaultCodes
{
    public interface ISpecialFaultCodesRepository
    {
        long AddOrUpdateSpecialFaultCodesDetails(string xml);
        List<SpecialFaultCodesDetails> GetAllSpecialFaultCodesDetails(string specialCode = null, string specialFaultCodesType = null);
        SpecialFaultCodesDetails GetSpecialFaultCodesDetailsById(long id);
        long DeleteSpecialFaultCodesDetailsById(long id);
        SpecialFaultCodesDetails GetSpecialFaultCodesDetails(string xml);
    }
}
