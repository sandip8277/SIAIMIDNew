using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Driven
{
    public class DrivenRepository : IDrivenRepository
    {
        private readonly ISQLRepository sqlRepository;

        public DrivenRepository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }
        public long AddOrUpdateDrivenDetails(string xml)
        {
            long id = 0;
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.saveDriven;
                List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml) };
                id = sqlRepository.ExecuteNonQuery(spName, allParams);
            }
            catch (Exception ex)
            {
                ex.ToString();
                return 0;
            }
            return id;
        }
    }

}
