using MIDDerivationLibrary.Models.IntermediateModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Intermediate
{
    public interface IIntermediateService 
    {
        long AddOrUpdateIntermediateDetails(string xmlContent);
        List<IntermediateDetails> GetAllIntermediateDetails(string componentType, string intermediateType);
        IntermediateDetails GetIntermediateDetailsById(long id);
        long DeleteIntermediateDetailsById(long id);
        bool CheckIsIntermediateDetailsExist(long id);
        bool CheckIsIntermediateDetailsExist(string xmlContent);
    }
}
