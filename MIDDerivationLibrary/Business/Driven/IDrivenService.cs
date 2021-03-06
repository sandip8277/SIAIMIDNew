using MIDDerivationLibrary.Models.DrivenModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Driven
{
    public interface IDrivenService
    {
        long AddOrUpdateDrivenDetails(string xmlContent);
        List<DrivenDetails> GetAllDrivenDetails(string componentType, string drivenType);
        DrivenDetails GetDrivenDetailsById(long id);
        long DeleteDrivenDetailsById(long id);
        bool CheckIsDrivenDetailsExist(long id);
        bool CheckIsDrivenDetailsExist(string xmlContent);
    }
}
