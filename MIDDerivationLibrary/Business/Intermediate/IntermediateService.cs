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
            try
            {
                //id = _intermediateRepository.AddOrUpdateDriverDetails(xmlContent);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }

        public List<IntermediateDetails> GetAllIntermediateDetails(string componentType, string driverType)
        {
            List<IntermediateDetails> detailsList = null;
            try
            {
                //detailsList = _driverRepository.GetAllIntermediateDetails(componentType, driverType);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return detailsList;
        }

        public IntermediateDetails GetDriverDetailsById(long id)
        {
            IntermediateDetails details = null;
            try
            {
               // details = _driverRepository.GetDriverDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return details;
        }

        public long DeleteDriverDetailsById(long id)
        {
            long Id = 0;
            try
            {
                //Id = _driverRepository.DeleteDriverDetailsById(id);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return id;
        }
    }
}
