using MIDDerivationLibrary.Models.CSDMdefsModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.CSDMdefs
{
    public class CSDMdefsRepository : ICSDMdefsRepository
    {
        private readonly ISQLRepository sqlRepository;

        public CSDMdefsRepository(ISQLRepository _sqlRepository)
        {
            sqlRepository = _sqlRepository;
        }
        public long AddOrUpdateCSDMdefsDetails(string xml)
        {
            long id = 0;
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spAddOrUpdateCSDMdefsDetails;
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

        public List<CSDMdefsDetails> GetAllCSDMdefsDetails(string csdmFile = null)
        {
            List<CSDMdefsDetails> detailsLst = new List<CSDMdefsDetails>();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spGetAllCSDMdefsDetails;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.csdmfile}", csdmFile == null ? DBNull.Value : csdmFile )};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    detailsLst = result.Tables[0].AsEnumerable().Select(dataRow => new CSDMdefsDetails
                    {
                        id = dataRow.Field<long>("id"),
                        csdmfile = dataRow.Field<string>("CSDMfile"),
                        componentCodeRangeStart = dataRow.Field<decimal?>("componentcoderangestart"),
                        componentCodeRangeEnd = dataRow.Field<decimal?>("componentcoderangeend"),
                        csdmSize = dataRow.Field<int?>("CSDMsize"),
                        csdmRelative = dataRow.Field<bool?>("CSDMrelative"),
                        defaultShaftLabel = dataRow.Field<string>("defaultshaftlabel")
                    }).ToList();
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
                return null;
            }
            return detailsLst;
        }

        public CSDMdefsDetails GetCSDMdefsDetailsById(long id)
        {
            CSDMdefsDetails details = new CSDMdefsDetails();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spGetCSDMdefsDetailsById;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.Id}", id)};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    details = result.Tables[0].AsEnumerable().Select(dataRow => new CSDMdefsDetails
                    {
                        id = dataRow.Field<long>("id"),
                        csdmfile = dataRow.Field<string>("CSDMfile"),
                        componentCodeRangeStart = dataRow.Field<decimal?>("componentcoderangestart"),
                        componentCodeRangeEnd = dataRow.Field<decimal?>("componentcoderangeend"),
                        csdmSize = dataRow.Field<int?>("CSDMsize"),
                        csdmRelative = dataRow.Field<bool?>("CSDMrelative"),
                        defaultShaftLabel = dataRow.Field<string>("defaultshaftlabel")
                    }).FirstOrDefault();
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
                return null;
            }
            return details;
        }

        public long DeleteCSDMdefsDetailsById(long id)
        {
            long Id = 0;
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spDeleteCSDMdefsDetailsById;
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

        public CSDMdefsDetails GetCSDMdefsDetails(string xml)
        {
            CSDMdefsDetails details = new CSDMdefsDetails();
            try
            {
                string spName = MIDDerivationLibrary.Models.Constants.spCheckIsCSDMdefsDetailsExist;
                List<SqlParameter> allParams = new List<SqlParameter>()
                { new SqlParameter($"@{MIDDerivationLibrary.Models.Constants.xmlInput}", xml)};

                DataSet result = sqlRepository.ExecuteQuery(spName, allParams);
                if (result != null && result.Tables[0].Rows.Count > 0)
                {
                    details = result.Tables[0].AsEnumerable().Select(dataRow => new CSDMdefsDetails
                    {
                        id = dataRow.Field<long>("id"),
                        csdmfile = dataRow.Field<string>("CSDMfile"),
                        componentCodeRangeStart = dataRow.Field<decimal?>("componentcoderangestart"),
                        componentCodeRangeEnd = dataRow.Field<decimal?>("componentcoderangeend"),
                        csdmSize = dataRow.Field<int?>("CSDMsize"),
                        csdmRelative = dataRow.Field<bool?>("CSDMrelative"),
                        defaultShaftLabel = dataRow.Field<string>("defaultshaftlabel")
                    }).FirstOrDefault();
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return details;
        }
    }
}
