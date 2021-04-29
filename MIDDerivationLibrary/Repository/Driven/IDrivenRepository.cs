using MIDDerivationLibrary.Models.DrivenModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Driven
{
    public interface IDrivenRepository
    {
        long AddOrUpdateDrivenDetails(string xml);
        List<DrivenDetails> GetAllDrivenDetails(string componentType, string driverType);
        DrivenDetails GetDrivenDetailsById(long id);
        long DeleteDrivenDetailsById(long id);
        DrivenDetails GetDrivenDetails(string xml);
    }
}
