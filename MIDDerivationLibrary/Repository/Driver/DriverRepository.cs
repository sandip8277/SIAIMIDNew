using Microsoft.VisualBasic;
using MIDDerivationLibrary.Models.DriverModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Driver
{
    public class DriverRepository : IDriverRepository
    {
        private readonly ISQLRepository sqlRepository;

        public DriverRepository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }
        public long AddOrUpdateDriverDetails(string xml)
        {
            long id = 0;
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.saveDriver; 
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

        public DriverDetails GetDriverDetails(string xml)
        {
            DriverDetails details = new DriverDetails();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.getDriverDetails;
                List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml) };
                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);

                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    var FaultCodeData = result.Tables[0].Rows[0][0].ToString();
                        //.AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "FaultCodeMatrix").FirstOrDefault();
                    
                    if (FaultCodeData != null)
                    {
                        var FaultCodeMatrixJsonString = FaultCodeData[4].ToString();
                        if (!string.IsNullOrEmpty(FaultCodeMatrixJsonString))
                        {
                            //details.FaultCodeMatrix = JsonConvert.DeserializeObject<FaultCodeMatrix>(FaultCodeMatrixJsonString);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
                return null;
            }
            return details;
        }
    }

}
