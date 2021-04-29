using MIDDerivationLibrary.Models.IntermediateModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Intermediate
{
    public interface IIntermediateRepository
    {
        long AddOrUpdateIntermediateDetails(string xml);
        List<IntermediateDetails> GetAllIntermediateDetails(string componentType = null, string intermediateType = null);
        IntermediateDetails GetIntermediateDetailsById(long id);
        long DeleteIntermediateDetailsById(long id);
        IntermediateDetails GetIntermediateDetails(string xml);
    }
}
