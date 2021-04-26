using MIDDerivationLibrary.Repository.Driven;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Business.Driven
{
    public class DrivenService : IDrivenService
    {
        private readonly IDrivenRepository _drivenRepository;
        public DrivenService(IDrivenRepository drivenRepository)
        {
            this._drivenRepository = drivenRepository;
        }
        public long AddOrUpdateDrivenDetails(string xmlContent)
        {
            long id = 0;
            try
            {
                id = _drivenRepository.AddOrUpdateDrivenDetails(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }
    }
}
