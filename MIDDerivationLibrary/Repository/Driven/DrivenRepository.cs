using MIDDerivationLibrary.Models.DrivenModels;
using System;
using System.Collections.Generic;
using System.Data;
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

        public List<DrivenDetails> GetAllDrivenDetails(string componentType, string driverType)
        {
            List<DrivenDetails> detailsLst = new List<DrivenDetails>();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.getAllDriverDetails;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.componentType}", componentType),
                  new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.driverType}", driverType)};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    var FaultCodeData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "FaultCodeMatrix").FirstOrDefault();
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
            return detailsLst;
        }

        public DrivenDetails GetDrivenDetailsById(long id)
        {
            DrivenDetails details = new DrivenDetails();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.getAllDriverDetails;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id)};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    var FaultCodeData = result.Tables[0].AsEnumerable().ToList().Where(x => x.Field<string>("Component") == "FaultCodeMatrix").FirstOrDefault();
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

        public long DeleteDrivenDetailsById(long id)
        {
            long Id = 0;
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.saveDriver;
                List<SqlParameter> allParams = new List<SqlParameter>() { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id) };
                id = sqlRepository.ExecuteNonQuery(spName, allParams);
            }
            catch (Exception ex)
            {
                ex.ToString();
                return 0;
            }
            return Id;
        }
    }
}
